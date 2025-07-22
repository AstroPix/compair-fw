

/*
    Wrapper Module with SPI interfaces for Trigger Module

*/
module trigger_module_if(
    input  wire			clk_core,
    input  wire			clk_core_resn,
    input  wire         meb_spi_clk,
    input   wire        meb_spi_miso,
    input   wire        meb_hold,         // meb full
    output  wire        meb_spi_mosi,
    output wire [7:0]	meb_spi_miso_m_axis_tdata,
    input  wire			meb_spi_miso_m_axis_tready,
    output wire			meb_spi_miso_m_axis_tvalid,
    output wire [31:0]	meb_spi_miso_read_size,
    input  wire [7:0]	meb_spi_mosi_s_axis_tdata,
    input  wire			meb_spi_mosi_s_axis_tlast,
    output wire			meb_spi_mosi_s_axis_tready,
    input  wire			meb_spi_mosi_s_axis_tvalid
);

GSR #(.SYNCMODE("SYNC")) GSR_INST (.GSR_N(1'b1), .CLK(clk_core));

    // Connections
    //----------------


//    wire mosi_fifo_m_axis_tvalid; // size=1
//    wire mosi_fifo_m_axis_tready; // size=1
//    wire [7:0] mosi_fifo_m_axis_tdata; // size=8
//    wire [7:0] spi_io_m_axis_tdata; // size=8
//    wire spi_io_m_axis_tvalid; // size=1

    // Sections
    //---------------
    byte_t spi_igress_m_axis_tdata;
    byte_t spi_igress_m_axis_tid;
    byte_t spi_igress_m_axis_tdest;

    // Instances
    //------------

     // IGRESS
    spi_slave_axis_igress #(.AXIS_DEST(0),.AXIS_SOURCE(2),.MSB_FIRST(0)) trig_igress(
        .spi_clk(meb_spi_clk),
        .spi_csn(meb_spi_csn),
        .spi_mosi(meb_spi_mosi),

        .m_axis_tdata(spi_igress_m_axis_tdata),
        .m_axis_tdest(spi_igress_m_axis_tdest),
        .m_axis_tid(spi_igress_m_axis_tid),
        .m_axis_tready(spi_igress_m_axis_tready),
        .m_axis_tvalid(spi_igress_m_axis_tvalid),

        .err_overrun(/* WAIVED: Overrun not relevant when CS not used */)
    );

        
    // Module Instance
    fifo_axis_common #(.AWIDTH(4),.TID_WIDTH(8),.TDEST_WIDTH(8),.USE_TID(1),.USE_TDEST(1),.TLAST(1))  trig_spi_igress_fifo(

        .s_axis_aclk(meb_spi_clk),
        .s_axis_aresetn(!meb_spi_csn),
        .s_axis_tdata(spi_igress_m_axis_tdata),
        .s_axis_tdest(spi_igress_m_axis_tdest),
        .s_axis_tid(spi_igress_m_axis_tid),
        .s_axis_tready(spi_igress_m_axis_tready),
        .s_axis_tvalid(spi_igress_m_axis_tvalid),
        .s_axis_tlast(1'b1),
       
        .m_axis_aclk(clk_core),
        .m_axis_aresetn(clk_core_resn),
        .m_axis_tready(mosi_fifo_m_axis_tready),
        .m_axis_tvalid(mosi_fifo_m_axis_tvalid),
        .m_axis_tdata(mosi_fifo_m_axis_tdata),
        .m_axis_tdest(mosi_fifo_m_axis_tdest)
        .m_axis_tlast(mosi_fifo_m_axis_tlast),

        .s_axis_tuser(),
        .m_axis_tuser(),

        .axis_wr_data_count(),
        .axis_rd_data_count(),

        .almost_full(),
        .almost_empty()
    );
            
    // Module Instance
    fifo_axis_common #(.AWIDTH(4),.TID_WIDTH(8), .TDEST_WIDTH(8), USE_TID(1),.USE_TDEST(1),.TLAST(1))  trig_spi_egress_fifo(

        .s_axis_aclk(clk_core),
        .s_axis_aresetn(clk_core_resn),
        .s_axis_tvalid(spi_io_m_axis_tvalid),
        .s_axis_tready(spi_io_m_axis_tready), 
        .s_axis_tdata(spi_io_m_axis_tdata),
        .s_axis_tdest(spi_io_m_axis_tdest),
        .s_axis_tlast(spi_io_m_axis_tlast),

        .m_axis_aclk(clk_core),
        .m_axis_aresetn(clk_core_resn),
        .m_axis_tdata(meb_spi_miso_m_axis_tdata),
        .m_axis_tready(meb_spi_miso_m_axis_tready),
        .m_axis_tvalid(meb_spi_miso_m_axis_tvalid),
        .m_axis_tlast(meb_spi_miso_m_axis_tlast),

        .s_axis_tuser(),
        .m_axis_tuser(),

        .axis_rd_data_count(),
        .axis_wr_data_count(),
        .m_axis_tdest(),
        .s_axis_tid(),
        .m_axis_tid(),
        .almost_full(),
        .almost_empty()

    );
    spi_slave_axis_egress #(.ASYNC_RES(1),.MSB_FIRST(0),.MISO_SIZE(1)) spi_egress(
       
        .s_axis_tdata(meb_spi_miso_m_axis_tdata),
        .s_axis_tready(meb_spi_miso_m_axis_tready),
        .s_axis_tuser(meb_spi_miso_m_axis_tuser),
        .s_axis_tvalid(meb_spi_miso_m_axis_tvalid),

        .spi_clk(spi_clk),
        .spi_csn(spi_csn),
        .spi_miso(spi_miso)
    );
              

endmodule

        
