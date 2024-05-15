module axis_switch #(parameter PORTS=4,parameter TID_WIDTH = 8, parameter TDATA_WIDTH=8 ) (
    input  wire                             clk, 
    input  wire                             res_n,

    // Busses for Master ports
    input  wire  [(PORTS*TID_WIDTH)-1:0]     m_axis_tid,
    input  wire  [(PORTS*TDATA_WIDTH)-1:0]   m_axis_tdata,
    input  wire  [PORTS-1:0]                 m_axis_tvalid,
    input  wire  [PORTS-1:0]                 m_axis_tlast,
    output logic [PORTS-1:0]                 m_axis_tready,
    
    // Busses for slave ports
    //---------

    // This signal will mask tvalid from master 
    input  wire  [PORTS-1:0]                 s_axis_tready,
    output logic [PORTS-1:0]                 s_axis_tvalid,
    output logic [(PORTS*TDATA_WIDTH)-1:0]   s_axis_tdata
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
    
    // Request mask maps master requested target slave with it's ready state
    reg [PORTS-1:0] internal_request_mask;

    // Master requests are masked by target slave ready
    wire [PORTS-1:0] internal_requests = m_axis_tvalid & internal_request_mask;

    // Grants outputs
    wire [PORTS-1:0]                internal_grant;
    wire [GRANT_BINARY_SIZE-1:0]    internal_grant_binary = one_hot_to_binary(internal_grant);
    wire                            grant_requested       = |m_axis_tvalid;
    wire                            grant_granted         = |internal_grant;

    // Transmition signals
    
    reg                         transmitting;
    reg [GRANT_BINARY_SIZE-1:0] source_port;
    reg [GRANT_BINARY_SIZE-1:0] target_port; // Save target port to avoid issues if the user changes tid while transmitting

    wire last_data = transmitting & m_axis_tlast[source_port]; // On last data block, allow arbiting

    //-- Arbiter
    round_robin_arbiter #(.N(PORTS)) arbiter(
        .clk(clk),
        .res_n(res_n),
        .enable(!transmitting || last_data),
        .req(internal_requests),
        .grant(internal_grant));

    // Transmit state
    //-------------------

    // Source port should be calculated back binary from onehot grants
    

    always @(posedge clk) begin
        if (!res_n) begin 
            transmitting <= 'b0;
            source_port  <= 'h0;
            target_port  <= 'h0;
        end
        else begin 

            // Transmitting state
            //-----------

            // If there is a request and grant given, set transmitting
            if (grant_requested && grant_granted) begin 
                transmitting <= 1'b1;
                source_port  <= internal_grant_binary;
                //target_port  <= m_axis_tid[internal_grant_binary*8+8-1:internal_grant_binary*8];
            end
        end
    end

    // Target Port MUX
    //--------------

    // Master Ports Logics and Mux
    //----------
    logic [7:0] target_port_map [PORTS];
    /*always_comb begin
        for (int i = 0 ; i < PORTS; i++) begin
            if (source_port==i) begin
                target_port = m_axis_tid[(i*8)+8-1:i*8];
            end
        end
    end*/
    
    genvar p;
    generate 
        for (p = 0 ; p < PORTS; p++) begin

            //-- Masking master requests by target slave ready
            wire master_target = m_axis_tid[(p*8)+8-1:p*8];
            always @(posedge clk) begin 
                if (!res_n) begin 
                    internal_request_mask <= 'b0;
                end
                else begin 
                    internal_request_mask[p] <= s_axis_tready[master_target];
                end
            end

            //-- tready from target slave
            wire master_selected = transmitting && (source_port==p);
            always_comb begin
                 m_axis_tready[p] = !master_selected ? 'b0 : s_axis_tready[master_target] ;

                 target_port_map[p] = master_target;
            end

            //-- Target port

            
        end
    endgenerate


    // Slave Ports Logics and Mux
    //----------
    generate 
        for (p = 0 ; p < PORTS; p++) begin

            //-- tvalid from source port
            wire slave_selected = target_port_map[source_port] == p && transmitting;
           // wire slave_selected = m_axis_tid[source_port*8+8-1:source_port*8] == p;
            always_comb begin
                s_axis_tvalid[p] = !slave_selected ? 'b0 : m_axis_tready[source_port] ;
            end
            
        end
    endgenerate
    

endmodule 