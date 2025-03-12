


/*
    Wrapper Module with SPI interfaces for Housekeeping

    At the moment there is one SPI Master, ADC/DAC are selected over Chip Select
*/
module housekeeping_main(
    input  wire			clk_core,
    input  wire			clk_core_resn,
    input  wire			clk_spi,
    input  wire			clk_spi_resn,
    input  wire                 select_adc,
    output wire [7:0]		ext_adc_miso_m_axis_tdata,
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
            

    // Module Instance
    wire miso_fifo_ready;
    wire spi_io_m_axis_tready = miso_fifo_ready || !select_adc;
    spi_axis_if_v1 #(.QSPI(0),.MSB_FIRST(0),.CLOCK_OUT_CG(1)) spi_io(
        .clk(clk_spi),
        .resn(clk_spi_resn),
        .enable(1'd0),
        .m_axis_tdata(spi_io_m_axis_tdata),
        .m_axis_tready(spi_io_m_axis_tready),
        .m_axis_tvalid(spi_io_m_axis_tvalid),
        .s_axis_tdata(mosi_fifo_m_axis_tdata),
        .s_axis_tready(mosi_fifo_m_axis_tready),
        .s_axis_tvalid(mosi_fifo_m_axis_tvalid),
        .spi_clk(ext_spi_clk),
        .spi_csn(ext_spi_csn),
        .spi_miso(ext_spi_miso),
        .spi_mosi(ext_spi_mosi)
    );
            

    // Module Instance
    wire miso_valid = spi_io_m_axis_tvalid & select_adc;// Slave out bytes are only valid if adc is selected
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

        
