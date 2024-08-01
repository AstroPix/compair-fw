/**

Wrapper to use Lattice FIFO with axis signals
tlast , read and write data count not supported yet
*/
module  fifo_lattice_axis_wrapper #(parameter DWIDTH=8,parameter AWIDTH=8) (

    // Write interface -> AXIS Slave
    input  wire                 s_axis_aclk,
    input  wire                 s_axis_aresetn,
    input  wire [DWIDTH-1:0]    s_axis_tdata,
    input  wire                 s_axis_tvalid,
    output wire                 s_axis_tready,

    input  wire                 s_axis_tlast,
    output wire [31:0]          axis_wr_data_count,


    // Read interface -> AXIS Master
    input  wire                 m_axis_aclk,
    output wire [DWIDTH-1:0]    m_axis_tdata,
    input  wire                 m_axis_tready,
    output wire                 m_axis_tvalid,

    output wire                 m_axis_tlast,
    output wire [31:0]          axis_rd_data_count

   
);


    // Instantiate
    //-------------------
    wire empty;
    wire full;
    assign m_axis_tvalid = !empty;
    assign s_axis_tready = !full;
    fifo_2clk_64e fifo (
        .wr_clk_i   (s_axis_aclk),
        .rd_clk_i   (m_axis_aclk),
        .rst_i      (!s_axis_aresetn),
        .rp_rst_i   (!s_axis_aresetn ),

        .wr_en_i    (s_axis_tvalid),
        .wr_data_i  (s_axis_tdata),
        .full_o     (full),

        .rd_en_i    (m_axis_tready),
        .rd_data_o  (m_axis_tdata),
        .empty_o    (empty ),
        
        .almost_full_o( ),
        .almost_empty_o( )
        
    );

    GSR GSR_INST ( .GSR_N(1'b1), .CLK(1'b0));


endmodule