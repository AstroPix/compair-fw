module axis_switch #(parameter PORTS=4,parameter TID_WIDTH = 8, parameter TUSER_WIDTH = 8, parameter TDATA_WIDTH=8 ) (
    input  wire                             clk, 
    input  wire                             resn,

    // Busses for Master ports
    output  logic  [(PORTS*TID_WIDTH)-1:0]     m_axis_tid,
    output  logic  [(PORTS*TUSER_WIDTH)-1:0]   m_axis_tuser,
    output  logic  [(PORTS*TDATA_WIDTH)-1:0]   m_axis_tdata,
    //output  logic  [(TID_WIDTH)-1:0]         m_axis_tid,
    //output  logic  [(TDATA_WIDTH)-1:0]       m_axis_tdata,
    output  logic  [PORTS-1:0]                 m_axis_tvalid,
    output  logic  [PORTS-1:0]                 m_axis_tlast,
    input   wire [PORTS-1:0]                   m_axis_tready,
    
    // Busses for slave ports
    //---------

    // This signal will mask tvalid from master
    input   wire  [(PORTS*TID_WIDTH)-1:0]     s_axis_tid,
    input   wire  [(PORTS*TUSER_WIDTH)-1:0]   s_axis_tuser,
    output  logic [PORTS-1:0]                 s_axis_tready,
    input   wire  [PORTS-1:0]                 s_axis_tvalid,
    input   wire  [(PORTS*TDATA_WIDTH)-1:0]   s_axis_tdata,
    input   wire  [PORTS-1:0]                 s_axis_tlast
    

);


    // Params + Functions
    //------------

    localparam GRANT_BINARY_SIZE = $clog2( PORTS) ;


    // https://support.xilinx.com/s/question/0D52E00006iHizJSAS/systemverilog-one-hot-to-binary-function?language=en_US
    function bit [ GRANT_BINARY_SIZE - 1 : 0 ] one_hot_to_binary ( input bit [ PORTS - 1 : 0 ] vector_one_hot );
        bit [ GRANT_BINARY_SIZE - 1 : 0 ] vector_binary;
        vector_binary = 0;
        foreach ( vector_one_hot [ index ] )
        begin
        if ( vector_one_hot [ index ] == 1'b1 )
            vector_binary = vector_binary | index ;
        end
        return( vector_binary );
    endfunction

    // Request and Grants using RR arbiter
    // Use tvalid to present requests, then when a grant is given, disable arbiter until the data routing has finished
    //----------------
    
    // Request mask maps slave requested target master with it's ready state
    reg [PORTS-1:0] internal_request_mask;

    // Slave requests are masked by target master ready
    wire [PORTS-1:0] internal_requests = s_axis_tvalid /*& internal_request_mask*/;

    // Grants outputs
    wire [PORTS-1:0]                internal_grant;
    wire [GRANT_BINARY_SIZE-1:0]    internal_grant_binary = one_hot_to_binary(internal_grant);
    wire                            grant_requested       = |s_axis_tvalid;
    wire                            grant_granted         = |internal_grant;

    // Transmition signals
    
    reg                         transmitting;
    reg [GRANT_BINARY_SIZE-1:0] source_port;
    reg [GRANT_BINARY_SIZE-1:0] target_port; // Save target port to avoid issues if the user changes tid while transmitting
    reg [TID_WIDTH-1:0] source_tid;

    //wire last_data = transmitting & s_axis_tlast[source_port]; // On last data block, allow arbiting
    wire last_data = transmitting & |m_axis_tlast;

    //-- Arbiter
    round_robin_arbiter #(.N(PORTS)) arbiter(
        .clk(clk),
        .resn(resn),
        .enable(!transmitting || last_data),
        .req(internal_requests),
        .grant(internal_grant));

    // Transmit state
    //-------------------

    // Source port should be calculated back binary from onehot grants
    

    always @(posedge clk) begin
        if (!resn) begin 
            transmitting <= 'b0;
            source_port  <= 'h0;
            target_port  <= 'h0;
            source_tid  <= 'h0;
        end
        else begin 

            // Transmitting state
            //-----------

            // If there is a request and grant given, set transmitting
            if (grant_requested && grant_granted) begin 
                transmitting <= 1'b1;
                source_port  <= internal_grant_binary;
            end
            else if (transmitting && last_data) begin
                transmitting <= 1'b0;
            end
        end
    end


    // Input FIFOS for all slave interfaces which are getting data
    // Fifo Output is connected to the granted master
    //----------------

     // Key is the target master, value the source slave
    logic [TID_WIDTH:0] target_port_source_slave [PORTS];

    // Key is the target master, value the source tuser
    logic [7:0] target_port_source_tuser [PORTS];

    // Key is the target master, value the source tuser
    logic [7:0] target_port_source_tdata [PORTS];


    localparam INPUT_FIFO_WIDTH = TDATA_WIDTH+TID_WIDTH+TUSER_WIDTH+1;

    logic [PORTS-1:0] m_axis_empty_internal; // Internal FIFO empty, will be inverted as valid
    logic [INPUT_FIFO_WIDTH-1:0] m_axis_slave_output[PORTS]; // Output of slave fifo routed to proper master

    logic [PORTS-1:0] s_axis_fifo_almost_full;
    assign s_axis_tready = ~s_axis_fifo_almost_full;

    
    genvar f;
    generate 
        for (f = 0 ; f < PORTS; f++) begin

            //-- Slave Side tuser, tdata, input fifo
            //------------
            wire slave_selected = transmitting && (source_port==f);
            wire [TID_WIDTH-1:0] master_target = s_axis_tid[(f*8)+8-1:f*8];
            wire [TUSER_WIDTH-1:0] slave_tuser = s_axis_tuser[(f*TUSER_WIDTH)+TUSER_WIDTH-1:f*TUSER_WIDTH];
            wire [TDATA_WIDTH-1:0] slave_tdata = s_axis_tdata[(f*TDATA_WIDTH)+TDATA_WIDTH-1:f*TDATA_WIDTH];

            // Write in fifo the slave side data, tuser, tid
            simple_1ck_fifo #(.DWIDTH(INPUT_FIFO_WIDTH)) input_fifo(
                .clk(clk),
                .resn(resn),
                
                // Slave side
                // Almost full sets slave ready
                // Write is from slave interface
                .write_value({s_axis_tlast[f],master_target,slave_tuser,slave_tdata}),
                .write(s_axis_tvalid[f] & s_axis_tready[f]),
                .full(),
                .almost_full(s_axis_fifo_almost_full[f]),

                // Master internal side
                // Empty sets matched master valid
                .read_value(m_axis_slave_output[f]),
                .read( m_axis_tready[master_target] /*& slave_selected*/ & m_axis_tvalid[master_target] ),
                .empty(m_axis_empty_internal[f]),
                .almost_empty()
            );

            //-- Save selected state in target port memory entry
            always @(posedge clk) begin 
                if (!resn) begin 
                    internal_request_mask[f] <= 'b0;
                    //master_target_reg <= 'b0;
                end
                else begin 
                    internal_request_mask[f] <= m_axis_tready[master_target] && !slave_selected;
                    //master_target_reg <= s_axis_tid[(f*8)+8-1:f*8];
                end
            end
            always @(posedge clk) begin
                if (!resn) begin
                    target_port_source_slave[f] <= 'h0;
                end else if (slave_selected) begin
                    target_port_source_slave[master_target[1:0]][TID_WIDTH] <= 1'b1 ;
                    target_port_source_slave[master_target[1:0]][TID_WIDTH-1:0] <= f;
                end else if (slave_selected & last_data) begin
                    target_port_source_slave[master_target[1:0]][TID_WIDTH] <= 1'b0 ;
                    //target_port_source_slave[master_target[1:0]][TID_WIDTH-1:0] <= f;
                end
            end
            /*always_comb begin

                if(!resn) begin 
                    target_port_source_slave[f] = 'h0;
                end else if (slave_selected) begin
                    target_port_source_slave[master_target][TID_WIDTH] = 1'b1;
                    target_port_source_slave[master_target][TID_WIDTH-1:0] = f;
                    target_port_source_tuser[master_target] = slave_tuser;
                    target_port_source_tdata[master_target] = slave_tdata;
                    //target_port_map[p] = {1'b1,master_target}; 
                end 
            end*/

            //-- Master target ready signal connected to this slave
            wire master_port_selected = target_port_source_slave[f][TID_WIDTH] == 1'b1;
           // wire master_port_selected = target_port_source_slave[f][TID_WIDTH] == 1'b1;
           // wire master_port_selected = m_axis_slave_output[f]
            always_comb begin
                //m_axis_tvalid[f] = !master_port_selected ? 1'b0 : s_axis_tvalid[target_port_source_slave[f][7:0]];
                m_axis_tuser[f*8+8-1:f*8] = target_port_source_tuser[f];
                m_axis_tid[f*8+8-1:f*8] = target_port_source_slave[f];
                //m_axis_tdata[f*8+8-1:f*8] = !master_port_selected ? 'h0 : target_port_source_tdata[f];
                m_axis_tvalid[f] = !master_port_selected ? 1'b0 : !m_axis_empty_internal[target_port_source_slave[f][7:0]];
                m_axis_tdata[f*8+8-1:f*8] = !master_port_selected ? 'h0 : m_axis_slave_output[internal_grant_binary][TDATA_WIDTH-1:0];
                m_axis_tlast[f] = !master_port_selected ? 'b0 : m_axis_slave_output[internal_grant_binary][INPUT_FIFO_WIDTH-1]; 
            end
        end
    endgenerate

    // Master Ports Logics and Mux
    //----------

   
    

    /*genvar p;
    generate 
        for (p = 0 ; p < PORTS; p++) begin

            wire slave_selected = transmitting && (source_port==p);

            //-- Masking slave requests by target master ready
            wire [TUSER_WIDTH-1:0] slave_tuser = s_axis_tuser[(p*TUSER_WIDTH)+TUSER_WIDTH-1:p*TUSER_WIDTH];
            wire [TDATA_WIDTH-1:0] slave_tdata = s_axis_tdata[(p*TDATA_WIDTH)+TDATA_WIDTH-1:p*TDATA_WIDTH];
            wire [TID_WIDTH-1:0] master_target = s_axis_tid[(p*8)+8-1:p*8];
            logic [TID_WIDTH-1:0] master_target_reg;
            always @(posedge clk) begin 
                if (!resn) begin 
                    internal_request_mask[p] <= 'b0;
                    master_target_reg <= 'b0;
                end
                else begin 
                    internal_request_mask[p] <= m_axis_tready[master_target] && !slave_selected;
                    master_target_reg <= s_axis_tid[(p*8)+8-1:p*8];
                end
            end

            //-- tready from target slave
            always_comb begin

                if(!resn) begin 
                    target_port_source_slave[p] = 'h0;
                end else if (slave_selected) begin
                    target_port_source_slave[master_target][TID_WIDTH] = 1'b1;
                    target_port_source_slave[master_target][TID_WIDTH-1:0] = p;
                    target_port_source_tuser[master_target] = slave_tuser;
                    target_port_source_tdata[master_target] = slave_tdata;
                    //target_port_map[p] = {1'b1,master_target}; 
                end 
            end

            //-- tready to source port from master ready
            always_comb begin
                s_axis_tready[p] = !slave_selected ? 'b0 : m_axis_tready[master_target];
            end

            // Master 
            //-- tuser from selected slave
            wire [TUSER_WIDTH-1:0] master_tuser;
            wire master_port_selected = target_port_source_slave[p][TID_WIDTH] == 1'b1;
            always_comb begin
                m_axis_tvalid[p] = !master_port_selected ? 1'b0 : s_axis_tvalid[target_port_source_slave[p][7:0]];
                m_axis_tuser[p*8+8-1:p*8] = target_port_source_tuser[p];
                m_axis_tid[p*8+8-1:p*8] = target_port_source_slave[p];
                m_axis_tdata[p*8+8-1:p*8] = !master_port_selected ? 'h0 : target_port_source_tdata[p];
            end
            
        end
    endgenerate
    */

endmodule 