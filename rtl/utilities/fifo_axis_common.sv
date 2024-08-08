/**

Wrapper to use Lattice FIFO with axis signals in First Word Fall  Through mode
tlast , read and write data count not supported (yet)

At the moment, the Firt Word Fall Through variant of the FIFO doesn't really work as expected in the simulation.
It is not clear why, maybe a simulation issue, so the lattice fifo must be generated in standard mode with LUT implementation

This module adds a 4 words register First-Word Fall Through mini-fifo on the read path, which is filled as long as the underlying Lattice FIFO is not empty.
The mini-fifo acts as a cache that can hide the one cycle read delay of the underlying FIFO when it is not in First Word Fall Through mode

    
*/
module  fifo_axis_common #(
    parameter DUAL_CLOCK=1, 
    parameter DWIDTH=8, 
    parameter AWIDTH=8, 
    
    parameter USE_TID = 0,
    parameter TID_WIDTH=8,

    parameter USE_TDEST = 0,
    parameter TDEST_WIDTH=8,

    parameter USE_TUSER = 0,
    parameter TUSER_WIDTH=8,

    parameter TLAST=1) (

    // Write interface -> AXIS Slave
    input  wire                     s_axis_aclk,
    input  wire                     s_axis_aresetn,
    input  wire [DWIDTH-1:0]        s_axis_tdata,
    input  wire                     s_axis_tvalid,
    output wire                     s_axis_tready,

    input  wire  [TID_WIDTH-1:0]    s_axis_tid,
    input  wire  [TDEST_WIDTH-1:0]  s_axis_tdest,
    input  wire  [TUSER_WIDTH-1:0]  s_axis_tuser,
    input  wire                     s_axis_tlast,

    output wire [31:0]              axis_wr_data_count,


    // Read interface -> AXIS Master
    input  wire                     m_axis_aclk,
    input  wire                     m_axis_aresetn,
    output logic [DWIDTH-1:0]       m_axis_tdata,
    input  wire                     m_axis_tready,
    output logic                    m_axis_tvalid,

    output wire  [TID_WIDTH-1:0]    m_axis_tid,
    output wire  [TDEST_WIDTH-1:0]  m_axis_tdest,
    output wire  [TUSER_WIDTH-1:0]  m_axis_tuser,
    output wire                     m_axis_tlast,

    output wire [31:0]              axis_rd_data_count,

    // Sideband Signals
    output wire                     almost_empty,
    output wire                     almost_full

   
);  

    // Merge Input Data busses into one data bus for the FIFO
    //--------------------
    localparam TID_WIDTH_INTERNAL = USE_TID == 1 ? TID_WIDTH : 0;
    localparam TUSER_WIDTH_INTERNAL = USE_TUSER == 1 ? TUSER_WIDTH : 0;
    localparam TDEST_WIDTH_INTERNAL = USE_TDEST == 1 ? TDEST_WIDTH : 0;
    localparam FIFO_DATA_WIDTH= DWIDTH + TID_WIDTH_INTERNAL + TUSER_WIDTH_INTERNAL + TDEST_WIDTH_INTERNAL + TLAST;

    

    localparam IN_TID_LOW = USE_TID == 1 ? DWIDTH : 0 ;
    localparam IN_TID_HIGH = USE_TID == 1 ? IN_TID_LOW + TID_WIDTH_INTERNAL -1 : 0;

    localparam IN_TDEST_LOW = USE_TDEST == 1 ? DWIDTH+TID_WIDTH_INTERNAL : 0 ;
    localparam IN_TDEST_HIGH = USE_TDEST == 1 ? IN_TDEST_LOW + TDEST_WIDTH_INTERNAL -1 : 0;

    localparam IN_TUSER_LOW = USE_TUSER == 1 ? DWIDTH+TID_WIDTH_INTERNAL +TDEST_WIDTH_INTERNAL: 0 ;
    localparam IN_TUSER_HIGH = USE_TUSER == 1 ? IN_TUSER_LOW + TUSER_WIDTH_INTERNAL -1 : 0;
    
    //wire [TID_WIDTH-1:0] s_axis_tid_internal = USE_TID ? s_axis_tid : 'b0; {TLAST ==1 ? s_axis_tlast : 0'b0}
    //wire [TUSER_WIDTH_INTERNAL] internal_tuser = USE_TUSER ==1 ? s_axis_tuser : 0'b0;
    logic [FIFO_DATA_WIDTH-1:0] fifo_data_in;
    //wire [FIFO_DATA_WIDTH-1:0] fifo_data_in = { s_axis_tlast ,{USE_TUSER ==1 ? s_axis_tuser : 0'b0},{USE_TDEST==1 ? s_axis_tdest : 0'b0} ,{USE_TID==1 ? s_axis_tid : 0'b0} ,s_axis_tdata} ;
    //generate
    always_comb begin
        fifo_data_in[DWIDTH-1:0] = s_axis_tdata;
        if (USE_TID==1) begin
            fifo_data_in[IN_TID_HIGH:IN_TID_LOW] = s_axis_tid;
        end
        if (USE_TDEST==1) begin
            //fifo_data_in[(DWIDTH+TID_WIDTH_INTERNAL+TDEST_WIDTH_INTERNAL)-1:DWIDTH+TID_WIDTH_INTERNAL] = s_axis_tdest;
            fifo_data_in[IN_TDEST_HIGH:IN_TDEST_LOW] = s_axis_tdest;
        end
        if (USE_TUSER==1) begin
            fifo_data_in[IN_TUSER_HIGH:IN_TUSER_LOW] = s_axis_tuser;
        end
        if (TLAST==1) begin
            fifo_data_in[FIFO_DATA_WIDTH-1] = s_axis_tlast;
        end
        
    end
    //endgenerate
    // DC Fifo in normal read mode, with a small FWFT single clock cache fifo for the read path
    //-----------------------------
    wire [FIFO_DATA_WIDTH-1:0] fifo_data;
    reg fifo_read;
    reg fifo_read_data_valid;
    wire empty, fifo_almost_empty,full;
    assign s_axis_tready = !full;

    //-- Generate the FIFO instance based on parameters
    generate
        if (FIFO_DATA_WIDTH<=8) begin
            fifo_2clk_64x8 fifo (
                .wr_clk_i   (s_axis_aclk),
                .rd_clk_i   (m_axis_aclk),
                .rst_i      (!s_axis_aresetn),
                .rp_rst_i   (!s_axis_aresetn ),

                .wr_en_i    (s_axis_tvalid),
                .wr_data_i  (fifo_data_in),
                .full_o     (full),

                .rd_en_i    (fifo_read),
                .rd_data_o  (fifo_data),
                .empty_o    (empty ),
                
                .almost_full_o( almost_full ),
                .almost_empty_o(fifo_almost_empty )
                
            );
        end
        else if (FIFO_DATA_WIDTH<=32) begin
            fifo_2clk_64x32 fifo (
                .wr_clk_i   (s_axis_aclk),
                .rd_clk_i   (m_axis_aclk),
                .rst_i      (!s_axis_aresetn),
                .rp_rst_i   (!s_axis_aresetn ),

                .wr_en_i    (s_axis_tvalid),
                .wr_data_i  (fifo_data_in),
                .full_o     (full),

                .rd_en_i    (fifo_read),
                .rd_data_o  (fifo_data),
                .empty_o    (empty ),
                
                .almost_full_o( almost_full ),
                .almost_empty_o(fifo_almost_empty )
                
            );
        end
        else begin
            error_fifo error_fifo();
        end
    endgenerate
    

    //-- Read path Caching FIFO
    wire [FIFO_DATA_WIDTH-1:0] cache_fifo_data_out;
    reg cache_fifo_write;
    wire cache_fifo_read;
    wire cache_fifo_almost_empty, cache_fifo_almost_full,cache_fifo_empty,cache_fifo_full;
    assign m_axis_tvalid = !cache_fifo_empty;
    mini_fwft_fifo # (
        .AWIDTH(2),.DWIDTH(FIFO_DATA_WIDTH)
    )
    read_cache_fifo (
        .clk(m_axis_aclk),
        .resn(m_axis_aresetn),
        .full(cache_fifo_full),
        .almost_full(cache_fifo_almost_full),
        .empty(cache_fifo_empty),
        .almost_empty(cache_fifo_almost_empty),
        .write(fifo_read_data_valid),
        .read(m_axis_tready),
        .data_in(fifo_data),
        .data_out(cache_fifo_data_out)
    );

    //-- Map Outputs to cache fifo out
    assign m_axis_tdata = cache_fifo_data_out[DWIDTH-1:0];
    assign m_axis_tid   = USE_TID== 1   ?  cache_fifo_data_out[(DWIDTH+TID_WIDTH)-1:DWIDTH] : 'b0;
    assign m_axis_tdest = USE_TDEST== 1 ?  cache_fifo_data_out[(TID_WIDTH_INTERNAL+DWIDTH+TDEST_WIDTH)-1:(TID_WIDTH_INTERNAL+DWIDTH)] : 'b0;
    assign m_axis_tuser = USE_TUSER == 1 ?  cache_fifo_data_out[(TID_WIDTH_INTERNAL+DWIDTH+TDEST_WIDTH_INTERNAL+TUSER_WIDTH)-1:(TID_WIDTH_INTERNAL+TDEST_WIDTH_INTERNAL+DWIDTH)] : 'b0;
    assign m_axis_tlast = TLAST == 1 ?  cache_fifo_data_out[FIFO_DATA_WIDTH-1] : 'b0;
    
    //-- DC_FIFo to cache FIFO path
    always @(posedge m_axis_aclk) begin
        if (!m_axis_aresetn) begin
            cache_fifo_write <= 1'b0;
            fifo_read <= 1'b0;
            fifo_read_data_valid <= 1'b0;
        end
        else begin
            
            fifo_read_data_valid <= cache_fifo_full ? fifo_read_data_valid : fifo_read;

            // If Source FIFO Is not empty, write to cache fifo
            if (!empty && !(fifo_read && fifo_almost_empty) && !(cache_fifo_almost_full && !m_axis_tready)  ) begin
                fifo_read <= 1'b1;
            end 
            else begin
                fifo_read <= 1'b0;
            end

        end
    end


    `ifdef SIMULATION
    GSR GSR_INST ( .GSR_N(1'b1), .CLK(1'b0));
    `endif

endmodule