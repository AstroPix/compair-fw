


/*
    Wrapper Module with SPI interfaces for Housekeeping

    At the moment there is one SPI Master, ADC/DAC are selected over Chip Select
*/
module housekeeping_main(
    input  wire			clk_core,
    input  wire			clk_core_resn,
    input  wire			clk_spi,
    input  wire			clk_spi_resn,
    input  wire [2:0]   select_adc,
    output wire [7:0]	ext_adc_miso_m_axis_tdata,
    input  wire			ext_adc_miso_m_axis_tready,
    output wire			ext_adc_miso_m_axis_tvalid,
    output wire [31:0]		ext_adc_miso_read_size,
    input  wire [7:0]		ext_adcdac_mosi_s_axis_tdata,
    input  wire			ext_adcdac_mosi_s_axis_tlast,
    output wire			ext_adcdac_mosi_s_axis_tready,
    input  wire			ext_adcdac_mosi_s_axis_tvalid,
    output wire			ext_spi_clk,
    output wire			ext_spi_csn,
    input  wire			ext_spi_miso,
    output wire			ext_spi_mosi

);

    // Connections
    //----------------
    wire mosi_fifo_m_axis_tvalid; // size=1
    wire mosi_fifo_m_axis_tready; // size=1
    wire [7:0] mosi_fifo_m_axis_tdata; // size=8
    wire [7:0] spi_io_m_axis_tdata; // size=8
    wire spi_io_m_axis_tvalid; // size=1

    // Sections
    //---------------


    // Instances
    //------------

    // Module Instance
    fifo_axis_common #(.AWIDTH(5),.USE_TID(0),.USE_TDEST(0),.TLAST(0))  mosi_fifo(

        .m_axis_aclk(clk_spi),
        .m_axis_aresetn(clk_spi_resn),
        .m_axis_tdata(mosi_fifo_m_axis_tdata),
        .m_axis_tlast(/* unused */),
        .m_axis_tready(mosi_fifo_m_axis_tready),
        .m_axis_tvalid(mosi_fifo_m_axis_tvalid),

        .axis_rd_data_count(/* WAIVED: Fifo fill status not needed */),

        .s_axis_aclk(clk_core),
        .s_axis_aresetn(clk_core_resn),

        .s_axis_tdata(ext_adcdac_mosi_s_axis_tdata),
        .s_axis_tlast(ext_adcdac_mosi_s_axis_tlast),
        .s_axis_tready(ext_adcdac_mosi_s_axis_tready),
        .s_axis_tvalid(ext_adcdac_mosi_s_axis_tvalid),

        .axis_wr_data_count(),
        .s_axis_tuser(),
        .m_axis_tuser(),
        .s_axis_tdest(),
        .m_axis_tdest(),
        .s_axis_tid(),
        .m_axis_tid(),
        .almost_full(),
        .almost_empty()
    );


    // SPI Master
    // ------------------

    wire one_selected_adc = select_adc[2] == 1'b1 || select_adc[1] == 2'b1 || select_adc[0] == 1'b1;

    // Removed this, I don't think it is necessary, this original code is very old
    //wire spi_io_m_axis_tready = miso_fifo_ready || !(select_adc[2] == 1'b1 || select_adc[1] == 2'b1 || select_adc[0] == 1'b1);

    // mosi_fifo_m_axis_tvalid is 1 if the output fifo has bytes, it is masked by spi_send_frame - if spi_send_frame is 0, this valid signal will be 0, the spi master will think there are no bytes
    wire spi_io_s_axis_tvalid = one_selected_adc & mosi_fifo_m_axis_tvalid;

    wire miso_fifo_ready;

    spi_axis_if_v1 #(.QSPI(0),.MSB_FIRST(1),.CLOCK_OUT_CG(1)) spi_io(
        .clk(clk_spi),
        .resn(clk_spi_resn),
        .enable(1'd0),
        .m_axis_tdata(spi_io_m_axis_tdata),
        .m_axis_tready(miso_fifo_ready),
        .m_axis_tvalid(spi_io_m_axis_tvalid),
        .s_axis_tdata(mosi_fifo_m_axis_tdata),
        .s_axis_tready(mosi_fifo_m_axis_tready),
        .s_axis_tvalid(spi_io_s_axis_tvalid),
        .spi_clk(ext_spi_clk),
        .spi_csn(ext_spi_csn),
        .spi_miso(ext_spi_miso),
        .spi_mosi(ext_spi_mosi)
    );


    // Module Instance
    wire miso_valid = spi_io_m_axis_tvalid & (select_adc[2] == 1'b1 || select_adc[1] == 1'b1 || select_adc[0] == 1'b1);// Slave out bytes are only valid if adc is selected
    fifo_axis_common #(.AWIDTH(5),.USE_TID(0),.USE_TDEST(0),.TLAST(0))  miso_fifo(

        .m_axis_aclk(clk_core),
        .m_axis_aresetn(clk_core_resn),
        .m_axis_tdata(ext_adc_miso_m_axis_tdata),
        .m_axis_tlast(/* unused */),
        .m_axis_tready(ext_adc_miso_m_axis_tready),
        .m_axis_tvalid(ext_adc_miso_m_axis_tvalid),

        .axis_rd_data_count(ext_adc_miso_read_size),

        .s_axis_aclk(clk_spi),
        .s_axis_aresetn(clk_spi_resn),

        .s_axis_tdata(spi_io_m_axis_tdata),
        .s_axis_tlast(1'd1),
        .s_axis_tready(miso_fifo_ready), // If ADC not selected, always set ready to 1
        .s_axis_tvalid(miso_valid),

        .axis_wr_data_count(),
        .s_axis_tuser(),
        .m_axis_tuser(),
        .s_axis_tdest(),
        .m_axis_tdest(),
        .s_axis_tid(),
        .m_axis_tid(),
        .almost_full(),
        .almost_empty()

    );



endmodule
