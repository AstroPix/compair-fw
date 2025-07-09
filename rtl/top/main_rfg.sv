module main_rfg(
    // IO
    // RFG R/W Interface,
    // --------------------,
    input  wire                clk,
    input  wire                resn,
    input  wire  [15:0]         rfg_address,
    input  wire  [7:0]         rfg_write_value,
    input  wire                rfg_write,
    input  wire                rfg_write_last,
    input  wire                rfg_read,
    output reg                 rfg_read_valid,
    output reg  [7:0]          rfg_read_value,

    input  wire [15:0]            hk_xadc_temperature,
    input  wire                  hk_xadc_temperature_write,
    input  wire [15:0]            hk_xadc_vccint,
    input  wire                  hk_xadc_vccint_write,
    output wire [31:0]            hk_conversion_trigger,
    output  reg                  hk_conversion_trigger_interrupt,
    input   wire                  hk_stat_conversions_counter_enable,
    output wire [7:0]            hk_ctrl,
    output wire                  hk_ctrl_select_adc0,
    output wire                  hk_ctrl_select_adc1,
    output wire                  hk_ctrl_select_adc2,
    // AXIS Master interface to write to FIFO hk_adcdac_mosi_fifo,
    // --------------------,
    output reg [7:0]             hk_adcdac_mosi_fifo_m_axis_tdata,
    output reg                   hk_adcdac_mosi_fifo_m_axis_tvalid,
    input  wire                  hk_adcdac_mosi_fifo_m_axis_tready,
    output reg            hk_adcdac_mosi_fifo_m_axis_tlast,
    // AXIS Slave interface to read from FIFO hk_adc_miso_fifo,
    // --------------------,
    input  wire [7:0]            hk_adc_miso_fifo_s_axis_tdata,
    input  wire                  hk_adc_miso_fifo_s_axis_tvalid,
    output wire                  hk_adc_miso_fifo_s_axis_tready,
    input  wire [31:0]            hk_adc_miso_fifo_read_size,
    input  wire                  hk_adc_miso_fifo_read_size_write,
    input  wire            spi_lanes_ckdivider_source_clk,
    input  wire            spi_lanes_ckdivider_source_resn,
    output reg             spi_lanes_ckdivider_divided_clk,
    output wire            spi_lanes_ckdivider_divided_resn,
    input  wire            spi_hk_ckdivider_source_clk,
    input  wire            spi_hk_ckdivider_source_resn,
    output reg             spi_hk_ckdivider_divided_clk,
    output wire            spi_hk_ckdivider_divided_resn,
    output wire [7:0]            lane_0_cfg_ctrl,
    output wire                  lane_0_cfg_ctrl_hold,
    output wire                  lane_0_cfg_ctrl_reset,
    output wire                  lane_0_cfg_ctrl_disable_autoread,
    output wire                  lane_0_cfg_ctrl_cs,
    output wire                  lane_0_cfg_ctrl_disable_miso,
    output wire                  lane_0_cfg_ctrl_loopback,
    output wire [7:0]            lane_1_cfg_ctrl,
    output wire                  lane_1_cfg_ctrl_hold,
    output wire                  lane_1_cfg_ctrl_reset,
    output wire                  lane_1_cfg_ctrl_disable_autoread,
    output wire                  lane_1_cfg_ctrl_cs,
    output wire                  lane_1_cfg_ctrl_disable_miso,
    output wire                  lane_1_cfg_ctrl_loopback,
    output wire [7:0]            lane_2_cfg_ctrl,
    output wire                  lane_2_cfg_ctrl_hold,
    output wire                  lane_2_cfg_ctrl_reset,
    output wire                  lane_2_cfg_ctrl_disable_autoread,
    output wire                  lane_2_cfg_ctrl_cs,
    output wire                  lane_2_cfg_ctrl_disable_miso,
    output wire                  lane_2_cfg_ctrl_loopback,
    output wire [7:0]            lane_3_cfg_ctrl,
    output wire                  lane_3_cfg_ctrl_hold,
    output wire                  lane_3_cfg_ctrl_reset,
    output wire                  lane_3_cfg_ctrl_disable_autoread,
    output wire                  lane_3_cfg_ctrl_cs,
    output wire                  lane_3_cfg_ctrl_disable_miso,
    output wire                  lane_3_cfg_ctrl_loopback,
    output wire [7:0]            lane_4_cfg_ctrl,
    output wire                  lane_4_cfg_ctrl_hold,
    output wire                  lane_4_cfg_ctrl_reset,
    output wire                  lane_4_cfg_ctrl_disable_autoread,
    output wire                  lane_4_cfg_ctrl_cs,
    output wire                  lane_4_cfg_ctrl_disable_miso,
    output wire                  lane_4_cfg_ctrl_loopback,
    output wire [7:0]            lane_5_cfg_ctrl,
    output wire                  lane_5_cfg_ctrl_hold,
    output wire                  lane_5_cfg_ctrl_reset,
    output wire                  lane_5_cfg_ctrl_disable_autoread,
    output wire                  lane_5_cfg_ctrl_cs,
    output wire                  lane_5_cfg_ctrl_disable_miso,
    output wire                  lane_5_cfg_ctrl_loopback,
    output wire [7:0]            lane_6_cfg_ctrl,
    output wire                  lane_6_cfg_ctrl_hold,
    output wire                  lane_6_cfg_ctrl_reset,
    output wire                  lane_6_cfg_ctrl_disable_autoread,
    output wire                  lane_6_cfg_ctrl_cs,
    output wire                  lane_6_cfg_ctrl_disable_miso,
    output wire                  lane_6_cfg_ctrl_loopback,
    output wire [7:0]            lane_7_cfg_ctrl,
    output wire                  lane_7_cfg_ctrl_hold,
    output wire                  lane_7_cfg_ctrl_reset,
    output wire                  lane_7_cfg_ctrl_disable_autoread,
    output wire                  lane_7_cfg_ctrl_cs,
    output wire                  lane_7_cfg_ctrl_disable_miso,
    output wire                  lane_7_cfg_ctrl_loopback,
    output wire [7:0]            lane_8_cfg_ctrl,
    output wire                  lane_8_cfg_ctrl_hold,
    output wire                  lane_8_cfg_ctrl_reset,
    output wire                  lane_8_cfg_ctrl_disable_autoread,
    output wire                  lane_8_cfg_ctrl_cs,
    output wire                  lane_8_cfg_ctrl_disable_miso,
    output wire                  lane_8_cfg_ctrl_loopback,
    output wire [7:0]            lane_9_cfg_ctrl,
    output wire                  lane_9_cfg_ctrl_hold,
    output wire                  lane_9_cfg_ctrl_reset,
    output wire                  lane_9_cfg_ctrl_disable_autoread,
    output wire                  lane_9_cfg_ctrl_cs,
    output wire                  lane_9_cfg_ctrl_disable_miso,
    output wire                  lane_9_cfg_ctrl_loopback,
    output wire [7:0]            lane_10_cfg_ctrl,
    output wire                  lane_10_cfg_ctrl_hold,
    output wire                  lane_10_cfg_ctrl_reset,
    output wire                  lane_10_cfg_ctrl_disable_autoread,
    output wire                  lane_10_cfg_ctrl_cs,
    output wire                  lane_10_cfg_ctrl_disable_miso,
    output wire                  lane_10_cfg_ctrl_loopback,
    output wire [7:0]            lane_11_cfg_ctrl,
    output wire                  lane_11_cfg_ctrl_hold,
    output wire                  lane_11_cfg_ctrl_reset,
    output wire                  lane_11_cfg_ctrl_disable_autoread,
    output wire                  lane_11_cfg_ctrl_cs,
    output wire                  lane_11_cfg_ctrl_disable_miso,
    output wire                  lane_11_cfg_ctrl_loopback,
    output wire [7:0]            lane_12_cfg_ctrl,
    output wire                  lane_12_cfg_ctrl_hold,
    output wire                  lane_12_cfg_ctrl_reset,
    output wire                  lane_12_cfg_ctrl_disable_autoread,
    output wire                  lane_12_cfg_ctrl_cs,
    output wire                  lane_12_cfg_ctrl_disable_miso,
    output wire                  lane_12_cfg_ctrl_loopback,
    output wire [7:0]            lane_13_cfg_ctrl,
    output wire                  lane_13_cfg_ctrl_hold,
    output wire                  lane_13_cfg_ctrl_reset,
    output wire                  lane_13_cfg_ctrl_disable_autoread,
    output wire                  lane_13_cfg_ctrl_cs,
    output wire                  lane_13_cfg_ctrl_disable_miso,
    output wire                  lane_13_cfg_ctrl_loopback,
    output wire [7:0]            lane_14_cfg_ctrl,
    output wire                  lane_14_cfg_ctrl_hold,
    output wire                  lane_14_cfg_ctrl_reset,
    output wire                  lane_14_cfg_ctrl_disable_autoread,
    output wire                  lane_14_cfg_ctrl_cs,
    output wire                  lane_14_cfg_ctrl_disable_miso,
    output wire                  lane_14_cfg_ctrl_loopback,
    output wire [7:0]            lane_15_cfg_ctrl,
    output wire                  lane_15_cfg_ctrl_hold,
    output wire                  lane_15_cfg_ctrl_reset,
    output wire                  lane_15_cfg_ctrl_disable_autoread,
    output wire                  lane_15_cfg_ctrl_cs,
    output wire                  lane_15_cfg_ctrl_disable_miso,
    output wire                  lane_15_cfg_ctrl_loopback,
    output wire [7:0]            lane_16_cfg_ctrl,
    output wire                  lane_16_cfg_ctrl_hold,
    output wire                  lane_16_cfg_ctrl_reset,
    output wire                  lane_16_cfg_ctrl_disable_autoread,
    output wire                  lane_16_cfg_ctrl_cs,
    output wire                  lane_16_cfg_ctrl_disable_miso,
    output wire                  lane_16_cfg_ctrl_loopback,
    output wire [7:0]            lane_17_cfg_ctrl,
    output wire                  lane_17_cfg_ctrl_hold,
    output wire                  lane_17_cfg_ctrl_reset,
    output wire                  lane_17_cfg_ctrl_disable_autoread,
    output wire                  lane_17_cfg_ctrl_cs,
    output wire                  lane_17_cfg_ctrl_disable_miso,
    output wire                  lane_17_cfg_ctrl_loopback,
    output wire [7:0]            lane_18_cfg_ctrl,
    output wire                  lane_18_cfg_ctrl_hold,
    output wire                  lane_18_cfg_ctrl_reset,
    output wire                  lane_18_cfg_ctrl_disable_autoread,
    output wire                  lane_18_cfg_ctrl_cs,
    output wire                  lane_18_cfg_ctrl_disable_miso,
    output wire                  lane_18_cfg_ctrl_loopback,
    output wire [7:0]            lane_19_cfg_ctrl,
    output wire                  lane_19_cfg_ctrl_hold,
    output wire                  lane_19_cfg_ctrl_reset,
    output wire                  lane_19_cfg_ctrl_disable_autoread,
    output wire                  lane_19_cfg_ctrl_cs,
    output wire                  lane_19_cfg_ctrl_disable_miso,
    output wire                  lane_19_cfg_ctrl_loopback,
    output wire [7:0]            lane_0_status,
    input  wire                  lane_0_status_interruptn,
    input  wire                  lane_0_status_frame_decoding,
    output wire [7:0]            lane_1_status,
    input  wire                  lane_1_status_interruptn,
    input  wire                  lane_1_status_frame_decoding,
    output wire [7:0]            lane_2_status,
    input  wire                  lane_2_status_interruptn,
    input  wire                  lane_2_status_frame_decoding,
    output wire [7:0]            lane_3_status,
    input  wire                  lane_3_status_interruptn,
    input  wire                  lane_3_status_frame_decoding,
    output wire [7:0]            lane_4_status,
    input  wire                  lane_4_status_interruptn,
    input  wire                  lane_4_status_frame_decoding,
    output wire [7:0]            lane_5_status,
    input  wire                  lane_5_status_interruptn,
    input  wire                  lane_5_status_frame_decoding,
    output wire [7:0]            lane_6_status,
    input  wire                  lane_6_status_interruptn,
    input  wire                  lane_6_status_frame_decoding,
    output wire [7:0]            lane_7_status,
    input  wire                  lane_7_status_interruptn,
    input  wire                  lane_7_status_frame_decoding,
    output wire [7:0]            lane_8_status,
    input  wire                  lane_8_status_interruptn,
    input  wire                  lane_8_status_frame_decoding,
    output wire [7:0]            lane_9_status,
    input  wire                  lane_9_status_interruptn,
    input  wire                  lane_9_status_frame_decoding,
    output wire [7:0]            lane_10_status,
    input  wire                  lane_10_status_interruptn,
    input  wire                  lane_10_status_frame_decoding,
    output wire [7:0]            lane_11_status,
    input  wire                  lane_11_status_interruptn,
    input  wire                  lane_11_status_frame_decoding,
    output wire [7:0]            lane_12_status,
    input  wire                  lane_12_status_interruptn,
    input  wire                  lane_12_status_frame_decoding,
    output wire [7:0]            lane_13_status,
    input  wire                  lane_13_status_interruptn,
    input  wire                  lane_13_status_frame_decoding,
    output wire [7:0]            lane_14_status,
    input  wire                  lane_14_status_interruptn,
    input  wire                  lane_14_status_frame_decoding,
    output wire [7:0]            lane_15_status,
    input  wire                  lane_15_status_interruptn,
    input  wire                  lane_15_status_frame_decoding,
    output wire [7:0]            lane_16_status,
    input  wire                  lane_16_status_interruptn,
    input  wire                  lane_16_status_frame_decoding,
    output wire [7:0]            lane_17_status,
    input  wire                  lane_17_status_interruptn,
    input  wire                  lane_17_status_frame_decoding,
    output wire [7:0]            lane_18_status,
    input  wire                  lane_18_status_interruptn,
    input  wire                  lane_18_status_frame_decoding,
    output wire [7:0]            lane_19_status,
    input  wire                  lane_19_status_interruptn,
    input  wire                  lane_19_status_frame_decoding,
    input   wire                  lane_0_stat_frame_counter_enable,
    input   wire                  lane_1_stat_frame_counter_enable,
    input   wire                  lane_2_stat_frame_counter_enable,
    input   wire                  lane_3_stat_frame_counter_enable,
    input   wire                  lane_4_stat_frame_counter_enable,
    input   wire                  lane_5_stat_frame_counter_enable,
    input   wire                  lane_6_stat_frame_counter_enable,
    input   wire                  lane_7_stat_frame_counter_enable,
    input   wire                  lane_8_stat_frame_counter_enable,
    input   wire                  lane_9_stat_frame_counter_enable,
    input   wire                  lane_10_stat_frame_counter_enable,
    input   wire                  lane_11_stat_frame_counter_enable,
    input   wire                  lane_12_stat_frame_counter_enable,
    input   wire                  lane_13_stat_frame_counter_enable,
    input   wire                  lane_14_stat_frame_counter_enable,
    input   wire                  lane_15_stat_frame_counter_enable,
    input   wire                  lane_16_stat_frame_counter_enable,
    input   wire                  lane_17_stat_frame_counter_enable,
    input   wire                  lane_18_stat_frame_counter_enable,
    input   wire                  lane_19_stat_frame_counter_enable,
    input   wire                  lane_0_stat_idle_counter_enable,
    input   wire                  lane_1_stat_idle_counter_enable,
    input   wire                  lane_2_stat_idle_counter_enable,
    input   wire                  lane_3_stat_idle_counter_enable,
    input   wire                  lane_4_stat_idle_counter_enable,
    input   wire                  lane_5_stat_idle_counter_enable,
    input   wire                  lane_6_stat_idle_counter_enable,
    input   wire                  lane_7_stat_idle_counter_enable,
    input   wire                  lane_8_stat_idle_counter_enable,
    input   wire                  lane_9_stat_idle_counter_enable,
    input   wire                  lane_10_stat_idle_counter_enable,
    input   wire                  lane_11_stat_idle_counter_enable,
    input   wire                  lane_12_stat_idle_counter_enable,
    input   wire                  lane_13_stat_idle_counter_enable,
    input   wire                  lane_14_stat_idle_counter_enable,
    input   wire                  lane_15_stat_idle_counter_enable,
    input   wire                  lane_16_stat_idle_counter_enable,
    input   wire                  lane_17_stat_idle_counter_enable,
    input   wire                  lane_18_stat_idle_counter_enable,
    input   wire                  lane_19_stat_idle_counter_enable,
    // AXIS Master interface to write to FIFO lane_0_mosi,
    // --------------------,
    output reg [7:0]             lane_0_mosi_m_axis_tdata,
    output reg                   lane_0_mosi_m_axis_tvalid,
    input  wire                  lane_0_mosi_m_axis_tready,
    output reg            lane_0_mosi_m_axis_tlast,
    input  wire [31:0]            lane_0_mosi_write_size,
    input  wire                  lane_0_mosi_write_size_write,
    // AXIS Master interface to write to FIFO lane_1_mosi,
    // --------------------,
    output reg [7:0]             lane_1_mosi_m_axis_tdata,
    output reg                   lane_1_mosi_m_axis_tvalid,
    input  wire                  lane_1_mosi_m_axis_tready,
    output reg            lane_1_mosi_m_axis_tlast,
    input  wire [31:0]            lane_1_mosi_write_size,
    input  wire                  lane_1_mosi_write_size_write,
    // AXIS Master interface to write to FIFO lane_2_mosi,
    // --------------------,
    output reg [7:0]             lane_2_mosi_m_axis_tdata,
    output reg                   lane_2_mosi_m_axis_tvalid,
    input  wire                  lane_2_mosi_m_axis_tready,
    output reg            lane_2_mosi_m_axis_tlast,
    input  wire [31:0]            lane_2_mosi_write_size,
    input  wire                  lane_2_mosi_write_size_write,
    // AXIS Master interface to write to FIFO lane_3_mosi,
    // --------------------,
    output reg [7:0]             lane_3_mosi_m_axis_tdata,
    output reg                   lane_3_mosi_m_axis_tvalid,
    input  wire                  lane_3_mosi_m_axis_tready,
    output reg            lane_3_mosi_m_axis_tlast,
    input  wire [31:0]            lane_3_mosi_write_size,
    input  wire                  lane_3_mosi_write_size_write,
    // AXIS Master interface to write to FIFO lane_4_mosi,
    // --------------------,
    output reg [7:0]             lane_4_mosi_m_axis_tdata,
    output reg                   lane_4_mosi_m_axis_tvalid,
    input  wire                  lane_4_mosi_m_axis_tready,
    output reg            lane_4_mosi_m_axis_tlast,
    input  wire [31:0]            lane_4_mosi_write_size,
    input  wire                  lane_4_mosi_write_size_write,
    // AXIS Master interface to write to FIFO lane_5_mosi,
    // --------------------,
    output reg [7:0]             lane_5_mosi_m_axis_tdata,
    output reg                   lane_5_mosi_m_axis_tvalid,
    input  wire                  lane_5_mosi_m_axis_tready,
    output reg            lane_5_mosi_m_axis_tlast,
    input  wire [31:0]            lane_5_mosi_write_size,
    input  wire                  lane_5_mosi_write_size_write,
    // AXIS Master interface to write to FIFO lane_6_mosi,
    // --------------------,
    output reg [7:0]             lane_6_mosi_m_axis_tdata,
    output reg                   lane_6_mosi_m_axis_tvalid,
    input  wire                  lane_6_mosi_m_axis_tready,
    output reg            lane_6_mosi_m_axis_tlast,
    input  wire [31:0]            lane_6_mosi_write_size,
    input  wire                  lane_6_mosi_write_size_write,
    // AXIS Master interface to write to FIFO lane_7_mosi,
    // --------------------,
    output reg [7:0]             lane_7_mosi_m_axis_tdata,
    output reg                   lane_7_mosi_m_axis_tvalid,
    input  wire                  lane_7_mosi_m_axis_tready,
    output reg            lane_7_mosi_m_axis_tlast,
    input  wire [31:0]            lane_7_mosi_write_size,
    input  wire                  lane_7_mosi_write_size_write,
    // AXIS Master interface to write to FIFO lane_8_mosi,
    // --------------------,
    output reg [7:0]             lane_8_mosi_m_axis_tdata,
    output reg                   lane_8_mosi_m_axis_tvalid,
    input  wire                  lane_8_mosi_m_axis_tready,
    output reg            lane_8_mosi_m_axis_tlast,
    input  wire [31:0]            lane_8_mosi_write_size,
    input  wire                  lane_8_mosi_write_size_write,
    // AXIS Master interface to write to FIFO lane_9_mosi,
    // --------------------,
    output reg [7:0]             lane_9_mosi_m_axis_tdata,
    output reg                   lane_9_mosi_m_axis_tvalid,
    input  wire                  lane_9_mosi_m_axis_tready,
    output reg            lane_9_mosi_m_axis_tlast,
    input  wire [31:0]            lane_9_mosi_write_size,
    input  wire                  lane_9_mosi_write_size_write,
    // AXIS Master interface to write to FIFO lane_10_mosi,
    // --------------------,
    output reg [7:0]             lane_10_mosi_m_axis_tdata,
    output reg                   lane_10_mosi_m_axis_tvalid,
    input  wire                  lane_10_mosi_m_axis_tready,
    output reg            lane_10_mosi_m_axis_tlast,
    input  wire [31:0]            lane_10_mosi_write_size,
    input  wire                  lane_10_mosi_write_size_write,
    // AXIS Master interface to write to FIFO lane_11_mosi,
    // --------------------,
    output reg [7:0]             lane_11_mosi_m_axis_tdata,
    output reg                   lane_11_mosi_m_axis_tvalid,
    input  wire                  lane_11_mosi_m_axis_tready,
    output reg            lane_11_mosi_m_axis_tlast,
    input  wire [31:0]            lane_11_mosi_write_size,
    input  wire                  lane_11_mosi_write_size_write,
    // AXIS Master interface to write to FIFO lane_12_mosi,
    // --------------------,
    output reg [7:0]             lane_12_mosi_m_axis_tdata,
    output reg                   lane_12_mosi_m_axis_tvalid,
    input  wire                  lane_12_mosi_m_axis_tready,
    output reg            lane_12_mosi_m_axis_tlast,
    input  wire [31:0]            lane_12_mosi_write_size,
    input  wire                  lane_12_mosi_write_size_write,
    // AXIS Master interface to write to FIFO lane_13_mosi,
    // --------------------,
    output reg [7:0]             lane_13_mosi_m_axis_tdata,
    output reg                   lane_13_mosi_m_axis_tvalid,
    input  wire                  lane_13_mosi_m_axis_tready,
    output reg            lane_13_mosi_m_axis_tlast,
    input  wire [31:0]            lane_13_mosi_write_size,
    input  wire                  lane_13_mosi_write_size_write,
    // AXIS Master interface to write to FIFO lane_14_mosi,
    // --------------------,
    output reg [7:0]             lane_14_mosi_m_axis_tdata,
    output reg                   lane_14_mosi_m_axis_tvalid,
    input  wire                  lane_14_mosi_m_axis_tready,
    output reg            lane_14_mosi_m_axis_tlast,
    input  wire [31:0]            lane_14_mosi_write_size,
    input  wire                  lane_14_mosi_write_size_write,
    // AXIS Master interface to write to FIFO lane_15_mosi,
    // --------------------,
    output reg [7:0]             lane_15_mosi_m_axis_tdata,
    output reg                   lane_15_mosi_m_axis_tvalid,
    input  wire                  lane_15_mosi_m_axis_tready,
    output reg            lane_15_mosi_m_axis_tlast,
    input  wire [31:0]            lane_15_mosi_write_size,
    input  wire                  lane_15_mosi_write_size_write,
    // AXIS Master interface to write to FIFO lane_16_mosi,
    // --------------------,
    output reg [7:0]             lane_16_mosi_m_axis_tdata,
    output reg                   lane_16_mosi_m_axis_tvalid,
    input  wire                  lane_16_mosi_m_axis_tready,
    output reg            lane_16_mosi_m_axis_tlast,
    input  wire [31:0]            lane_16_mosi_write_size,
    input  wire                  lane_16_mosi_write_size_write,
    // AXIS Master interface to write to FIFO lane_17_mosi,
    // --------------------,
    output reg [7:0]             lane_17_mosi_m_axis_tdata,
    output reg                   lane_17_mosi_m_axis_tvalid,
    input  wire                  lane_17_mosi_m_axis_tready,
    output reg            lane_17_mosi_m_axis_tlast,
    input  wire [31:0]            lane_17_mosi_write_size,
    input  wire                  lane_17_mosi_write_size_write,
    // AXIS Master interface to write to FIFO lane_18_mosi,
    // --------------------,
    output reg [7:0]             lane_18_mosi_m_axis_tdata,
    output reg                   lane_18_mosi_m_axis_tvalid,
    input  wire                  lane_18_mosi_m_axis_tready,
    output reg            lane_18_mosi_m_axis_tlast,
    input  wire [31:0]            lane_18_mosi_write_size,
    input  wire                  lane_18_mosi_write_size_write,
    // AXIS Master interface to write to FIFO lane_19_mosi,
    // --------------------,
    output reg [7:0]             lane_19_mosi_m_axis_tdata,
    output reg                   lane_19_mosi_m_axis_tvalid,
    input  wire                  lane_19_mosi_m_axis_tready,
    output reg            lane_19_mosi_m_axis_tlast,
    input  wire [31:0]            lane_19_mosi_write_size,
    input  wire                  lane_19_mosi_write_size_write,
    // AXIS Master interface to write to FIFO lane_0_loopback_miso,
    // --------------------,
    output reg [7:0]             lane_0_loopback_miso_m_axis_tdata,
    output reg                   lane_0_loopback_miso_m_axis_tvalid,
    input  wire                  lane_0_loopback_miso_m_axis_tready,
    input  wire [31:0]            lane_0_loopback_miso_write_size,
    input  wire                  lane_0_loopback_miso_write_size_write,
    // AXIS Master interface to write to FIFO lane_1_loopback_miso,
    // --------------------,
    output reg [7:0]             lane_1_loopback_miso_m_axis_tdata,
    output reg                   lane_1_loopback_miso_m_axis_tvalid,
    input  wire                  lane_1_loopback_miso_m_axis_tready,
    input  wire [31:0]            lane_1_loopback_miso_write_size,
    input  wire                  lane_1_loopback_miso_write_size_write,
    // AXIS Master interface to write to FIFO lane_2_loopback_miso,
    // --------------------,
    output reg [7:0]             lane_2_loopback_miso_m_axis_tdata,
    output reg                   lane_2_loopback_miso_m_axis_tvalid,
    input  wire                  lane_2_loopback_miso_m_axis_tready,
    input  wire [31:0]            lane_2_loopback_miso_write_size,
    input  wire                  lane_2_loopback_miso_write_size_write,
    // AXIS Master interface to write to FIFO lane_3_loopback_miso,
    // --------------------,
    output reg [7:0]             lane_3_loopback_miso_m_axis_tdata,
    output reg                   lane_3_loopback_miso_m_axis_tvalid,
    input  wire                  lane_3_loopback_miso_m_axis_tready,
    input  wire [31:0]            lane_3_loopback_miso_write_size,
    input  wire                  lane_3_loopback_miso_write_size_write,
    // AXIS Master interface to write to FIFO lane_4_loopback_miso,
    // --------------------,
    output reg [7:0]             lane_4_loopback_miso_m_axis_tdata,
    output reg                   lane_4_loopback_miso_m_axis_tvalid,
    input  wire                  lane_4_loopback_miso_m_axis_tready,
    input  wire [31:0]            lane_4_loopback_miso_write_size,
    input  wire                  lane_4_loopback_miso_write_size_write,
    // AXIS Master interface to write to FIFO lane_5_loopback_miso,
    // --------------------,
    output reg [7:0]             lane_5_loopback_miso_m_axis_tdata,
    output reg                   lane_5_loopback_miso_m_axis_tvalid,
    input  wire                  lane_5_loopback_miso_m_axis_tready,
    input  wire [31:0]            lane_5_loopback_miso_write_size,
    input  wire                  lane_5_loopback_miso_write_size_write,
    // AXIS Master interface to write to FIFO lane_6_loopback_miso,
    // --------------------,
    output reg [7:0]             lane_6_loopback_miso_m_axis_tdata,
    output reg                   lane_6_loopback_miso_m_axis_tvalid,
    input  wire                  lane_6_loopback_miso_m_axis_tready,
    input  wire [31:0]            lane_6_loopback_miso_write_size,
    input  wire                  lane_6_loopback_miso_write_size_write,
    // AXIS Master interface to write to FIFO lane_7_loopback_miso,
    // --------------------,
    output reg [7:0]             lane_7_loopback_miso_m_axis_tdata,
    output reg                   lane_7_loopback_miso_m_axis_tvalid,
    input  wire                  lane_7_loopback_miso_m_axis_tready,
    input  wire [31:0]            lane_7_loopback_miso_write_size,
    input  wire                  lane_7_loopback_miso_write_size_write,
    // AXIS Master interface to write to FIFO lane_8_loopback_miso,
    // --------------------,
    output reg [7:0]             lane_8_loopback_miso_m_axis_tdata,
    output reg                   lane_8_loopback_miso_m_axis_tvalid,
    input  wire                  lane_8_loopback_miso_m_axis_tready,
    input  wire [31:0]            lane_8_loopback_miso_write_size,
    input  wire                  lane_8_loopback_miso_write_size_write,
    // AXIS Master interface to write to FIFO lane_9_loopback_miso,
    // --------------------,
    output reg [7:0]             lane_9_loopback_miso_m_axis_tdata,
    output reg                   lane_9_loopback_miso_m_axis_tvalid,
    input  wire                  lane_9_loopback_miso_m_axis_tready,
    input  wire [31:0]            lane_9_loopback_miso_write_size,
    input  wire                  lane_9_loopback_miso_write_size_write,
    // AXIS Master interface to write to FIFO lane_10_loopback_miso,
    // --------------------,
    output reg [7:0]             lane_10_loopback_miso_m_axis_tdata,
    output reg                   lane_10_loopback_miso_m_axis_tvalid,
    input  wire                  lane_10_loopback_miso_m_axis_tready,
    input  wire [31:0]            lane_10_loopback_miso_write_size,
    input  wire                  lane_10_loopback_miso_write_size_write,
    // AXIS Master interface to write to FIFO lane_11_loopback_miso,
    // --------------------,
    output reg [7:0]             lane_11_loopback_miso_m_axis_tdata,
    output reg                   lane_11_loopback_miso_m_axis_tvalid,
    input  wire                  lane_11_loopback_miso_m_axis_tready,
    input  wire [31:0]            lane_11_loopback_miso_write_size,
    input  wire                  lane_11_loopback_miso_write_size_write,
    // AXIS Master interface to write to FIFO lane_12_loopback_miso,
    // --------------------,
    output reg [7:0]             lane_12_loopback_miso_m_axis_tdata,
    output reg                   lane_12_loopback_miso_m_axis_tvalid,
    input  wire                  lane_12_loopback_miso_m_axis_tready,
    input  wire [31:0]            lane_12_loopback_miso_write_size,
    input  wire                  lane_12_loopback_miso_write_size_write,
    // AXIS Master interface to write to FIFO lane_13_loopback_miso,
    // --------------------,
    output reg [7:0]             lane_13_loopback_miso_m_axis_tdata,
    output reg                   lane_13_loopback_miso_m_axis_tvalid,
    input  wire                  lane_13_loopback_miso_m_axis_tready,
    input  wire [31:0]            lane_13_loopback_miso_write_size,
    input  wire                  lane_13_loopback_miso_write_size_write,
    // AXIS Master interface to write to FIFO lane_14_loopback_miso,
    // --------------------,
    output reg [7:0]             lane_14_loopback_miso_m_axis_tdata,
    output reg                   lane_14_loopback_miso_m_axis_tvalid,
    input  wire                  lane_14_loopback_miso_m_axis_tready,
    input  wire [31:0]            lane_14_loopback_miso_write_size,
    input  wire                  lane_14_loopback_miso_write_size_write,
    // AXIS Master interface to write to FIFO lane_15_loopback_miso,
    // --------------------,
    output reg [7:0]             lane_15_loopback_miso_m_axis_tdata,
    output reg                   lane_15_loopback_miso_m_axis_tvalid,
    input  wire                  lane_15_loopback_miso_m_axis_tready,
    input  wire [31:0]            lane_15_loopback_miso_write_size,
    input  wire                  lane_15_loopback_miso_write_size_write,
    // AXIS Master interface to write to FIFO lane_16_loopback_miso,
    // --------------------,
    output reg [7:0]             lane_16_loopback_miso_m_axis_tdata,
    output reg                   lane_16_loopback_miso_m_axis_tvalid,
    input  wire                  lane_16_loopback_miso_m_axis_tready,
    input  wire [31:0]            lane_16_loopback_miso_write_size,
    input  wire                  lane_16_loopback_miso_write_size_write,
    // AXIS Master interface to write to FIFO lane_17_loopback_miso,
    // --------------------,
    output reg [7:0]             lane_17_loopback_miso_m_axis_tdata,
    output reg                   lane_17_loopback_miso_m_axis_tvalid,
    input  wire                  lane_17_loopback_miso_m_axis_tready,
    input  wire [31:0]            lane_17_loopback_miso_write_size,
    input  wire                  lane_17_loopback_miso_write_size_write,
    // AXIS Master interface to write to FIFO lane_18_loopback_miso,
    // --------------------,
    output reg [7:0]             lane_18_loopback_miso_m_axis_tdata,
    output reg                   lane_18_loopback_miso_m_axis_tvalid,
    input  wire                  lane_18_loopback_miso_m_axis_tready,
    input  wire [31:0]            lane_18_loopback_miso_write_size,
    input  wire                  lane_18_loopback_miso_write_size_write,
    // AXIS Master interface to write to FIFO lane_19_loopback_miso,
    // --------------------,
    output reg [7:0]             lane_19_loopback_miso_m_axis_tdata,
    output reg                   lane_19_loopback_miso_m_axis_tvalid,
    input  wire                  lane_19_loopback_miso_m_axis_tready,
    input  wire [31:0]            lane_19_loopback_miso_write_size,
    input  wire                  lane_19_loopback_miso_write_size_write,
    // AXIS Slave interface to read from FIFO lane_0_loopback_mosi,
    // --------------------,
    input  wire [7:0]            lane_0_loopback_mosi_s_axis_tdata,
    input  wire                  lane_0_loopback_mosi_s_axis_tvalid,
    output wire                  lane_0_loopback_mosi_s_axis_tready,
    input  wire [31:0]            lane_0_loopback_mosi_read_size,
    input  wire                  lane_0_loopback_mosi_read_size_write,
    // AXIS Slave interface to read from FIFO lane_1_loopback_mosi,
    // --------------------,
    input  wire [7:0]            lane_1_loopback_mosi_s_axis_tdata,
    input  wire                  lane_1_loopback_mosi_s_axis_tvalid,
    output wire                  lane_1_loopback_mosi_s_axis_tready,
    input  wire [31:0]            lane_1_loopback_mosi_read_size,
    input  wire                  lane_1_loopback_mosi_read_size_write,
    // AXIS Slave interface to read from FIFO lane_2_loopback_mosi,
    // --------------------,
    input  wire [7:0]            lane_2_loopback_mosi_s_axis_tdata,
    input  wire                  lane_2_loopback_mosi_s_axis_tvalid,
    output wire                  lane_2_loopback_mosi_s_axis_tready,
    input  wire [31:0]            lane_2_loopback_mosi_read_size,
    input  wire                  lane_2_loopback_mosi_read_size_write,
    // AXIS Slave interface to read from FIFO lane_3_loopback_mosi,
    // --------------------,
    input  wire [7:0]            lane_3_loopback_mosi_s_axis_tdata,
    input  wire                  lane_3_loopback_mosi_s_axis_tvalid,
    output wire                  lane_3_loopback_mosi_s_axis_tready,
    input  wire [31:0]            lane_3_loopback_mosi_read_size,
    input  wire                  lane_3_loopback_mosi_read_size_write,
    // AXIS Slave interface to read from FIFO lane_4_loopback_mosi,
    // --------------------,
    input  wire [7:0]            lane_4_loopback_mosi_s_axis_tdata,
    input  wire                  lane_4_loopback_mosi_s_axis_tvalid,
    output wire                  lane_4_loopback_mosi_s_axis_tready,
    input  wire [31:0]            lane_4_loopback_mosi_read_size,
    input  wire                  lane_4_loopback_mosi_read_size_write,
    // AXIS Slave interface to read from FIFO lane_5_loopback_mosi,
    // --------------------,
    input  wire [7:0]            lane_5_loopback_mosi_s_axis_tdata,
    input  wire                  lane_5_loopback_mosi_s_axis_tvalid,
    output wire                  lane_5_loopback_mosi_s_axis_tready,
    input  wire [31:0]            lane_5_loopback_mosi_read_size,
    input  wire                  lane_5_loopback_mosi_read_size_write,
    // AXIS Slave interface to read from FIFO lane_6_loopback_mosi,
    // --------------------,
    input  wire [7:0]            lane_6_loopback_mosi_s_axis_tdata,
    input  wire                  lane_6_loopback_mosi_s_axis_tvalid,
    output wire                  lane_6_loopback_mosi_s_axis_tready,
    input  wire [31:0]            lane_6_loopback_mosi_read_size,
    input  wire                  lane_6_loopback_mosi_read_size_write,
    // AXIS Slave interface to read from FIFO lane_7_loopback_mosi,
    // --------------------,
    input  wire [7:0]            lane_7_loopback_mosi_s_axis_tdata,
    input  wire                  lane_7_loopback_mosi_s_axis_tvalid,
    output wire                  lane_7_loopback_mosi_s_axis_tready,
    input  wire [31:0]            lane_7_loopback_mosi_read_size,
    input  wire                  lane_7_loopback_mosi_read_size_write,
    // AXIS Slave interface to read from FIFO lane_8_loopback_mosi,
    // --------------------,
    input  wire [7:0]            lane_8_loopback_mosi_s_axis_tdata,
    input  wire                  lane_8_loopback_mosi_s_axis_tvalid,
    output wire                  lane_8_loopback_mosi_s_axis_tready,
    input  wire [31:0]            lane_8_loopback_mosi_read_size,
    input  wire                  lane_8_loopback_mosi_read_size_write,
    // AXIS Slave interface to read from FIFO lane_9_loopback_mosi,
    // --------------------,
    input  wire [7:0]            lane_9_loopback_mosi_s_axis_tdata,
    input  wire                  lane_9_loopback_mosi_s_axis_tvalid,
    output wire                  lane_9_loopback_mosi_s_axis_tready,
    input  wire [31:0]            lane_9_loopback_mosi_read_size,
    input  wire                  lane_9_loopback_mosi_read_size_write,
    // AXIS Slave interface to read from FIFO lane_10_loopback_mosi,
    // --------------------,
    input  wire [7:0]            lane_10_loopback_mosi_s_axis_tdata,
    input  wire                  lane_10_loopback_mosi_s_axis_tvalid,
    output wire                  lane_10_loopback_mosi_s_axis_tready,
    input  wire [31:0]            lane_10_loopback_mosi_read_size,
    input  wire                  lane_10_loopback_mosi_read_size_write,
    // AXIS Slave interface to read from FIFO lane_11_loopback_mosi,
    // --------------------,
    input  wire [7:0]            lane_11_loopback_mosi_s_axis_tdata,
    input  wire                  lane_11_loopback_mosi_s_axis_tvalid,
    output wire                  lane_11_loopback_mosi_s_axis_tready,
    input  wire [31:0]            lane_11_loopback_mosi_read_size,
    input  wire                  lane_11_loopback_mosi_read_size_write,
    // AXIS Slave interface to read from FIFO lane_12_loopback_mosi,
    // --------------------,
    input  wire [7:0]            lane_12_loopback_mosi_s_axis_tdata,
    input  wire                  lane_12_loopback_mosi_s_axis_tvalid,
    output wire                  lane_12_loopback_mosi_s_axis_tready,
    input  wire [31:0]            lane_12_loopback_mosi_read_size,
    input  wire                  lane_12_loopback_mosi_read_size_write,
    // AXIS Slave interface to read from FIFO lane_13_loopback_mosi,
    // --------------------,
    input  wire [7:0]            lane_13_loopback_mosi_s_axis_tdata,
    input  wire                  lane_13_loopback_mosi_s_axis_tvalid,
    output wire                  lane_13_loopback_mosi_s_axis_tready,
    input  wire [31:0]            lane_13_loopback_mosi_read_size,
    input  wire                  lane_13_loopback_mosi_read_size_write,
    // AXIS Slave interface to read from FIFO lane_14_loopback_mosi,
    // --------------------,
    input  wire [7:0]            lane_14_loopback_mosi_s_axis_tdata,
    input  wire                  lane_14_loopback_mosi_s_axis_tvalid,
    output wire                  lane_14_loopback_mosi_s_axis_tready,
    input  wire [31:0]            lane_14_loopback_mosi_read_size,
    input  wire                  lane_14_loopback_mosi_read_size_write,
    // AXIS Slave interface to read from FIFO lane_15_loopback_mosi,
    // --------------------,
    input  wire [7:0]            lane_15_loopback_mosi_s_axis_tdata,
    input  wire                  lane_15_loopback_mosi_s_axis_tvalid,
    output wire                  lane_15_loopback_mosi_s_axis_tready,
    input  wire [31:0]            lane_15_loopback_mosi_read_size,
    input  wire                  lane_15_loopback_mosi_read_size_write,
    // AXIS Slave interface to read from FIFO lane_16_loopback_mosi,
    // --------------------,
    input  wire [7:0]            lane_16_loopback_mosi_s_axis_tdata,
    input  wire                  lane_16_loopback_mosi_s_axis_tvalid,
    output wire                  lane_16_loopback_mosi_s_axis_tready,
    input  wire [31:0]            lane_16_loopback_mosi_read_size,
    input  wire                  lane_16_loopback_mosi_read_size_write,
    // AXIS Slave interface to read from FIFO lane_17_loopback_mosi,
    // --------------------,
    input  wire [7:0]            lane_17_loopback_mosi_s_axis_tdata,
    input  wire                  lane_17_loopback_mosi_s_axis_tvalid,
    output wire                  lane_17_loopback_mosi_s_axis_tready,
    input  wire [31:0]            lane_17_loopback_mosi_read_size,
    input  wire                  lane_17_loopback_mosi_read_size_write,
    // AXIS Slave interface to read from FIFO lane_18_loopback_mosi,
    // --------------------,
    input  wire [7:0]            lane_18_loopback_mosi_s_axis_tdata,
    input  wire                  lane_18_loopback_mosi_s_axis_tvalid,
    output wire                  lane_18_loopback_mosi_s_axis_tready,
    input  wire [31:0]            lane_18_loopback_mosi_read_size,
    input  wire                  lane_18_loopback_mosi_read_size_write,
    // AXIS Slave interface to read from FIFO lane_19_loopback_mosi,
    // --------------------,
    input  wire [7:0]            lane_19_loopback_mosi_s_axis_tdata,
    input  wire                  lane_19_loopback_mosi_s_axis_tvalid,
    output wire                  lane_19_loopback_mosi_s_axis_tready,
    input  wire [31:0]            lane_19_loopback_mosi_read_size,
    input  wire                  lane_19_loopback_mosi_read_size_write,
    output wire [7:0]            lanes_cfg_frame_tag_counter_ctrl,
    output wire                  lanes_cfg_frame_tag_counter_ctrl_enable,
    output wire                  lanes_cfg_frame_tag_counter_ctrl_force_count,
    output wire [31:0]            lanes_cfg_frame_tag_counter_trigger,
    output  reg                  lanes_cfg_frame_tag_counter_trigger_interrupt,
    input   wire                  lanes_cfg_frame_tag_counter_trigger_enable,
    output wire [31:0]            lanes_cfg_frame_tag_counter,
    input   wire                  lanes_cfg_frame_tag_counter_enable,
    output wire [7:0]            lanes_cfg_nodata_continue,
    output wire [7:0]            lanes_sr_out,
    output wire                  lanes_sr_out_ck1,
    output wire                  lanes_sr_out_ck2,
    output wire                  lanes_sr_out_sin,
    output wire                  lanes_sr_out_ld0,
    output wire                  lanes_sr_out_ld1,
    output wire                  lanes_sr_out_ld2,
    output wire [7:0]            lanes_sr_in,
    output wire                  lanes_sr_in_rb,
    input  wire                  lanes_sr_in_sout0,
    input  wire                  lanes_sr_in_sout1,
    input  wire                  lanes_sr_in_sout2,
    output wire [7:0]            lanes_inj_ctrl,
    output wire                  lanes_inj_ctrl_reset,
    output wire                  lanes_inj_ctrl_suspend,
    output wire                  lanes_inj_ctrl_synced,
    output wire                  lanes_inj_ctrl_trigger,
    output wire                  lanes_inj_ctrl_write,
    input  wire                  lanes_inj_ctrl_done,
    input  wire                  lanes_inj_ctrl_running,
    output wire [3:0]            lanes_inj_waddr,
    output wire [7:0]            lanes_inj_wdata,
    // AXIS Slave interface to read from FIFO lanes_readout,
    // --------------------,
    input  wire [7:0]            lanes_readout_s_axis_tdata,
    input  wire                  lanes_readout_s_axis_tvalid,
    output wire                  lanes_readout_s_axis_tready,
    input  wire [31:0]            lanes_readout_read_size,
    input  wire                  lanes_readout_read_size_write,
    output wire [7:0]            io_ctrl,
    output wire                  io_ctrl_sample_clock_enable,
    output wire                  io_ctrl_timestamp_clock_enable,
    output wire                  io_ctrl_gecco_sample_clock_se,
    output wire                  io_ctrl_gecco_inj_enable,
    output wire [7:0]            io_led,
    output wire [7:0]            gecco_sr_ctrl,
    output wire                  gecco_sr_ctrl_ck,
    output wire                  gecco_sr_ctrl_sin,
    output wire                  gecco_sr_ctrl_ld,
    output wire [31:0]            hk_conversion_trigger_match,
    output wire [31:0]            lanes_cfg_frame_tag_counter_trigger_match
    );
    
    
    reg [15:0] hk_xadc_temperature_reg;
    reg [15:0] hk_xadc_vccint_reg;
    reg hk_conversion_trigger_up;
    reg [31:0] hk_adc_miso_fifo_read_size_reg;
    // Clock Divider spi_lanes_ckdivider
    reg [7:0] spi_lanes_ckdivider_counter;
    reg [7:0] spi_lanes_ckdivider_reg;
    // Clock Divider spi_hk_ckdivider
    reg [7:0] spi_hk_ckdivider_counter;
    reg [7:0] spi_hk_ckdivider_reg;
    reg [31:0] lane_0_mosi_write_size_reg;
    reg [31:0] lane_1_mosi_write_size_reg;
    reg [31:0] lane_2_mosi_write_size_reg;
    reg [31:0] lane_3_mosi_write_size_reg;
    reg [31:0] lane_4_mosi_write_size_reg;
    reg [31:0] lane_5_mosi_write_size_reg;
    reg [31:0] lane_6_mosi_write_size_reg;
    reg [31:0] lane_7_mosi_write_size_reg;
    reg [31:0] lane_8_mosi_write_size_reg;
    reg [31:0] lane_9_mosi_write_size_reg;
    reg [31:0] lane_10_mosi_write_size_reg;
    reg [31:0] lane_11_mosi_write_size_reg;
    reg [31:0] lane_12_mosi_write_size_reg;
    reg [31:0] lane_13_mosi_write_size_reg;
    reg [31:0] lane_14_mosi_write_size_reg;
    reg [31:0] lane_15_mosi_write_size_reg;
    reg [31:0] lane_16_mosi_write_size_reg;
    reg [31:0] lane_17_mosi_write_size_reg;
    reg [31:0] lane_18_mosi_write_size_reg;
    reg [31:0] lane_19_mosi_write_size_reg;
    reg [31:0] lane_0_loopback_miso_write_size_reg;
    reg [31:0] lane_1_loopback_miso_write_size_reg;
    reg [31:0] lane_2_loopback_miso_write_size_reg;
    reg [31:0] lane_3_loopback_miso_write_size_reg;
    reg [31:0] lane_4_loopback_miso_write_size_reg;
    reg [31:0] lane_5_loopback_miso_write_size_reg;
    reg [31:0] lane_6_loopback_miso_write_size_reg;
    reg [31:0] lane_7_loopback_miso_write_size_reg;
    reg [31:0] lane_8_loopback_miso_write_size_reg;
    reg [31:0] lane_9_loopback_miso_write_size_reg;
    reg [31:0] lane_10_loopback_miso_write_size_reg;
    reg [31:0] lane_11_loopback_miso_write_size_reg;
    reg [31:0] lane_12_loopback_miso_write_size_reg;
    reg [31:0] lane_13_loopback_miso_write_size_reg;
    reg [31:0] lane_14_loopback_miso_write_size_reg;
    reg [31:0] lane_15_loopback_miso_write_size_reg;
    reg [31:0] lane_16_loopback_miso_write_size_reg;
    reg [31:0] lane_17_loopback_miso_write_size_reg;
    reg [31:0] lane_18_loopback_miso_write_size_reg;
    reg [31:0] lane_19_loopback_miso_write_size_reg;
    reg [31:0] lane_0_loopback_mosi_read_size_reg;
    reg [31:0] lane_1_loopback_mosi_read_size_reg;
    reg [31:0] lane_2_loopback_mosi_read_size_reg;
    reg [31:0] lane_3_loopback_mosi_read_size_reg;
    reg [31:0] lane_4_loopback_mosi_read_size_reg;
    reg [31:0] lane_5_loopback_mosi_read_size_reg;
    reg [31:0] lane_6_loopback_mosi_read_size_reg;
    reg [31:0] lane_7_loopback_mosi_read_size_reg;
    reg [31:0] lane_8_loopback_mosi_read_size_reg;
    reg [31:0] lane_9_loopback_mosi_read_size_reg;
    reg [31:0] lane_10_loopback_mosi_read_size_reg;
    reg [31:0] lane_11_loopback_mosi_read_size_reg;
    reg [31:0] lane_12_loopback_mosi_read_size_reg;
    reg [31:0] lane_13_loopback_mosi_read_size_reg;
    reg [31:0] lane_14_loopback_mosi_read_size_reg;
    reg [31:0] lane_15_loopback_mosi_read_size_reg;
    reg [31:0] lane_16_loopback_mosi_read_size_reg;
    reg [31:0] lane_17_loopback_mosi_read_size_reg;
    reg [31:0] lane_18_loopback_mosi_read_size_reg;
    reg [31:0] lane_19_loopback_mosi_read_size_reg;
    reg lanes_cfg_frame_tag_counter_trigger_up;
    reg [31:0] lanes_readout_read_size_reg;
    
    
    // Registers I/O assignments
    // ---------------
    reg [31:0] hk_firmware_id_reg;
    
    reg [31:0] hk_firmware_version_reg;
    
    reg [31:0] hk_conversion_trigger_reg;
    assign hk_conversion_trigger = hk_conversion_trigger_reg;
    
    reg [31:0] hk_stat_conversions_counter_reg;
    
    reg [7:0] hk_ctrl_reg;
    assign hk_ctrl = hk_ctrl_reg;
    
    reg [7:0] lane_0_cfg_ctrl_reg;
    assign lane_0_cfg_ctrl = lane_0_cfg_ctrl_reg;
    
    reg [7:0] lane_1_cfg_ctrl_reg;
    assign lane_1_cfg_ctrl = lane_1_cfg_ctrl_reg;
    
    reg [7:0] lane_2_cfg_ctrl_reg;
    assign lane_2_cfg_ctrl = lane_2_cfg_ctrl_reg;
    
    reg [7:0] lane_3_cfg_ctrl_reg;
    assign lane_3_cfg_ctrl = lane_3_cfg_ctrl_reg;
    
    reg [7:0] lane_4_cfg_ctrl_reg;
    assign lane_4_cfg_ctrl = lane_4_cfg_ctrl_reg;
    
    reg [7:0] lane_5_cfg_ctrl_reg;
    assign lane_5_cfg_ctrl = lane_5_cfg_ctrl_reg;
    
    reg [7:0] lane_6_cfg_ctrl_reg;
    assign lane_6_cfg_ctrl = lane_6_cfg_ctrl_reg;
    
    reg [7:0] lane_7_cfg_ctrl_reg;
    assign lane_7_cfg_ctrl = lane_7_cfg_ctrl_reg;
    
    reg [7:0] lane_8_cfg_ctrl_reg;
    assign lane_8_cfg_ctrl = lane_8_cfg_ctrl_reg;
    
    reg [7:0] lane_9_cfg_ctrl_reg;
    assign lane_9_cfg_ctrl = lane_9_cfg_ctrl_reg;
    
    reg [7:0] lane_10_cfg_ctrl_reg;
    assign lane_10_cfg_ctrl = lane_10_cfg_ctrl_reg;
    
    reg [7:0] lane_11_cfg_ctrl_reg;
    assign lane_11_cfg_ctrl = lane_11_cfg_ctrl_reg;
    
    reg [7:0] lane_12_cfg_ctrl_reg;
    assign lane_12_cfg_ctrl = lane_12_cfg_ctrl_reg;
    
    reg [7:0] lane_13_cfg_ctrl_reg;
    assign lane_13_cfg_ctrl = lane_13_cfg_ctrl_reg;
    
    reg [7:0] lane_14_cfg_ctrl_reg;
    assign lane_14_cfg_ctrl = lane_14_cfg_ctrl_reg;
    
    reg [7:0] lane_15_cfg_ctrl_reg;
    assign lane_15_cfg_ctrl = lane_15_cfg_ctrl_reg;
    
    reg [7:0] lane_16_cfg_ctrl_reg;
    assign lane_16_cfg_ctrl = lane_16_cfg_ctrl_reg;
    
    reg [7:0] lane_17_cfg_ctrl_reg;
    assign lane_17_cfg_ctrl = lane_17_cfg_ctrl_reg;
    
    reg [7:0] lane_18_cfg_ctrl_reg;
    assign lane_18_cfg_ctrl = lane_18_cfg_ctrl_reg;
    
    reg [7:0] lane_19_cfg_ctrl_reg;
    assign lane_19_cfg_ctrl = lane_19_cfg_ctrl_reg;
    
    reg [7:0] lane_0_status_reg;
    assign lane_0_status = lane_0_status_reg;
    
    reg [7:0] lane_1_status_reg;
    assign lane_1_status = lane_1_status_reg;
    
    reg [7:0] lane_2_status_reg;
    assign lane_2_status = lane_2_status_reg;
    
    reg [7:0] lane_3_status_reg;
    assign lane_3_status = lane_3_status_reg;
    
    reg [7:0] lane_4_status_reg;
    assign lane_4_status = lane_4_status_reg;
    
    reg [7:0] lane_5_status_reg;
    assign lane_5_status = lane_5_status_reg;
    
    reg [7:0] lane_6_status_reg;
    assign lane_6_status = lane_6_status_reg;
    
    reg [7:0] lane_7_status_reg;
    assign lane_7_status = lane_7_status_reg;
    
    reg [7:0] lane_8_status_reg;
    assign lane_8_status = lane_8_status_reg;
    
    reg [7:0] lane_9_status_reg;
    assign lane_9_status = lane_9_status_reg;
    
    reg [7:0] lane_10_status_reg;
    assign lane_10_status = lane_10_status_reg;
    
    reg [7:0] lane_11_status_reg;
    assign lane_11_status = lane_11_status_reg;
    
    reg [7:0] lane_12_status_reg;
    assign lane_12_status = lane_12_status_reg;
    
    reg [7:0] lane_13_status_reg;
    assign lane_13_status = lane_13_status_reg;
    
    reg [7:0] lane_14_status_reg;
    assign lane_14_status = lane_14_status_reg;
    
    reg [7:0] lane_15_status_reg;
    assign lane_15_status = lane_15_status_reg;
    
    reg [7:0] lane_16_status_reg;
    assign lane_16_status = lane_16_status_reg;
    
    reg [7:0] lane_17_status_reg;
    assign lane_17_status = lane_17_status_reg;
    
    reg [7:0] lane_18_status_reg;
    assign lane_18_status = lane_18_status_reg;
    
    reg [7:0] lane_19_status_reg;
    assign lane_19_status = lane_19_status_reg;
    
    reg [31:0] lane_0_stat_frame_counter_reg;
    
    reg [31:0] lane_1_stat_frame_counter_reg;
    
    reg [31:0] lane_2_stat_frame_counter_reg;
    
    reg [31:0] lane_3_stat_frame_counter_reg;
    
    reg [31:0] lane_4_stat_frame_counter_reg;
    
    reg [31:0] lane_5_stat_frame_counter_reg;
    
    reg [31:0] lane_6_stat_frame_counter_reg;
    
    reg [31:0] lane_7_stat_frame_counter_reg;
    
    reg [31:0] lane_8_stat_frame_counter_reg;
    
    reg [31:0] lane_9_stat_frame_counter_reg;
    
    reg [31:0] lane_10_stat_frame_counter_reg;
    
    reg [31:0] lane_11_stat_frame_counter_reg;
    
    reg [31:0] lane_12_stat_frame_counter_reg;
    
    reg [31:0] lane_13_stat_frame_counter_reg;
    
    reg [31:0] lane_14_stat_frame_counter_reg;
    
    reg [31:0] lane_15_stat_frame_counter_reg;
    
    reg [31:0] lane_16_stat_frame_counter_reg;
    
    reg [31:0] lane_17_stat_frame_counter_reg;
    
    reg [31:0] lane_18_stat_frame_counter_reg;
    
    reg [31:0] lane_19_stat_frame_counter_reg;
    
    reg [31:0] lane_0_stat_idle_counter_reg;
    
    reg [31:0] lane_1_stat_idle_counter_reg;
    
    reg [31:0] lane_2_stat_idle_counter_reg;
    
    reg [31:0] lane_3_stat_idle_counter_reg;
    
    reg [31:0] lane_4_stat_idle_counter_reg;
    
    reg [31:0] lane_5_stat_idle_counter_reg;
    
    reg [31:0] lane_6_stat_idle_counter_reg;
    
    reg [31:0] lane_7_stat_idle_counter_reg;
    
    reg [31:0] lane_8_stat_idle_counter_reg;
    
    reg [31:0] lane_9_stat_idle_counter_reg;
    
    reg [31:0] lane_10_stat_idle_counter_reg;
    
    reg [31:0] lane_11_stat_idle_counter_reg;
    
    reg [31:0] lane_12_stat_idle_counter_reg;
    
    reg [31:0] lane_13_stat_idle_counter_reg;
    
    reg [31:0] lane_14_stat_idle_counter_reg;
    
    reg [31:0] lane_15_stat_idle_counter_reg;
    
    reg [31:0] lane_16_stat_idle_counter_reg;
    
    reg [31:0] lane_17_stat_idle_counter_reg;
    
    reg [31:0] lane_18_stat_idle_counter_reg;
    
    reg [31:0] lane_19_stat_idle_counter_reg;
    
    reg [7:0] lanes_cfg_frame_tag_counter_ctrl_reg;
    assign lanes_cfg_frame_tag_counter_ctrl = lanes_cfg_frame_tag_counter_ctrl_reg;
    
    reg [31:0] lanes_cfg_frame_tag_counter_trigger_reg;
    assign lanes_cfg_frame_tag_counter_trigger = lanes_cfg_frame_tag_counter_trigger_reg;
    
    reg [31:0] lanes_cfg_frame_tag_counter_reg;
    assign lanes_cfg_frame_tag_counter = lanes_cfg_frame_tag_counter_reg;
    
    reg [7:0] lanes_cfg_nodata_continue_reg;
    assign lanes_cfg_nodata_continue = lanes_cfg_nodata_continue_reg;
    
    reg [7:0] lanes_sr_out_reg;
    assign lanes_sr_out = lanes_sr_out_reg;
    
    reg [7:0] lanes_sr_in_reg;
    assign lanes_sr_in = lanes_sr_in_reg;
    
    reg [7:0] lanes_inj_ctrl_reg;
    assign lanes_inj_ctrl = lanes_inj_ctrl_reg;
    
    reg [3:0] lanes_inj_waddr_reg;
    assign lanes_inj_waddr = lanes_inj_waddr_reg;
    
    reg [7:0] lanes_inj_wdata_reg;
    assign lanes_inj_wdata = lanes_inj_wdata_reg;
    
    reg [7:0] io_ctrl_reg;
    assign io_ctrl = io_ctrl_reg;
    
    reg [7:0] io_led_reg;
    assign io_led = io_led_reg;
    
    reg [7:0] gecco_sr_ctrl_reg;
    assign gecco_sr_ctrl = gecco_sr_ctrl_reg;
    
    reg [31:0] hk_conversion_trigger_match_reg;
    assign hk_conversion_trigger_match = hk_conversion_trigger_match_reg;
    
    reg [31:0] lanes_cfg_frame_tag_counter_trigger_match_reg;
    assign lanes_cfg_frame_tag_counter_trigger_match = lanes_cfg_frame_tag_counter_trigger_match_reg;
    
    
    
    // Register Bits assignments
    // ---------------
    assign hk_ctrl_select_adc0 = hk_ctrl_reg[0];
    assign hk_ctrl_select_adc1 = hk_ctrl_reg[1];
    assign hk_ctrl_select_adc2 = hk_ctrl_reg[2];
    assign lane_0_cfg_ctrl_hold = lane_0_cfg_ctrl_reg[0];
    assign lane_0_cfg_ctrl_reset = lane_0_cfg_ctrl_reg[1];
    assign lane_0_cfg_ctrl_disable_autoread = lane_0_cfg_ctrl_reg[2];
    assign lane_0_cfg_ctrl_cs = lane_0_cfg_ctrl_reg[3];
    assign lane_0_cfg_ctrl_disable_miso = lane_0_cfg_ctrl_reg[4];
    assign lane_0_cfg_ctrl_loopback = lane_0_cfg_ctrl_reg[5];
    assign lane_1_cfg_ctrl_hold = lane_1_cfg_ctrl_reg[0];
    assign lane_1_cfg_ctrl_reset = lane_1_cfg_ctrl_reg[1];
    assign lane_1_cfg_ctrl_disable_autoread = lane_1_cfg_ctrl_reg[2];
    assign lane_1_cfg_ctrl_cs = lane_1_cfg_ctrl_reg[3];
    assign lane_1_cfg_ctrl_disable_miso = lane_1_cfg_ctrl_reg[4];
    assign lane_1_cfg_ctrl_loopback = lane_1_cfg_ctrl_reg[5];
    assign lane_2_cfg_ctrl_hold = lane_2_cfg_ctrl_reg[0];
    assign lane_2_cfg_ctrl_reset = lane_2_cfg_ctrl_reg[1];
    assign lane_2_cfg_ctrl_disable_autoread = lane_2_cfg_ctrl_reg[2];
    assign lane_2_cfg_ctrl_cs = lane_2_cfg_ctrl_reg[3];
    assign lane_2_cfg_ctrl_disable_miso = lane_2_cfg_ctrl_reg[4];
    assign lane_2_cfg_ctrl_loopback = lane_2_cfg_ctrl_reg[5];
    assign lane_3_cfg_ctrl_hold = lane_3_cfg_ctrl_reg[0];
    assign lane_3_cfg_ctrl_reset = lane_3_cfg_ctrl_reg[1];
    assign lane_3_cfg_ctrl_disable_autoread = lane_3_cfg_ctrl_reg[2];
    assign lane_3_cfg_ctrl_cs = lane_3_cfg_ctrl_reg[3];
    assign lane_3_cfg_ctrl_disable_miso = lane_3_cfg_ctrl_reg[4];
    assign lane_3_cfg_ctrl_loopback = lane_3_cfg_ctrl_reg[5];
    assign lane_4_cfg_ctrl_hold = lane_4_cfg_ctrl_reg[0];
    assign lane_4_cfg_ctrl_reset = lane_4_cfg_ctrl_reg[1];
    assign lane_4_cfg_ctrl_disable_autoread = lane_4_cfg_ctrl_reg[2];
    assign lane_4_cfg_ctrl_cs = lane_4_cfg_ctrl_reg[3];
    assign lane_4_cfg_ctrl_disable_miso = lane_4_cfg_ctrl_reg[4];
    assign lane_4_cfg_ctrl_loopback = lane_4_cfg_ctrl_reg[5];
    assign lane_5_cfg_ctrl_hold = lane_5_cfg_ctrl_reg[0];
    assign lane_5_cfg_ctrl_reset = lane_5_cfg_ctrl_reg[1];
    assign lane_5_cfg_ctrl_disable_autoread = lane_5_cfg_ctrl_reg[2];
    assign lane_5_cfg_ctrl_cs = lane_5_cfg_ctrl_reg[3];
    assign lane_5_cfg_ctrl_disable_miso = lane_5_cfg_ctrl_reg[4];
    assign lane_5_cfg_ctrl_loopback = lane_5_cfg_ctrl_reg[5];
    assign lane_6_cfg_ctrl_hold = lane_6_cfg_ctrl_reg[0];
    assign lane_6_cfg_ctrl_reset = lane_6_cfg_ctrl_reg[1];
    assign lane_6_cfg_ctrl_disable_autoread = lane_6_cfg_ctrl_reg[2];
    assign lane_6_cfg_ctrl_cs = lane_6_cfg_ctrl_reg[3];
    assign lane_6_cfg_ctrl_disable_miso = lane_6_cfg_ctrl_reg[4];
    assign lane_6_cfg_ctrl_loopback = lane_6_cfg_ctrl_reg[5];
    assign lane_7_cfg_ctrl_hold = lane_7_cfg_ctrl_reg[0];
    assign lane_7_cfg_ctrl_reset = lane_7_cfg_ctrl_reg[1];
    assign lane_7_cfg_ctrl_disable_autoread = lane_7_cfg_ctrl_reg[2];
    assign lane_7_cfg_ctrl_cs = lane_7_cfg_ctrl_reg[3];
    assign lane_7_cfg_ctrl_disable_miso = lane_7_cfg_ctrl_reg[4];
    assign lane_7_cfg_ctrl_loopback = lane_7_cfg_ctrl_reg[5];
    assign lane_8_cfg_ctrl_hold = lane_8_cfg_ctrl_reg[0];
    assign lane_8_cfg_ctrl_reset = lane_8_cfg_ctrl_reg[1];
    assign lane_8_cfg_ctrl_disable_autoread = lane_8_cfg_ctrl_reg[2];
    assign lane_8_cfg_ctrl_cs = lane_8_cfg_ctrl_reg[3];
    assign lane_8_cfg_ctrl_disable_miso = lane_8_cfg_ctrl_reg[4];
    assign lane_8_cfg_ctrl_loopback = lane_8_cfg_ctrl_reg[5];
    assign lane_9_cfg_ctrl_hold = lane_9_cfg_ctrl_reg[0];
    assign lane_9_cfg_ctrl_reset = lane_9_cfg_ctrl_reg[1];
    assign lane_9_cfg_ctrl_disable_autoread = lane_9_cfg_ctrl_reg[2];
    assign lane_9_cfg_ctrl_cs = lane_9_cfg_ctrl_reg[3];
    assign lane_9_cfg_ctrl_disable_miso = lane_9_cfg_ctrl_reg[4];
    assign lane_9_cfg_ctrl_loopback = lane_9_cfg_ctrl_reg[5];
    assign lane_10_cfg_ctrl_hold = lane_10_cfg_ctrl_reg[0];
    assign lane_10_cfg_ctrl_reset = lane_10_cfg_ctrl_reg[1];
    assign lane_10_cfg_ctrl_disable_autoread = lane_10_cfg_ctrl_reg[2];
    assign lane_10_cfg_ctrl_cs = lane_10_cfg_ctrl_reg[3];
    assign lane_10_cfg_ctrl_disable_miso = lane_10_cfg_ctrl_reg[4];
    assign lane_10_cfg_ctrl_loopback = lane_10_cfg_ctrl_reg[5];
    assign lane_11_cfg_ctrl_hold = lane_11_cfg_ctrl_reg[0];
    assign lane_11_cfg_ctrl_reset = lane_11_cfg_ctrl_reg[1];
    assign lane_11_cfg_ctrl_disable_autoread = lane_11_cfg_ctrl_reg[2];
    assign lane_11_cfg_ctrl_cs = lane_11_cfg_ctrl_reg[3];
    assign lane_11_cfg_ctrl_disable_miso = lane_11_cfg_ctrl_reg[4];
    assign lane_11_cfg_ctrl_loopback = lane_11_cfg_ctrl_reg[5];
    assign lane_12_cfg_ctrl_hold = lane_12_cfg_ctrl_reg[0];
    assign lane_12_cfg_ctrl_reset = lane_12_cfg_ctrl_reg[1];
    assign lane_12_cfg_ctrl_disable_autoread = lane_12_cfg_ctrl_reg[2];
    assign lane_12_cfg_ctrl_cs = lane_12_cfg_ctrl_reg[3];
    assign lane_12_cfg_ctrl_disable_miso = lane_12_cfg_ctrl_reg[4];
    assign lane_12_cfg_ctrl_loopback = lane_12_cfg_ctrl_reg[5];
    assign lane_13_cfg_ctrl_hold = lane_13_cfg_ctrl_reg[0];
    assign lane_13_cfg_ctrl_reset = lane_13_cfg_ctrl_reg[1];
    assign lane_13_cfg_ctrl_disable_autoread = lane_13_cfg_ctrl_reg[2];
    assign lane_13_cfg_ctrl_cs = lane_13_cfg_ctrl_reg[3];
    assign lane_13_cfg_ctrl_disable_miso = lane_13_cfg_ctrl_reg[4];
    assign lane_13_cfg_ctrl_loopback = lane_13_cfg_ctrl_reg[5];
    assign lane_14_cfg_ctrl_hold = lane_14_cfg_ctrl_reg[0];
    assign lane_14_cfg_ctrl_reset = lane_14_cfg_ctrl_reg[1];
    assign lane_14_cfg_ctrl_disable_autoread = lane_14_cfg_ctrl_reg[2];
    assign lane_14_cfg_ctrl_cs = lane_14_cfg_ctrl_reg[3];
    assign lane_14_cfg_ctrl_disable_miso = lane_14_cfg_ctrl_reg[4];
    assign lane_14_cfg_ctrl_loopback = lane_14_cfg_ctrl_reg[5];
    assign lane_15_cfg_ctrl_hold = lane_15_cfg_ctrl_reg[0];
    assign lane_15_cfg_ctrl_reset = lane_15_cfg_ctrl_reg[1];
    assign lane_15_cfg_ctrl_disable_autoread = lane_15_cfg_ctrl_reg[2];
    assign lane_15_cfg_ctrl_cs = lane_15_cfg_ctrl_reg[3];
    assign lane_15_cfg_ctrl_disable_miso = lane_15_cfg_ctrl_reg[4];
    assign lane_15_cfg_ctrl_loopback = lane_15_cfg_ctrl_reg[5];
    assign lane_16_cfg_ctrl_hold = lane_16_cfg_ctrl_reg[0];
    assign lane_16_cfg_ctrl_reset = lane_16_cfg_ctrl_reg[1];
    assign lane_16_cfg_ctrl_disable_autoread = lane_16_cfg_ctrl_reg[2];
    assign lane_16_cfg_ctrl_cs = lane_16_cfg_ctrl_reg[3];
    assign lane_16_cfg_ctrl_disable_miso = lane_16_cfg_ctrl_reg[4];
    assign lane_16_cfg_ctrl_loopback = lane_16_cfg_ctrl_reg[5];
    assign lane_17_cfg_ctrl_hold = lane_17_cfg_ctrl_reg[0];
    assign lane_17_cfg_ctrl_reset = lane_17_cfg_ctrl_reg[1];
    assign lane_17_cfg_ctrl_disable_autoread = lane_17_cfg_ctrl_reg[2];
    assign lane_17_cfg_ctrl_cs = lane_17_cfg_ctrl_reg[3];
    assign lane_17_cfg_ctrl_disable_miso = lane_17_cfg_ctrl_reg[4];
    assign lane_17_cfg_ctrl_loopback = lane_17_cfg_ctrl_reg[5];
    assign lane_18_cfg_ctrl_hold = lane_18_cfg_ctrl_reg[0];
    assign lane_18_cfg_ctrl_reset = lane_18_cfg_ctrl_reg[1];
    assign lane_18_cfg_ctrl_disable_autoread = lane_18_cfg_ctrl_reg[2];
    assign lane_18_cfg_ctrl_cs = lane_18_cfg_ctrl_reg[3];
    assign lane_18_cfg_ctrl_disable_miso = lane_18_cfg_ctrl_reg[4];
    assign lane_18_cfg_ctrl_loopback = lane_18_cfg_ctrl_reg[5];
    assign lane_19_cfg_ctrl_hold = lane_19_cfg_ctrl_reg[0];
    assign lane_19_cfg_ctrl_reset = lane_19_cfg_ctrl_reg[1];
    assign lane_19_cfg_ctrl_disable_autoread = lane_19_cfg_ctrl_reg[2];
    assign lane_19_cfg_ctrl_cs = lane_19_cfg_ctrl_reg[3];
    assign lane_19_cfg_ctrl_disable_miso = lane_19_cfg_ctrl_reg[4];
    assign lane_19_cfg_ctrl_loopback = lane_19_cfg_ctrl_reg[5];
    assign lanes_cfg_frame_tag_counter_ctrl_enable = lanes_cfg_frame_tag_counter_ctrl_reg[0];
    assign lanes_cfg_frame_tag_counter_ctrl_force_count = lanes_cfg_frame_tag_counter_ctrl_reg[1];
    assign lanes_sr_out_ck1 = lanes_sr_out_reg[0];
    assign lanes_sr_out_ck2 = lanes_sr_out_reg[1];
    assign lanes_sr_out_sin = lanes_sr_out_reg[2];
    assign lanes_sr_out_ld0 = lanes_sr_out_reg[3];
    assign lanes_sr_out_ld1 = lanes_sr_out_reg[4];
    assign lanes_sr_out_ld2 = lanes_sr_out_reg[5];
    assign lanes_sr_in_rb = lanes_sr_in_reg[0];
    assign lanes_inj_ctrl_reset = lanes_inj_ctrl_reg[0];
    assign lanes_inj_ctrl_suspend = lanes_inj_ctrl_reg[1];
    assign lanes_inj_ctrl_synced = lanes_inj_ctrl_reg[2];
    assign lanes_inj_ctrl_trigger = lanes_inj_ctrl_reg[3];
    assign lanes_inj_ctrl_write = lanes_inj_ctrl_reg[4];
    assign io_ctrl_sample_clock_enable = io_ctrl_reg[0];
    assign io_ctrl_timestamp_clock_enable = io_ctrl_reg[1];
    assign io_ctrl_gecco_sample_clock_se = io_ctrl_reg[2];
    assign io_ctrl_gecco_inj_enable = io_ctrl_reg[3];
    assign gecco_sr_ctrl_ck = gecco_sr_ctrl_reg[0];
    assign gecco_sr_ctrl_sin = gecco_sr_ctrl_reg[1];
    assign gecco_sr_ctrl_ld = gecco_sr_ctrl_reg[2];
    
    
    // Register Writes
    // ---------------
    always@(posedge clk) begin
        if (!resn) begin
            hk_firmware_id_reg <= 32'h0000ff00;
            hk_firmware_version_reg <= 32'd2024112001;
            hk_xadc_temperature_reg <= 0;
            hk_xadc_vccint_reg <= 0;
            hk_conversion_trigger_reg <= 0;
            hk_conversion_trigger_up <= 1'b1;
            hk_stat_conversions_counter_reg <= 0;
            hk_ctrl_reg <= 0;
            hk_adcdac_mosi_fifo_m_axis_tvalid <= 1'b0;
            hk_adcdac_mosi_fifo_m_axis_tlast  <= 1'b0;
            hk_adc_miso_fifo_read_size_reg <= 0;
            spi_lanes_ckdivider_reg <= 8'h4;
            spi_hk_ckdivider_reg <= 8'h4;
            lane_0_cfg_ctrl_reg <= 8'b00000111;
            lane_1_cfg_ctrl_reg <= 8'b00000111;
            lane_2_cfg_ctrl_reg <= 8'b00000111;
            lane_3_cfg_ctrl_reg <= 8'b00000111;
            lane_4_cfg_ctrl_reg <= 8'b00000111;
            lane_5_cfg_ctrl_reg <= 8'b00000111;
            lane_6_cfg_ctrl_reg <= 8'b00000111;
            lane_7_cfg_ctrl_reg <= 8'b00000111;
            lane_8_cfg_ctrl_reg <= 8'b00000111;
            lane_9_cfg_ctrl_reg <= 8'b00000111;
            lane_10_cfg_ctrl_reg <= 8'b00000111;
            lane_11_cfg_ctrl_reg <= 8'b00000111;
            lane_12_cfg_ctrl_reg <= 8'b00000111;
            lane_13_cfg_ctrl_reg <= 8'b00000111;
            lane_14_cfg_ctrl_reg <= 8'b00000111;
            lane_15_cfg_ctrl_reg <= 8'b00000111;
            lane_16_cfg_ctrl_reg <= 8'b00000111;
            lane_17_cfg_ctrl_reg <= 8'b00000111;
            lane_18_cfg_ctrl_reg <= 8'b00000111;
            lane_19_cfg_ctrl_reg <= 8'b00000111;
            lane_0_status_reg <= 0;
            lane_1_status_reg <= 0;
            lane_2_status_reg <= 0;
            lane_3_status_reg <= 0;
            lane_4_status_reg <= 0;
            lane_5_status_reg <= 0;
            lane_6_status_reg <= 0;
            lane_7_status_reg <= 0;
            lane_8_status_reg <= 0;
            lane_9_status_reg <= 0;
            lane_10_status_reg <= 0;
            lane_11_status_reg <= 0;
            lane_12_status_reg <= 0;
            lane_13_status_reg <= 0;
            lane_14_status_reg <= 0;
            lane_15_status_reg <= 0;
            lane_16_status_reg <= 0;
            lane_17_status_reg <= 0;
            lane_18_status_reg <= 0;
            lane_19_status_reg <= 0;
            lane_0_stat_frame_counter_reg <= 0;
            lane_1_stat_frame_counter_reg <= 0;
            lane_2_stat_frame_counter_reg <= 0;
            lane_3_stat_frame_counter_reg <= 0;
            lane_4_stat_frame_counter_reg <= 0;
            lane_5_stat_frame_counter_reg <= 0;
            lane_6_stat_frame_counter_reg <= 0;
            lane_7_stat_frame_counter_reg <= 0;
            lane_8_stat_frame_counter_reg <= 0;
            lane_9_stat_frame_counter_reg <= 0;
            lane_10_stat_frame_counter_reg <= 0;
            lane_11_stat_frame_counter_reg <= 0;
            lane_12_stat_frame_counter_reg <= 0;
            lane_13_stat_frame_counter_reg <= 0;
            lane_14_stat_frame_counter_reg <= 0;
            lane_15_stat_frame_counter_reg <= 0;
            lane_16_stat_frame_counter_reg <= 0;
            lane_17_stat_frame_counter_reg <= 0;
            lane_18_stat_frame_counter_reg <= 0;
            lane_19_stat_frame_counter_reg <= 0;
            lane_0_stat_idle_counter_reg <= 0;
            lane_1_stat_idle_counter_reg <= 0;
            lane_2_stat_idle_counter_reg <= 0;
            lane_3_stat_idle_counter_reg <= 0;
            lane_4_stat_idle_counter_reg <= 0;
            lane_5_stat_idle_counter_reg <= 0;
            lane_6_stat_idle_counter_reg <= 0;
            lane_7_stat_idle_counter_reg <= 0;
            lane_8_stat_idle_counter_reg <= 0;
            lane_9_stat_idle_counter_reg <= 0;
            lane_10_stat_idle_counter_reg <= 0;
            lane_11_stat_idle_counter_reg <= 0;
            lane_12_stat_idle_counter_reg <= 0;
            lane_13_stat_idle_counter_reg <= 0;
            lane_14_stat_idle_counter_reg <= 0;
            lane_15_stat_idle_counter_reg <= 0;
            lane_16_stat_idle_counter_reg <= 0;
            lane_17_stat_idle_counter_reg <= 0;
            lane_18_stat_idle_counter_reg <= 0;
            lane_19_stat_idle_counter_reg <= 0;
            lane_0_mosi_m_axis_tvalid <= 1'b0;
            lane_0_mosi_m_axis_tlast  <= 1'b0;
            lane_0_mosi_write_size_reg <= 0;
            lane_1_mosi_m_axis_tvalid <= 1'b0;
            lane_1_mosi_m_axis_tlast  <= 1'b0;
            lane_1_mosi_write_size_reg <= 0;
            lane_2_mosi_m_axis_tvalid <= 1'b0;
            lane_2_mosi_m_axis_tlast  <= 1'b0;
            lane_2_mosi_write_size_reg <= 0;
            lane_3_mosi_m_axis_tvalid <= 1'b0;
            lane_3_mosi_m_axis_tlast  <= 1'b0;
            lane_3_mosi_write_size_reg <= 0;
            lane_4_mosi_m_axis_tvalid <= 1'b0;
            lane_4_mosi_m_axis_tlast  <= 1'b0;
            lane_4_mosi_write_size_reg <= 0;
            lane_5_mosi_m_axis_tvalid <= 1'b0;
            lane_5_mosi_m_axis_tlast  <= 1'b0;
            lane_5_mosi_write_size_reg <= 0;
            lane_6_mosi_m_axis_tvalid <= 1'b0;
            lane_6_mosi_m_axis_tlast  <= 1'b0;
            lane_6_mosi_write_size_reg <= 0;
            lane_7_mosi_m_axis_tvalid <= 1'b0;
            lane_7_mosi_m_axis_tlast  <= 1'b0;
            lane_7_mosi_write_size_reg <= 0;
            lane_8_mosi_m_axis_tvalid <= 1'b0;
            lane_8_mosi_m_axis_tlast  <= 1'b0;
            lane_8_mosi_write_size_reg <= 0;
            lane_9_mosi_m_axis_tvalid <= 1'b0;
            lane_9_mosi_m_axis_tlast  <= 1'b0;
            lane_9_mosi_write_size_reg <= 0;
            lane_10_mosi_m_axis_tvalid <= 1'b0;
            lane_10_mosi_m_axis_tlast  <= 1'b0;
            lane_10_mosi_write_size_reg <= 0;
            lane_11_mosi_m_axis_tvalid <= 1'b0;
            lane_11_mosi_m_axis_tlast  <= 1'b0;
            lane_11_mosi_write_size_reg <= 0;
            lane_12_mosi_m_axis_tvalid <= 1'b0;
            lane_12_mosi_m_axis_tlast  <= 1'b0;
            lane_12_mosi_write_size_reg <= 0;
            lane_13_mosi_m_axis_tvalid <= 1'b0;
            lane_13_mosi_m_axis_tlast  <= 1'b0;
            lane_13_mosi_write_size_reg <= 0;
            lane_14_mosi_m_axis_tvalid <= 1'b0;
            lane_14_mosi_m_axis_tlast  <= 1'b0;
            lane_14_mosi_write_size_reg <= 0;
            lane_15_mosi_m_axis_tvalid <= 1'b0;
            lane_15_mosi_m_axis_tlast  <= 1'b0;
            lane_15_mosi_write_size_reg <= 0;
            lane_16_mosi_m_axis_tvalid <= 1'b0;
            lane_16_mosi_m_axis_tlast  <= 1'b0;
            lane_16_mosi_write_size_reg <= 0;
            lane_17_mosi_m_axis_tvalid <= 1'b0;
            lane_17_mosi_m_axis_tlast  <= 1'b0;
            lane_17_mosi_write_size_reg <= 0;
            lane_18_mosi_m_axis_tvalid <= 1'b0;
            lane_18_mosi_m_axis_tlast  <= 1'b0;
            lane_18_mosi_write_size_reg <= 0;
            lane_19_mosi_m_axis_tvalid <= 1'b0;
            lane_19_mosi_m_axis_tlast  <= 1'b0;
            lane_19_mosi_write_size_reg <= 0;
            lane_0_loopback_miso_m_axis_tvalid <= 1'b0;
            lane_0_loopback_miso_write_size_reg <= 0;
            lane_1_loopback_miso_m_axis_tvalid <= 1'b0;
            lane_1_loopback_miso_write_size_reg <= 0;
            lane_2_loopback_miso_m_axis_tvalid <= 1'b0;
            lane_2_loopback_miso_write_size_reg <= 0;
            lane_3_loopback_miso_m_axis_tvalid <= 1'b0;
            lane_3_loopback_miso_write_size_reg <= 0;
            lane_4_loopback_miso_m_axis_tvalid <= 1'b0;
            lane_4_loopback_miso_write_size_reg <= 0;
            lane_5_loopback_miso_m_axis_tvalid <= 1'b0;
            lane_5_loopback_miso_write_size_reg <= 0;
            lane_6_loopback_miso_m_axis_tvalid <= 1'b0;
            lane_6_loopback_miso_write_size_reg <= 0;
            lane_7_loopback_miso_m_axis_tvalid <= 1'b0;
            lane_7_loopback_miso_write_size_reg <= 0;
            lane_8_loopback_miso_m_axis_tvalid <= 1'b0;
            lane_8_loopback_miso_write_size_reg <= 0;
            lane_9_loopback_miso_m_axis_tvalid <= 1'b0;
            lane_9_loopback_miso_write_size_reg <= 0;
            lane_10_loopback_miso_m_axis_tvalid <= 1'b0;
            lane_10_loopback_miso_write_size_reg <= 0;
            lane_11_loopback_miso_m_axis_tvalid <= 1'b0;
            lane_11_loopback_miso_write_size_reg <= 0;
            lane_12_loopback_miso_m_axis_tvalid <= 1'b0;
            lane_12_loopback_miso_write_size_reg <= 0;
            lane_13_loopback_miso_m_axis_tvalid <= 1'b0;
            lane_13_loopback_miso_write_size_reg <= 0;
            lane_14_loopback_miso_m_axis_tvalid <= 1'b0;
            lane_14_loopback_miso_write_size_reg <= 0;
            lane_15_loopback_miso_m_axis_tvalid <= 1'b0;
            lane_15_loopback_miso_write_size_reg <= 0;
            lane_16_loopback_miso_m_axis_tvalid <= 1'b0;
            lane_16_loopback_miso_write_size_reg <= 0;
            lane_17_loopback_miso_m_axis_tvalid <= 1'b0;
            lane_17_loopback_miso_write_size_reg <= 0;
            lane_18_loopback_miso_m_axis_tvalid <= 1'b0;
            lane_18_loopback_miso_write_size_reg <= 0;
            lane_19_loopback_miso_m_axis_tvalid <= 1'b0;
            lane_19_loopback_miso_write_size_reg <= 0;
            lane_0_loopback_mosi_read_size_reg <= 0;
            lane_1_loopback_mosi_read_size_reg <= 0;
            lane_2_loopback_mosi_read_size_reg <= 0;
            lane_3_loopback_mosi_read_size_reg <= 0;
            lane_4_loopback_mosi_read_size_reg <= 0;
            lane_5_loopback_mosi_read_size_reg <= 0;
            lane_6_loopback_mosi_read_size_reg <= 0;
            lane_7_loopback_mosi_read_size_reg <= 0;
            lane_8_loopback_mosi_read_size_reg <= 0;
            lane_9_loopback_mosi_read_size_reg <= 0;
            lane_10_loopback_mosi_read_size_reg <= 0;
            lane_11_loopback_mosi_read_size_reg <= 0;
            lane_12_loopback_mosi_read_size_reg <= 0;
            lane_13_loopback_mosi_read_size_reg <= 0;
            lane_14_loopback_mosi_read_size_reg <= 0;
            lane_15_loopback_mosi_read_size_reg <= 0;
            lane_16_loopback_mosi_read_size_reg <= 0;
            lane_17_loopback_mosi_read_size_reg <= 0;
            lane_18_loopback_mosi_read_size_reg <= 0;
            lane_19_loopback_mosi_read_size_reg <= 0;
            lanes_cfg_frame_tag_counter_ctrl_reg <= 8'h1;
            lanes_cfg_frame_tag_counter_trigger_reg <= 0;
            lanes_cfg_frame_tag_counter_trigger_up <= 1'b1;
            lanes_cfg_frame_tag_counter_reg <= 0;
            lanes_cfg_nodata_continue_reg <= 8'd5;
            lanes_sr_out_reg <= 0;
            lanes_sr_in_reg <= 0;
            lanes_inj_ctrl_reg <= 8'b00000110;
            lanes_inj_waddr_reg <= 0;
            lanes_inj_wdata_reg <= 0;
            lanes_readout_read_size_reg <= 0;
            io_ctrl_reg <= 8'b00001000;
            io_led_reg <= 0;
            gecco_sr_ctrl_reg <= 0;
            hk_conversion_trigger_match_reg <= 32'd10;
            lanes_cfg_frame_tag_counter_trigger_match_reg <= 32'd4;
        end else begin
            
            
            // Single in bits are always sampled
            lane_0_status_reg[0] <= lane_0_status_interruptn;
            lane_0_status_reg[1] <= lane_0_status_frame_decoding;
            lane_1_status_reg[0] <= lane_1_status_interruptn;
            lane_1_status_reg[1] <= lane_1_status_frame_decoding;
            lane_2_status_reg[0] <= lane_2_status_interruptn;
            lane_2_status_reg[1] <= lane_2_status_frame_decoding;
            lane_3_status_reg[0] <= lane_3_status_interruptn;
            lane_3_status_reg[1] <= lane_3_status_frame_decoding;
            lane_4_status_reg[0] <= lane_4_status_interruptn;
            lane_4_status_reg[1] <= lane_4_status_frame_decoding;
            lane_5_status_reg[0] <= lane_5_status_interruptn;
            lane_5_status_reg[1] <= lane_5_status_frame_decoding;
            lane_6_status_reg[0] <= lane_6_status_interruptn;
            lane_6_status_reg[1] <= lane_6_status_frame_decoding;
            lane_7_status_reg[0] <= lane_7_status_interruptn;
            lane_7_status_reg[1] <= lane_7_status_frame_decoding;
            lane_8_status_reg[0] <= lane_8_status_interruptn;
            lane_8_status_reg[1] <= lane_8_status_frame_decoding;
            lane_9_status_reg[0] <= lane_9_status_interruptn;
            lane_9_status_reg[1] <= lane_9_status_frame_decoding;
            lane_10_status_reg[0] <= lane_10_status_interruptn;
            lane_10_status_reg[1] <= lane_10_status_frame_decoding;
            lane_11_status_reg[0] <= lane_11_status_interruptn;
            lane_11_status_reg[1] <= lane_11_status_frame_decoding;
            lane_12_status_reg[0] <= lane_12_status_interruptn;
            lane_12_status_reg[1] <= lane_12_status_frame_decoding;
            lane_13_status_reg[0] <= lane_13_status_interruptn;
            lane_13_status_reg[1] <= lane_13_status_frame_decoding;
            lane_14_status_reg[0] <= lane_14_status_interruptn;
            lane_14_status_reg[1] <= lane_14_status_frame_decoding;
            lane_15_status_reg[0] <= lane_15_status_interruptn;
            lane_15_status_reg[1] <= lane_15_status_frame_decoding;
            lane_16_status_reg[0] <= lane_16_status_interruptn;
            lane_16_status_reg[1] <= lane_16_status_frame_decoding;
            lane_17_status_reg[0] <= lane_17_status_interruptn;
            lane_17_status_reg[1] <= lane_17_status_frame_decoding;
            lane_18_status_reg[0] <= lane_18_status_interruptn;
            lane_18_status_reg[1] <= lane_18_status_frame_decoding;
            lane_19_status_reg[0] <= lane_19_status_interruptn;
            lane_19_status_reg[1] <= lane_19_status_frame_decoding;
            lanes_sr_in_reg[1] <= lanes_sr_in_sout0;
            lanes_sr_in_reg[2] <= lanes_sr_in_sout1;
            lanes_sr_in_reg[3] <= lanes_sr_in_sout2;
            lanes_inj_ctrl_reg[5] <= lanes_inj_ctrl_done;
            lanes_inj_ctrl_reg[6] <= lanes_inj_ctrl_running;
            
            
            // Write for simple registers
            case({rfg_write,rfg_address})
                {1'b1,16'hc}: begin
                    hk_conversion_trigger_reg[7:0] <= rfg_write_value;
                end
                {1'b1,16'hd}: begin
                    hk_conversion_trigger_reg[15:8] <= rfg_write_value;
                end
                {1'b1,16'he}: begin
                    hk_conversion_trigger_reg[23:16] <= rfg_write_value;
                end
                {1'b1,16'hf}: begin
                    hk_conversion_trigger_reg[31:24] <= rfg_write_value;
                end
                {1'b1,16'h14}: begin
                    hk_ctrl_reg[7:0] <= rfg_write_value;
                end
                {1'b1,16'h1b}: begin
                    spi_lanes_ckdivider_reg <= rfg_write_value;
                end
                {1'b1,16'h1c}: begin
                    spi_hk_ckdivider_reg <= rfg_write_value;
                end
                {1'b1,16'h1d}: begin
                    lane_0_cfg_ctrl_reg[7:0] <= rfg_write_value;
                end
                {1'b1,16'h1e}: begin
                    lane_1_cfg_ctrl_reg[7:0] <= rfg_write_value;
                end
                {1'b1,16'h1f}: begin
                    lane_2_cfg_ctrl_reg[7:0] <= rfg_write_value;
                end
                {1'b1,16'h20}: begin
                    lane_3_cfg_ctrl_reg[7:0] <= rfg_write_value;
                end
                {1'b1,16'h21}: begin
                    lane_4_cfg_ctrl_reg[7:0] <= rfg_write_value;
                end
                {1'b1,16'h22}: begin
                    lane_5_cfg_ctrl_reg[7:0] <= rfg_write_value;
                end
                {1'b1,16'h23}: begin
                    lane_6_cfg_ctrl_reg[7:0] <= rfg_write_value;
                end
                {1'b1,16'h24}: begin
                    lane_7_cfg_ctrl_reg[7:0] <= rfg_write_value;
                end
                {1'b1,16'h25}: begin
                    lane_8_cfg_ctrl_reg[7:0] <= rfg_write_value;
                end
                {1'b1,16'h26}: begin
                    lane_9_cfg_ctrl_reg[7:0] <= rfg_write_value;
                end
                {1'b1,16'h27}: begin
                    lane_10_cfg_ctrl_reg[7:0] <= rfg_write_value;
                end
                {1'b1,16'h28}: begin
                    lane_11_cfg_ctrl_reg[7:0] <= rfg_write_value;
                end
                {1'b1,16'h29}: begin
                    lane_12_cfg_ctrl_reg[7:0] <= rfg_write_value;
                end
                {1'b1,16'h2a}: begin
                    lane_13_cfg_ctrl_reg[7:0] <= rfg_write_value;
                end
                {1'b1,16'h2b}: begin
                    lane_14_cfg_ctrl_reg[7:0] <= rfg_write_value;
                end
                {1'b1,16'h2c}: begin
                    lane_15_cfg_ctrl_reg[7:0] <= rfg_write_value;
                end
                {1'b1,16'h2d}: begin
                    lane_16_cfg_ctrl_reg[7:0] <= rfg_write_value;
                end
                {1'b1,16'h2e}: begin
                    lane_17_cfg_ctrl_reg[7:0] <= rfg_write_value;
                end
                {1'b1,16'h2f}: begin
                    lane_18_cfg_ctrl_reg[7:0] <= rfg_write_value;
                end
                {1'b1,16'h30}: begin
                    lane_19_cfg_ctrl_reg[7:0] <= rfg_write_value;
                end
                {1'b1,16'h45}: begin
                    lane_0_stat_frame_counter_reg[7:0] <= rfg_write_value;
                end
                {1'b1,16'h46}: begin
                    lane_0_stat_frame_counter_reg[15:8] <= rfg_write_value;
                end
                {1'b1,16'h47}: begin
                    lane_0_stat_frame_counter_reg[23:16] <= rfg_write_value;
                end
                {1'b1,16'h48}: begin
                    lane_0_stat_frame_counter_reg[31:24] <= rfg_write_value;
                end
                {1'b1,16'h49}: begin
                    lane_1_stat_frame_counter_reg[7:0] <= rfg_write_value;
                end
                {1'b1,16'h4a}: begin
                    lane_1_stat_frame_counter_reg[15:8] <= rfg_write_value;
                end
                {1'b1,16'h4b}: begin
                    lane_1_stat_frame_counter_reg[23:16] <= rfg_write_value;
                end
                {1'b1,16'h4c}: begin
                    lane_1_stat_frame_counter_reg[31:24] <= rfg_write_value;
                end
                {1'b1,16'h4d}: begin
                    lane_2_stat_frame_counter_reg[7:0] <= rfg_write_value;
                end
                {1'b1,16'h4e}: begin
                    lane_2_stat_frame_counter_reg[15:8] <= rfg_write_value;
                end
                {1'b1,16'h4f}: begin
                    lane_2_stat_frame_counter_reg[23:16] <= rfg_write_value;
                end
                {1'b1,16'h50}: begin
                    lane_2_stat_frame_counter_reg[31:24] <= rfg_write_value;
                end
                {1'b1,16'h51}: begin
                    lane_3_stat_frame_counter_reg[7:0] <= rfg_write_value;
                end
                {1'b1,16'h52}: begin
                    lane_3_stat_frame_counter_reg[15:8] <= rfg_write_value;
                end
                {1'b1,16'h53}: begin
                    lane_3_stat_frame_counter_reg[23:16] <= rfg_write_value;
                end
                {1'b1,16'h54}: begin
                    lane_3_stat_frame_counter_reg[31:24] <= rfg_write_value;
                end
                {1'b1,16'h55}: begin
                    lane_4_stat_frame_counter_reg[7:0] <= rfg_write_value;
                end
                {1'b1,16'h56}: begin
                    lane_4_stat_frame_counter_reg[15:8] <= rfg_write_value;
                end
                {1'b1,16'h57}: begin
                    lane_4_stat_frame_counter_reg[23:16] <= rfg_write_value;
                end
                {1'b1,16'h58}: begin
                    lane_4_stat_frame_counter_reg[31:24] <= rfg_write_value;
                end
                {1'b1,16'h59}: begin
                    lane_5_stat_frame_counter_reg[7:0] <= rfg_write_value;
                end
                {1'b1,16'h5a}: begin
                    lane_5_stat_frame_counter_reg[15:8] <= rfg_write_value;
                end
                {1'b1,16'h5b}: begin
                    lane_5_stat_frame_counter_reg[23:16] <= rfg_write_value;
                end
                {1'b1,16'h5c}: begin
                    lane_5_stat_frame_counter_reg[31:24] <= rfg_write_value;
                end
                {1'b1,16'h5d}: begin
                    lane_6_stat_frame_counter_reg[7:0] <= rfg_write_value;
                end
                {1'b1,16'h5e}: begin
                    lane_6_stat_frame_counter_reg[15:8] <= rfg_write_value;
                end
                {1'b1,16'h5f}: begin
                    lane_6_stat_frame_counter_reg[23:16] <= rfg_write_value;
                end
                {1'b1,16'h60}: begin
                    lane_6_stat_frame_counter_reg[31:24] <= rfg_write_value;
                end
                {1'b1,16'h61}: begin
                    lane_7_stat_frame_counter_reg[7:0] <= rfg_write_value;
                end
                {1'b1,16'h62}: begin
                    lane_7_stat_frame_counter_reg[15:8] <= rfg_write_value;
                end
                {1'b1,16'h63}: begin
                    lane_7_stat_frame_counter_reg[23:16] <= rfg_write_value;
                end
                {1'b1,16'h64}: begin
                    lane_7_stat_frame_counter_reg[31:24] <= rfg_write_value;
                end
                {1'b1,16'h65}: begin
                    lane_8_stat_frame_counter_reg[7:0] <= rfg_write_value;
                end
                {1'b1,16'h66}: begin
                    lane_8_stat_frame_counter_reg[15:8] <= rfg_write_value;
                end
                {1'b1,16'h67}: begin
                    lane_8_stat_frame_counter_reg[23:16] <= rfg_write_value;
                end
                {1'b1,16'h68}: begin
                    lane_8_stat_frame_counter_reg[31:24] <= rfg_write_value;
                end
                {1'b1,16'h69}: begin
                    lane_9_stat_frame_counter_reg[7:0] <= rfg_write_value;
                end
                {1'b1,16'h6a}: begin
                    lane_9_stat_frame_counter_reg[15:8] <= rfg_write_value;
                end
                {1'b1,16'h6b}: begin
                    lane_9_stat_frame_counter_reg[23:16] <= rfg_write_value;
                end
                {1'b1,16'h6c}: begin
                    lane_9_stat_frame_counter_reg[31:24] <= rfg_write_value;
                end
                {1'b1,16'h6d}: begin
                    lane_10_stat_frame_counter_reg[7:0] <= rfg_write_value;
                end
                {1'b1,16'h6e}: begin
                    lane_10_stat_frame_counter_reg[15:8] <= rfg_write_value;
                end
                {1'b1,16'h6f}: begin
                    lane_10_stat_frame_counter_reg[23:16] <= rfg_write_value;
                end
                {1'b1,16'h70}: begin
                    lane_10_stat_frame_counter_reg[31:24] <= rfg_write_value;
                end
                {1'b1,16'h71}: begin
                    lane_11_stat_frame_counter_reg[7:0] <= rfg_write_value;
                end
                {1'b1,16'h72}: begin
                    lane_11_stat_frame_counter_reg[15:8] <= rfg_write_value;
                end
                {1'b1,16'h73}: begin
                    lane_11_stat_frame_counter_reg[23:16] <= rfg_write_value;
                end
                {1'b1,16'h74}: begin
                    lane_11_stat_frame_counter_reg[31:24] <= rfg_write_value;
                end
                {1'b1,16'h75}: begin
                    lane_12_stat_frame_counter_reg[7:0] <= rfg_write_value;
                end
                {1'b1,16'h76}: begin
                    lane_12_stat_frame_counter_reg[15:8] <= rfg_write_value;
                end
                {1'b1,16'h77}: begin
                    lane_12_stat_frame_counter_reg[23:16] <= rfg_write_value;
                end
                {1'b1,16'h78}: begin
                    lane_12_stat_frame_counter_reg[31:24] <= rfg_write_value;
                end
                {1'b1,16'h79}: begin
                    lane_13_stat_frame_counter_reg[7:0] <= rfg_write_value;
                end
                {1'b1,16'h7a}: begin
                    lane_13_stat_frame_counter_reg[15:8] <= rfg_write_value;
                end
                {1'b1,16'h7b}: begin
                    lane_13_stat_frame_counter_reg[23:16] <= rfg_write_value;
                end
                {1'b1,16'h7c}: begin
                    lane_13_stat_frame_counter_reg[31:24] <= rfg_write_value;
                end
                {1'b1,16'h7d}: begin
                    lane_14_stat_frame_counter_reg[7:0] <= rfg_write_value;
                end
                {1'b1,16'h7e}: begin
                    lane_14_stat_frame_counter_reg[15:8] <= rfg_write_value;
                end
                {1'b1,16'h7f}: begin
                    lane_14_stat_frame_counter_reg[23:16] <= rfg_write_value;
                end
                {1'b1,16'h80}: begin
                    lane_14_stat_frame_counter_reg[31:24] <= rfg_write_value;
                end
                {1'b1,16'h81}: begin
                    lane_15_stat_frame_counter_reg[7:0] <= rfg_write_value;
                end
                {1'b1,16'h82}: begin
                    lane_15_stat_frame_counter_reg[15:8] <= rfg_write_value;
                end
                {1'b1,16'h83}: begin
                    lane_15_stat_frame_counter_reg[23:16] <= rfg_write_value;
                end
                {1'b1,16'h84}: begin
                    lane_15_stat_frame_counter_reg[31:24] <= rfg_write_value;
                end
                {1'b1,16'h85}: begin
                    lane_16_stat_frame_counter_reg[7:0] <= rfg_write_value;
                end
                {1'b1,16'h86}: begin
                    lane_16_stat_frame_counter_reg[15:8] <= rfg_write_value;
                end
                {1'b1,16'h87}: begin
                    lane_16_stat_frame_counter_reg[23:16] <= rfg_write_value;
                end
                {1'b1,16'h88}: begin
                    lane_16_stat_frame_counter_reg[31:24] <= rfg_write_value;
                end
                {1'b1,16'h89}: begin
                    lane_17_stat_frame_counter_reg[7:0] <= rfg_write_value;
                end
                {1'b1,16'h8a}: begin
                    lane_17_stat_frame_counter_reg[15:8] <= rfg_write_value;
                end
                {1'b1,16'h8b}: begin
                    lane_17_stat_frame_counter_reg[23:16] <= rfg_write_value;
                end
                {1'b1,16'h8c}: begin
                    lane_17_stat_frame_counter_reg[31:24] <= rfg_write_value;
                end
                {1'b1,16'h8d}: begin
                    lane_18_stat_frame_counter_reg[7:0] <= rfg_write_value;
                end
                {1'b1,16'h8e}: begin
                    lane_18_stat_frame_counter_reg[15:8] <= rfg_write_value;
                end
                {1'b1,16'h8f}: begin
                    lane_18_stat_frame_counter_reg[23:16] <= rfg_write_value;
                end
                {1'b1,16'h90}: begin
                    lane_18_stat_frame_counter_reg[31:24] <= rfg_write_value;
                end
                {1'b1,16'h91}: begin
                    lane_19_stat_frame_counter_reg[7:0] <= rfg_write_value;
                end
                {1'b1,16'h92}: begin
                    lane_19_stat_frame_counter_reg[15:8] <= rfg_write_value;
                end
                {1'b1,16'h93}: begin
                    lane_19_stat_frame_counter_reg[23:16] <= rfg_write_value;
                end
                {1'b1,16'h94}: begin
                    lane_19_stat_frame_counter_reg[31:24] <= rfg_write_value;
                end
                {1'b1,16'h95}: begin
                    lane_0_stat_idle_counter_reg[7:0] <= rfg_write_value;
                end
                {1'b1,16'h96}: begin
                    lane_0_stat_idle_counter_reg[15:8] <= rfg_write_value;
                end
                {1'b1,16'h97}: begin
                    lane_0_stat_idle_counter_reg[23:16] <= rfg_write_value;
                end
                {1'b1,16'h98}: begin
                    lane_0_stat_idle_counter_reg[31:24] <= rfg_write_value;
                end
                {1'b1,16'h99}: begin
                    lane_1_stat_idle_counter_reg[7:0] <= rfg_write_value;
                end
                {1'b1,16'h9a}: begin
                    lane_1_stat_idle_counter_reg[15:8] <= rfg_write_value;
                end
                {1'b1,16'h9b}: begin
                    lane_1_stat_idle_counter_reg[23:16] <= rfg_write_value;
                end
                {1'b1,16'h9c}: begin
                    lane_1_stat_idle_counter_reg[31:24] <= rfg_write_value;
                end
                {1'b1,16'h9d}: begin
                    lane_2_stat_idle_counter_reg[7:0] <= rfg_write_value;
                end
                {1'b1,16'h9e}: begin
                    lane_2_stat_idle_counter_reg[15:8] <= rfg_write_value;
                end
                {1'b1,16'h9f}: begin
                    lane_2_stat_idle_counter_reg[23:16] <= rfg_write_value;
                end
                {1'b1,16'ha0}: begin
                    lane_2_stat_idle_counter_reg[31:24] <= rfg_write_value;
                end
                {1'b1,16'ha1}: begin
                    lane_3_stat_idle_counter_reg[7:0] <= rfg_write_value;
                end
                {1'b1,16'ha2}: begin
                    lane_3_stat_idle_counter_reg[15:8] <= rfg_write_value;
                end
                {1'b1,16'ha3}: begin
                    lane_3_stat_idle_counter_reg[23:16] <= rfg_write_value;
                end
                {1'b1,16'ha4}: begin
                    lane_3_stat_idle_counter_reg[31:24] <= rfg_write_value;
                end
                {1'b1,16'ha5}: begin
                    lane_4_stat_idle_counter_reg[7:0] <= rfg_write_value;
                end
                {1'b1,16'ha6}: begin
                    lane_4_stat_idle_counter_reg[15:8] <= rfg_write_value;
                end
                {1'b1,16'ha7}: begin
                    lane_4_stat_idle_counter_reg[23:16] <= rfg_write_value;
                end
                {1'b1,16'ha8}: begin
                    lane_4_stat_idle_counter_reg[31:24] <= rfg_write_value;
                end
                {1'b1,16'ha9}: begin
                    lane_5_stat_idle_counter_reg[7:0] <= rfg_write_value;
                end
                {1'b1,16'haa}: begin
                    lane_5_stat_idle_counter_reg[15:8] <= rfg_write_value;
                end
                {1'b1,16'hab}: begin
                    lane_5_stat_idle_counter_reg[23:16] <= rfg_write_value;
                end
                {1'b1,16'hac}: begin
                    lane_5_stat_idle_counter_reg[31:24] <= rfg_write_value;
                end
                {1'b1,16'had}: begin
                    lane_6_stat_idle_counter_reg[7:0] <= rfg_write_value;
                end
                {1'b1,16'hae}: begin
                    lane_6_stat_idle_counter_reg[15:8] <= rfg_write_value;
                end
                {1'b1,16'haf}: begin
                    lane_6_stat_idle_counter_reg[23:16] <= rfg_write_value;
                end
                {1'b1,16'hb0}: begin
                    lane_6_stat_idle_counter_reg[31:24] <= rfg_write_value;
                end
                {1'b1,16'hb1}: begin
                    lane_7_stat_idle_counter_reg[7:0] <= rfg_write_value;
                end
                {1'b1,16'hb2}: begin
                    lane_7_stat_idle_counter_reg[15:8] <= rfg_write_value;
                end
                {1'b1,16'hb3}: begin
                    lane_7_stat_idle_counter_reg[23:16] <= rfg_write_value;
                end
                {1'b1,16'hb4}: begin
                    lane_7_stat_idle_counter_reg[31:24] <= rfg_write_value;
                end
                {1'b1,16'hb5}: begin
                    lane_8_stat_idle_counter_reg[7:0] <= rfg_write_value;
                end
                {1'b1,16'hb6}: begin
                    lane_8_stat_idle_counter_reg[15:8] <= rfg_write_value;
                end
                {1'b1,16'hb7}: begin
                    lane_8_stat_idle_counter_reg[23:16] <= rfg_write_value;
                end
                {1'b1,16'hb8}: begin
                    lane_8_stat_idle_counter_reg[31:24] <= rfg_write_value;
                end
                {1'b1,16'hb9}: begin
                    lane_9_stat_idle_counter_reg[7:0] <= rfg_write_value;
                end
                {1'b1,16'hba}: begin
                    lane_9_stat_idle_counter_reg[15:8] <= rfg_write_value;
                end
                {1'b1,16'hbb}: begin
                    lane_9_stat_idle_counter_reg[23:16] <= rfg_write_value;
                end
                {1'b1,16'hbc}: begin
                    lane_9_stat_idle_counter_reg[31:24] <= rfg_write_value;
                end
                {1'b1,16'hbd}: begin
                    lane_10_stat_idle_counter_reg[7:0] <= rfg_write_value;
                end
                {1'b1,16'hbe}: begin
                    lane_10_stat_idle_counter_reg[15:8] <= rfg_write_value;
                end
                {1'b1,16'hbf}: begin
                    lane_10_stat_idle_counter_reg[23:16] <= rfg_write_value;
                end
                {1'b1,16'hc0}: begin
                    lane_10_stat_idle_counter_reg[31:24] <= rfg_write_value;
                end
                {1'b1,16'hc1}: begin
                    lane_11_stat_idle_counter_reg[7:0] <= rfg_write_value;
                end
                {1'b1,16'hc2}: begin
                    lane_11_stat_idle_counter_reg[15:8] <= rfg_write_value;
                end
                {1'b1,16'hc3}: begin
                    lane_11_stat_idle_counter_reg[23:16] <= rfg_write_value;
                end
                {1'b1,16'hc4}: begin
                    lane_11_stat_idle_counter_reg[31:24] <= rfg_write_value;
                end
                {1'b1,16'hc5}: begin
                    lane_12_stat_idle_counter_reg[7:0] <= rfg_write_value;
                end
                {1'b1,16'hc6}: begin
                    lane_12_stat_idle_counter_reg[15:8] <= rfg_write_value;
                end
                {1'b1,16'hc7}: begin
                    lane_12_stat_idle_counter_reg[23:16] <= rfg_write_value;
                end
                {1'b1,16'hc8}: begin
                    lane_12_stat_idle_counter_reg[31:24] <= rfg_write_value;
                end
                {1'b1,16'hc9}: begin
                    lane_13_stat_idle_counter_reg[7:0] <= rfg_write_value;
                end
                {1'b1,16'hca}: begin
                    lane_13_stat_idle_counter_reg[15:8] <= rfg_write_value;
                end
                {1'b1,16'hcb}: begin
                    lane_13_stat_idle_counter_reg[23:16] <= rfg_write_value;
                end
                {1'b1,16'hcc}: begin
                    lane_13_stat_idle_counter_reg[31:24] <= rfg_write_value;
                end
                {1'b1,16'hcd}: begin
                    lane_14_stat_idle_counter_reg[7:0] <= rfg_write_value;
                end
                {1'b1,16'hce}: begin
                    lane_14_stat_idle_counter_reg[15:8] <= rfg_write_value;
                end
                {1'b1,16'hcf}: begin
                    lane_14_stat_idle_counter_reg[23:16] <= rfg_write_value;
                end
                {1'b1,16'hd0}: begin
                    lane_14_stat_idle_counter_reg[31:24] <= rfg_write_value;
                end
                {1'b1,16'hd1}: begin
                    lane_15_stat_idle_counter_reg[7:0] <= rfg_write_value;
                end
                {1'b1,16'hd2}: begin
                    lane_15_stat_idle_counter_reg[15:8] <= rfg_write_value;
                end
                {1'b1,16'hd3}: begin
                    lane_15_stat_idle_counter_reg[23:16] <= rfg_write_value;
                end
                {1'b1,16'hd4}: begin
                    lane_15_stat_idle_counter_reg[31:24] <= rfg_write_value;
                end
                {1'b1,16'hd5}: begin
                    lane_16_stat_idle_counter_reg[7:0] <= rfg_write_value;
                end
                {1'b1,16'hd6}: begin
                    lane_16_stat_idle_counter_reg[15:8] <= rfg_write_value;
                end
                {1'b1,16'hd7}: begin
                    lane_16_stat_idle_counter_reg[23:16] <= rfg_write_value;
                end
                {1'b1,16'hd8}: begin
                    lane_16_stat_idle_counter_reg[31:24] <= rfg_write_value;
                end
                {1'b1,16'hd9}: begin
                    lane_17_stat_idle_counter_reg[7:0] <= rfg_write_value;
                end
                {1'b1,16'hda}: begin
                    lane_17_stat_idle_counter_reg[15:8] <= rfg_write_value;
                end
                {1'b1,16'hdb}: begin
                    lane_17_stat_idle_counter_reg[23:16] <= rfg_write_value;
                end
                {1'b1,16'hdc}: begin
                    lane_17_stat_idle_counter_reg[31:24] <= rfg_write_value;
                end
                {1'b1,16'hdd}: begin
                    lane_18_stat_idle_counter_reg[7:0] <= rfg_write_value;
                end
                {1'b1,16'hde}: begin
                    lane_18_stat_idle_counter_reg[15:8] <= rfg_write_value;
                end
                {1'b1,16'hdf}: begin
                    lane_18_stat_idle_counter_reg[23:16] <= rfg_write_value;
                end
                {1'b1,16'he0}: begin
                    lane_18_stat_idle_counter_reg[31:24] <= rfg_write_value;
                end
                {1'b1,16'he1}: begin
                    lane_19_stat_idle_counter_reg[7:0] <= rfg_write_value;
                end
                {1'b1,16'he2}: begin
                    lane_19_stat_idle_counter_reg[15:8] <= rfg_write_value;
                end
                {1'b1,16'he3}: begin
                    lane_19_stat_idle_counter_reg[23:16] <= rfg_write_value;
                end
                {1'b1,16'he4}: begin
                    lane_19_stat_idle_counter_reg[31:24] <= rfg_write_value;
                end
                {1'b1,16'h211}: begin
                    lanes_cfg_frame_tag_counter_ctrl_reg[7:0] <= rfg_write_value;
                end
                {1'b1,16'h212}: begin
                    lanes_cfg_frame_tag_counter_trigger_reg[7:0] <= rfg_write_value;
                end
                {1'b1,16'h213}: begin
                    lanes_cfg_frame_tag_counter_trigger_reg[15:8] <= rfg_write_value;
                end
                {1'b1,16'h214}: begin
                    lanes_cfg_frame_tag_counter_trigger_reg[23:16] <= rfg_write_value;
                end
                {1'b1,16'h215}: begin
                    lanes_cfg_frame_tag_counter_trigger_reg[31:24] <= rfg_write_value;
                end
                {1'b1,16'h216}: begin
                    lanes_cfg_frame_tag_counter_reg[7:0] <= rfg_write_value;
                end
                {1'b1,16'h217}: begin
                    lanes_cfg_frame_tag_counter_reg[15:8] <= rfg_write_value;
                end
                {1'b1,16'h218}: begin
                    lanes_cfg_frame_tag_counter_reg[23:16] <= rfg_write_value;
                end
                {1'b1,16'h219}: begin
                    lanes_cfg_frame_tag_counter_reg[31:24] <= rfg_write_value;
                end
                {1'b1,16'h21a}: begin
                    lanes_cfg_nodata_continue_reg[7:0] <= rfg_write_value;
                end
                {1'b1,16'h21b}: begin
                    lanes_sr_out_reg[7:0] <= rfg_write_value;
                end
                {1'b1,16'h21c}: begin
                    lanes_sr_in_reg[7:0] <= rfg_write_value;
                end
                {1'b1,16'h21d}: begin
                    lanes_inj_ctrl_reg[7:0] <= rfg_write_value;
                end
                {1'b1,16'h21e}: begin
                    lanes_inj_waddr_reg[3:0] <= rfg_write_value[3:0];
                end
                {1'b1,16'h21f}: begin
                    lanes_inj_wdata_reg[7:0] <= rfg_write_value;
                end
                {1'b1,16'h225}: begin
                    io_ctrl_reg[7:0] <= rfg_write_value;
                end
                {1'b1,16'h226}: begin
                    io_led_reg[7:0] <= rfg_write_value;
                end
                {1'b1,16'h227}: begin
                    gecco_sr_ctrl_reg[7:0] <= rfg_write_value;
                end
                {1'b1,16'h228}: begin
                    hk_conversion_trigger_match_reg[7:0] <= rfg_write_value;
                end
                {1'b1,16'h229}: begin
                    hk_conversion_trigger_match_reg[15:8] <= rfg_write_value;
                end
                {1'b1,16'h22a}: begin
                    hk_conversion_trigger_match_reg[23:16] <= rfg_write_value;
                end
                {1'b1,16'h22b}: begin
                    hk_conversion_trigger_match_reg[31:24] <= rfg_write_value;
                end
                {1'b1,16'h22c}: begin
                    lanes_cfg_frame_tag_counter_trigger_match_reg[7:0] <= rfg_write_value;
                end
                {1'b1,16'h22d}: begin
                    lanes_cfg_frame_tag_counter_trigger_match_reg[15:8] <= rfg_write_value;
                end
                {1'b1,16'h22e}: begin
                    lanes_cfg_frame_tag_counter_trigger_match_reg[23:16] <= rfg_write_value;
                end
                {1'b1,16'h22f}: begin
                    lanes_cfg_frame_tag_counter_trigger_match_reg[31:24] <= rfg_write_value;
                end
                default: begin
                end
            endcase
            
            // Write for FIFO Master
            if(rfg_write && rfg_address==16'h15) begin
                hk_adcdac_mosi_fifo_m_axis_tvalid <= 1'b1;
                hk_adcdac_mosi_fifo_m_axis_tdata  <= rfg_write_value;
                hk_adcdac_mosi_fifo_m_axis_tlast  <= rfg_write_last;
            end else begin
                hk_adcdac_mosi_fifo_m_axis_tvalid <= 1'b0;
                hk_adcdac_mosi_fifo_m_axis_tlast  <= 1'b0;
            end
            if(rfg_write && rfg_address==16'he5) begin
                lane_0_mosi_m_axis_tvalid <= 1'b1;
                lane_0_mosi_m_axis_tdata  <= rfg_write_value;
                lane_0_mosi_m_axis_tlast  <= rfg_write_last;
            end else begin
                lane_0_mosi_m_axis_tvalid <= 1'b0;
                lane_0_mosi_m_axis_tlast  <= 1'b0;
            end
            if(rfg_write && rfg_address==16'hea) begin
                lane_1_mosi_m_axis_tvalid <= 1'b1;
                lane_1_mosi_m_axis_tdata  <= rfg_write_value;
                lane_1_mosi_m_axis_tlast  <= rfg_write_last;
            end else begin
                lane_1_mosi_m_axis_tvalid <= 1'b0;
                lane_1_mosi_m_axis_tlast  <= 1'b0;
            end
            if(rfg_write && rfg_address==16'hef) begin
                lane_2_mosi_m_axis_tvalid <= 1'b1;
                lane_2_mosi_m_axis_tdata  <= rfg_write_value;
                lane_2_mosi_m_axis_tlast  <= rfg_write_last;
            end else begin
                lane_2_mosi_m_axis_tvalid <= 1'b0;
                lane_2_mosi_m_axis_tlast  <= 1'b0;
            end
            if(rfg_write && rfg_address==16'hf4) begin
                lane_3_mosi_m_axis_tvalid <= 1'b1;
                lane_3_mosi_m_axis_tdata  <= rfg_write_value;
                lane_3_mosi_m_axis_tlast  <= rfg_write_last;
            end else begin
                lane_3_mosi_m_axis_tvalid <= 1'b0;
                lane_3_mosi_m_axis_tlast  <= 1'b0;
            end
            if(rfg_write && rfg_address==16'hf9) begin
                lane_4_mosi_m_axis_tvalid <= 1'b1;
                lane_4_mosi_m_axis_tdata  <= rfg_write_value;
                lane_4_mosi_m_axis_tlast  <= rfg_write_last;
            end else begin
                lane_4_mosi_m_axis_tvalid <= 1'b0;
                lane_4_mosi_m_axis_tlast  <= 1'b0;
            end
            if(rfg_write && rfg_address==16'hfe) begin
                lane_5_mosi_m_axis_tvalid <= 1'b1;
                lane_5_mosi_m_axis_tdata  <= rfg_write_value;
                lane_5_mosi_m_axis_tlast  <= rfg_write_last;
            end else begin
                lane_5_mosi_m_axis_tvalid <= 1'b0;
                lane_5_mosi_m_axis_tlast  <= 1'b0;
            end
            if(rfg_write && rfg_address==16'h103) begin
                lane_6_mosi_m_axis_tvalid <= 1'b1;
                lane_6_mosi_m_axis_tdata  <= rfg_write_value;
                lane_6_mosi_m_axis_tlast  <= rfg_write_last;
            end else begin
                lane_6_mosi_m_axis_tvalid <= 1'b0;
                lane_6_mosi_m_axis_tlast  <= 1'b0;
            end
            if(rfg_write && rfg_address==16'h108) begin
                lane_7_mosi_m_axis_tvalid <= 1'b1;
                lane_7_mosi_m_axis_tdata  <= rfg_write_value;
                lane_7_mosi_m_axis_tlast  <= rfg_write_last;
            end else begin
                lane_7_mosi_m_axis_tvalid <= 1'b0;
                lane_7_mosi_m_axis_tlast  <= 1'b0;
            end
            if(rfg_write && rfg_address==16'h10d) begin
                lane_8_mosi_m_axis_tvalid <= 1'b1;
                lane_8_mosi_m_axis_tdata  <= rfg_write_value;
                lane_8_mosi_m_axis_tlast  <= rfg_write_last;
            end else begin
                lane_8_mosi_m_axis_tvalid <= 1'b0;
                lane_8_mosi_m_axis_tlast  <= 1'b0;
            end
            if(rfg_write && rfg_address==16'h112) begin
                lane_9_mosi_m_axis_tvalid <= 1'b1;
                lane_9_mosi_m_axis_tdata  <= rfg_write_value;
                lane_9_mosi_m_axis_tlast  <= rfg_write_last;
            end else begin
                lane_9_mosi_m_axis_tvalid <= 1'b0;
                lane_9_mosi_m_axis_tlast  <= 1'b0;
            end
            if(rfg_write && rfg_address==16'h117) begin
                lane_10_mosi_m_axis_tvalid <= 1'b1;
                lane_10_mosi_m_axis_tdata  <= rfg_write_value;
                lane_10_mosi_m_axis_tlast  <= rfg_write_last;
            end else begin
                lane_10_mosi_m_axis_tvalid <= 1'b0;
                lane_10_mosi_m_axis_tlast  <= 1'b0;
            end
            if(rfg_write && rfg_address==16'h11c) begin
                lane_11_mosi_m_axis_tvalid <= 1'b1;
                lane_11_mosi_m_axis_tdata  <= rfg_write_value;
                lane_11_mosi_m_axis_tlast  <= rfg_write_last;
            end else begin
                lane_11_mosi_m_axis_tvalid <= 1'b0;
                lane_11_mosi_m_axis_tlast  <= 1'b0;
            end
            if(rfg_write && rfg_address==16'h121) begin
                lane_12_mosi_m_axis_tvalid <= 1'b1;
                lane_12_mosi_m_axis_tdata  <= rfg_write_value;
                lane_12_mosi_m_axis_tlast  <= rfg_write_last;
            end else begin
                lane_12_mosi_m_axis_tvalid <= 1'b0;
                lane_12_mosi_m_axis_tlast  <= 1'b0;
            end
            if(rfg_write && rfg_address==16'h126) begin
                lane_13_mosi_m_axis_tvalid <= 1'b1;
                lane_13_mosi_m_axis_tdata  <= rfg_write_value;
                lane_13_mosi_m_axis_tlast  <= rfg_write_last;
            end else begin
                lane_13_mosi_m_axis_tvalid <= 1'b0;
                lane_13_mosi_m_axis_tlast  <= 1'b0;
            end
            if(rfg_write && rfg_address==16'h12b) begin
                lane_14_mosi_m_axis_tvalid <= 1'b1;
                lane_14_mosi_m_axis_tdata  <= rfg_write_value;
                lane_14_mosi_m_axis_tlast  <= rfg_write_last;
            end else begin
                lane_14_mosi_m_axis_tvalid <= 1'b0;
                lane_14_mosi_m_axis_tlast  <= 1'b0;
            end
            if(rfg_write && rfg_address==16'h130) begin
                lane_15_mosi_m_axis_tvalid <= 1'b1;
                lane_15_mosi_m_axis_tdata  <= rfg_write_value;
                lane_15_mosi_m_axis_tlast  <= rfg_write_last;
            end else begin
                lane_15_mosi_m_axis_tvalid <= 1'b0;
                lane_15_mosi_m_axis_tlast  <= 1'b0;
            end
            if(rfg_write && rfg_address==16'h135) begin
                lane_16_mosi_m_axis_tvalid <= 1'b1;
                lane_16_mosi_m_axis_tdata  <= rfg_write_value;
                lane_16_mosi_m_axis_tlast  <= rfg_write_last;
            end else begin
                lane_16_mosi_m_axis_tvalid <= 1'b0;
                lane_16_mosi_m_axis_tlast  <= 1'b0;
            end
            if(rfg_write && rfg_address==16'h13a) begin
                lane_17_mosi_m_axis_tvalid <= 1'b1;
                lane_17_mosi_m_axis_tdata  <= rfg_write_value;
                lane_17_mosi_m_axis_tlast  <= rfg_write_last;
            end else begin
                lane_17_mosi_m_axis_tvalid <= 1'b0;
                lane_17_mosi_m_axis_tlast  <= 1'b0;
            end
            if(rfg_write && rfg_address==16'h13f) begin
                lane_18_mosi_m_axis_tvalid <= 1'b1;
                lane_18_mosi_m_axis_tdata  <= rfg_write_value;
                lane_18_mosi_m_axis_tlast  <= rfg_write_last;
            end else begin
                lane_18_mosi_m_axis_tvalid <= 1'b0;
                lane_18_mosi_m_axis_tlast  <= 1'b0;
            end
            if(rfg_write && rfg_address==16'h144) begin
                lane_19_mosi_m_axis_tvalid <= 1'b1;
                lane_19_mosi_m_axis_tdata  <= rfg_write_value;
                lane_19_mosi_m_axis_tlast  <= rfg_write_last;
            end else begin
                lane_19_mosi_m_axis_tvalid <= 1'b0;
                lane_19_mosi_m_axis_tlast  <= 1'b0;
            end
            if(rfg_write && rfg_address==16'h149) begin
                lane_0_loopback_miso_m_axis_tvalid <= 1'b1;
                lane_0_loopback_miso_m_axis_tdata  <= rfg_write_value;
            end else begin
                lane_0_loopback_miso_m_axis_tvalid <= 1'b0;
            end
            if(rfg_write && rfg_address==16'h14e) begin
                lane_1_loopback_miso_m_axis_tvalid <= 1'b1;
                lane_1_loopback_miso_m_axis_tdata  <= rfg_write_value;
            end else begin
                lane_1_loopback_miso_m_axis_tvalid <= 1'b0;
            end
            if(rfg_write && rfg_address==16'h153) begin
                lane_2_loopback_miso_m_axis_tvalid <= 1'b1;
                lane_2_loopback_miso_m_axis_tdata  <= rfg_write_value;
            end else begin
                lane_2_loopback_miso_m_axis_tvalid <= 1'b0;
            end
            if(rfg_write && rfg_address==16'h158) begin
                lane_3_loopback_miso_m_axis_tvalid <= 1'b1;
                lane_3_loopback_miso_m_axis_tdata  <= rfg_write_value;
            end else begin
                lane_3_loopback_miso_m_axis_tvalid <= 1'b0;
            end
            if(rfg_write && rfg_address==16'h15d) begin
                lane_4_loopback_miso_m_axis_tvalid <= 1'b1;
                lane_4_loopback_miso_m_axis_tdata  <= rfg_write_value;
            end else begin
                lane_4_loopback_miso_m_axis_tvalid <= 1'b0;
            end
            if(rfg_write && rfg_address==16'h162) begin
                lane_5_loopback_miso_m_axis_tvalid <= 1'b1;
                lane_5_loopback_miso_m_axis_tdata  <= rfg_write_value;
            end else begin
                lane_5_loopback_miso_m_axis_tvalid <= 1'b0;
            end
            if(rfg_write && rfg_address==16'h167) begin
                lane_6_loopback_miso_m_axis_tvalid <= 1'b1;
                lane_6_loopback_miso_m_axis_tdata  <= rfg_write_value;
            end else begin
                lane_6_loopback_miso_m_axis_tvalid <= 1'b0;
            end
            if(rfg_write && rfg_address==16'h16c) begin
                lane_7_loopback_miso_m_axis_tvalid <= 1'b1;
                lane_7_loopback_miso_m_axis_tdata  <= rfg_write_value;
            end else begin
                lane_7_loopback_miso_m_axis_tvalid <= 1'b0;
            end
            if(rfg_write && rfg_address==16'h171) begin
                lane_8_loopback_miso_m_axis_tvalid <= 1'b1;
                lane_8_loopback_miso_m_axis_tdata  <= rfg_write_value;
            end else begin
                lane_8_loopback_miso_m_axis_tvalid <= 1'b0;
            end
            if(rfg_write && rfg_address==16'h176) begin
                lane_9_loopback_miso_m_axis_tvalid <= 1'b1;
                lane_9_loopback_miso_m_axis_tdata  <= rfg_write_value;
            end else begin
                lane_9_loopback_miso_m_axis_tvalid <= 1'b0;
            end
            if(rfg_write && rfg_address==16'h17b) begin
                lane_10_loopback_miso_m_axis_tvalid <= 1'b1;
                lane_10_loopback_miso_m_axis_tdata  <= rfg_write_value;
            end else begin
                lane_10_loopback_miso_m_axis_tvalid <= 1'b0;
            end
            if(rfg_write && rfg_address==16'h180) begin
                lane_11_loopback_miso_m_axis_tvalid <= 1'b1;
                lane_11_loopback_miso_m_axis_tdata  <= rfg_write_value;
            end else begin
                lane_11_loopback_miso_m_axis_tvalid <= 1'b0;
            end
            if(rfg_write && rfg_address==16'h185) begin
                lane_12_loopback_miso_m_axis_tvalid <= 1'b1;
                lane_12_loopback_miso_m_axis_tdata  <= rfg_write_value;
            end else begin
                lane_12_loopback_miso_m_axis_tvalid <= 1'b0;
            end
            if(rfg_write && rfg_address==16'h18a) begin
                lane_13_loopback_miso_m_axis_tvalid <= 1'b1;
                lane_13_loopback_miso_m_axis_tdata  <= rfg_write_value;
            end else begin
                lane_13_loopback_miso_m_axis_tvalid <= 1'b0;
            end
            if(rfg_write && rfg_address==16'h18f) begin
                lane_14_loopback_miso_m_axis_tvalid <= 1'b1;
                lane_14_loopback_miso_m_axis_tdata  <= rfg_write_value;
            end else begin
                lane_14_loopback_miso_m_axis_tvalid <= 1'b0;
            end
            if(rfg_write && rfg_address==16'h194) begin
                lane_15_loopback_miso_m_axis_tvalid <= 1'b1;
                lane_15_loopback_miso_m_axis_tdata  <= rfg_write_value;
            end else begin
                lane_15_loopback_miso_m_axis_tvalid <= 1'b0;
            end
            if(rfg_write && rfg_address==16'h199) begin
                lane_16_loopback_miso_m_axis_tvalid <= 1'b1;
                lane_16_loopback_miso_m_axis_tdata  <= rfg_write_value;
            end else begin
                lane_16_loopback_miso_m_axis_tvalid <= 1'b0;
            end
            if(rfg_write && rfg_address==16'h19e) begin
                lane_17_loopback_miso_m_axis_tvalid <= 1'b1;
                lane_17_loopback_miso_m_axis_tdata  <= rfg_write_value;
            end else begin
                lane_17_loopback_miso_m_axis_tvalid <= 1'b0;
            end
            if(rfg_write && rfg_address==16'h1a3) begin
                lane_18_loopback_miso_m_axis_tvalid <= 1'b1;
                lane_18_loopback_miso_m_axis_tdata  <= rfg_write_value;
            end else begin
                lane_18_loopback_miso_m_axis_tvalid <= 1'b0;
            end
            if(rfg_write && rfg_address==16'h1a8) begin
                lane_19_loopback_miso_m_axis_tvalid <= 1'b1;
                lane_19_loopback_miso_m_axis_tdata  <= rfg_write_value;
            end else begin
                lane_19_loopback_miso_m_axis_tvalid <= 1'b0;
            end
            
            // Write for HW Write only
            if(hk_xadc_temperature_write) begin
                hk_xadc_temperature_reg <= hk_xadc_temperature ;
            end
            if(hk_xadc_vccint_write) begin
                hk_xadc_vccint_reg <= hk_xadc_vccint ;
            end
            if(hk_adc_miso_fifo_read_size_write) begin
                hk_adc_miso_fifo_read_size_reg <= hk_adc_miso_fifo_read_size ;
            end
            if(lane_0_mosi_write_size_write) begin
                lane_0_mosi_write_size_reg <= lane_0_mosi_write_size ;
            end
            if(lane_1_mosi_write_size_write) begin
                lane_1_mosi_write_size_reg <= lane_1_mosi_write_size ;
            end
            if(lane_2_mosi_write_size_write) begin
                lane_2_mosi_write_size_reg <= lane_2_mosi_write_size ;
            end
            if(lane_3_mosi_write_size_write) begin
                lane_3_mosi_write_size_reg <= lane_3_mosi_write_size ;
            end
            if(lane_4_mosi_write_size_write) begin
                lane_4_mosi_write_size_reg <= lane_4_mosi_write_size ;
            end
            if(lane_5_mosi_write_size_write) begin
                lane_5_mosi_write_size_reg <= lane_5_mosi_write_size ;
            end
            if(lane_6_mosi_write_size_write) begin
                lane_6_mosi_write_size_reg <= lane_6_mosi_write_size ;
            end
            if(lane_7_mosi_write_size_write) begin
                lane_7_mosi_write_size_reg <= lane_7_mosi_write_size ;
            end
            if(lane_8_mosi_write_size_write) begin
                lane_8_mosi_write_size_reg <= lane_8_mosi_write_size ;
            end
            if(lane_9_mosi_write_size_write) begin
                lane_9_mosi_write_size_reg <= lane_9_mosi_write_size ;
            end
            if(lane_10_mosi_write_size_write) begin
                lane_10_mosi_write_size_reg <= lane_10_mosi_write_size ;
            end
            if(lane_11_mosi_write_size_write) begin
                lane_11_mosi_write_size_reg <= lane_11_mosi_write_size ;
            end
            if(lane_12_mosi_write_size_write) begin
                lane_12_mosi_write_size_reg <= lane_12_mosi_write_size ;
            end
            if(lane_13_mosi_write_size_write) begin
                lane_13_mosi_write_size_reg <= lane_13_mosi_write_size ;
            end
            if(lane_14_mosi_write_size_write) begin
                lane_14_mosi_write_size_reg <= lane_14_mosi_write_size ;
            end
            if(lane_15_mosi_write_size_write) begin
                lane_15_mosi_write_size_reg <= lane_15_mosi_write_size ;
            end
            if(lane_16_mosi_write_size_write) begin
                lane_16_mosi_write_size_reg <= lane_16_mosi_write_size ;
            end
            if(lane_17_mosi_write_size_write) begin
                lane_17_mosi_write_size_reg <= lane_17_mosi_write_size ;
            end
            if(lane_18_mosi_write_size_write) begin
                lane_18_mosi_write_size_reg <= lane_18_mosi_write_size ;
            end
            if(lane_19_mosi_write_size_write) begin
                lane_19_mosi_write_size_reg <= lane_19_mosi_write_size ;
            end
            if(lane_0_loopback_miso_write_size_write) begin
                lane_0_loopback_miso_write_size_reg <= lane_0_loopback_miso_write_size ;
            end
            if(lane_1_loopback_miso_write_size_write) begin
                lane_1_loopback_miso_write_size_reg <= lane_1_loopback_miso_write_size ;
            end
            if(lane_2_loopback_miso_write_size_write) begin
                lane_2_loopback_miso_write_size_reg <= lane_2_loopback_miso_write_size ;
            end
            if(lane_3_loopback_miso_write_size_write) begin
                lane_3_loopback_miso_write_size_reg <= lane_3_loopback_miso_write_size ;
            end
            if(lane_4_loopback_miso_write_size_write) begin
                lane_4_loopback_miso_write_size_reg <= lane_4_loopback_miso_write_size ;
            end
            if(lane_5_loopback_miso_write_size_write) begin
                lane_5_loopback_miso_write_size_reg <= lane_5_loopback_miso_write_size ;
            end
            if(lane_6_loopback_miso_write_size_write) begin
                lane_6_loopback_miso_write_size_reg <= lane_6_loopback_miso_write_size ;
            end
            if(lane_7_loopback_miso_write_size_write) begin
                lane_7_loopback_miso_write_size_reg <= lane_7_loopback_miso_write_size ;
            end
            if(lane_8_loopback_miso_write_size_write) begin
                lane_8_loopback_miso_write_size_reg <= lane_8_loopback_miso_write_size ;
            end
            if(lane_9_loopback_miso_write_size_write) begin
                lane_9_loopback_miso_write_size_reg <= lane_9_loopback_miso_write_size ;
            end
            if(lane_10_loopback_miso_write_size_write) begin
                lane_10_loopback_miso_write_size_reg <= lane_10_loopback_miso_write_size ;
            end
            if(lane_11_loopback_miso_write_size_write) begin
                lane_11_loopback_miso_write_size_reg <= lane_11_loopback_miso_write_size ;
            end
            if(lane_12_loopback_miso_write_size_write) begin
                lane_12_loopback_miso_write_size_reg <= lane_12_loopback_miso_write_size ;
            end
            if(lane_13_loopback_miso_write_size_write) begin
                lane_13_loopback_miso_write_size_reg <= lane_13_loopback_miso_write_size ;
            end
            if(lane_14_loopback_miso_write_size_write) begin
                lane_14_loopback_miso_write_size_reg <= lane_14_loopback_miso_write_size ;
            end
            if(lane_15_loopback_miso_write_size_write) begin
                lane_15_loopback_miso_write_size_reg <= lane_15_loopback_miso_write_size ;
            end
            if(lane_16_loopback_miso_write_size_write) begin
                lane_16_loopback_miso_write_size_reg <= lane_16_loopback_miso_write_size ;
            end
            if(lane_17_loopback_miso_write_size_write) begin
                lane_17_loopback_miso_write_size_reg <= lane_17_loopback_miso_write_size ;
            end
            if(lane_18_loopback_miso_write_size_write) begin
                lane_18_loopback_miso_write_size_reg <= lane_18_loopback_miso_write_size ;
            end
            if(lane_19_loopback_miso_write_size_write) begin
                lane_19_loopback_miso_write_size_reg <= lane_19_loopback_miso_write_size ;
            end
            if(lane_0_loopback_mosi_read_size_write) begin
                lane_0_loopback_mosi_read_size_reg <= lane_0_loopback_mosi_read_size ;
            end
            if(lane_1_loopback_mosi_read_size_write) begin
                lane_1_loopback_mosi_read_size_reg <= lane_1_loopback_mosi_read_size ;
            end
            if(lane_2_loopback_mosi_read_size_write) begin
                lane_2_loopback_mosi_read_size_reg <= lane_2_loopback_mosi_read_size ;
            end
            if(lane_3_loopback_mosi_read_size_write) begin
                lane_3_loopback_mosi_read_size_reg <= lane_3_loopback_mosi_read_size ;
            end
            if(lane_4_loopback_mosi_read_size_write) begin
                lane_4_loopback_mosi_read_size_reg <= lane_4_loopback_mosi_read_size ;
            end
            if(lane_5_loopback_mosi_read_size_write) begin
                lane_5_loopback_mosi_read_size_reg <= lane_5_loopback_mosi_read_size ;
            end
            if(lane_6_loopback_mosi_read_size_write) begin
                lane_6_loopback_mosi_read_size_reg <= lane_6_loopback_mosi_read_size ;
            end
            if(lane_7_loopback_mosi_read_size_write) begin
                lane_7_loopback_mosi_read_size_reg <= lane_7_loopback_mosi_read_size ;
            end
            if(lane_8_loopback_mosi_read_size_write) begin
                lane_8_loopback_mosi_read_size_reg <= lane_8_loopback_mosi_read_size ;
            end
            if(lane_9_loopback_mosi_read_size_write) begin
                lane_9_loopback_mosi_read_size_reg <= lane_9_loopback_mosi_read_size ;
            end
            if(lane_10_loopback_mosi_read_size_write) begin
                lane_10_loopback_mosi_read_size_reg <= lane_10_loopback_mosi_read_size ;
            end
            if(lane_11_loopback_mosi_read_size_write) begin
                lane_11_loopback_mosi_read_size_reg <= lane_11_loopback_mosi_read_size ;
            end
            if(lane_12_loopback_mosi_read_size_write) begin
                lane_12_loopback_mosi_read_size_reg <= lane_12_loopback_mosi_read_size ;
            end
            if(lane_13_loopback_mosi_read_size_write) begin
                lane_13_loopback_mosi_read_size_reg <= lane_13_loopback_mosi_read_size ;
            end
            if(lane_14_loopback_mosi_read_size_write) begin
                lane_14_loopback_mosi_read_size_reg <= lane_14_loopback_mosi_read_size ;
            end
            if(lane_15_loopback_mosi_read_size_write) begin
                lane_15_loopback_mosi_read_size_reg <= lane_15_loopback_mosi_read_size ;
            end
            if(lane_16_loopback_mosi_read_size_write) begin
                lane_16_loopback_mosi_read_size_reg <= lane_16_loopback_mosi_read_size ;
            end
            if(lane_17_loopback_mosi_read_size_write) begin
                lane_17_loopback_mosi_read_size_reg <= lane_17_loopback_mosi_read_size ;
            end
            if(lane_18_loopback_mosi_read_size_write) begin
                lane_18_loopback_mosi_read_size_reg <= lane_18_loopback_mosi_read_size ;
            end
            if(lane_19_loopback_mosi_read_size_write) begin
                lane_19_loopback_mosi_read_size_reg <= lane_19_loopback_mosi_read_size ;
            end
            if(lanes_readout_read_size_write) begin
                lanes_readout_read_size_reg <= lanes_readout_read_size ;
            end
            // Write for Counter
            if(!(rfg_write && rfg_address==16'hc)) begin
                hk_conversion_trigger_reg <= hk_conversion_trigger_up ? hk_conversion_trigger_reg + 1 : hk_conversion_trigger_reg -1 ;
            end
            if(( (hk_conversion_trigger_up && hk_conversion_trigger_reg == (hk_conversion_trigger_match_reg - 1)) || (!hk_conversion_trigger_up && hk_conversion_trigger_reg==1 )) ) begin
                hk_conversion_trigger_interrupt <= 1'b1;
                hk_conversion_trigger_up <= !hk_conversion_trigger_up;
            end else begin
                hk_conversion_trigger_interrupt <= 1'b0;
            end
            if(hk_stat_conversions_counter_enable) begin
                hk_stat_conversions_counter_reg <= hk_stat_conversions_counter_reg + 1 ;
            end
            if(!(rfg_write && rfg_address==16'h45) && lane_0_stat_frame_counter_enable) begin
                lane_0_stat_frame_counter_reg <= lane_0_stat_frame_counter_reg + 1 ;
            end
            if(!(rfg_write && rfg_address==16'h49) && lane_1_stat_frame_counter_enable) begin
                lane_1_stat_frame_counter_reg <= lane_1_stat_frame_counter_reg + 1 ;
            end
            if(!(rfg_write && rfg_address==16'h4d) && lane_2_stat_frame_counter_enable) begin
                lane_2_stat_frame_counter_reg <= lane_2_stat_frame_counter_reg + 1 ;
            end
            if(!(rfg_write && rfg_address==16'h51) && lane_3_stat_frame_counter_enable) begin
                lane_3_stat_frame_counter_reg <= lane_3_stat_frame_counter_reg + 1 ;
            end
            if(!(rfg_write && rfg_address==16'h55) && lane_4_stat_frame_counter_enable) begin
                lane_4_stat_frame_counter_reg <= lane_4_stat_frame_counter_reg + 1 ;
            end
            if(!(rfg_write && rfg_address==16'h59) && lane_5_stat_frame_counter_enable) begin
                lane_5_stat_frame_counter_reg <= lane_5_stat_frame_counter_reg + 1 ;
            end
            if(!(rfg_write && rfg_address==16'h5d) && lane_6_stat_frame_counter_enable) begin
                lane_6_stat_frame_counter_reg <= lane_6_stat_frame_counter_reg + 1 ;
            end
            if(!(rfg_write && rfg_address==16'h61) && lane_7_stat_frame_counter_enable) begin
                lane_7_stat_frame_counter_reg <= lane_7_stat_frame_counter_reg + 1 ;
            end
            if(!(rfg_write && rfg_address==16'h65) && lane_8_stat_frame_counter_enable) begin
                lane_8_stat_frame_counter_reg <= lane_8_stat_frame_counter_reg + 1 ;
            end
            if(!(rfg_write && rfg_address==16'h69) && lane_9_stat_frame_counter_enable) begin
                lane_9_stat_frame_counter_reg <= lane_9_stat_frame_counter_reg + 1 ;
            end
            if(!(rfg_write && rfg_address==16'h6d) && lane_10_stat_frame_counter_enable) begin
                lane_10_stat_frame_counter_reg <= lane_10_stat_frame_counter_reg + 1 ;
            end
            if(!(rfg_write && rfg_address==16'h71) && lane_11_stat_frame_counter_enable) begin
                lane_11_stat_frame_counter_reg <= lane_11_stat_frame_counter_reg + 1 ;
            end
            if(!(rfg_write && rfg_address==16'h75) && lane_12_stat_frame_counter_enable) begin
                lane_12_stat_frame_counter_reg <= lane_12_stat_frame_counter_reg + 1 ;
            end
            if(!(rfg_write && rfg_address==16'h79) && lane_13_stat_frame_counter_enable) begin
                lane_13_stat_frame_counter_reg <= lane_13_stat_frame_counter_reg + 1 ;
            end
            if(!(rfg_write && rfg_address==16'h7d) && lane_14_stat_frame_counter_enable) begin
                lane_14_stat_frame_counter_reg <= lane_14_stat_frame_counter_reg + 1 ;
            end
            if(!(rfg_write && rfg_address==16'h81) && lane_15_stat_frame_counter_enable) begin
                lane_15_stat_frame_counter_reg <= lane_15_stat_frame_counter_reg + 1 ;
            end
            if(!(rfg_write && rfg_address==16'h85) && lane_16_stat_frame_counter_enable) begin
                lane_16_stat_frame_counter_reg <= lane_16_stat_frame_counter_reg + 1 ;
            end
            if(!(rfg_write && rfg_address==16'h89) && lane_17_stat_frame_counter_enable) begin
                lane_17_stat_frame_counter_reg <= lane_17_stat_frame_counter_reg + 1 ;
            end
            if(!(rfg_write && rfg_address==16'h8d) && lane_18_stat_frame_counter_enable) begin
                lane_18_stat_frame_counter_reg <= lane_18_stat_frame_counter_reg + 1 ;
            end
            if(!(rfg_write && rfg_address==16'h91) && lane_19_stat_frame_counter_enable) begin
                lane_19_stat_frame_counter_reg <= lane_19_stat_frame_counter_reg + 1 ;
            end
            if(!(rfg_write && rfg_address==16'h95) && lane_0_stat_idle_counter_enable) begin
                lane_0_stat_idle_counter_reg <= lane_0_stat_idle_counter_reg + 1 ;
            end
            if(!(rfg_write && rfg_address==16'h99) && lane_1_stat_idle_counter_enable) begin
                lane_1_stat_idle_counter_reg <= lane_1_stat_idle_counter_reg + 1 ;
            end
            if(!(rfg_write && rfg_address==16'h9d) && lane_2_stat_idle_counter_enable) begin
                lane_2_stat_idle_counter_reg <= lane_2_stat_idle_counter_reg + 1 ;
            end
            if(!(rfg_write && rfg_address==16'ha1) && lane_3_stat_idle_counter_enable) begin
                lane_3_stat_idle_counter_reg <= lane_3_stat_idle_counter_reg + 1 ;
            end
            if(!(rfg_write && rfg_address==16'ha5) && lane_4_stat_idle_counter_enable) begin
                lane_4_stat_idle_counter_reg <= lane_4_stat_idle_counter_reg + 1 ;
            end
            if(!(rfg_write && rfg_address==16'ha9) && lane_5_stat_idle_counter_enable) begin
                lane_5_stat_idle_counter_reg <= lane_5_stat_idle_counter_reg + 1 ;
            end
            if(!(rfg_write && rfg_address==16'had) && lane_6_stat_idle_counter_enable) begin
                lane_6_stat_idle_counter_reg <= lane_6_stat_idle_counter_reg + 1 ;
            end
            if(!(rfg_write && rfg_address==16'hb1) && lane_7_stat_idle_counter_enable) begin
                lane_7_stat_idle_counter_reg <= lane_7_stat_idle_counter_reg + 1 ;
            end
            if(!(rfg_write && rfg_address==16'hb5) && lane_8_stat_idle_counter_enable) begin
                lane_8_stat_idle_counter_reg <= lane_8_stat_idle_counter_reg + 1 ;
            end
            if(!(rfg_write && rfg_address==16'hb9) && lane_9_stat_idle_counter_enable) begin
                lane_9_stat_idle_counter_reg <= lane_9_stat_idle_counter_reg + 1 ;
            end
            if(!(rfg_write && rfg_address==16'hbd) && lane_10_stat_idle_counter_enable) begin
                lane_10_stat_idle_counter_reg <= lane_10_stat_idle_counter_reg + 1 ;
            end
            if(!(rfg_write && rfg_address==16'hc1) && lane_11_stat_idle_counter_enable) begin
                lane_11_stat_idle_counter_reg <= lane_11_stat_idle_counter_reg + 1 ;
            end
            if(!(rfg_write && rfg_address==16'hc5) && lane_12_stat_idle_counter_enable) begin
                lane_12_stat_idle_counter_reg <= lane_12_stat_idle_counter_reg + 1 ;
            end
            if(!(rfg_write && rfg_address==16'hc9) && lane_13_stat_idle_counter_enable) begin
                lane_13_stat_idle_counter_reg <= lane_13_stat_idle_counter_reg + 1 ;
            end
            if(!(rfg_write && rfg_address==16'hcd) && lane_14_stat_idle_counter_enable) begin
                lane_14_stat_idle_counter_reg <= lane_14_stat_idle_counter_reg + 1 ;
            end
            if(!(rfg_write && rfg_address==16'hd1) && lane_15_stat_idle_counter_enable) begin
                lane_15_stat_idle_counter_reg <= lane_15_stat_idle_counter_reg + 1 ;
            end
            if(!(rfg_write && rfg_address==16'hd5) && lane_16_stat_idle_counter_enable) begin
                lane_16_stat_idle_counter_reg <= lane_16_stat_idle_counter_reg + 1 ;
            end
            if(!(rfg_write && rfg_address==16'hd9) && lane_17_stat_idle_counter_enable) begin
                lane_17_stat_idle_counter_reg <= lane_17_stat_idle_counter_reg + 1 ;
            end
            if(!(rfg_write && rfg_address==16'hdd) && lane_18_stat_idle_counter_enable) begin
                lane_18_stat_idle_counter_reg <= lane_18_stat_idle_counter_reg + 1 ;
            end
            if(!(rfg_write && rfg_address==16'he1) && lane_19_stat_idle_counter_enable) begin
                lane_19_stat_idle_counter_reg <= lane_19_stat_idle_counter_reg + 1 ;
            end
            if(!(rfg_write && rfg_address==16'h212) && lanes_cfg_frame_tag_counter_trigger_enable) begin
                lanes_cfg_frame_tag_counter_trigger_reg <= lanes_cfg_frame_tag_counter_trigger_up ? lanes_cfg_frame_tag_counter_trigger_reg + 1 : lanes_cfg_frame_tag_counter_trigger_reg -1 ;
            end
            if(( (lanes_cfg_frame_tag_counter_trigger_up && lanes_cfg_frame_tag_counter_trigger_reg == (lanes_cfg_frame_tag_counter_trigger_match_reg - 1)) || (!lanes_cfg_frame_tag_counter_trigger_up && lanes_cfg_frame_tag_counter_trigger_reg==1 )) && lanes_cfg_frame_tag_counter_trigger_enable) begin
                lanes_cfg_frame_tag_counter_trigger_interrupt <= 1'b1;
                lanes_cfg_frame_tag_counter_trigger_up <= !lanes_cfg_frame_tag_counter_trigger_up;
            end else begin
                lanes_cfg_frame_tag_counter_trigger_interrupt <= 1'b0;
            end
            if(!(rfg_write && rfg_address==16'h216) && lanes_cfg_frame_tag_counter_enable) begin
                lanes_cfg_frame_tag_counter_reg <= lanes_cfg_frame_tag_counter_reg + 1 ;
            end
        end
    end
    
    
    // Read for FIFO Slave
    assign hk_adc_miso_fifo_s_axis_tready = rfg_read && rfg_address==16'h16;
    assign lane_0_loopback_mosi_s_axis_tready = rfg_read && rfg_address==16'h1ad;
    assign lane_1_loopback_mosi_s_axis_tready = rfg_read && rfg_address==16'h1b2;
    assign lane_2_loopback_mosi_s_axis_tready = rfg_read && rfg_address==16'h1b7;
    assign lane_3_loopback_mosi_s_axis_tready = rfg_read && rfg_address==16'h1bc;
    assign lane_4_loopback_mosi_s_axis_tready = rfg_read && rfg_address==16'h1c1;
    assign lane_5_loopback_mosi_s_axis_tready = rfg_read && rfg_address==16'h1c6;
    assign lane_6_loopback_mosi_s_axis_tready = rfg_read && rfg_address==16'h1cb;
    assign lane_7_loopback_mosi_s_axis_tready = rfg_read && rfg_address==16'h1d0;
    assign lane_8_loopback_mosi_s_axis_tready = rfg_read && rfg_address==16'h1d5;
    assign lane_9_loopback_mosi_s_axis_tready = rfg_read && rfg_address==16'h1da;
    assign lane_10_loopback_mosi_s_axis_tready = rfg_read && rfg_address==16'h1df;
    assign lane_11_loopback_mosi_s_axis_tready = rfg_read && rfg_address==16'h1e4;
    assign lane_12_loopback_mosi_s_axis_tready = rfg_read && rfg_address==16'h1e9;
    assign lane_13_loopback_mosi_s_axis_tready = rfg_read && rfg_address==16'h1ee;
    assign lane_14_loopback_mosi_s_axis_tready = rfg_read && rfg_address==16'h1f3;
    assign lane_15_loopback_mosi_s_axis_tready = rfg_read && rfg_address==16'h1f8;
    assign lane_16_loopback_mosi_s_axis_tready = rfg_read && rfg_address==16'h1fd;
    assign lane_17_loopback_mosi_s_axis_tready = rfg_read && rfg_address==16'h202;
    assign lane_18_loopback_mosi_s_axis_tready = rfg_read && rfg_address==16'h207;
    assign lane_19_loopback_mosi_s_axis_tready = rfg_read && rfg_address==16'h20c;
    assign lanes_readout_s_axis_tready = rfg_read && rfg_address==16'h220;
    
    
    // Register Read
    // ---------------
    always@(posedge clk) begin
        if (!resn) begin
            rfg_read_valid <= 0;
            rfg_read_value <= 0;
        end else begin
            // Read for simple registers
            case({rfg_read,rfg_address})
                {1'b1,16'h0}: begin
                    rfg_read_value <= hk_firmware_id_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1}: begin
                    rfg_read_value <= hk_firmware_id_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h2}: begin
                    rfg_read_value <= hk_firmware_id_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h3}: begin
                    rfg_read_value <= hk_firmware_id_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h4}: begin
                    rfg_read_value <= hk_firmware_version_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h5}: begin
                    rfg_read_value <= hk_firmware_version_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h6}: begin
                    rfg_read_value <= hk_firmware_version_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h7}: begin
                    rfg_read_value <= hk_firmware_version_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h8}: begin
                    rfg_read_value <= hk_xadc_temperature_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h9}: begin
                    rfg_read_value <= hk_xadc_temperature_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'ha}: begin
                    rfg_read_value <= hk_xadc_vccint_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'hb}: begin
                    rfg_read_value <= hk_xadc_vccint_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'hc}: begin
                    rfg_read_value <= hk_conversion_trigger_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'hd}: begin
                    rfg_read_value <= hk_conversion_trigger_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'he}: begin
                    rfg_read_value <= hk_conversion_trigger_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'hf}: begin
                    rfg_read_value <= hk_conversion_trigger_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h10}: begin
                    rfg_read_value <= hk_stat_conversions_counter_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h11}: begin
                    rfg_read_value <= hk_stat_conversions_counter_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h12}: begin
                    rfg_read_value <= hk_stat_conversions_counter_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h13}: begin
                    rfg_read_value <= hk_stat_conversions_counter_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h14}: begin
                    rfg_read_value <= hk_ctrl_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h16}: begin
                    rfg_read_value <= hk_adc_miso_fifo_s_axis_tvalid ? hk_adc_miso_fifo_s_axis_tdata : 8'hff;
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h17}: begin
                    rfg_read_value <= hk_adc_miso_fifo_read_size_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h18}: begin
                    rfg_read_value <= hk_adc_miso_fifo_read_size_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h19}: begin
                    rfg_read_value <= hk_adc_miso_fifo_read_size_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1a}: begin
                    rfg_read_value <= hk_adc_miso_fifo_read_size_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1b}: begin
                    rfg_read_value <= spi_lanes_ckdivider_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1c}: begin
                    rfg_read_value <= spi_hk_ckdivider_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1d}: begin
                    rfg_read_value <= lane_0_cfg_ctrl_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1e}: begin
                    rfg_read_value <= lane_1_cfg_ctrl_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1f}: begin
                    rfg_read_value <= lane_2_cfg_ctrl_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h20}: begin
                    rfg_read_value <= lane_3_cfg_ctrl_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h21}: begin
                    rfg_read_value <= lane_4_cfg_ctrl_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h22}: begin
                    rfg_read_value <= lane_5_cfg_ctrl_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h23}: begin
                    rfg_read_value <= lane_6_cfg_ctrl_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h24}: begin
                    rfg_read_value <= lane_7_cfg_ctrl_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h25}: begin
                    rfg_read_value <= lane_8_cfg_ctrl_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h26}: begin
                    rfg_read_value <= lane_9_cfg_ctrl_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h27}: begin
                    rfg_read_value <= lane_10_cfg_ctrl_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h28}: begin
                    rfg_read_value <= lane_11_cfg_ctrl_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h29}: begin
                    rfg_read_value <= lane_12_cfg_ctrl_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h2a}: begin
                    rfg_read_value <= lane_13_cfg_ctrl_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h2b}: begin
                    rfg_read_value <= lane_14_cfg_ctrl_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h2c}: begin
                    rfg_read_value <= lane_15_cfg_ctrl_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h2d}: begin
                    rfg_read_value <= lane_16_cfg_ctrl_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h2e}: begin
                    rfg_read_value <= lane_17_cfg_ctrl_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h2f}: begin
                    rfg_read_value <= lane_18_cfg_ctrl_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h30}: begin
                    rfg_read_value <= lane_19_cfg_ctrl_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h31}: begin
                    rfg_read_value <= lane_0_status_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h32}: begin
                    rfg_read_value <= lane_1_status_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h33}: begin
                    rfg_read_value <= lane_2_status_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h34}: begin
                    rfg_read_value <= lane_3_status_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h35}: begin
                    rfg_read_value <= lane_4_status_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h36}: begin
                    rfg_read_value <= lane_5_status_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h37}: begin
                    rfg_read_value <= lane_6_status_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h38}: begin
                    rfg_read_value <= lane_7_status_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h39}: begin
                    rfg_read_value <= lane_8_status_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h3a}: begin
                    rfg_read_value <= lane_9_status_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h3b}: begin
                    rfg_read_value <= lane_10_status_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h3c}: begin
                    rfg_read_value <= lane_11_status_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h3d}: begin
                    rfg_read_value <= lane_12_status_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h3e}: begin
                    rfg_read_value <= lane_13_status_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h3f}: begin
                    rfg_read_value <= lane_14_status_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h40}: begin
                    rfg_read_value <= lane_15_status_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h41}: begin
                    rfg_read_value <= lane_16_status_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h42}: begin
                    rfg_read_value <= lane_17_status_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h43}: begin
                    rfg_read_value <= lane_18_status_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h44}: begin
                    rfg_read_value <= lane_19_status_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h45}: begin
                    rfg_read_value <= lane_0_stat_frame_counter_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h46}: begin
                    rfg_read_value <= lane_0_stat_frame_counter_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h47}: begin
                    rfg_read_value <= lane_0_stat_frame_counter_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h48}: begin
                    rfg_read_value <= lane_0_stat_frame_counter_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h49}: begin
                    rfg_read_value <= lane_1_stat_frame_counter_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h4a}: begin
                    rfg_read_value <= lane_1_stat_frame_counter_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h4b}: begin
                    rfg_read_value <= lane_1_stat_frame_counter_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h4c}: begin
                    rfg_read_value <= lane_1_stat_frame_counter_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h4d}: begin
                    rfg_read_value <= lane_2_stat_frame_counter_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h4e}: begin
                    rfg_read_value <= lane_2_stat_frame_counter_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h4f}: begin
                    rfg_read_value <= lane_2_stat_frame_counter_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h50}: begin
                    rfg_read_value <= lane_2_stat_frame_counter_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h51}: begin
                    rfg_read_value <= lane_3_stat_frame_counter_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h52}: begin
                    rfg_read_value <= lane_3_stat_frame_counter_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h53}: begin
                    rfg_read_value <= lane_3_stat_frame_counter_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h54}: begin
                    rfg_read_value <= lane_3_stat_frame_counter_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h55}: begin
                    rfg_read_value <= lane_4_stat_frame_counter_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h56}: begin
                    rfg_read_value <= lane_4_stat_frame_counter_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h57}: begin
                    rfg_read_value <= lane_4_stat_frame_counter_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h58}: begin
                    rfg_read_value <= lane_4_stat_frame_counter_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h59}: begin
                    rfg_read_value <= lane_5_stat_frame_counter_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h5a}: begin
                    rfg_read_value <= lane_5_stat_frame_counter_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h5b}: begin
                    rfg_read_value <= lane_5_stat_frame_counter_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h5c}: begin
                    rfg_read_value <= lane_5_stat_frame_counter_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h5d}: begin
                    rfg_read_value <= lane_6_stat_frame_counter_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h5e}: begin
                    rfg_read_value <= lane_6_stat_frame_counter_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h5f}: begin
                    rfg_read_value <= lane_6_stat_frame_counter_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h60}: begin
                    rfg_read_value <= lane_6_stat_frame_counter_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h61}: begin
                    rfg_read_value <= lane_7_stat_frame_counter_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h62}: begin
                    rfg_read_value <= lane_7_stat_frame_counter_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h63}: begin
                    rfg_read_value <= lane_7_stat_frame_counter_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h64}: begin
                    rfg_read_value <= lane_7_stat_frame_counter_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h65}: begin
                    rfg_read_value <= lane_8_stat_frame_counter_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h66}: begin
                    rfg_read_value <= lane_8_stat_frame_counter_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h67}: begin
                    rfg_read_value <= lane_8_stat_frame_counter_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h68}: begin
                    rfg_read_value <= lane_8_stat_frame_counter_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h69}: begin
                    rfg_read_value <= lane_9_stat_frame_counter_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h6a}: begin
                    rfg_read_value <= lane_9_stat_frame_counter_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h6b}: begin
                    rfg_read_value <= lane_9_stat_frame_counter_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h6c}: begin
                    rfg_read_value <= lane_9_stat_frame_counter_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h6d}: begin
                    rfg_read_value <= lane_10_stat_frame_counter_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h6e}: begin
                    rfg_read_value <= lane_10_stat_frame_counter_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h6f}: begin
                    rfg_read_value <= lane_10_stat_frame_counter_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h70}: begin
                    rfg_read_value <= lane_10_stat_frame_counter_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h71}: begin
                    rfg_read_value <= lane_11_stat_frame_counter_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h72}: begin
                    rfg_read_value <= lane_11_stat_frame_counter_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h73}: begin
                    rfg_read_value <= lane_11_stat_frame_counter_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h74}: begin
                    rfg_read_value <= lane_11_stat_frame_counter_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h75}: begin
                    rfg_read_value <= lane_12_stat_frame_counter_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h76}: begin
                    rfg_read_value <= lane_12_stat_frame_counter_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h77}: begin
                    rfg_read_value <= lane_12_stat_frame_counter_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h78}: begin
                    rfg_read_value <= lane_12_stat_frame_counter_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h79}: begin
                    rfg_read_value <= lane_13_stat_frame_counter_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h7a}: begin
                    rfg_read_value <= lane_13_stat_frame_counter_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h7b}: begin
                    rfg_read_value <= lane_13_stat_frame_counter_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h7c}: begin
                    rfg_read_value <= lane_13_stat_frame_counter_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h7d}: begin
                    rfg_read_value <= lane_14_stat_frame_counter_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h7e}: begin
                    rfg_read_value <= lane_14_stat_frame_counter_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h7f}: begin
                    rfg_read_value <= lane_14_stat_frame_counter_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h80}: begin
                    rfg_read_value <= lane_14_stat_frame_counter_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h81}: begin
                    rfg_read_value <= lane_15_stat_frame_counter_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h82}: begin
                    rfg_read_value <= lane_15_stat_frame_counter_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h83}: begin
                    rfg_read_value <= lane_15_stat_frame_counter_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h84}: begin
                    rfg_read_value <= lane_15_stat_frame_counter_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h85}: begin
                    rfg_read_value <= lane_16_stat_frame_counter_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h86}: begin
                    rfg_read_value <= lane_16_stat_frame_counter_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h87}: begin
                    rfg_read_value <= lane_16_stat_frame_counter_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h88}: begin
                    rfg_read_value <= lane_16_stat_frame_counter_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h89}: begin
                    rfg_read_value <= lane_17_stat_frame_counter_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h8a}: begin
                    rfg_read_value <= lane_17_stat_frame_counter_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h8b}: begin
                    rfg_read_value <= lane_17_stat_frame_counter_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h8c}: begin
                    rfg_read_value <= lane_17_stat_frame_counter_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h8d}: begin
                    rfg_read_value <= lane_18_stat_frame_counter_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h8e}: begin
                    rfg_read_value <= lane_18_stat_frame_counter_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h8f}: begin
                    rfg_read_value <= lane_18_stat_frame_counter_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h90}: begin
                    rfg_read_value <= lane_18_stat_frame_counter_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h91}: begin
                    rfg_read_value <= lane_19_stat_frame_counter_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h92}: begin
                    rfg_read_value <= lane_19_stat_frame_counter_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h93}: begin
                    rfg_read_value <= lane_19_stat_frame_counter_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h94}: begin
                    rfg_read_value <= lane_19_stat_frame_counter_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h95}: begin
                    rfg_read_value <= lane_0_stat_idle_counter_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h96}: begin
                    rfg_read_value <= lane_0_stat_idle_counter_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h97}: begin
                    rfg_read_value <= lane_0_stat_idle_counter_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h98}: begin
                    rfg_read_value <= lane_0_stat_idle_counter_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h99}: begin
                    rfg_read_value <= lane_1_stat_idle_counter_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h9a}: begin
                    rfg_read_value <= lane_1_stat_idle_counter_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h9b}: begin
                    rfg_read_value <= lane_1_stat_idle_counter_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h9c}: begin
                    rfg_read_value <= lane_1_stat_idle_counter_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h9d}: begin
                    rfg_read_value <= lane_2_stat_idle_counter_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h9e}: begin
                    rfg_read_value <= lane_2_stat_idle_counter_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h9f}: begin
                    rfg_read_value <= lane_2_stat_idle_counter_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'ha0}: begin
                    rfg_read_value <= lane_2_stat_idle_counter_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'ha1}: begin
                    rfg_read_value <= lane_3_stat_idle_counter_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'ha2}: begin
                    rfg_read_value <= lane_3_stat_idle_counter_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'ha3}: begin
                    rfg_read_value <= lane_3_stat_idle_counter_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'ha4}: begin
                    rfg_read_value <= lane_3_stat_idle_counter_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'ha5}: begin
                    rfg_read_value <= lane_4_stat_idle_counter_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'ha6}: begin
                    rfg_read_value <= lane_4_stat_idle_counter_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'ha7}: begin
                    rfg_read_value <= lane_4_stat_idle_counter_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'ha8}: begin
                    rfg_read_value <= lane_4_stat_idle_counter_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'ha9}: begin
                    rfg_read_value <= lane_5_stat_idle_counter_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'haa}: begin
                    rfg_read_value <= lane_5_stat_idle_counter_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'hab}: begin
                    rfg_read_value <= lane_5_stat_idle_counter_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'hac}: begin
                    rfg_read_value <= lane_5_stat_idle_counter_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'had}: begin
                    rfg_read_value <= lane_6_stat_idle_counter_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'hae}: begin
                    rfg_read_value <= lane_6_stat_idle_counter_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'haf}: begin
                    rfg_read_value <= lane_6_stat_idle_counter_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'hb0}: begin
                    rfg_read_value <= lane_6_stat_idle_counter_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'hb1}: begin
                    rfg_read_value <= lane_7_stat_idle_counter_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'hb2}: begin
                    rfg_read_value <= lane_7_stat_idle_counter_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'hb3}: begin
                    rfg_read_value <= lane_7_stat_idle_counter_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'hb4}: begin
                    rfg_read_value <= lane_7_stat_idle_counter_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'hb5}: begin
                    rfg_read_value <= lane_8_stat_idle_counter_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'hb6}: begin
                    rfg_read_value <= lane_8_stat_idle_counter_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'hb7}: begin
                    rfg_read_value <= lane_8_stat_idle_counter_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'hb8}: begin
                    rfg_read_value <= lane_8_stat_idle_counter_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'hb9}: begin
                    rfg_read_value <= lane_9_stat_idle_counter_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'hba}: begin
                    rfg_read_value <= lane_9_stat_idle_counter_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'hbb}: begin
                    rfg_read_value <= lane_9_stat_idle_counter_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'hbc}: begin
                    rfg_read_value <= lane_9_stat_idle_counter_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'hbd}: begin
                    rfg_read_value <= lane_10_stat_idle_counter_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'hbe}: begin
                    rfg_read_value <= lane_10_stat_idle_counter_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'hbf}: begin
                    rfg_read_value <= lane_10_stat_idle_counter_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'hc0}: begin
                    rfg_read_value <= lane_10_stat_idle_counter_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'hc1}: begin
                    rfg_read_value <= lane_11_stat_idle_counter_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'hc2}: begin
                    rfg_read_value <= lane_11_stat_idle_counter_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'hc3}: begin
                    rfg_read_value <= lane_11_stat_idle_counter_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'hc4}: begin
                    rfg_read_value <= lane_11_stat_idle_counter_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'hc5}: begin
                    rfg_read_value <= lane_12_stat_idle_counter_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'hc6}: begin
                    rfg_read_value <= lane_12_stat_idle_counter_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'hc7}: begin
                    rfg_read_value <= lane_12_stat_idle_counter_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'hc8}: begin
                    rfg_read_value <= lane_12_stat_idle_counter_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'hc9}: begin
                    rfg_read_value <= lane_13_stat_idle_counter_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'hca}: begin
                    rfg_read_value <= lane_13_stat_idle_counter_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'hcb}: begin
                    rfg_read_value <= lane_13_stat_idle_counter_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'hcc}: begin
                    rfg_read_value <= lane_13_stat_idle_counter_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'hcd}: begin
                    rfg_read_value <= lane_14_stat_idle_counter_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'hce}: begin
                    rfg_read_value <= lane_14_stat_idle_counter_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'hcf}: begin
                    rfg_read_value <= lane_14_stat_idle_counter_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'hd0}: begin
                    rfg_read_value <= lane_14_stat_idle_counter_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'hd1}: begin
                    rfg_read_value <= lane_15_stat_idle_counter_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'hd2}: begin
                    rfg_read_value <= lane_15_stat_idle_counter_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'hd3}: begin
                    rfg_read_value <= lane_15_stat_idle_counter_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'hd4}: begin
                    rfg_read_value <= lane_15_stat_idle_counter_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'hd5}: begin
                    rfg_read_value <= lane_16_stat_idle_counter_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'hd6}: begin
                    rfg_read_value <= lane_16_stat_idle_counter_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'hd7}: begin
                    rfg_read_value <= lane_16_stat_idle_counter_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'hd8}: begin
                    rfg_read_value <= lane_16_stat_idle_counter_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'hd9}: begin
                    rfg_read_value <= lane_17_stat_idle_counter_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'hda}: begin
                    rfg_read_value <= lane_17_stat_idle_counter_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'hdb}: begin
                    rfg_read_value <= lane_17_stat_idle_counter_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'hdc}: begin
                    rfg_read_value <= lane_17_stat_idle_counter_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'hdd}: begin
                    rfg_read_value <= lane_18_stat_idle_counter_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'hde}: begin
                    rfg_read_value <= lane_18_stat_idle_counter_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'hdf}: begin
                    rfg_read_value <= lane_18_stat_idle_counter_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'he0}: begin
                    rfg_read_value <= lane_18_stat_idle_counter_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'he1}: begin
                    rfg_read_value <= lane_19_stat_idle_counter_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'he2}: begin
                    rfg_read_value <= lane_19_stat_idle_counter_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'he3}: begin
                    rfg_read_value <= lane_19_stat_idle_counter_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'he4}: begin
                    rfg_read_value <= lane_19_stat_idle_counter_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'he6}: begin
                    rfg_read_value <= lane_0_mosi_write_size_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'he7}: begin
                    rfg_read_value <= lane_0_mosi_write_size_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'he8}: begin
                    rfg_read_value <= lane_0_mosi_write_size_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'he9}: begin
                    rfg_read_value <= lane_0_mosi_write_size_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'heb}: begin
                    rfg_read_value <= lane_1_mosi_write_size_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'hec}: begin
                    rfg_read_value <= lane_1_mosi_write_size_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'hed}: begin
                    rfg_read_value <= lane_1_mosi_write_size_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'hee}: begin
                    rfg_read_value <= lane_1_mosi_write_size_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'hf0}: begin
                    rfg_read_value <= lane_2_mosi_write_size_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'hf1}: begin
                    rfg_read_value <= lane_2_mosi_write_size_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'hf2}: begin
                    rfg_read_value <= lane_2_mosi_write_size_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'hf3}: begin
                    rfg_read_value <= lane_2_mosi_write_size_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'hf5}: begin
                    rfg_read_value <= lane_3_mosi_write_size_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'hf6}: begin
                    rfg_read_value <= lane_3_mosi_write_size_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'hf7}: begin
                    rfg_read_value <= lane_3_mosi_write_size_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'hf8}: begin
                    rfg_read_value <= lane_3_mosi_write_size_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'hfa}: begin
                    rfg_read_value <= lane_4_mosi_write_size_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'hfb}: begin
                    rfg_read_value <= lane_4_mosi_write_size_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'hfc}: begin
                    rfg_read_value <= lane_4_mosi_write_size_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'hfd}: begin
                    rfg_read_value <= lane_4_mosi_write_size_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'hff}: begin
                    rfg_read_value <= lane_5_mosi_write_size_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h100}: begin
                    rfg_read_value <= lane_5_mosi_write_size_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h101}: begin
                    rfg_read_value <= lane_5_mosi_write_size_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h102}: begin
                    rfg_read_value <= lane_5_mosi_write_size_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h104}: begin
                    rfg_read_value <= lane_6_mosi_write_size_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h105}: begin
                    rfg_read_value <= lane_6_mosi_write_size_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h106}: begin
                    rfg_read_value <= lane_6_mosi_write_size_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h107}: begin
                    rfg_read_value <= lane_6_mosi_write_size_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h109}: begin
                    rfg_read_value <= lane_7_mosi_write_size_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h10a}: begin
                    rfg_read_value <= lane_7_mosi_write_size_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h10b}: begin
                    rfg_read_value <= lane_7_mosi_write_size_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h10c}: begin
                    rfg_read_value <= lane_7_mosi_write_size_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h10e}: begin
                    rfg_read_value <= lane_8_mosi_write_size_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h10f}: begin
                    rfg_read_value <= lane_8_mosi_write_size_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h110}: begin
                    rfg_read_value <= lane_8_mosi_write_size_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h111}: begin
                    rfg_read_value <= lane_8_mosi_write_size_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h113}: begin
                    rfg_read_value <= lane_9_mosi_write_size_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h114}: begin
                    rfg_read_value <= lane_9_mosi_write_size_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h115}: begin
                    rfg_read_value <= lane_9_mosi_write_size_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h116}: begin
                    rfg_read_value <= lane_9_mosi_write_size_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h118}: begin
                    rfg_read_value <= lane_10_mosi_write_size_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h119}: begin
                    rfg_read_value <= lane_10_mosi_write_size_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h11a}: begin
                    rfg_read_value <= lane_10_mosi_write_size_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h11b}: begin
                    rfg_read_value <= lane_10_mosi_write_size_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h11d}: begin
                    rfg_read_value <= lane_11_mosi_write_size_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h11e}: begin
                    rfg_read_value <= lane_11_mosi_write_size_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h11f}: begin
                    rfg_read_value <= lane_11_mosi_write_size_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h120}: begin
                    rfg_read_value <= lane_11_mosi_write_size_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h122}: begin
                    rfg_read_value <= lane_12_mosi_write_size_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h123}: begin
                    rfg_read_value <= lane_12_mosi_write_size_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h124}: begin
                    rfg_read_value <= lane_12_mosi_write_size_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h125}: begin
                    rfg_read_value <= lane_12_mosi_write_size_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h127}: begin
                    rfg_read_value <= lane_13_mosi_write_size_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h128}: begin
                    rfg_read_value <= lane_13_mosi_write_size_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h129}: begin
                    rfg_read_value <= lane_13_mosi_write_size_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h12a}: begin
                    rfg_read_value <= lane_13_mosi_write_size_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h12c}: begin
                    rfg_read_value <= lane_14_mosi_write_size_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h12d}: begin
                    rfg_read_value <= lane_14_mosi_write_size_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h12e}: begin
                    rfg_read_value <= lane_14_mosi_write_size_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h12f}: begin
                    rfg_read_value <= lane_14_mosi_write_size_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h131}: begin
                    rfg_read_value <= lane_15_mosi_write_size_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h132}: begin
                    rfg_read_value <= lane_15_mosi_write_size_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h133}: begin
                    rfg_read_value <= lane_15_mosi_write_size_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h134}: begin
                    rfg_read_value <= lane_15_mosi_write_size_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h136}: begin
                    rfg_read_value <= lane_16_mosi_write_size_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h137}: begin
                    rfg_read_value <= lane_16_mosi_write_size_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h138}: begin
                    rfg_read_value <= lane_16_mosi_write_size_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h139}: begin
                    rfg_read_value <= lane_16_mosi_write_size_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h13b}: begin
                    rfg_read_value <= lane_17_mosi_write_size_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h13c}: begin
                    rfg_read_value <= lane_17_mosi_write_size_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h13d}: begin
                    rfg_read_value <= lane_17_mosi_write_size_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h13e}: begin
                    rfg_read_value <= lane_17_mosi_write_size_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h140}: begin
                    rfg_read_value <= lane_18_mosi_write_size_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h141}: begin
                    rfg_read_value <= lane_18_mosi_write_size_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h142}: begin
                    rfg_read_value <= lane_18_mosi_write_size_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h143}: begin
                    rfg_read_value <= lane_18_mosi_write_size_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h145}: begin
                    rfg_read_value <= lane_19_mosi_write_size_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h146}: begin
                    rfg_read_value <= lane_19_mosi_write_size_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h147}: begin
                    rfg_read_value <= lane_19_mosi_write_size_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h148}: begin
                    rfg_read_value <= lane_19_mosi_write_size_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h14a}: begin
                    rfg_read_value <= lane_0_loopback_miso_write_size_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h14b}: begin
                    rfg_read_value <= lane_0_loopback_miso_write_size_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h14c}: begin
                    rfg_read_value <= lane_0_loopback_miso_write_size_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h14d}: begin
                    rfg_read_value <= lane_0_loopback_miso_write_size_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h14f}: begin
                    rfg_read_value <= lane_1_loopback_miso_write_size_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h150}: begin
                    rfg_read_value <= lane_1_loopback_miso_write_size_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h151}: begin
                    rfg_read_value <= lane_1_loopback_miso_write_size_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h152}: begin
                    rfg_read_value <= lane_1_loopback_miso_write_size_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h154}: begin
                    rfg_read_value <= lane_2_loopback_miso_write_size_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h155}: begin
                    rfg_read_value <= lane_2_loopback_miso_write_size_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h156}: begin
                    rfg_read_value <= lane_2_loopback_miso_write_size_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h157}: begin
                    rfg_read_value <= lane_2_loopback_miso_write_size_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h159}: begin
                    rfg_read_value <= lane_3_loopback_miso_write_size_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h15a}: begin
                    rfg_read_value <= lane_3_loopback_miso_write_size_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h15b}: begin
                    rfg_read_value <= lane_3_loopback_miso_write_size_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h15c}: begin
                    rfg_read_value <= lane_3_loopback_miso_write_size_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h15e}: begin
                    rfg_read_value <= lane_4_loopback_miso_write_size_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h15f}: begin
                    rfg_read_value <= lane_4_loopback_miso_write_size_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h160}: begin
                    rfg_read_value <= lane_4_loopback_miso_write_size_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h161}: begin
                    rfg_read_value <= lane_4_loopback_miso_write_size_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h163}: begin
                    rfg_read_value <= lane_5_loopback_miso_write_size_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h164}: begin
                    rfg_read_value <= lane_5_loopback_miso_write_size_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h165}: begin
                    rfg_read_value <= lane_5_loopback_miso_write_size_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h166}: begin
                    rfg_read_value <= lane_5_loopback_miso_write_size_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h168}: begin
                    rfg_read_value <= lane_6_loopback_miso_write_size_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h169}: begin
                    rfg_read_value <= lane_6_loopback_miso_write_size_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h16a}: begin
                    rfg_read_value <= lane_6_loopback_miso_write_size_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h16b}: begin
                    rfg_read_value <= lane_6_loopback_miso_write_size_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h16d}: begin
                    rfg_read_value <= lane_7_loopback_miso_write_size_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h16e}: begin
                    rfg_read_value <= lane_7_loopback_miso_write_size_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h16f}: begin
                    rfg_read_value <= lane_7_loopback_miso_write_size_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h170}: begin
                    rfg_read_value <= lane_7_loopback_miso_write_size_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h172}: begin
                    rfg_read_value <= lane_8_loopback_miso_write_size_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h173}: begin
                    rfg_read_value <= lane_8_loopback_miso_write_size_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h174}: begin
                    rfg_read_value <= lane_8_loopback_miso_write_size_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h175}: begin
                    rfg_read_value <= lane_8_loopback_miso_write_size_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h177}: begin
                    rfg_read_value <= lane_9_loopback_miso_write_size_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h178}: begin
                    rfg_read_value <= lane_9_loopback_miso_write_size_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h179}: begin
                    rfg_read_value <= lane_9_loopback_miso_write_size_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h17a}: begin
                    rfg_read_value <= lane_9_loopback_miso_write_size_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h17c}: begin
                    rfg_read_value <= lane_10_loopback_miso_write_size_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h17d}: begin
                    rfg_read_value <= lane_10_loopback_miso_write_size_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h17e}: begin
                    rfg_read_value <= lane_10_loopback_miso_write_size_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h17f}: begin
                    rfg_read_value <= lane_10_loopback_miso_write_size_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h181}: begin
                    rfg_read_value <= lane_11_loopback_miso_write_size_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h182}: begin
                    rfg_read_value <= lane_11_loopback_miso_write_size_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h183}: begin
                    rfg_read_value <= lane_11_loopback_miso_write_size_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h184}: begin
                    rfg_read_value <= lane_11_loopback_miso_write_size_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h186}: begin
                    rfg_read_value <= lane_12_loopback_miso_write_size_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h187}: begin
                    rfg_read_value <= lane_12_loopback_miso_write_size_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h188}: begin
                    rfg_read_value <= lane_12_loopback_miso_write_size_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h189}: begin
                    rfg_read_value <= lane_12_loopback_miso_write_size_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h18b}: begin
                    rfg_read_value <= lane_13_loopback_miso_write_size_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h18c}: begin
                    rfg_read_value <= lane_13_loopback_miso_write_size_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h18d}: begin
                    rfg_read_value <= lane_13_loopback_miso_write_size_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h18e}: begin
                    rfg_read_value <= lane_13_loopback_miso_write_size_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h190}: begin
                    rfg_read_value <= lane_14_loopback_miso_write_size_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h191}: begin
                    rfg_read_value <= lane_14_loopback_miso_write_size_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h192}: begin
                    rfg_read_value <= lane_14_loopback_miso_write_size_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h193}: begin
                    rfg_read_value <= lane_14_loopback_miso_write_size_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h195}: begin
                    rfg_read_value <= lane_15_loopback_miso_write_size_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h196}: begin
                    rfg_read_value <= lane_15_loopback_miso_write_size_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h197}: begin
                    rfg_read_value <= lane_15_loopback_miso_write_size_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h198}: begin
                    rfg_read_value <= lane_15_loopback_miso_write_size_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h19a}: begin
                    rfg_read_value <= lane_16_loopback_miso_write_size_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h19b}: begin
                    rfg_read_value <= lane_16_loopback_miso_write_size_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h19c}: begin
                    rfg_read_value <= lane_16_loopback_miso_write_size_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h19d}: begin
                    rfg_read_value <= lane_16_loopback_miso_write_size_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h19f}: begin
                    rfg_read_value <= lane_17_loopback_miso_write_size_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1a0}: begin
                    rfg_read_value <= lane_17_loopback_miso_write_size_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1a1}: begin
                    rfg_read_value <= lane_17_loopback_miso_write_size_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1a2}: begin
                    rfg_read_value <= lane_17_loopback_miso_write_size_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1a4}: begin
                    rfg_read_value <= lane_18_loopback_miso_write_size_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1a5}: begin
                    rfg_read_value <= lane_18_loopback_miso_write_size_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1a6}: begin
                    rfg_read_value <= lane_18_loopback_miso_write_size_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1a7}: begin
                    rfg_read_value <= lane_18_loopback_miso_write_size_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1a9}: begin
                    rfg_read_value <= lane_19_loopback_miso_write_size_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1aa}: begin
                    rfg_read_value <= lane_19_loopback_miso_write_size_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1ab}: begin
                    rfg_read_value <= lane_19_loopback_miso_write_size_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1ac}: begin
                    rfg_read_value <= lane_19_loopback_miso_write_size_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1ad}: begin
                    rfg_read_value <= lane_0_loopback_mosi_s_axis_tvalid ? lane_0_loopback_mosi_s_axis_tdata : 8'hff;
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1ae}: begin
                    rfg_read_value <= lane_0_loopback_mosi_read_size_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1af}: begin
                    rfg_read_value <= lane_0_loopback_mosi_read_size_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1b0}: begin
                    rfg_read_value <= lane_0_loopback_mosi_read_size_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1b1}: begin
                    rfg_read_value <= lane_0_loopback_mosi_read_size_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1b2}: begin
                    rfg_read_value <= lane_1_loopback_mosi_s_axis_tvalid ? lane_1_loopback_mosi_s_axis_tdata : 8'hff;
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1b3}: begin
                    rfg_read_value <= lane_1_loopback_mosi_read_size_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1b4}: begin
                    rfg_read_value <= lane_1_loopback_mosi_read_size_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1b5}: begin
                    rfg_read_value <= lane_1_loopback_mosi_read_size_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1b6}: begin
                    rfg_read_value <= lane_1_loopback_mosi_read_size_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1b7}: begin
                    rfg_read_value <= lane_2_loopback_mosi_s_axis_tvalid ? lane_2_loopback_mosi_s_axis_tdata : 8'hff;
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1b8}: begin
                    rfg_read_value <= lane_2_loopback_mosi_read_size_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1b9}: begin
                    rfg_read_value <= lane_2_loopback_mosi_read_size_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1ba}: begin
                    rfg_read_value <= lane_2_loopback_mosi_read_size_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1bb}: begin
                    rfg_read_value <= lane_2_loopback_mosi_read_size_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1bc}: begin
                    rfg_read_value <= lane_3_loopback_mosi_s_axis_tvalid ? lane_3_loopback_mosi_s_axis_tdata : 8'hff;
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1bd}: begin
                    rfg_read_value <= lane_3_loopback_mosi_read_size_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1be}: begin
                    rfg_read_value <= lane_3_loopback_mosi_read_size_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1bf}: begin
                    rfg_read_value <= lane_3_loopback_mosi_read_size_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1c0}: begin
                    rfg_read_value <= lane_3_loopback_mosi_read_size_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1c1}: begin
                    rfg_read_value <= lane_4_loopback_mosi_s_axis_tvalid ? lane_4_loopback_mosi_s_axis_tdata : 8'hff;
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1c2}: begin
                    rfg_read_value <= lane_4_loopback_mosi_read_size_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1c3}: begin
                    rfg_read_value <= lane_4_loopback_mosi_read_size_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1c4}: begin
                    rfg_read_value <= lane_4_loopback_mosi_read_size_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1c5}: begin
                    rfg_read_value <= lane_4_loopback_mosi_read_size_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1c6}: begin
                    rfg_read_value <= lane_5_loopback_mosi_s_axis_tvalid ? lane_5_loopback_mosi_s_axis_tdata : 8'hff;
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1c7}: begin
                    rfg_read_value <= lane_5_loopback_mosi_read_size_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1c8}: begin
                    rfg_read_value <= lane_5_loopback_mosi_read_size_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1c9}: begin
                    rfg_read_value <= lane_5_loopback_mosi_read_size_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1ca}: begin
                    rfg_read_value <= lane_5_loopback_mosi_read_size_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1cb}: begin
                    rfg_read_value <= lane_6_loopback_mosi_s_axis_tvalid ? lane_6_loopback_mosi_s_axis_tdata : 8'hff;
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1cc}: begin
                    rfg_read_value <= lane_6_loopback_mosi_read_size_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1cd}: begin
                    rfg_read_value <= lane_6_loopback_mosi_read_size_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1ce}: begin
                    rfg_read_value <= lane_6_loopback_mosi_read_size_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1cf}: begin
                    rfg_read_value <= lane_6_loopback_mosi_read_size_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1d0}: begin
                    rfg_read_value <= lane_7_loopback_mosi_s_axis_tvalid ? lane_7_loopback_mosi_s_axis_tdata : 8'hff;
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1d1}: begin
                    rfg_read_value <= lane_7_loopback_mosi_read_size_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1d2}: begin
                    rfg_read_value <= lane_7_loopback_mosi_read_size_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1d3}: begin
                    rfg_read_value <= lane_7_loopback_mosi_read_size_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1d4}: begin
                    rfg_read_value <= lane_7_loopback_mosi_read_size_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1d5}: begin
                    rfg_read_value <= lane_8_loopback_mosi_s_axis_tvalid ? lane_8_loopback_mosi_s_axis_tdata : 8'hff;
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1d6}: begin
                    rfg_read_value <= lane_8_loopback_mosi_read_size_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1d7}: begin
                    rfg_read_value <= lane_8_loopback_mosi_read_size_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1d8}: begin
                    rfg_read_value <= lane_8_loopback_mosi_read_size_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1d9}: begin
                    rfg_read_value <= lane_8_loopback_mosi_read_size_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1da}: begin
                    rfg_read_value <= lane_9_loopback_mosi_s_axis_tvalid ? lane_9_loopback_mosi_s_axis_tdata : 8'hff;
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1db}: begin
                    rfg_read_value <= lane_9_loopback_mosi_read_size_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1dc}: begin
                    rfg_read_value <= lane_9_loopback_mosi_read_size_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1dd}: begin
                    rfg_read_value <= lane_9_loopback_mosi_read_size_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1de}: begin
                    rfg_read_value <= lane_9_loopback_mosi_read_size_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1df}: begin
                    rfg_read_value <= lane_10_loopback_mosi_s_axis_tvalid ? lane_10_loopback_mosi_s_axis_tdata : 8'hff;
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1e0}: begin
                    rfg_read_value <= lane_10_loopback_mosi_read_size_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1e1}: begin
                    rfg_read_value <= lane_10_loopback_mosi_read_size_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1e2}: begin
                    rfg_read_value <= lane_10_loopback_mosi_read_size_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1e3}: begin
                    rfg_read_value <= lane_10_loopback_mosi_read_size_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1e4}: begin
                    rfg_read_value <= lane_11_loopback_mosi_s_axis_tvalid ? lane_11_loopback_mosi_s_axis_tdata : 8'hff;
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1e5}: begin
                    rfg_read_value <= lane_11_loopback_mosi_read_size_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1e6}: begin
                    rfg_read_value <= lane_11_loopback_mosi_read_size_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1e7}: begin
                    rfg_read_value <= lane_11_loopback_mosi_read_size_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1e8}: begin
                    rfg_read_value <= lane_11_loopback_mosi_read_size_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1e9}: begin
                    rfg_read_value <= lane_12_loopback_mosi_s_axis_tvalid ? lane_12_loopback_mosi_s_axis_tdata : 8'hff;
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1ea}: begin
                    rfg_read_value <= lane_12_loopback_mosi_read_size_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1eb}: begin
                    rfg_read_value <= lane_12_loopback_mosi_read_size_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1ec}: begin
                    rfg_read_value <= lane_12_loopback_mosi_read_size_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1ed}: begin
                    rfg_read_value <= lane_12_loopback_mosi_read_size_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1ee}: begin
                    rfg_read_value <= lane_13_loopback_mosi_s_axis_tvalid ? lane_13_loopback_mosi_s_axis_tdata : 8'hff;
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1ef}: begin
                    rfg_read_value <= lane_13_loopback_mosi_read_size_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1f0}: begin
                    rfg_read_value <= lane_13_loopback_mosi_read_size_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1f1}: begin
                    rfg_read_value <= lane_13_loopback_mosi_read_size_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1f2}: begin
                    rfg_read_value <= lane_13_loopback_mosi_read_size_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1f3}: begin
                    rfg_read_value <= lane_14_loopback_mosi_s_axis_tvalid ? lane_14_loopback_mosi_s_axis_tdata : 8'hff;
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1f4}: begin
                    rfg_read_value <= lane_14_loopback_mosi_read_size_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1f5}: begin
                    rfg_read_value <= lane_14_loopback_mosi_read_size_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1f6}: begin
                    rfg_read_value <= lane_14_loopback_mosi_read_size_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1f7}: begin
                    rfg_read_value <= lane_14_loopback_mosi_read_size_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1f8}: begin
                    rfg_read_value <= lane_15_loopback_mosi_s_axis_tvalid ? lane_15_loopback_mosi_s_axis_tdata : 8'hff;
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1f9}: begin
                    rfg_read_value <= lane_15_loopback_mosi_read_size_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1fa}: begin
                    rfg_read_value <= lane_15_loopback_mosi_read_size_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1fb}: begin
                    rfg_read_value <= lane_15_loopback_mosi_read_size_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1fc}: begin
                    rfg_read_value <= lane_15_loopback_mosi_read_size_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1fd}: begin
                    rfg_read_value <= lane_16_loopback_mosi_s_axis_tvalid ? lane_16_loopback_mosi_s_axis_tdata : 8'hff;
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1fe}: begin
                    rfg_read_value <= lane_16_loopback_mosi_read_size_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1ff}: begin
                    rfg_read_value <= lane_16_loopback_mosi_read_size_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h200}: begin
                    rfg_read_value <= lane_16_loopback_mosi_read_size_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h201}: begin
                    rfg_read_value <= lane_16_loopback_mosi_read_size_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h202}: begin
                    rfg_read_value <= lane_17_loopback_mosi_s_axis_tvalid ? lane_17_loopback_mosi_s_axis_tdata : 8'hff;
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h203}: begin
                    rfg_read_value <= lane_17_loopback_mosi_read_size_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h204}: begin
                    rfg_read_value <= lane_17_loopback_mosi_read_size_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h205}: begin
                    rfg_read_value <= lane_17_loopback_mosi_read_size_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h206}: begin
                    rfg_read_value <= lane_17_loopback_mosi_read_size_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h207}: begin
                    rfg_read_value <= lane_18_loopback_mosi_s_axis_tvalid ? lane_18_loopback_mosi_s_axis_tdata : 8'hff;
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h208}: begin
                    rfg_read_value <= lane_18_loopback_mosi_read_size_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h209}: begin
                    rfg_read_value <= lane_18_loopback_mosi_read_size_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h20a}: begin
                    rfg_read_value <= lane_18_loopback_mosi_read_size_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h20b}: begin
                    rfg_read_value <= lane_18_loopback_mosi_read_size_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h20c}: begin
                    rfg_read_value <= lane_19_loopback_mosi_s_axis_tvalid ? lane_19_loopback_mosi_s_axis_tdata : 8'hff;
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h20d}: begin
                    rfg_read_value <= lane_19_loopback_mosi_read_size_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h20e}: begin
                    rfg_read_value <= lane_19_loopback_mosi_read_size_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h20f}: begin
                    rfg_read_value <= lane_19_loopback_mosi_read_size_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h210}: begin
                    rfg_read_value <= lane_19_loopback_mosi_read_size_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h211}: begin
                    rfg_read_value <= lanes_cfg_frame_tag_counter_ctrl_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h212}: begin
                    rfg_read_value <= lanes_cfg_frame_tag_counter_trigger_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h213}: begin
                    rfg_read_value <= lanes_cfg_frame_tag_counter_trigger_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h214}: begin
                    rfg_read_value <= lanes_cfg_frame_tag_counter_trigger_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h215}: begin
                    rfg_read_value <= lanes_cfg_frame_tag_counter_trigger_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h216}: begin
                    rfg_read_value <= lanes_cfg_frame_tag_counter_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h217}: begin
                    rfg_read_value <= lanes_cfg_frame_tag_counter_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h218}: begin
                    rfg_read_value <= lanes_cfg_frame_tag_counter_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h219}: begin
                    rfg_read_value <= lanes_cfg_frame_tag_counter_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h21a}: begin
                    rfg_read_value <= lanes_cfg_nodata_continue_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h21b}: begin
                    rfg_read_value <= lanes_sr_out_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h21c}: begin
                    rfg_read_value <= lanes_sr_in_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h21d}: begin
                    rfg_read_value <= lanes_inj_ctrl_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h21f}: begin
                    rfg_read_value <= lanes_inj_wdata_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h220}: begin
                    rfg_read_value <= lanes_readout_s_axis_tvalid ? lanes_readout_s_axis_tdata : 8'hff;
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h221}: begin
                    rfg_read_value <= lanes_readout_read_size_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h222}: begin
                    rfg_read_value <= lanes_readout_read_size_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h223}: begin
                    rfg_read_value <= lanes_readout_read_size_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h224}: begin
                    rfg_read_value <= lanes_readout_read_size_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h225}: begin
                    rfg_read_value <= io_ctrl_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h226}: begin
                    rfg_read_value <= io_led_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h227}: begin
                    rfg_read_value <= gecco_sr_ctrl_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h228}: begin
                    rfg_read_value <= hk_conversion_trigger_match_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h229}: begin
                    rfg_read_value <= hk_conversion_trigger_match_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h22a}: begin
                    rfg_read_value <= hk_conversion_trigger_match_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h22b}: begin
                    rfg_read_value <= hk_conversion_trigger_match_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h22c}: begin
                    rfg_read_value <= lanes_cfg_frame_tag_counter_trigger_match_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h22d}: begin
                    rfg_read_value <= lanes_cfg_frame_tag_counter_trigger_match_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h22e}: begin
                    rfg_read_value <= lanes_cfg_frame_tag_counter_trigger_match_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h22f}: begin
                    rfg_read_value <= lanes_cfg_frame_tag_counter_trigger_match_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                default: begin
                rfg_read_valid <= 0 ;
                end
            endcase
            
        end
    end
    
    
    always@(posedge spi_lanes_ckdivider_source_clk) begin
        if (!spi_lanes_ckdivider_source_resn) begin
            spi_lanes_ckdivider_divided_clk <= 1'b0;
            spi_lanes_ckdivider_counter <= 8'h00;
        end else begin
            if (spi_lanes_ckdivider_counter==spi_lanes_ckdivider_reg) begin
                spi_lanes_ckdivider_divided_clk <= !spi_lanes_ckdivider_divided_clk;
                spi_lanes_ckdivider_counter <= 8'h00;
            end else begin
                spi_lanes_ckdivider_counter <= spi_lanes_ckdivider_counter+1;
            end
        end
    end
    reg [7:0] spi_lanes_ckdivider_divided_resn_delay;
    assign spi_lanes_ckdivider_divided_resn = spi_lanes_ckdivider_divided_resn_delay[7];
    always@(posedge spi_lanes_ckdivider_divided_clk or negedge spi_lanes_ckdivider_source_resn) begin
        if (!spi_lanes_ckdivider_source_resn) begin
            spi_lanes_ckdivider_divided_resn_delay <= 8'h00;
        end else begin
            spi_lanes_ckdivider_divided_resn_delay <= {spi_lanes_ckdivider_divided_resn_delay[6:0],1'b1};
        end
    end
    
    
    always@(posedge spi_hk_ckdivider_source_clk) begin
        if (!spi_hk_ckdivider_source_resn) begin
            spi_hk_ckdivider_divided_clk <= 1'b0;
            spi_hk_ckdivider_counter <= 8'h00;
        end else begin
            if (spi_hk_ckdivider_counter==spi_hk_ckdivider_reg) begin
                spi_hk_ckdivider_divided_clk <= !spi_hk_ckdivider_divided_clk;
                spi_hk_ckdivider_counter <= 8'h00;
            end else begin
                spi_hk_ckdivider_counter <= spi_hk_ckdivider_counter+1;
            end
        end
    end
    reg [7:0] spi_hk_ckdivider_divided_resn_delay;
    assign spi_hk_ckdivider_divided_resn = spi_hk_ckdivider_divided_resn_delay[7];
    always@(posedge spi_hk_ckdivider_divided_clk or negedge spi_hk_ckdivider_source_resn) begin
        if (!spi_hk_ckdivider_source_resn) begin
            spi_hk_ckdivider_divided_resn_delay <= 8'h00;
        end else begin
            spi_hk_ckdivider_divided_resn_delay <= {spi_hk_ckdivider_divided_resn_delay[6:0],1'b1};
        end
    end
    
    
endmodule
