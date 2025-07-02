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
    input  wire            spi_layers_ckdivider_source_clk,
    input  wire            spi_layers_ckdivider_source_resn,
    output reg             spi_layers_ckdivider_divided_clk,
    output wire            spi_layers_ckdivider_divided_resn,
    input  wire            spi_hk_ckdivider_source_clk,
    input  wire            spi_hk_ckdivider_source_resn,
    output reg             spi_hk_ckdivider_divided_clk,
    output wire            spi_hk_ckdivider_divided_resn,
    output wire [7:0]            layer_0_cfg_ctrl,
    output wire                  layer_0_cfg_ctrl_hold,
    output wire                  layer_0_cfg_ctrl_reset,
    output wire                  layer_0_cfg_ctrl_disable_autoread,
    output wire                  layer_0_cfg_ctrl_cs,
    output wire                  layer_0_cfg_ctrl_disable_miso,
    output wire                  layer_0_cfg_ctrl_loopback,
    output wire [7:0]            layer_1_cfg_ctrl,
    output wire                  layer_1_cfg_ctrl_hold,
    output wire                  layer_1_cfg_ctrl_reset,
    output wire                  layer_1_cfg_ctrl_disable_autoread,
    output wire                  layer_1_cfg_ctrl_cs,
    output wire                  layer_1_cfg_ctrl_disable_miso,
    output wire                  layer_1_cfg_ctrl_loopback,
    output wire [7:0]            layer_2_cfg_ctrl,
    output wire                  layer_2_cfg_ctrl_hold,
    output wire                  layer_2_cfg_ctrl_reset,
    output wire                  layer_2_cfg_ctrl_disable_autoread,
    output wire                  layer_2_cfg_ctrl_cs,
    output wire                  layer_2_cfg_ctrl_disable_miso,
    output wire                  layer_2_cfg_ctrl_loopback,
    output wire [7:0]            layer_3_cfg_ctrl,
    output wire                  layer_3_cfg_ctrl_hold,
    output wire                  layer_3_cfg_ctrl_reset,
    output wire                  layer_3_cfg_ctrl_disable_autoread,
    output wire                  layer_3_cfg_ctrl_cs,
    output wire                  layer_3_cfg_ctrl_disable_miso,
    output wire                  layer_3_cfg_ctrl_loopback,
    output wire [7:0]            layer_4_cfg_ctrl,
    output wire                  layer_4_cfg_ctrl_hold,
    output wire                  layer_4_cfg_ctrl_reset,
    output wire                  layer_4_cfg_ctrl_disable_autoread,
    output wire                  layer_4_cfg_ctrl_cs,
    output wire                  layer_4_cfg_ctrl_disable_miso,
    output wire                  layer_4_cfg_ctrl_loopback,
    output wire [7:0]            layer_5_cfg_ctrl,
    output wire                  layer_5_cfg_ctrl_hold,
    output wire                  layer_5_cfg_ctrl_reset,
    output wire                  layer_5_cfg_ctrl_disable_autoread,
    output wire                  layer_5_cfg_ctrl_cs,
    output wire                  layer_5_cfg_ctrl_disable_miso,
    output wire                  layer_5_cfg_ctrl_loopback,
    output wire [7:0]            layer_6_cfg_ctrl,
    output wire                  layer_6_cfg_ctrl_hold,
    output wire                  layer_6_cfg_ctrl_reset,
    output wire                  layer_6_cfg_ctrl_disable_autoread,
    output wire                  layer_6_cfg_ctrl_cs,
    output wire                  layer_6_cfg_ctrl_disable_miso,
    output wire                  layer_6_cfg_ctrl_loopback,
    output wire [7:0]            layer_7_cfg_ctrl,
    output wire                  layer_7_cfg_ctrl_hold,
    output wire                  layer_7_cfg_ctrl_reset,
    output wire                  layer_7_cfg_ctrl_disable_autoread,
    output wire                  layer_7_cfg_ctrl_cs,
    output wire                  layer_7_cfg_ctrl_disable_miso,
    output wire                  layer_7_cfg_ctrl_loopback,
    output wire [7:0]            layer_8_cfg_ctrl,
    output wire                  layer_8_cfg_ctrl_hold,
    output wire                  layer_8_cfg_ctrl_reset,
    output wire                  layer_8_cfg_ctrl_disable_autoread,
    output wire                  layer_8_cfg_ctrl_cs,
    output wire                  layer_8_cfg_ctrl_disable_miso,
    output wire                  layer_8_cfg_ctrl_loopback,
    output wire [7:0]            layer_9_cfg_ctrl,
    output wire                  layer_9_cfg_ctrl_hold,
    output wire                  layer_9_cfg_ctrl_reset,
    output wire                  layer_9_cfg_ctrl_disable_autoread,
    output wire                  layer_9_cfg_ctrl_cs,
    output wire                  layer_9_cfg_ctrl_disable_miso,
    output wire                  layer_9_cfg_ctrl_loopback,
    output wire [7:0]            layer_10_cfg_ctrl,
    output wire                  layer_10_cfg_ctrl_hold,
    output wire                  layer_10_cfg_ctrl_reset,
    output wire                  layer_10_cfg_ctrl_disable_autoread,
    output wire                  layer_10_cfg_ctrl_cs,
    output wire                  layer_10_cfg_ctrl_disable_miso,
    output wire                  layer_10_cfg_ctrl_loopback,
    output wire [7:0]            layer_11_cfg_ctrl,
    output wire                  layer_11_cfg_ctrl_hold,
    output wire                  layer_11_cfg_ctrl_reset,
    output wire                  layer_11_cfg_ctrl_disable_autoread,
    output wire                  layer_11_cfg_ctrl_cs,
    output wire                  layer_11_cfg_ctrl_disable_miso,
    output wire                  layer_11_cfg_ctrl_loopback,
    output wire [7:0]            layer_12_cfg_ctrl,
    output wire                  layer_12_cfg_ctrl_hold,
    output wire                  layer_12_cfg_ctrl_reset,
    output wire                  layer_12_cfg_ctrl_disable_autoread,
    output wire                  layer_12_cfg_ctrl_cs,
    output wire                  layer_12_cfg_ctrl_disable_miso,
    output wire                  layer_12_cfg_ctrl_loopback,
    output wire [7:0]            layer_13_cfg_ctrl,
    output wire                  layer_13_cfg_ctrl_hold,
    output wire                  layer_13_cfg_ctrl_reset,
    output wire                  layer_13_cfg_ctrl_disable_autoread,
    output wire                  layer_13_cfg_ctrl_cs,
    output wire                  layer_13_cfg_ctrl_disable_miso,
    output wire                  layer_13_cfg_ctrl_loopback,
    output wire [7:0]            layer_14_cfg_ctrl,
    output wire                  layer_14_cfg_ctrl_hold,
    output wire                  layer_14_cfg_ctrl_reset,
    output wire                  layer_14_cfg_ctrl_disable_autoread,
    output wire                  layer_14_cfg_ctrl_cs,
    output wire                  layer_14_cfg_ctrl_disable_miso,
    output wire                  layer_14_cfg_ctrl_loopback,
    output wire [7:0]            layer_15_cfg_ctrl,
    output wire                  layer_15_cfg_ctrl_hold,
    output wire                  layer_15_cfg_ctrl_reset,
    output wire                  layer_15_cfg_ctrl_disable_autoread,
    output wire                  layer_15_cfg_ctrl_cs,
    output wire                  layer_15_cfg_ctrl_disable_miso,
    output wire                  layer_15_cfg_ctrl_loopback,
    output wire [7:0]            layer_16_cfg_ctrl,
    output wire                  layer_16_cfg_ctrl_hold,
    output wire                  layer_16_cfg_ctrl_reset,
    output wire                  layer_16_cfg_ctrl_disable_autoread,
    output wire                  layer_16_cfg_ctrl_cs,
    output wire                  layer_16_cfg_ctrl_disable_miso,
    output wire                  layer_16_cfg_ctrl_loopback,
    output wire [7:0]            layer_17_cfg_ctrl,
    output wire                  layer_17_cfg_ctrl_hold,
    output wire                  layer_17_cfg_ctrl_reset,
    output wire                  layer_17_cfg_ctrl_disable_autoread,
    output wire                  layer_17_cfg_ctrl_cs,
    output wire                  layer_17_cfg_ctrl_disable_miso,
    output wire                  layer_17_cfg_ctrl_loopback,
    output wire [7:0]            layer_18_cfg_ctrl,
    output wire                  layer_18_cfg_ctrl_hold,
    output wire                  layer_18_cfg_ctrl_reset,
    output wire                  layer_18_cfg_ctrl_disable_autoread,
    output wire                  layer_18_cfg_ctrl_cs,
    output wire                  layer_18_cfg_ctrl_disable_miso,
    output wire                  layer_18_cfg_ctrl_loopback,
    output wire [7:0]            layer_19_cfg_ctrl,
    output wire                  layer_19_cfg_ctrl_hold,
    output wire                  layer_19_cfg_ctrl_reset,
    output wire                  layer_19_cfg_ctrl_disable_autoread,
    output wire                  layer_19_cfg_ctrl_cs,
    output wire                  layer_19_cfg_ctrl_disable_miso,
    output wire                  layer_19_cfg_ctrl_loopback,
    output wire [7:0]            layer_0_status,
    input  wire                  layer_0_status_interruptn,
    input  wire                  layer_0_status_frame_decoding,
    output wire [7:0]            layer_1_status,
    input  wire                  layer_1_status_interruptn,
    input  wire                  layer_1_status_frame_decoding,
    output wire [7:0]            layer_2_status,
    input  wire                  layer_2_status_interruptn,
    input  wire                  layer_2_status_frame_decoding,
    output wire [7:0]            layer_3_status,
    input  wire                  layer_3_status_interruptn,
    input  wire                  layer_3_status_frame_decoding,
    output wire [7:0]            layer_4_status,
    input  wire                  layer_4_status_interruptn,
    input  wire                  layer_4_status_frame_decoding,
    output wire [7:0]            layer_5_status,
    input  wire                  layer_5_status_interruptn,
    input  wire                  layer_5_status_frame_decoding,
    output wire [7:0]            layer_6_status,
    input  wire                  layer_6_status_interruptn,
    input  wire                  layer_6_status_frame_decoding,
    output wire [7:0]            layer_7_status,
    input  wire                  layer_7_status_interruptn,
    input  wire                  layer_7_status_frame_decoding,
    output wire [7:0]            layer_8_status,
    input  wire                  layer_8_status_interruptn,
    input  wire                  layer_8_status_frame_decoding,
    output wire [7:0]            layer_9_status,
    input  wire                  layer_9_status_interruptn,
    input  wire                  layer_9_status_frame_decoding,
    output wire [7:0]            layer_10_status,
    input  wire                  layer_10_status_interruptn,
    input  wire                  layer_10_status_frame_decoding,
    output wire [7:0]            layer_11_status,
    input  wire                  layer_11_status_interruptn,
    input  wire                  layer_11_status_frame_decoding,
    output wire [7:0]            layer_12_status,
    input  wire                  layer_12_status_interruptn,
    input  wire                  layer_12_status_frame_decoding,
    output wire [7:0]            layer_13_status,
    input  wire                  layer_13_status_interruptn,
    input  wire                  layer_13_status_frame_decoding,
    output wire [7:0]            layer_14_status,
    input  wire                  layer_14_status_interruptn,
    input  wire                  layer_14_status_frame_decoding,
    output wire [7:0]            layer_15_status,
    input  wire                  layer_15_status_interruptn,
    input  wire                  layer_15_status_frame_decoding,
    output wire [7:0]            layer_16_status,
    input  wire                  layer_16_status_interruptn,
    input  wire                  layer_16_status_frame_decoding,
    output wire [7:0]            layer_17_status,
    input  wire                  layer_17_status_interruptn,
    input  wire                  layer_17_status_frame_decoding,
    output wire [7:0]            layer_18_status,
    input  wire                  layer_18_status_interruptn,
    input  wire                  layer_18_status_frame_decoding,
    output wire [7:0]            layer_19_status,
    input  wire                  layer_19_status_interruptn,
    input  wire                  layer_19_status_frame_decoding,
    input   wire                  layer_0_stat_frame_counter_enable,
    input   wire                  layer_1_stat_frame_counter_enable,
    input   wire                  layer_2_stat_frame_counter_enable,
    input   wire                  layer_3_stat_frame_counter_enable,
    input   wire                  layer_4_stat_frame_counter_enable,
    input   wire                  layer_5_stat_frame_counter_enable,
    input   wire                  layer_6_stat_frame_counter_enable,
    input   wire                  layer_7_stat_frame_counter_enable,
    input   wire                  layer_8_stat_frame_counter_enable,
    input   wire                  layer_9_stat_frame_counter_enable,
    input   wire                  layer_10_stat_frame_counter_enable,
    input   wire                  layer_11_stat_frame_counter_enable,
    input   wire                  layer_12_stat_frame_counter_enable,
    input   wire                  layer_13_stat_frame_counter_enable,
    input   wire                  layer_14_stat_frame_counter_enable,
    input   wire                  layer_15_stat_frame_counter_enable,
    input   wire                  layer_16_stat_frame_counter_enable,
    input   wire                  layer_17_stat_frame_counter_enable,
    input   wire                  layer_18_stat_frame_counter_enable,
    input   wire                  layer_19_stat_frame_counter_enable,
    input   wire                  layer_0_stat_idle_counter_enable,
    input   wire                  layer_1_stat_idle_counter_enable,
    input   wire                  layer_2_stat_idle_counter_enable,
    input   wire                  layer_3_stat_idle_counter_enable,
    input   wire                  layer_4_stat_idle_counter_enable,
    input   wire                  layer_5_stat_idle_counter_enable,
    input   wire                  layer_6_stat_idle_counter_enable,
    input   wire                  layer_7_stat_idle_counter_enable,
    input   wire                  layer_8_stat_idle_counter_enable,
    input   wire                  layer_9_stat_idle_counter_enable,
    input   wire                  layer_10_stat_idle_counter_enable,
    input   wire                  layer_11_stat_idle_counter_enable,
    input   wire                  layer_12_stat_idle_counter_enable,
    input   wire                  layer_13_stat_idle_counter_enable,
    input   wire                  layer_14_stat_idle_counter_enable,
    input   wire                  layer_15_stat_idle_counter_enable,
    input   wire                  layer_16_stat_idle_counter_enable,
    input   wire                  layer_17_stat_idle_counter_enable,
    input   wire                  layer_18_stat_idle_counter_enable,
    input   wire                  layer_19_stat_idle_counter_enable,
    // AXIS Master interface to write to FIFO layer_0_mosi,
    // --------------------,
    output reg [7:0]             layer_0_mosi_m_axis_tdata,
    output reg                   layer_0_mosi_m_axis_tvalid,
    input  wire                  layer_0_mosi_m_axis_tready,
    output reg            layer_0_mosi_m_axis_tlast,
    input  wire [31:0]            layer_0_mosi_write_size,
    input  wire                  layer_0_mosi_write_size_write,
    // AXIS Master interface to write to FIFO layer_1_mosi,
    // --------------------,
    output reg [7:0]             layer_1_mosi_m_axis_tdata,
    output reg                   layer_1_mosi_m_axis_tvalid,
    input  wire                  layer_1_mosi_m_axis_tready,
    output reg            layer_1_mosi_m_axis_tlast,
    input  wire [31:0]            layer_1_mosi_write_size,
    input  wire                  layer_1_mosi_write_size_write,
    // AXIS Master interface to write to FIFO layer_2_mosi,
    // --------------------,
    output reg [7:0]             layer_2_mosi_m_axis_tdata,
    output reg                   layer_2_mosi_m_axis_tvalid,
    input  wire                  layer_2_mosi_m_axis_tready,
    output reg            layer_2_mosi_m_axis_tlast,
    input  wire [31:0]            layer_2_mosi_write_size,
    input  wire                  layer_2_mosi_write_size_write,
    // AXIS Master interface to write to FIFO layer_3_mosi,
    // --------------------,
    output reg [7:0]             layer_3_mosi_m_axis_tdata,
    output reg                   layer_3_mosi_m_axis_tvalid,
    input  wire                  layer_3_mosi_m_axis_tready,
    output reg            layer_3_mosi_m_axis_tlast,
    input  wire [31:0]            layer_3_mosi_write_size,
    input  wire                  layer_3_mosi_write_size_write,
    // AXIS Master interface to write to FIFO layer_4_mosi,
    // --------------------,
    output reg [7:0]             layer_4_mosi_m_axis_tdata,
    output reg                   layer_4_mosi_m_axis_tvalid,
    input  wire                  layer_4_mosi_m_axis_tready,
    output reg            layer_4_mosi_m_axis_tlast,
    input  wire [31:0]            layer_4_mosi_write_size,
    input  wire                  layer_4_mosi_write_size_write,
    // AXIS Master interface to write to FIFO layer_5_mosi,
    // --------------------,
    output reg [7:0]             layer_5_mosi_m_axis_tdata,
    output reg                   layer_5_mosi_m_axis_tvalid,
    input  wire                  layer_5_mosi_m_axis_tready,
    output reg            layer_5_mosi_m_axis_tlast,
    input  wire [31:0]            layer_5_mosi_write_size,
    input  wire                  layer_5_mosi_write_size_write,
    // AXIS Master interface to write to FIFO layer_6_mosi,
    // --------------------,
    output reg [7:0]             layer_6_mosi_m_axis_tdata,
    output reg                   layer_6_mosi_m_axis_tvalid,
    input  wire                  layer_6_mosi_m_axis_tready,
    output reg            layer_6_mosi_m_axis_tlast,
    input  wire [31:0]            layer_6_mosi_write_size,
    input  wire                  layer_6_mosi_write_size_write,
    // AXIS Master interface to write to FIFO layer_7_mosi,
    // --------------------,
    output reg [7:0]             layer_7_mosi_m_axis_tdata,
    output reg                   layer_7_mosi_m_axis_tvalid,
    input  wire                  layer_7_mosi_m_axis_tready,
    output reg            layer_7_mosi_m_axis_tlast,
    input  wire [31:0]            layer_7_mosi_write_size,
    input  wire                  layer_7_mosi_write_size_write,
    // AXIS Master interface to write to FIFO layer_8_mosi,
    // --------------------,
    output reg [7:0]             layer_8_mosi_m_axis_tdata,
    output reg                   layer_8_mosi_m_axis_tvalid,
    input  wire                  layer_8_mosi_m_axis_tready,
    output reg            layer_8_mosi_m_axis_tlast,
    input  wire [31:0]            layer_8_mosi_write_size,
    input  wire                  layer_8_mosi_write_size_write,
    // AXIS Master interface to write to FIFO layer_9_mosi,
    // --------------------,
    output reg [7:0]             layer_9_mosi_m_axis_tdata,
    output reg                   layer_9_mosi_m_axis_tvalid,
    input  wire                  layer_9_mosi_m_axis_tready,
    output reg            layer_9_mosi_m_axis_tlast,
    input  wire [31:0]            layer_9_mosi_write_size,
    input  wire                  layer_9_mosi_write_size_write,
    // AXIS Master interface to write to FIFO layer_10_mosi,
    // --------------------,
    output reg [7:0]             layer_10_mosi_m_axis_tdata,
    output reg                   layer_10_mosi_m_axis_tvalid,
    input  wire                  layer_10_mosi_m_axis_tready,
    output reg            layer_10_mosi_m_axis_tlast,
    input  wire [31:0]            layer_10_mosi_write_size,
    input  wire                  layer_10_mosi_write_size_write,
    // AXIS Master interface to write to FIFO layer_11_mosi,
    // --------------------,
    output reg [7:0]             layer_11_mosi_m_axis_tdata,
    output reg                   layer_11_mosi_m_axis_tvalid,
    input  wire                  layer_11_mosi_m_axis_tready,
    output reg            layer_11_mosi_m_axis_tlast,
    input  wire [31:0]            layer_11_mosi_write_size,
    input  wire                  layer_11_mosi_write_size_write,
    // AXIS Master interface to write to FIFO layer_12_mosi,
    // --------------------,
    output reg [7:0]             layer_12_mosi_m_axis_tdata,
    output reg                   layer_12_mosi_m_axis_tvalid,
    input  wire                  layer_12_mosi_m_axis_tready,
    output reg            layer_12_mosi_m_axis_tlast,
    input  wire [31:0]            layer_12_mosi_write_size,
    input  wire                  layer_12_mosi_write_size_write,
    // AXIS Master interface to write to FIFO layer_13_mosi,
    // --------------------,
    output reg [7:0]             layer_13_mosi_m_axis_tdata,
    output reg                   layer_13_mosi_m_axis_tvalid,
    input  wire                  layer_13_mosi_m_axis_tready,
    output reg            layer_13_mosi_m_axis_tlast,
    input  wire [31:0]            layer_13_mosi_write_size,
    input  wire                  layer_13_mosi_write_size_write,
    // AXIS Master interface to write to FIFO layer_14_mosi,
    // --------------------,
    output reg [7:0]             layer_14_mosi_m_axis_tdata,
    output reg                   layer_14_mosi_m_axis_tvalid,
    input  wire                  layer_14_mosi_m_axis_tready,
    output reg            layer_14_mosi_m_axis_tlast,
    input  wire [31:0]            layer_14_mosi_write_size,
    input  wire                  layer_14_mosi_write_size_write,
    // AXIS Master interface to write to FIFO layer_15_mosi,
    // --------------------,
    output reg [7:0]             layer_15_mosi_m_axis_tdata,
    output reg                   layer_15_mosi_m_axis_tvalid,
    input  wire                  layer_15_mosi_m_axis_tready,
    output reg            layer_15_mosi_m_axis_tlast,
    input  wire [31:0]            layer_15_mosi_write_size,
    input  wire                  layer_15_mosi_write_size_write,
    // AXIS Master interface to write to FIFO layer_16_mosi,
    // --------------------,
    output reg [7:0]             layer_16_mosi_m_axis_tdata,
    output reg                   layer_16_mosi_m_axis_tvalid,
    input  wire                  layer_16_mosi_m_axis_tready,
    output reg            layer_16_mosi_m_axis_tlast,
    input  wire [31:0]            layer_16_mosi_write_size,
    input  wire                  layer_16_mosi_write_size_write,
    // AXIS Master interface to write to FIFO layer_17_mosi,
    // --------------------,
    output reg [7:0]             layer_17_mosi_m_axis_tdata,
    output reg                   layer_17_mosi_m_axis_tvalid,
    input  wire                  layer_17_mosi_m_axis_tready,
    output reg            layer_17_mosi_m_axis_tlast,
    input  wire [31:0]            layer_17_mosi_write_size,
    input  wire                  layer_17_mosi_write_size_write,
    // AXIS Master interface to write to FIFO layer_18_mosi,
    // --------------------,
    output reg [7:0]             layer_18_mosi_m_axis_tdata,
    output reg                   layer_18_mosi_m_axis_tvalid,
    input  wire                  layer_18_mosi_m_axis_tready,
    output reg            layer_18_mosi_m_axis_tlast,
    input  wire [31:0]            layer_18_mosi_write_size,
    input  wire                  layer_18_mosi_write_size_write,
    // AXIS Master interface to write to FIFO layer_19_mosi,
    // --------------------,
    output reg [7:0]             layer_19_mosi_m_axis_tdata,
    output reg                   layer_19_mosi_m_axis_tvalid,
    input  wire                  layer_19_mosi_m_axis_tready,
    output reg            layer_19_mosi_m_axis_tlast,
    input  wire [31:0]            layer_19_mosi_write_size,
    input  wire                  layer_19_mosi_write_size_write,
    // AXIS Master interface to write to FIFO layer_0_loopback_miso,
    // --------------------,
    output reg [7:0]             layer_0_loopback_miso_m_axis_tdata,
    output reg                   layer_0_loopback_miso_m_axis_tvalid,
    input  wire                  layer_0_loopback_miso_m_axis_tready,
    input  wire [31:0]            layer_0_loopback_miso_write_size,
    input  wire                  layer_0_loopback_miso_write_size_write,
    // AXIS Master interface to write to FIFO layer_1_loopback_miso,
    // --------------------,
    output reg [7:0]             layer_1_loopback_miso_m_axis_tdata,
    output reg                   layer_1_loopback_miso_m_axis_tvalid,
    input  wire                  layer_1_loopback_miso_m_axis_tready,
    input  wire [31:0]            layer_1_loopback_miso_write_size,
    input  wire                  layer_1_loopback_miso_write_size_write,
    // AXIS Master interface to write to FIFO layer_2_loopback_miso,
    // --------------------,
    output reg [7:0]             layer_2_loopback_miso_m_axis_tdata,
    output reg                   layer_2_loopback_miso_m_axis_tvalid,
    input  wire                  layer_2_loopback_miso_m_axis_tready,
    input  wire [31:0]            layer_2_loopback_miso_write_size,
    input  wire                  layer_2_loopback_miso_write_size_write,
    // AXIS Master interface to write to FIFO layer_3_loopback_miso,
    // --------------------,
    output reg [7:0]             layer_3_loopback_miso_m_axis_tdata,
    output reg                   layer_3_loopback_miso_m_axis_tvalid,
    input  wire                  layer_3_loopback_miso_m_axis_tready,
    input  wire [31:0]            layer_3_loopback_miso_write_size,
    input  wire                  layer_3_loopback_miso_write_size_write,
    // AXIS Master interface to write to FIFO layer_4_loopback_miso,
    // --------------------,
    output reg [7:0]             layer_4_loopback_miso_m_axis_tdata,
    output reg                   layer_4_loopback_miso_m_axis_tvalid,
    input  wire                  layer_4_loopback_miso_m_axis_tready,
    input  wire [31:0]            layer_4_loopback_miso_write_size,
    input  wire                  layer_4_loopback_miso_write_size_write,
    // AXIS Master interface to write to FIFO layer_5_loopback_miso,
    // --------------------,
    output reg [7:0]             layer_5_loopback_miso_m_axis_tdata,
    output reg                   layer_5_loopback_miso_m_axis_tvalid,
    input  wire                  layer_5_loopback_miso_m_axis_tready,
    input  wire [31:0]            layer_5_loopback_miso_write_size,
    input  wire                  layer_5_loopback_miso_write_size_write,
    // AXIS Master interface to write to FIFO layer_6_loopback_miso,
    // --------------------,
    output reg [7:0]             layer_6_loopback_miso_m_axis_tdata,
    output reg                   layer_6_loopback_miso_m_axis_tvalid,
    input  wire                  layer_6_loopback_miso_m_axis_tready,
    input  wire [31:0]            layer_6_loopback_miso_write_size,
    input  wire                  layer_6_loopback_miso_write_size_write,
    // AXIS Master interface to write to FIFO layer_7_loopback_miso,
    // --------------------,
    output reg [7:0]             layer_7_loopback_miso_m_axis_tdata,
    output reg                   layer_7_loopback_miso_m_axis_tvalid,
    input  wire                  layer_7_loopback_miso_m_axis_tready,
    input  wire [31:0]            layer_7_loopback_miso_write_size,
    input  wire                  layer_7_loopback_miso_write_size_write,
    // AXIS Master interface to write to FIFO layer_8_loopback_miso,
    // --------------------,
    output reg [7:0]             layer_8_loopback_miso_m_axis_tdata,
    output reg                   layer_8_loopback_miso_m_axis_tvalid,
    input  wire                  layer_8_loopback_miso_m_axis_tready,
    input  wire [31:0]            layer_8_loopback_miso_write_size,
    input  wire                  layer_8_loopback_miso_write_size_write,
    // AXIS Master interface to write to FIFO layer_9_loopback_miso,
    // --------------------,
    output reg [7:0]             layer_9_loopback_miso_m_axis_tdata,
    output reg                   layer_9_loopback_miso_m_axis_tvalid,
    input  wire                  layer_9_loopback_miso_m_axis_tready,
    input  wire [31:0]            layer_9_loopback_miso_write_size,
    input  wire                  layer_9_loopback_miso_write_size_write,
    // AXIS Master interface to write to FIFO layer_10_loopback_miso,
    // --------------------,
    output reg [7:0]             layer_10_loopback_miso_m_axis_tdata,
    output reg                   layer_10_loopback_miso_m_axis_tvalid,
    input  wire                  layer_10_loopback_miso_m_axis_tready,
    input  wire [31:0]            layer_10_loopback_miso_write_size,
    input  wire                  layer_10_loopback_miso_write_size_write,
    // AXIS Master interface to write to FIFO layer_11_loopback_miso,
    // --------------------,
    output reg [7:0]             layer_11_loopback_miso_m_axis_tdata,
    output reg                   layer_11_loopback_miso_m_axis_tvalid,
    input  wire                  layer_11_loopback_miso_m_axis_tready,
    input  wire [31:0]            layer_11_loopback_miso_write_size,
    input  wire                  layer_11_loopback_miso_write_size_write,
    // AXIS Master interface to write to FIFO layer_12_loopback_miso,
    // --------------------,
    output reg [7:0]             layer_12_loopback_miso_m_axis_tdata,
    output reg                   layer_12_loopback_miso_m_axis_tvalid,
    input  wire                  layer_12_loopback_miso_m_axis_tready,
    input  wire [31:0]            layer_12_loopback_miso_write_size,
    input  wire                  layer_12_loopback_miso_write_size_write,
    // AXIS Master interface to write to FIFO layer_13_loopback_miso,
    // --------------------,
    output reg [7:0]             layer_13_loopback_miso_m_axis_tdata,
    output reg                   layer_13_loopback_miso_m_axis_tvalid,
    input  wire                  layer_13_loopback_miso_m_axis_tready,
    input  wire [31:0]            layer_13_loopback_miso_write_size,
    input  wire                  layer_13_loopback_miso_write_size_write,
    // AXIS Master interface to write to FIFO layer_14_loopback_miso,
    // --------------------,
    output reg [7:0]             layer_14_loopback_miso_m_axis_tdata,
    output reg                   layer_14_loopback_miso_m_axis_tvalid,
    input  wire                  layer_14_loopback_miso_m_axis_tready,
    input  wire [31:0]            layer_14_loopback_miso_write_size,
    input  wire                  layer_14_loopback_miso_write_size_write,
    // AXIS Master interface to write to FIFO layer_15_loopback_miso,
    // --------------------,
    output reg [7:0]             layer_15_loopback_miso_m_axis_tdata,
    output reg                   layer_15_loopback_miso_m_axis_tvalid,
    input  wire                  layer_15_loopback_miso_m_axis_tready,
    input  wire [31:0]            layer_15_loopback_miso_write_size,
    input  wire                  layer_15_loopback_miso_write_size_write,
    // AXIS Master interface to write to FIFO layer_16_loopback_miso,
    // --------------------,
    output reg [7:0]             layer_16_loopback_miso_m_axis_tdata,
    output reg                   layer_16_loopback_miso_m_axis_tvalid,
    input  wire                  layer_16_loopback_miso_m_axis_tready,
    input  wire [31:0]            layer_16_loopback_miso_write_size,
    input  wire                  layer_16_loopback_miso_write_size_write,
    // AXIS Master interface to write to FIFO layer_17_loopback_miso,
    // --------------------,
    output reg [7:0]             layer_17_loopback_miso_m_axis_tdata,
    output reg                   layer_17_loopback_miso_m_axis_tvalid,
    input  wire                  layer_17_loopback_miso_m_axis_tready,
    input  wire [31:0]            layer_17_loopback_miso_write_size,
    input  wire                  layer_17_loopback_miso_write_size_write,
    // AXIS Master interface to write to FIFO layer_18_loopback_miso,
    // --------------------,
    output reg [7:0]             layer_18_loopback_miso_m_axis_tdata,
    output reg                   layer_18_loopback_miso_m_axis_tvalid,
    input  wire                  layer_18_loopback_miso_m_axis_tready,
    input  wire [31:0]            layer_18_loopback_miso_write_size,
    input  wire                  layer_18_loopback_miso_write_size_write,
    // AXIS Master interface to write to FIFO layer_19_loopback_miso,
    // --------------------,
    output reg [7:0]             layer_19_loopback_miso_m_axis_tdata,
    output reg                   layer_19_loopback_miso_m_axis_tvalid,
    input  wire                  layer_19_loopback_miso_m_axis_tready,
    input  wire [31:0]            layer_19_loopback_miso_write_size,
    input  wire                  layer_19_loopback_miso_write_size_write,
    // AXIS Slave interface to read from FIFO layer_0_loopback_mosi,
    // --------------------,
    input  wire [7:0]            layer_0_loopback_mosi_s_axis_tdata,
    input  wire                  layer_0_loopback_mosi_s_axis_tvalid,
    output wire                  layer_0_loopback_mosi_s_axis_tready,
    input  wire [31:0]            layer_0_loopback_mosi_read_size,
    input  wire                  layer_0_loopback_mosi_read_size_write,
    // AXIS Slave interface to read from FIFO layer_1_loopback_mosi,
    // --------------------,
    input  wire [7:0]            layer_1_loopback_mosi_s_axis_tdata,
    input  wire                  layer_1_loopback_mosi_s_axis_tvalid,
    output wire                  layer_1_loopback_mosi_s_axis_tready,
    input  wire [31:0]            layer_1_loopback_mosi_read_size,
    input  wire                  layer_1_loopback_mosi_read_size_write,
    // AXIS Slave interface to read from FIFO layer_2_loopback_mosi,
    // --------------------,
    input  wire [7:0]            layer_2_loopback_mosi_s_axis_tdata,
    input  wire                  layer_2_loopback_mosi_s_axis_tvalid,
    output wire                  layer_2_loopback_mosi_s_axis_tready,
    input  wire [31:0]            layer_2_loopback_mosi_read_size,
    input  wire                  layer_2_loopback_mosi_read_size_write,
    // AXIS Slave interface to read from FIFO layer_3_loopback_mosi,
    // --------------------,
    input  wire [7:0]            layer_3_loopback_mosi_s_axis_tdata,
    input  wire                  layer_3_loopback_mosi_s_axis_tvalid,
    output wire                  layer_3_loopback_mosi_s_axis_tready,
    input  wire [31:0]            layer_3_loopback_mosi_read_size,
    input  wire                  layer_3_loopback_mosi_read_size_write,
    // AXIS Slave interface to read from FIFO layer_4_loopback_mosi,
    // --------------------,
    input  wire [7:0]            layer_4_loopback_mosi_s_axis_tdata,
    input  wire                  layer_4_loopback_mosi_s_axis_tvalid,
    output wire                  layer_4_loopback_mosi_s_axis_tready,
    input  wire [31:0]            layer_4_loopback_mosi_read_size,
    input  wire                  layer_4_loopback_mosi_read_size_write,
    // AXIS Slave interface to read from FIFO layer_5_loopback_mosi,
    // --------------------,
    input  wire [7:0]            layer_5_loopback_mosi_s_axis_tdata,
    input  wire                  layer_5_loopback_mosi_s_axis_tvalid,
    output wire                  layer_5_loopback_mosi_s_axis_tready,
    input  wire [31:0]            layer_5_loopback_mosi_read_size,
    input  wire                  layer_5_loopback_mosi_read_size_write,
    // AXIS Slave interface to read from FIFO layer_6_loopback_mosi,
    // --------------------,
    input  wire [7:0]            layer_6_loopback_mosi_s_axis_tdata,
    input  wire                  layer_6_loopback_mosi_s_axis_tvalid,
    output wire                  layer_6_loopback_mosi_s_axis_tready,
    input  wire [31:0]            layer_6_loopback_mosi_read_size,
    input  wire                  layer_6_loopback_mosi_read_size_write,
    // AXIS Slave interface to read from FIFO layer_7_loopback_mosi,
    // --------------------,
    input  wire [7:0]            layer_7_loopback_mosi_s_axis_tdata,
    input  wire                  layer_7_loopback_mosi_s_axis_tvalid,
    output wire                  layer_7_loopback_mosi_s_axis_tready,
    input  wire [31:0]            layer_7_loopback_mosi_read_size,
    input  wire                  layer_7_loopback_mosi_read_size_write,
    // AXIS Slave interface to read from FIFO layer_8_loopback_mosi,
    // --------------------,
    input  wire [7:0]            layer_8_loopback_mosi_s_axis_tdata,
    input  wire                  layer_8_loopback_mosi_s_axis_tvalid,
    output wire                  layer_8_loopback_mosi_s_axis_tready,
    input  wire [31:0]            layer_8_loopback_mosi_read_size,
    input  wire                  layer_8_loopback_mosi_read_size_write,
    // AXIS Slave interface to read from FIFO layer_9_loopback_mosi,
    // --------------------,
    input  wire [7:0]            layer_9_loopback_mosi_s_axis_tdata,
    input  wire                  layer_9_loopback_mosi_s_axis_tvalid,
    output wire                  layer_9_loopback_mosi_s_axis_tready,
    input  wire [31:0]            layer_9_loopback_mosi_read_size,
    input  wire                  layer_9_loopback_mosi_read_size_write,
    // AXIS Slave interface to read from FIFO layer_10_loopback_mosi,
    // --------------------,
    input  wire [7:0]            layer_10_loopback_mosi_s_axis_tdata,
    input  wire                  layer_10_loopback_mosi_s_axis_tvalid,
    output wire                  layer_10_loopback_mosi_s_axis_tready,
    input  wire [31:0]            layer_10_loopback_mosi_read_size,
    input  wire                  layer_10_loopback_mosi_read_size_write,
    // AXIS Slave interface to read from FIFO layer_11_loopback_mosi,
    // --------------------,
    input  wire [7:0]            layer_11_loopback_mosi_s_axis_tdata,
    input  wire                  layer_11_loopback_mosi_s_axis_tvalid,
    output wire                  layer_11_loopback_mosi_s_axis_tready,
    input  wire [31:0]            layer_11_loopback_mosi_read_size,
    input  wire                  layer_11_loopback_mosi_read_size_write,
    // AXIS Slave interface to read from FIFO layer_12_loopback_mosi,
    // --------------------,
    input  wire [7:0]            layer_12_loopback_mosi_s_axis_tdata,
    input  wire                  layer_12_loopback_mosi_s_axis_tvalid,
    output wire                  layer_12_loopback_mosi_s_axis_tready,
    input  wire [31:0]            layer_12_loopback_mosi_read_size,
    input  wire                  layer_12_loopback_mosi_read_size_write,
    // AXIS Slave interface to read from FIFO layer_13_loopback_mosi,
    // --------------------,
    input  wire [7:0]            layer_13_loopback_mosi_s_axis_tdata,
    input  wire                  layer_13_loopback_mosi_s_axis_tvalid,
    output wire                  layer_13_loopback_mosi_s_axis_tready,
    input  wire [31:0]            layer_13_loopback_mosi_read_size,
    input  wire                  layer_13_loopback_mosi_read_size_write,
    // AXIS Slave interface to read from FIFO layer_14_loopback_mosi,
    // --------------------,
    input  wire [7:0]            layer_14_loopback_mosi_s_axis_tdata,
    input  wire                  layer_14_loopback_mosi_s_axis_tvalid,
    output wire                  layer_14_loopback_mosi_s_axis_tready,
    input  wire [31:0]            layer_14_loopback_mosi_read_size,
    input  wire                  layer_14_loopback_mosi_read_size_write,
    // AXIS Slave interface to read from FIFO layer_15_loopback_mosi,
    // --------------------,
    input  wire [7:0]            layer_15_loopback_mosi_s_axis_tdata,
    input  wire                  layer_15_loopback_mosi_s_axis_tvalid,
    output wire                  layer_15_loopback_mosi_s_axis_tready,
    input  wire [31:0]            layer_15_loopback_mosi_read_size,
    input  wire                  layer_15_loopback_mosi_read_size_write,
    // AXIS Slave interface to read from FIFO layer_16_loopback_mosi,
    // --------------------,
    input  wire [7:0]            layer_16_loopback_mosi_s_axis_tdata,
    input  wire                  layer_16_loopback_mosi_s_axis_tvalid,
    output wire                  layer_16_loopback_mosi_s_axis_tready,
    input  wire [31:0]            layer_16_loopback_mosi_read_size,
    input  wire                  layer_16_loopback_mosi_read_size_write,
    // AXIS Slave interface to read from FIFO layer_17_loopback_mosi,
    // --------------------,
    input  wire [7:0]            layer_17_loopback_mosi_s_axis_tdata,
    input  wire                  layer_17_loopback_mosi_s_axis_tvalid,
    output wire                  layer_17_loopback_mosi_s_axis_tready,
    input  wire [31:0]            layer_17_loopback_mosi_read_size,
    input  wire                  layer_17_loopback_mosi_read_size_write,
    // AXIS Slave interface to read from FIFO layer_18_loopback_mosi,
    // --------------------,
    input  wire [7:0]            layer_18_loopback_mosi_s_axis_tdata,
    input  wire                  layer_18_loopback_mosi_s_axis_tvalid,
    output wire                  layer_18_loopback_mosi_s_axis_tready,
    input  wire [31:0]            layer_18_loopback_mosi_read_size,
    input  wire                  layer_18_loopback_mosi_read_size_write,
    // AXIS Slave interface to read from FIFO layer_19_loopback_mosi,
    // --------------------,
    input  wire [7:0]            layer_19_loopback_mosi_s_axis_tdata,
    input  wire                  layer_19_loopback_mosi_s_axis_tvalid,
    output wire                  layer_19_loopback_mosi_s_axis_tready,
    input  wire [31:0]            layer_19_loopback_mosi_read_size,
    input  wire                  layer_19_loopback_mosi_read_size_write,
    output wire [7:0]            layers_cfg_frame_tag_counter_ctrl,
    output wire                  layers_cfg_frame_tag_counter_ctrl_enable,
    output wire                  layers_cfg_frame_tag_counter_ctrl_force_count,
    output wire [31:0]            layers_cfg_frame_tag_counter_trigger,
    output  reg                  layers_cfg_frame_tag_counter_trigger_interrupt,
    input   wire                  layers_cfg_frame_tag_counter_trigger_enable,
    output wire [31:0]            layers_cfg_frame_tag_counter,
    input   wire                  layers_cfg_frame_tag_counter_enable,
    output wire [7:0]            layers_cfg_nodata_continue,
    output wire [7:0]            layers_sr_out,
    output wire                  layers_sr_out_ck1,
    output wire                  layers_sr_out_ck2,
    output wire                  layers_sr_out_sin,
    output wire                  layers_sr_out_ld0,
    output wire                  layers_sr_out_ld1,
    output wire                  layers_sr_out_ld2,
    output wire [7:0]            layers_sr_in,
    output wire                  layers_sr_in_rb,
    input  wire                  layers_sr_in_sout0,
    input  wire                  layers_sr_in_sout1,
    input  wire                  layers_sr_in_sout2,
    output wire [7:0]            layers_inj_ctrl,
    output wire                  layers_inj_ctrl_reset,
    output wire                  layers_inj_ctrl_suspend,
    output wire                  layers_inj_ctrl_synced,
    output wire                  layers_inj_ctrl_trigger,
    output wire                  layers_inj_ctrl_write,
    input  wire                  layers_inj_ctrl_done,
    input  wire                  layers_inj_ctrl_running,
    output wire [3:0]            layers_inj_waddr,
    output wire [7:0]            layers_inj_wdata,
    // AXIS Slave interface to read from FIFO layers_readout,
    // --------------------,
    input  wire [7:0]            layers_readout_s_axis_tdata,
    input  wire                  layers_readout_s_axis_tvalid,
    output wire                  layers_readout_s_axis_tready,
    input  wire [31:0]            layers_readout_read_size,
    input  wire                  layers_readout_read_size_write,
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
    output wire [31:0]            layers_cfg_frame_tag_counter_trigger_match
    );
    
    
    reg [15:0] hk_xadc_temperature_reg;
    reg [15:0] hk_xadc_vccint_reg;
    reg hk_conversion_trigger_up;
    reg [31:0] hk_adc_miso_fifo_read_size_reg;
    // Clock Divider spi_layers_ckdivider
    reg [7:0] spi_layers_ckdivider_counter;
    reg [7:0] spi_layers_ckdivider_reg;
    // Clock Divider spi_hk_ckdivider
    reg [7:0] spi_hk_ckdivider_counter;
    reg [7:0] spi_hk_ckdivider_reg;
    reg [31:0] layer_0_mosi_write_size_reg;
    reg [31:0] layer_1_mosi_write_size_reg;
    reg [31:0] layer_2_mosi_write_size_reg;
    reg [31:0] layer_3_mosi_write_size_reg;
    reg [31:0] layer_4_mosi_write_size_reg;
    reg [31:0] layer_5_mosi_write_size_reg;
    reg [31:0] layer_6_mosi_write_size_reg;
    reg [31:0] layer_7_mosi_write_size_reg;
    reg [31:0] layer_8_mosi_write_size_reg;
    reg [31:0] layer_9_mosi_write_size_reg;
    reg [31:0] layer_10_mosi_write_size_reg;
    reg [31:0] layer_11_mosi_write_size_reg;
    reg [31:0] layer_12_mosi_write_size_reg;
    reg [31:0] layer_13_mosi_write_size_reg;
    reg [31:0] layer_14_mosi_write_size_reg;
    reg [31:0] layer_15_mosi_write_size_reg;
    reg [31:0] layer_16_mosi_write_size_reg;
    reg [31:0] layer_17_mosi_write_size_reg;
    reg [31:0] layer_18_mosi_write_size_reg;
    reg [31:0] layer_19_mosi_write_size_reg;
    reg [31:0] layer_0_loopback_miso_write_size_reg;
    reg [31:0] layer_1_loopback_miso_write_size_reg;
    reg [31:0] layer_2_loopback_miso_write_size_reg;
    reg [31:0] layer_3_loopback_miso_write_size_reg;
    reg [31:0] layer_4_loopback_miso_write_size_reg;
    reg [31:0] layer_5_loopback_miso_write_size_reg;
    reg [31:0] layer_6_loopback_miso_write_size_reg;
    reg [31:0] layer_7_loopback_miso_write_size_reg;
    reg [31:0] layer_8_loopback_miso_write_size_reg;
    reg [31:0] layer_9_loopback_miso_write_size_reg;
    reg [31:0] layer_10_loopback_miso_write_size_reg;
    reg [31:0] layer_11_loopback_miso_write_size_reg;
    reg [31:0] layer_12_loopback_miso_write_size_reg;
    reg [31:0] layer_13_loopback_miso_write_size_reg;
    reg [31:0] layer_14_loopback_miso_write_size_reg;
    reg [31:0] layer_15_loopback_miso_write_size_reg;
    reg [31:0] layer_16_loopback_miso_write_size_reg;
    reg [31:0] layer_17_loopback_miso_write_size_reg;
    reg [31:0] layer_18_loopback_miso_write_size_reg;
    reg [31:0] layer_19_loopback_miso_write_size_reg;
    reg [31:0] layer_0_loopback_mosi_read_size_reg;
    reg [31:0] layer_1_loopback_mosi_read_size_reg;
    reg [31:0] layer_2_loopback_mosi_read_size_reg;
    reg [31:0] layer_3_loopback_mosi_read_size_reg;
    reg [31:0] layer_4_loopback_mosi_read_size_reg;
    reg [31:0] layer_5_loopback_mosi_read_size_reg;
    reg [31:0] layer_6_loopback_mosi_read_size_reg;
    reg [31:0] layer_7_loopback_mosi_read_size_reg;
    reg [31:0] layer_8_loopback_mosi_read_size_reg;
    reg [31:0] layer_9_loopback_mosi_read_size_reg;
    reg [31:0] layer_10_loopback_mosi_read_size_reg;
    reg [31:0] layer_11_loopback_mosi_read_size_reg;
    reg [31:0] layer_12_loopback_mosi_read_size_reg;
    reg [31:0] layer_13_loopback_mosi_read_size_reg;
    reg [31:0] layer_14_loopback_mosi_read_size_reg;
    reg [31:0] layer_15_loopback_mosi_read_size_reg;
    reg [31:0] layer_16_loopback_mosi_read_size_reg;
    reg [31:0] layer_17_loopback_mosi_read_size_reg;
    reg [31:0] layer_18_loopback_mosi_read_size_reg;
    reg [31:0] layer_19_loopback_mosi_read_size_reg;
    reg layers_cfg_frame_tag_counter_trigger_up;
    reg [31:0] layers_readout_read_size_reg;
    
    
    // Registers I/O assignments
    // ---------------
    reg [31:0] hk_firmware_id_reg;
    
    reg [31:0] hk_firmware_version_reg;
    
    reg [31:0] hk_conversion_trigger_reg;
    assign hk_conversion_trigger = hk_conversion_trigger_reg;
    
    reg [31:0] hk_stat_conversions_counter_reg;
    
    reg [7:0] hk_ctrl_reg;
    assign hk_ctrl = hk_ctrl_reg;
    
    reg [7:0] layer_0_cfg_ctrl_reg;
    assign layer_0_cfg_ctrl = layer_0_cfg_ctrl_reg;
    
    reg [7:0] layer_1_cfg_ctrl_reg;
    assign layer_1_cfg_ctrl = layer_1_cfg_ctrl_reg;
    
    reg [7:0] layer_2_cfg_ctrl_reg;
    assign layer_2_cfg_ctrl = layer_2_cfg_ctrl_reg;
    
    reg [7:0] layer_3_cfg_ctrl_reg;
    assign layer_3_cfg_ctrl = layer_3_cfg_ctrl_reg;
    
    reg [7:0] layer_4_cfg_ctrl_reg;
    assign layer_4_cfg_ctrl = layer_4_cfg_ctrl_reg;
    
    reg [7:0] layer_5_cfg_ctrl_reg;
    assign layer_5_cfg_ctrl = layer_5_cfg_ctrl_reg;
    
    reg [7:0] layer_6_cfg_ctrl_reg;
    assign layer_6_cfg_ctrl = layer_6_cfg_ctrl_reg;
    
    reg [7:0] layer_7_cfg_ctrl_reg;
    assign layer_7_cfg_ctrl = layer_7_cfg_ctrl_reg;
    
    reg [7:0] layer_8_cfg_ctrl_reg;
    assign layer_8_cfg_ctrl = layer_8_cfg_ctrl_reg;
    
    reg [7:0] layer_9_cfg_ctrl_reg;
    assign layer_9_cfg_ctrl = layer_9_cfg_ctrl_reg;
    
    reg [7:0] layer_10_cfg_ctrl_reg;
    assign layer_10_cfg_ctrl = layer_10_cfg_ctrl_reg;
    
    reg [7:0] layer_11_cfg_ctrl_reg;
    assign layer_11_cfg_ctrl = layer_11_cfg_ctrl_reg;
    
    reg [7:0] layer_12_cfg_ctrl_reg;
    assign layer_12_cfg_ctrl = layer_12_cfg_ctrl_reg;
    
    reg [7:0] layer_13_cfg_ctrl_reg;
    assign layer_13_cfg_ctrl = layer_13_cfg_ctrl_reg;
    
    reg [7:0] layer_14_cfg_ctrl_reg;
    assign layer_14_cfg_ctrl = layer_14_cfg_ctrl_reg;
    
    reg [7:0] layer_15_cfg_ctrl_reg;
    assign layer_15_cfg_ctrl = layer_15_cfg_ctrl_reg;
    
    reg [7:0] layer_16_cfg_ctrl_reg;
    assign layer_16_cfg_ctrl = layer_16_cfg_ctrl_reg;
    
    reg [7:0] layer_17_cfg_ctrl_reg;
    assign layer_17_cfg_ctrl = layer_17_cfg_ctrl_reg;
    
    reg [7:0] layer_18_cfg_ctrl_reg;
    assign layer_18_cfg_ctrl = layer_18_cfg_ctrl_reg;
    
    reg [7:0] layer_19_cfg_ctrl_reg;
    assign layer_19_cfg_ctrl = layer_19_cfg_ctrl_reg;
    
    reg [7:0] layer_0_status_reg;
    assign layer_0_status = layer_0_status_reg;
    
    reg [7:0] layer_1_status_reg;
    assign layer_1_status = layer_1_status_reg;
    
    reg [7:0] layer_2_status_reg;
    assign layer_2_status = layer_2_status_reg;
    
    reg [7:0] layer_3_status_reg;
    assign layer_3_status = layer_3_status_reg;
    
    reg [7:0] layer_4_status_reg;
    assign layer_4_status = layer_4_status_reg;
    
    reg [7:0] layer_5_status_reg;
    assign layer_5_status = layer_5_status_reg;
    
    reg [7:0] layer_6_status_reg;
    assign layer_6_status = layer_6_status_reg;
    
    reg [7:0] layer_7_status_reg;
    assign layer_7_status = layer_7_status_reg;
    
    reg [7:0] layer_8_status_reg;
    assign layer_8_status = layer_8_status_reg;
    
    reg [7:0] layer_9_status_reg;
    assign layer_9_status = layer_9_status_reg;
    
    reg [7:0] layer_10_status_reg;
    assign layer_10_status = layer_10_status_reg;
    
    reg [7:0] layer_11_status_reg;
    assign layer_11_status = layer_11_status_reg;
    
    reg [7:0] layer_12_status_reg;
    assign layer_12_status = layer_12_status_reg;
    
    reg [7:0] layer_13_status_reg;
    assign layer_13_status = layer_13_status_reg;
    
    reg [7:0] layer_14_status_reg;
    assign layer_14_status = layer_14_status_reg;
    
    reg [7:0] layer_15_status_reg;
    assign layer_15_status = layer_15_status_reg;
    
    reg [7:0] layer_16_status_reg;
    assign layer_16_status = layer_16_status_reg;
    
    reg [7:0] layer_17_status_reg;
    assign layer_17_status = layer_17_status_reg;
    
    reg [7:0] layer_18_status_reg;
    assign layer_18_status = layer_18_status_reg;
    
    reg [7:0] layer_19_status_reg;
    assign layer_19_status = layer_19_status_reg;
    
    reg [31:0] layer_0_stat_frame_counter_reg;
    
    reg [31:0] layer_1_stat_frame_counter_reg;
    
    reg [31:0] layer_2_stat_frame_counter_reg;
    
    reg [31:0] layer_3_stat_frame_counter_reg;
    
    reg [31:0] layer_4_stat_frame_counter_reg;
    
    reg [31:0] layer_5_stat_frame_counter_reg;
    
    reg [31:0] layer_6_stat_frame_counter_reg;
    
    reg [31:0] layer_7_stat_frame_counter_reg;
    
    reg [31:0] layer_8_stat_frame_counter_reg;
    
    reg [31:0] layer_9_stat_frame_counter_reg;
    
    reg [31:0] layer_10_stat_frame_counter_reg;
    
    reg [31:0] layer_11_stat_frame_counter_reg;
    
    reg [31:0] layer_12_stat_frame_counter_reg;
    
    reg [31:0] layer_13_stat_frame_counter_reg;
    
    reg [31:0] layer_14_stat_frame_counter_reg;
    
    reg [31:0] layer_15_stat_frame_counter_reg;
    
    reg [31:0] layer_16_stat_frame_counter_reg;
    
    reg [31:0] layer_17_stat_frame_counter_reg;
    
    reg [31:0] layer_18_stat_frame_counter_reg;
    
    reg [31:0] layer_19_stat_frame_counter_reg;
    
    reg [31:0] layer_0_stat_idle_counter_reg;
    
    reg [31:0] layer_1_stat_idle_counter_reg;
    
    reg [31:0] layer_2_stat_idle_counter_reg;
    
    reg [31:0] layer_3_stat_idle_counter_reg;
    
    reg [31:0] layer_4_stat_idle_counter_reg;
    
    reg [31:0] layer_5_stat_idle_counter_reg;
    
    reg [31:0] layer_6_stat_idle_counter_reg;
    
    reg [31:0] layer_7_stat_idle_counter_reg;
    
    reg [31:0] layer_8_stat_idle_counter_reg;
    
    reg [31:0] layer_9_stat_idle_counter_reg;
    
    reg [31:0] layer_10_stat_idle_counter_reg;
    
    reg [31:0] layer_11_stat_idle_counter_reg;
    
    reg [31:0] layer_12_stat_idle_counter_reg;
    
    reg [31:0] layer_13_stat_idle_counter_reg;
    
    reg [31:0] layer_14_stat_idle_counter_reg;
    
    reg [31:0] layer_15_stat_idle_counter_reg;
    
    reg [31:0] layer_16_stat_idle_counter_reg;
    
    reg [31:0] layer_17_stat_idle_counter_reg;
    
    reg [31:0] layer_18_stat_idle_counter_reg;
    
    reg [31:0] layer_19_stat_idle_counter_reg;
    
    reg [7:0] layers_cfg_frame_tag_counter_ctrl_reg;
    assign layers_cfg_frame_tag_counter_ctrl = layers_cfg_frame_tag_counter_ctrl_reg;
    
    reg [31:0] layers_cfg_frame_tag_counter_trigger_reg;
    assign layers_cfg_frame_tag_counter_trigger = layers_cfg_frame_tag_counter_trigger_reg;
    
    reg [31:0] layers_cfg_frame_tag_counter_reg;
    assign layers_cfg_frame_tag_counter = layers_cfg_frame_tag_counter_reg;
    
    reg [7:0] layers_cfg_nodata_continue_reg;
    assign layers_cfg_nodata_continue = layers_cfg_nodata_continue_reg;
    
    reg [7:0] layers_sr_out_reg;
    assign layers_sr_out = layers_sr_out_reg;
    
    reg [7:0] layers_sr_in_reg;
    assign layers_sr_in = layers_sr_in_reg;
    
    reg [7:0] layers_inj_ctrl_reg;
    assign layers_inj_ctrl = layers_inj_ctrl_reg;
    
    reg [3:0] layers_inj_waddr_reg;
    assign layers_inj_waddr = layers_inj_waddr_reg;
    
    reg [7:0] layers_inj_wdata_reg;
    assign layers_inj_wdata = layers_inj_wdata_reg;
    
    reg [7:0] io_ctrl_reg;
    assign io_ctrl = io_ctrl_reg;
    
    reg [7:0] io_led_reg;
    assign io_led = io_led_reg;
    
    reg [7:0] gecco_sr_ctrl_reg;
    assign gecco_sr_ctrl = gecco_sr_ctrl_reg;
    
    reg [31:0] hk_conversion_trigger_match_reg;
    assign hk_conversion_trigger_match = hk_conversion_trigger_match_reg;
    
    reg [31:0] layers_cfg_frame_tag_counter_trigger_match_reg;
    assign layers_cfg_frame_tag_counter_trigger_match = layers_cfg_frame_tag_counter_trigger_match_reg;
    
    
    
    // Register Bits assignments
    // ---------------
    assign hk_ctrl_select_adc0 = hk_ctrl_reg[0];
    assign hk_ctrl_select_adc1 = hk_ctrl_reg[1];
    assign hk_ctrl_select_adc2 = hk_ctrl_reg[2];
    assign layer_0_cfg_ctrl_hold = layer_0_cfg_ctrl_reg[0];
    assign layer_0_cfg_ctrl_reset = layer_0_cfg_ctrl_reg[1];
    assign layer_0_cfg_ctrl_disable_autoread = layer_0_cfg_ctrl_reg[2];
    assign layer_0_cfg_ctrl_cs = layer_0_cfg_ctrl_reg[3];
    assign layer_0_cfg_ctrl_disable_miso = layer_0_cfg_ctrl_reg[4];
    assign layer_0_cfg_ctrl_loopback = layer_0_cfg_ctrl_reg[5];
    assign layer_1_cfg_ctrl_hold = layer_1_cfg_ctrl_reg[0];
    assign layer_1_cfg_ctrl_reset = layer_1_cfg_ctrl_reg[1];
    assign layer_1_cfg_ctrl_disable_autoread = layer_1_cfg_ctrl_reg[2];
    assign layer_1_cfg_ctrl_cs = layer_1_cfg_ctrl_reg[3];
    assign layer_1_cfg_ctrl_disable_miso = layer_1_cfg_ctrl_reg[4];
    assign layer_1_cfg_ctrl_loopback = layer_1_cfg_ctrl_reg[5];
    assign layer_2_cfg_ctrl_hold = layer_2_cfg_ctrl_reg[0];
    assign layer_2_cfg_ctrl_reset = layer_2_cfg_ctrl_reg[1];
    assign layer_2_cfg_ctrl_disable_autoread = layer_2_cfg_ctrl_reg[2];
    assign layer_2_cfg_ctrl_cs = layer_2_cfg_ctrl_reg[3];
    assign layer_2_cfg_ctrl_disable_miso = layer_2_cfg_ctrl_reg[4];
    assign layer_2_cfg_ctrl_loopback = layer_2_cfg_ctrl_reg[5];
    assign layer_3_cfg_ctrl_hold = layer_3_cfg_ctrl_reg[0];
    assign layer_3_cfg_ctrl_reset = layer_3_cfg_ctrl_reg[1];
    assign layer_3_cfg_ctrl_disable_autoread = layer_3_cfg_ctrl_reg[2];
    assign layer_3_cfg_ctrl_cs = layer_3_cfg_ctrl_reg[3];
    assign layer_3_cfg_ctrl_disable_miso = layer_3_cfg_ctrl_reg[4];
    assign layer_3_cfg_ctrl_loopback = layer_3_cfg_ctrl_reg[5];
    assign layer_4_cfg_ctrl_hold = layer_4_cfg_ctrl_reg[0];
    assign layer_4_cfg_ctrl_reset = layer_4_cfg_ctrl_reg[1];
    assign layer_4_cfg_ctrl_disable_autoread = layer_4_cfg_ctrl_reg[2];
    assign layer_4_cfg_ctrl_cs = layer_4_cfg_ctrl_reg[3];
    assign layer_4_cfg_ctrl_disable_miso = layer_4_cfg_ctrl_reg[4];
    assign layer_4_cfg_ctrl_loopback = layer_4_cfg_ctrl_reg[5];
    assign layer_5_cfg_ctrl_hold = layer_5_cfg_ctrl_reg[0];
    assign layer_5_cfg_ctrl_reset = layer_5_cfg_ctrl_reg[1];
    assign layer_5_cfg_ctrl_disable_autoread = layer_5_cfg_ctrl_reg[2];
    assign layer_5_cfg_ctrl_cs = layer_5_cfg_ctrl_reg[3];
    assign layer_5_cfg_ctrl_disable_miso = layer_5_cfg_ctrl_reg[4];
    assign layer_5_cfg_ctrl_loopback = layer_5_cfg_ctrl_reg[5];
    assign layer_6_cfg_ctrl_hold = layer_6_cfg_ctrl_reg[0];
    assign layer_6_cfg_ctrl_reset = layer_6_cfg_ctrl_reg[1];
    assign layer_6_cfg_ctrl_disable_autoread = layer_6_cfg_ctrl_reg[2];
    assign layer_6_cfg_ctrl_cs = layer_6_cfg_ctrl_reg[3];
    assign layer_6_cfg_ctrl_disable_miso = layer_6_cfg_ctrl_reg[4];
    assign layer_6_cfg_ctrl_loopback = layer_6_cfg_ctrl_reg[5];
    assign layer_7_cfg_ctrl_hold = layer_7_cfg_ctrl_reg[0];
    assign layer_7_cfg_ctrl_reset = layer_7_cfg_ctrl_reg[1];
    assign layer_7_cfg_ctrl_disable_autoread = layer_7_cfg_ctrl_reg[2];
    assign layer_7_cfg_ctrl_cs = layer_7_cfg_ctrl_reg[3];
    assign layer_7_cfg_ctrl_disable_miso = layer_7_cfg_ctrl_reg[4];
    assign layer_7_cfg_ctrl_loopback = layer_7_cfg_ctrl_reg[5];
    assign layer_8_cfg_ctrl_hold = layer_8_cfg_ctrl_reg[0];
    assign layer_8_cfg_ctrl_reset = layer_8_cfg_ctrl_reg[1];
    assign layer_8_cfg_ctrl_disable_autoread = layer_8_cfg_ctrl_reg[2];
    assign layer_8_cfg_ctrl_cs = layer_8_cfg_ctrl_reg[3];
    assign layer_8_cfg_ctrl_disable_miso = layer_8_cfg_ctrl_reg[4];
    assign layer_8_cfg_ctrl_loopback = layer_8_cfg_ctrl_reg[5];
    assign layer_9_cfg_ctrl_hold = layer_9_cfg_ctrl_reg[0];
    assign layer_9_cfg_ctrl_reset = layer_9_cfg_ctrl_reg[1];
    assign layer_9_cfg_ctrl_disable_autoread = layer_9_cfg_ctrl_reg[2];
    assign layer_9_cfg_ctrl_cs = layer_9_cfg_ctrl_reg[3];
    assign layer_9_cfg_ctrl_disable_miso = layer_9_cfg_ctrl_reg[4];
    assign layer_9_cfg_ctrl_loopback = layer_9_cfg_ctrl_reg[5];
    assign layer_10_cfg_ctrl_hold = layer_10_cfg_ctrl_reg[0];
    assign layer_10_cfg_ctrl_reset = layer_10_cfg_ctrl_reg[1];
    assign layer_10_cfg_ctrl_disable_autoread = layer_10_cfg_ctrl_reg[2];
    assign layer_10_cfg_ctrl_cs = layer_10_cfg_ctrl_reg[3];
    assign layer_10_cfg_ctrl_disable_miso = layer_10_cfg_ctrl_reg[4];
    assign layer_10_cfg_ctrl_loopback = layer_10_cfg_ctrl_reg[5];
    assign layer_11_cfg_ctrl_hold = layer_11_cfg_ctrl_reg[0];
    assign layer_11_cfg_ctrl_reset = layer_11_cfg_ctrl_reg[1];
    assign layer_11_cfg_ctrl_disable_autoread = layer_11_cfg_ctrl_reg[2];
    assign layer_11_cfg_ctrl_cs = layer_11_cfg_ctrl_reg[3];
    assign layer_11_cfg_ctrl_disable_miso = layer_11_cfg_ctrl_reg[4];
    assign layer_11_cfg_ctrl_loopback = layer_11_cfg_ctrl_reg[5];
    assign layer_12_cfg_ctrl_hold = layer_12_cfg_ctrl_reg[0];
    assign layer_12_cfg_ctrl_reset = layer_12_cfg_ctrl_reg[1];
    assign layer_12_cfg_ctrl_disable_autoread = layer_12_cfg_ctrl_reg[2];
    assign layer_12_cfg_ctrl_cs = layer_12_cfg_ctrl_reg[3];
    assign layer_12_cfg_ctrl_disable_miso = layer_12_cfg_ctrl_reg[4];
    assign layer_12_cfg_ctrl_loopback = layer_12_cfg_ctrl_reg[5];
    assign layer_13_cfg_ctrl_hold = layer_13_cfg_ctrl_reg[0];
    assign layer_13_cfg_ctrl_reset = layer_13_cfg_ctrl_reg[1];
    assign layer_13_cfg_ctrl_disable_autoread = layer_13_cfg_ctrl_reg[2];
    assign layer_13_cfg_ctrl_cs = layer_13_cfg_ctrl_reg[3];
    assign layer_13_cfg_ctrl_disable_miso = layer_13_cfg_ctrl_reg[4];
    assign layer_13_cfg_ctrl_loopback = layer_13_cfg_ctrl_reg[5];
    assign layer_14_cfg_ctrl_hold = layer_14_cfg_ctrl_reg[0];
    assign layer_14_cfg_ctrl_reset = layer_14_cfg_ctrl_reg[1];
    assign layer_14_cfg_ctrl_disable_autoread = layer_14_cfg_ctrl_reg[2];
    assign layer_14_cfg_ctrl_cs = layer_14_cfg_ctrl_reg[3];
    assign layer_14_cfg_ctrl_disable_miso = layer_14_cfg_ctrl_reg[4];
    assign layer_14_cfg_ctrl_loopback = layer_14_cfg_ctrl_reg[5];
    assign layer_15_cfg_ctrl_hold = layer_15_cfg_ctrl_reg[0];
    assign layer_15_cfg_ctrl_reset = layer_15_cfg_ctrl_reg[1];
    assign layer_15_cfg_ctrl_disable_autoread = layer_15_cfg_ctrl_reg[2];
    assign layer_15_cfg_ctrl_cs = layer_15_cfg_ctrl_reg[3];
    assign layer_15_cfg_ctrl_disable_miso = layer_15_cfg_ctrl_reg[4];
    assign layer_15_cfg_ctrl_loopback = layer_15_cfg_ctrl_reg[5];
    assign layer_16_cfg_ctrl_hold = layer_16_cfg_ctrl_reg[0];
    assign layer_16_cfg_ctrl_reset = layer_16_cfg_ctrl_reg[1];
    assign layer_16_cfg_ctrl_disable_autoread = layer_16_cfg_ctrl_reg[2];
    assign layer_16_cfg_ctrl_cs = layer_16_cfg_ctrl_reg[3];
    assign layer_16_cfg_ctrl_disable_miso = layer_16_cfg_ctrl_reg[4];
    assign layer_16_cfg_ctrl_loopback = layer_16_cfg_ctrl_reg[5];
    assign layer_17_cfg_ctrl_hold = layer_17_cfg_ctrl_reg[0];
    assign layer_17_cfg_ctrl_reset = layer_17_cfg_ctrl_reg[1];
    assign layer_17_cfg_ctrl_disable_autoread = layer_17_cfg_ctrl_reg[2];
    assign layer_17_cfg_ctrl_cs = layer_17_cfg_ctrl_reg[3];
    assign layer_17_cfg_ctrl_disable_miso = layer_17_cfg_ctrl_reg[4];
    assign layer_17_cfg_ctrl_loopback = layer_17_cfg_ctrl_reg[5];
    assign layer_18_cfg_ctrl_hold = layer_18_cfg_ctrl_reg[0];
    assign layer_18_cfg_ctrl_reset = layer_18_cfg_ctrl_reg[1];
    assign layer_18_cfg_ctrl_disable_autoread = layer_18_cfg_ctrl_reg[2];
    assign layer_18_cfg_ctrl_cs = layer_18_cfg_ctrl_reg[3];
    assign layer_18_cfg_ctrl_disable_miso = layer_18_cfg_ctrl_reg[4];
    assign layer_18_cfg_ctrl_loopback = layer_18_cfg_ctrl_reg[5];
    assign layer_19_cfg_ctrl_hold = layer_19_cfg_ctrl_reg[0];
    assign layer_19_cfg_ctrl_reset = layer_19_cfg_ctrl_reg[1];
    assign layer_19_cfg_ctrl_disable_autoread = layer_19_cfg_ctrl_reg[2];
    assign layer_19_cfg_ctrl_cs = layer_19_cfg_ctrl_reg[3];
    assign layer_19_cfg_ctrl_disable_miso = layer_19_cfg_ctrl_reg[4];
    assign layer_19_cfg_ctrl_loopback = layer_19_cfg_ctrl_reg[5];
    assign layers_cfg_frame_tag_counter_ctrl_enable = layers_cfg_frame_tag_counter_ctrl_reg[0];
    assign layers_cfg_frame_tag_counter_ctrl_force_count = layers_cfg_frame_tag_counter_ctrl_reg[1];
    assign layers_sr_out_ck1 = layers_sr_out_reg[0];
    assign layers_sr_out_ck2 = layers_sr_out_reg[1];
    assign layers_sr_out_sin = layers_sr_out_reg[2];
    assign layers_sr_out_ld0 = layers_sr_out_reg[3];
    assign layers_sr_out_ld1 = layers_sr_out_reg[4];
    assign layers_sr_out_ld2 = layers_sr_out_reg[5];
    assign layers_sr_in_rb = layers_sr_in_reg[0];
    assign layers_inj_ctrl_reset = layers_inj_ctrl_reg[0];
    assign layers_inj_ctrl_suspend = layers_inj_ctrl_reg[1];
    assign layers_inj_ctrl_synced = layers_inj_ctrl_reg[2];
    assign layers_inj_ctrl_trigger = layers_inj_ctrl_reg[3];
    assign layers_inj_ctrl_write = layers_inj_ctrl_reg[4];
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
            spi_layers_ckdivider_reg <= 8'h4;
            spi_hk_ckdivider_reg <= 8'h4;
            layer_0_cfg_ctrl_reg <= 8'b00000111;
            layer_1_cfg_ctrl_reg <= 8'b00000111;
            layer_2_cfg_ctrl_reg <= 8'b00000111;
            layer_3_cfg_ctrl_reg <= 8'b00000111;
            layer_4_cfg_ctrl_reg <= 8'b00000111;
            layer_5_cfg_ctrl_reg <= 8'b00000111;
            layer_6_cfg_ctrl_reg <= 8'b00000111;
            layer_7_cfg_ctrl_reg <= 8'b00000111;
            layer_8_cfg_ctrl_reg <= 8'b00000111;
            layer_9_cfg_ctrl_reg <= 8'b00000111;
            layer_10_cfg_ctrl_reg <= 8'b00000111;
            layer_11_cfg_ctrl_reg <= 8'b00000111;
            layer_12_cfg_ctrl_reg <= 8'b00000111;
            layer_13_cfg_ctrl_reg <= 8'b00000111;
            layer_14_cfg_ctrl_reg <= 8'b00000111;
            layer_15_cfg_ctrl_reg <= 8'b00000111;
            layer_16_cfg_ctrl_reg <= 8'b00000111;
            layer_17_cfg_ctrl_reg <= 8'b00000111;
            layer_18_cfg_ctrl_reg <= 8'b00000111;
            layer_19_cfg_ctrl_reg <= 8'b00000111;
            layer_0_status_reg <= 0;
            layer_1_status_reg <= 0;
            layer_2_status_reg <= 0;
            layer_3_status_reg <= 0;
            layer_4_status_reg <= 0;
            layer_5_status_reg <= 0;
            layer_6_status_reg <= 0;
            layer_7_status_reg <= 0;
            layer_8_status_reg <= 0;
            layer_9_status_reg <= 0;
            layer_10_status_reg <= 0;
            layer_11_status_reg <= 0;
            layer_12_status_reg <= 0;
            layer_13_status_reg <= 0;
            layer_14_status_reg <= 0;
            layer_15_status_reg <= 0;
            layer_16_status_reg <= 0;
            layer_17_status_reg <= 0;
            layer_18_status_reg <= 0;
            layer_19_status_reg <= 0;
            layer_0_stat_frame_counter_reg <= 0;
            layer_1_stat_frame_counter_reg <= 0;
            layer_2_stat_frame_counter_reg <= 0;
            layer_3_stat_frame_counter_reg <= 0;
            layer_4_stat_frame_counter_reg <= 0;
            layer_5_stat_frame_counter_reg <= 0;
            layer_6_stat_frame_counter_reg <= 0;
            layer_7_stat_frame_counter_reg <= 0;
            layer_8_stat_frame_counter_reg <= 0;
            layer_9_stat_frame_counter_reg <= 0;
            layer_10_stat_frame_counter_reg <= 0;
            layer_11_stat_frame_counter_reg <= 0;
            layer_12_stat_frame_counter_reg <= 0;
            layer_13_stat_frame_counter_reg <= 0;
            layer_14_stat_frame_counter_reg <= 0;
            layer_15_stat_frame_counter_reg <= 0;
            layer_16_stat_frame_counter_reg <= 0;
            layer_17_stat_frame_counter_reg <= 0;
            layer_18_stat_frame_counter_reg <= 0;
            layer_19_stat_frame_counter_reg <= 0;
            layer_0_stat_idle_counter_reg <= 0;
            layer_1_stat_idle_counter_reg <= 0;
            layer_2_stat_idle_counter_reg <= 0;
            layer_3_stat_idle_counter_reg <= 0;
            layer_4_stat_idle_counter_reg <= 0;
            layer_5_stat_idle_counter_reg <= 0;
            layer_6_stat_idle_counter_reg <= 0;
            layer_7_stat_idle_counter_reg <= 0;
            layer_8_stat_idle_counter_reg <= 0;
            layer_9_stat_idle_counter_reg <= 0;
            layer_10_stat_idle_counter_reg <= 0;
            layer_11_stat_idle_counter_reg <= 0;
            layer_12_stat_idle_counter_reg <= 0;
            layer_13_stat_idle_counter_reg <= 0;
            layer_14_stat_idle_counter_reg <= 0;
            layer_15_stat_idle_counter_reg <= 0;
            layer_16_stat_idle_counter_reg <= 0;
            layer_17_stat_idle_counter_reg <= 0;
            layer_18_stat_idle_counter_reg <= 0;
            layer_19_stat_idle_counter_reg <= 0;
            layer_0_mosi_m_axis_tvalid <= 1'b0;
            layer_0_mosi_m_axis_tlast  <= 1'b0;
            layer_0_mosi_write_size_reg <= 0;
            layer_1_mosi_m_axis_tvalid <= 1'b0;
            layer_1_mosi_m_axis_tlast  <= 1'b0;
            layer_1_mosi_write_size_reg <= 0;
            layer_2_mosi_m_axis_tvalid <= 1'b0;
            layer_2_mosi_m_axis_tlast  <= 1'b0;
            layer_2_mosi_write_size_reg <= 0;
            layer_3_mosi_m_axis_tvalid <= 1'b0;
            layer_3_mosi_m_axis_tlast  <= 1'b0;
            layer_3_mosi_write_size_reg <= 0;
            layer_4_mosi_m_axis_tvalid <= 1'b0;
            layer_4_mosi_m_axis_tlast  <= 1'b0;
            layer_4_mosi_write_size_reg <= 0;
            layer_5_mosi_m_axis_tvalid <= 1'b0;
            layer_5_mosi_m_axis_tlast  <= 1'b0;
            layer_5_mosi_write_size_reg <= 0;
            layer_6_mosi_m_axis_tvalid <= 1'b0;
            layer_6_mosi_m_axis_tlast  <= 1'b0;
            layer_6_mosi_write_size_reg <= 0;
            layer_7_mosi_m_axis_tvalid <= 1'b0;
            layer_7_mosi_m_axis_tlast  <= 1'b0;
            layer_7_mosi_write_size_reg <= 0;
            layer_8_mosi_m_axis_tvalid <= 1'b0;
            layer_8_mosi_m_axis_tlast  <= 1'b0;
            layer_8_mosi_write_size_reg <= 0;
            layer_9_mosi_m_axis_tvalid <= 1'b0;
            layer_9_mosi_m_axis_tlast  <= 1'b0;
            layer_9_mosi_write_size_reg <= 0;
            layer_10_mosi_m_axis_tvalid <= 1'b0;
            layer_10_mosi_m_axis_tlast  <= 1'b0;
            layer_10_mosi_write_size_reg <= 0;
            layer_11_mosi_m_axis_tvalid <= 1'b0;
            layer_11_mosi_m_axis_tlast  <= 1'b0;
            layer_11_mosi_write_size_reg <= 0;
            layer_12_mosi_m_axis_tvalid <= 1'b0;
            layer_12_mosi_m_axis_tlast  <= 1'b0;
            layer_12_mosi_write_size_reg <= 0;
            layer_13_mosi_m_axis_tvalid <= 1'b0;
            layer_13_mosi_m_axis_tlast  <= 1'b0;
            layer_13_mosi_write_size_reg <= 0;
            layer_14_mosi_m_axis_tvalid <= 1'b0;
            layer_14_mosi_m_axis_tlast  <= 1'b0;
            layer_14_mosi_write_size_reg <= 0;
            layer_15_mosi_m_axis_tvalid <= 1'b0;
            layer_15_mosi_m_axis_tlast  <= 1'b0;
            layer_15_mosi_write_size_reg <= 0;
            layer_16_mosi_m_axis_tvalid <= 1'b0;
            layer_16_mosi_m_axis_tlast  <= 1'b0;
            layer_16_mosi_write_size_reg <= 0;
            layer_17_mosi_m_axis_tvalid <= 1'b0;
            layer_17_mosi_m_axis_tlast  <= 1'b0;
            layer_17_mosi_write_size_reg <= 0;
            layer_18_mosi_m_axis_tvalid <= 1'b0;
            layer_18_mosi_m_axis_tlast  <= 1'b0;
            layer_18_mosi_write_size_reg <= 0;
            layer_19_mosi_m_axis_tvalid <= 1'b0;
            layer_19_mosi_m_axis_tlast  <= 1'b0;
            layer_19_mosi_write_size_reg <= 0;
            layer_0_loopback_miso_m_axis_tvalid <= 1'b0;
            layer_0_loopback_miso_write_size_reg <= 0;
            layer_1_loopback_miso_m_axis_tvalid <= 1'b0;
            layer_1_loopback_miso_write_size_reg <= 0;
            layer_2_loopback_miso_m_axis_tvalid <= 1'b0;
            layer_2_loopback_miso_write_size_reg <= 0;
            layer_3_loopback_miso_m_axis_tvalid <= 1'b0;
            layer_3_loopback_miso_write_size_reg <= 0;
            layer_4_loopback_miso_m_axis_tvalid <= 1'b0;
            layer_4_loopback_miso_write_size_reg <= 0;
            layer_5_loopback_miso_m_axis_tvalid <= 1'b0;
            layer_5_loopback_miso_write_size_reg <= 0;
            layer_6_loopback_miso_m_axis_tvalid <= 1'b0;
            layer_6_loopback_miso_write_size_reg <= 0;
            layer_7_loopback_miso_m_axis_tvalid <= 1'b0;
            layer_7_loopback_miso_write_size_reg <= 0;
            layer_8_loopback_miso_m_axis_tvalid <= 1'b0;
            layer_8_loopback_miso_write_size_reg <= 0;
            layer_9_loopback_miso_m_axis_tvalid <= 1'b0;
            layer_9_loopback_miso_write_size_reg <= 0;
            layer_10_loopback_miso_m_axis_tvalid <= 1'b0;
            layer_10_loopback_miso_write_size_reg <= 0;
            layer_11_loopback_miso_m_axis_tvalid <= 1'b0;
            layer_11_loopback_miso_write_size_reg <= 0;
            layer_12_loopback_miso_m_axis_tvalid <= 1'b0;
            layer_12_loopback_miso_write_size_reg <= 0;
            layer_13_loopback_miso_m_axis_tvalid <= 1'b0;
            layer_13_loopback_miso_write_size_reg <= 0;
            layer_14_loopback_miso_m_axis_tvalid <= 1'b0;
            layer_14_loopback_miso_write_size_reg <= 0;
            layer_15_loopback_miso_m_axis_tvalid <= 1'b0;
            layer_15_loopback_miso_write_size_reg <= 0;
            layer_16_loopback_miso_m_axis_tvalid <= 1'b0;
            layer_16_loopback_miso_write_size_reg <= 0;
            layer_17_loopback_miso_m_axis_tvalid <= 1'b0;
            layer_17_loopback_miso_write_size_reg <= 0;
            layer_18_loopback_miso_m_axis_tvalid <= 1'b0;
            layer_18_loopback_miso_write_size_reg <= 0;
            layer_19_loopback_miso_m_axis_tvalid <= 1'b0;
            layer_19_loopback_miso_write_size_reg <= 0;
            layer_0_loopback_mosi_read_size_reg <= 0;
            layer_1_loopback_mosi_read_size_reg <= 0;
            layer_2_loopback_mosi_read_size_reg <= 0;
            layer_3_loopback_mosi_read_size_reg <= 0;
            layer_4_loopback_mosi_read_size_reg <= 0;
            layer_5_loopback_mosi_read_size_reg <= 0;
            layer_6_loopback_mosi_read_size_reg <= 0;
            layer_7_loopback_mosi_read_size_reg <= 0;
            layer_8_loopback_mosi_read_size_reg <= 0;
            layer_9_loopback_mosi_read_size_reg <= 0;
            layer_10_loopback_mosi_read_size_reg <= 0;
            layer_11_loopback_mosi_read_size_reg <= 0;
            layer_12_loopback_mosi_read_size_reg <= 0;
            layer_13_loopback_mosi_read_size_reg <= 0;
            layer_14_loopback_mosi_read_size_reg <= 0;
            layer_15_loopback_mosi_read_size_reg <= 0;
            layer_16_loopback_mosi_read_size_reg <= 0;
            layer_17_loopback_mosi_read_size_reg <= 0;
            layer_18_loopback_mosi_read_size_reg <= 0;
            layer_19_loopback_mosi_read_size_reg <= 0;
            layers_cfg_frame_tag_counter_ctrl_reg <= 8'h1;
            layers_cfg_frame_tag_counter_trigger_reg <= 0;
            layers_cfg_frame_tag_counter_trigger_up <= 1'b1;
            layers_cfg_frame_tag_counter_reg <= 0;
            layers_cfg_nodata_continue_reg <= 8'd5;
            layers_sr_out_reg <= 0;
            layers_sr_in_reg <= 0;
            layers_inj_ctrl_reg <= 8'b00000110;
            layers_inj_waddr_reg <= 0;
            layers_inj_wdata_reg <= 0;
            layers_readout_read_size_reg <= 0;
            io_ctrl_reg <= 8'b00001000;
            io_led_reg <= 0;
            gecco_sr_ctrl_reg <= 0;
            hk_conversion_trigger_match_reg <= 32'd10;
            layers_cfg_frame_tag_counter_trigger_match_reg <= 32'd4;
        end else begin
            
            
            // Single in bits are always sampled
            layer_0_status_reg[0] <= layer_0_status_interruptn;
            layer_0_status_reg[1] <= layer_0_status_frame_decoding;
            layer_1_status_reg[0] <= layer_1_status_interruptn;
            layer_1_status_reg[1] <= layer_1_status_frame_decoding;
            layer_2_status_reg[0] <= layer_2_status_interruptn;
            layer_2_status_reg[1] <= layer_2_status_frame_decoding;
            layer_3_status_reg[0] <= layer_3_status_interruptn;
            layer_3_status_reg[1] <= layer_3_status_frame_decoding;
            layer_4_status_reg[0] <= layer_4_status_interruptn;
            layer_4_status_reg[1] <= layer_4_status_frame_decoding;
            layer_5_status_reg[0] <= layer_5_status_interruptn;
            layer_5_status_reg[1] <= layer_5_status_frame_decoding;
            layer_6_status_reg[0] <= layer_6_status_interruptn;
            layer_6_status_reg[1] <= layer_6_status_frame_decoding;
            layer_7_status_reg[0] <= layer_7_status_interruptn;
            layer_7_status_reg[1] <= layer_7_status_frame_decoding;
            layer_8_status_reg[0] <= layer_8_status_interruptn;
            layer_8_status_reg[1] <= layer_8_status_frame_decoding;
            layer_9_status_reg[0] <= layer_9_status_interruptn;
            layer_9_status_reg[1] <= layer_9_status_frame_decoding;
            layer_10_status_reg[0] <= layer_10_status_interruptn;
            layer_10_status_reg[1] <= layer_10_status_frame_decoding;
            layer_11_status_reg[0] <= layer_11_status_interruptn;
            layer_11_status_reg[1] <= layer_11_status_frame_decoding;
            layer_12_status_reg[0] <= layer_12_status_interruptn;
            layer_12_status_reg[1] <= layer_12_status_frame_decoding;
            layer_13_status_reg[0] <= layer_13_status_interruptn;
            layer_13_status_reg[1] <= layer_13_status_frame_decoding;
            layer_14_status_reg[0] <= layer_14_status_interruptn;
            layer_14_status_reg[1] <= layer_14_status_frame_decoding;
            layer_15_status_reg[0] <= layer_15_status_interruptn;
            layer_15_status_reg[1] <= layer_15_status_frame_decoding;
            layer_16_status_reg[0] <= layer_16_status_interruptn;
            layer_16_status_reg[1] <= layer_16_status_frame_decoding;
            layer_17_status_reg[0] <= layer_17_status_interruptn;
            layer_17_status_reg[1] <= layer_17_status_frame_decoding;
            layer_18_status_reg[0] <= layer_18_status_interruptn;
            layer_18_status_reg[1] <= layer_18_status_frame_decoding;
            layer_19_status_reg[0] <= layer_19_status_interruptn;
            layer_19_status_reg[1] <= layer_19_status_frame_decoding;
            layers_sr_in_reg[1] <= layers_sr_in_sout0;
            layers_sr_in_reg[2] <= layers_sr_in_sout1;
            layers_sr_in_reg[3] <= layers_sr_in_sout2;
            layers_inj_ctrl_reg[5] <= layers_inj_ctrl_done;
            layers_inj_ctrl_reg[6] <= layers_inj_ctrl_running;
            
            
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
                    spi_layers_ckdivider_reg <= rfg_write_value;
                end
                {1'b1,16'h1c}: begin
                    spi_hk_ckdivider_reg <= rfg_write_value;
                end
                {1'b1,16'h1d}: begin
                    layer_0_cfg_ctrl_reg[7:0] <= rfg_write_value;
                end
                {1'b1,16'h1e}: begin
                    layer_1_cfg_ctrl_reg[7:0] <= rfg_write_value;
                end
                {1'b1,16'h1f}: begin
                    layer_2_cfg_ctrl_reg[7:0] <= rfg_write_value;
                end
                {1'b1,16'h20}: begin
                    layer_3_cfg_ctrl_reg[7:0] <= rfg_write_value;
                end
                {1'b1,16'h21}: begin
                    layer_4_cfg_ctrl_reg[7:0] <= rfg_write_value;
                end
                {1'b1,16'h22}: begin
                    layer_5_cfg_ctrl_reg[7:0] <= rfg_write_value;
                end
                {1'b1,16'h23}: begin
                    layer_6_cfg_ctrl_reg[7:0] <= rfg_write_value;
                end
                {1'b1,16'h24}: begin
                    layer_7_cfg_ctrl_reg[7:0] <= rfg_write_value;
                end
                {1'b1,16'h25}: begin
                    layer_8_cfg_ctrl_reg[7:0] <= rfg_write_value;
                end
                {1'b1,16'h26}: begin
                    layer_9_cfg_ctrl_reg[7:0] <= rfg_write_value;
                end
                {1'b1,16'h27}: begin
                    layer_10_cfg_ctrl_reg[7:0] <= rfg_write_value;
                end
                {1'b1,16'h28}: begin
                    layer_11_cfg_ctrl_reg[7:0] <= rfg_write_value;
                end
                {1'b1,16'h29}: begin
                    layer_12_cfg_ctrl_reg[7:0] <= rfg_write_value;
                end
                {1'b1,16'h2a}: begin
                    layer_13_cfg_ctrl_reg[7:0] <= rfg_write_value;
                end
                {1'b1,16'h2b}: begin
                    layer_14_cfg_ctrl_reg[7:0] <= rfg_write_value;
                end
                {1'b1,16'h2c}: begin
                    layer_15_cfg_ctrl_reg[7:0] <= rfg_write_value;
                end
                {1'b1,16'h2d}: begin
                    layer_16_cfg_ctrl_reg[7:0] <= rfg_write_value;
                end
                {1'b1,16'h2e}: begin
                    layer_17_cfg_ctrl_reg[7:0] <= rfg_write_value;
                end
                {1'b1,16'h2f}: begin
                    layer_18_cfg_ctrl_reg[7:0] <= rfg_write_value;
                end
                {1'b1,16'h30}: begin
                    layer_19_cfg_ctrl_reg[7:0] <= rfg_write_value;
                end
                {1'b1,16'h45}: begin
                    layer_0_stat_frame_counter_reg[7:0] <= rfg_write_value;
                end
                {1'b1,16'h46}: begin
                    layer_0_stat_frame_counter_reg[15:8] <= rfg_write_value;
                end
                {1'b1,16'h47}: begin
                    layer_0_stat_frame_counter_reg[23:16] <= rfg_write_value;
                end
                {1'b1,16'h48}: begin
                    layer_0_stat_frame_counter_reg[31:24] <= rfg_write_value;
                end
                {1'b1,16'h49}: begin
                    layer_1_stat_frame_counter_reg[7:0] <= rfg_write_value;
                end
                {1'b1,16'h4a}: begin
                    layer_1_stat_frame_counter_reg[15:8] <= rfg_write_value;
                end
                {1'b1,16'h4b}: begin
                    layer_1_stat_frame_counter_reg[23:16] <= rfg_write_value;
                end
                {1'b1,16'h4c}: begin
                    layer_1_stat_frame_counter_reg[31:24] <= rfg_write_value;
                end
                {1'b1,16'h4d}: begin
                    layer_2_stat_frame_counter_reg[7:0] <= rfg_write_value;
                end
                {1'b1,16'h4e}: begin
                    layer_2_stat_frame_counter_reg[15:8] <= rfg_write_value;
                end
                {1'b1,16'h4f}: begin
                    layer_2_stat_frame_counter_reg[23:16] <= rfg_write_value;
                end
                {1'b1,16'h50}: begin
                    layer_2_stat_frame_counter_reg[31:24] <= rfg_write_value;
                end
                {1'b1,16'h51}: begin
                    layer_3_stat_frame_counter_reg[7:0] <= rfg_write_value;
                end
                {1'b1,16'h52}: begin
                    layer_3_stat_frame_counter_reg[15:8] <= rfg_write_value;
                end
                {1'b1,16'h53}: begin
                    layer_3_stat_frame_counter_reg[23:16] <= rfg_write_value;
                end
                {1'b1,16'h54}: begin
                    layer_3_stat_frame_counter_reg[31:24] <= rfg_write_value;
                end
                {1'b1,16'h55}: begin
                    layer_4_stat_frame_counter_reg[7:0] <= rfg_write_value;
                end
                {1'b1,16'h56}: begin
                    layer_4_stat_frame_counter_reg[15:8] <= rfg_write_value;
                end
                {1'b1,16'h57}: begin
                    layer_4_stat_frame_counter_reg[23:16] <= rfg_write_value;
                end
                {1'b1,16'h58}: begin
                    layer_4_stat_frame_counter_reg[31:24] <= rfg_write_value;
                end
                {1'b1,16'h59}: begin
                    layer_5_stat_frame_counter_reg[7:0] <= rfg_write_value;
                end
                {1'b1,16'h5a}: begin
                    layer_5_stat_frame_counter_reg[15:8] <= rfg_write_value;
                end
                {1'b1,16'h5b}: begin
                    layer_5_stat_frame_counter_reg[23:16] <= rfg_write_value;
                end
                {1'b1,16'h5c}: begin
                    layer_5_stat_frame_counter_reg[31:24] <= rfg_write_value;
                end
                {1'b1,16'h5d}: begin
                    layer_6_stat_frame_counter_reg[7:0] <= rfg_write_value;
                end
                {1'b1,16'h5e}: begin
                    layer_6_stat_frame_counter_reg[15:8] <= rfg_write_value;
                end
                {1'b1,16'h5f}: begin
                    layer_6_stat_frame_counter_reg[23:16] <= rfg_write_value;
                end
                {1'b1,16'h60}: begin
                    layer_6_stat_frame_counter_reg[31:24] <= rfg_write_value;
                end
                {1'b1,16'h61}: begin
                    layer_7_stat_frame_counter_reg[7:0] <= rfg_write_value;
                end
                {1'b1,16'h62}: begin
                    layer_7_stat_frame_counter_reg[15:8] <= rfg_write_value;
                end
                {1'b1,16'h63}: begin
                    layer_7_stat_frame_counter_reg[23:16] <= rfg_write_value;
                end
                {1'b1,16'h64}: begin
                    layer_7_stat_frame_counter_reg[31:24] <= rfg_write_value;
                end
                {1'b1,16'h65}: begin
                    layer_8_stat_frame_counter_reg[7:0] <= rfg_write_value;
                end
                {1'b1,16'h66}: begin
                    layer_8_stat_frame_counter_reg[15:8] <= rfg_write_value;
                end
                {1'b1,16'h67}: begin
                    layer_8_stat_frame_counter_reg[23:16] <= rfg_write_value;
                end
                {1'b1,16'h68}: begin
                    layer_8_stat_frame_counter_reg[31:24] <= rfg_write_value;
                end
                {1'b1,16'h69}: begin
                    layer_9_stat_frame_counter_reg[7:0] <= rfg_write_value;
                end
                {1'b1,16'h6a}: begin
                    layer_9_stat_frame_counter_reg[15:8] <= rfg_write_value;
                end
                {1'b1,16'h6b}: begin
                    layer_9_stat_frame_counter_reg[23:16] <= rfg_write_value;
                end
                {1'b1,16'h6c}: begin
                    layer_9_stat_frame_counter_reg[31:24] <= rfg_write_value;
                end
                {1'b1,16'h6d}: begin
                    layer_10_stat_frame_counter_reg[7:0] <= rfg_write_value;
                end
                {1'b1,16'h6e}: begin
                    layer_10_stat_frame_counter_reg[15:8] <= rfg_write_value;
                end
                {1'b1,16'h6f}: begin
                    layer_10_stat_frame_counter_reg[23:16] <= rfg_write_value;
                end
                {1'b1,16'h70}: begin
                    layer_10_stat_frame_counter_reg[31:24] <= rfg_write_value;
                end
                {1'b1,16'h71}: begin
                    layer_11_stat_frame_counter_reg[7:0] <= rfg_write_value;
                end
                {1'b1,16'h72}: begin
                    layer_11_stat_frame_counter_reg[15:8] <= rfg_write_value;
                end
                {1'b1,16'h73}: begin
                    layer_11_stat_frame_counter_reg[23:16] <= rfg_write_value;
                end
                {1'b1,16'h74}: begin
                    layer_11_stat_frame_counter_reg[31:24] <= rfg_write_value;
                end
                {1'b1,16'h75}: begin
                    layer_12_stat_frame_counter_reg[7:0] <= rfg_write_value;
                end
                {1'b1,16'h76}: begin
                    layer_12_stat_frame_counter_reg[15:8] <= rfg_write_value;
                end
                {1'b1,16'h77}: begin
                    layer_12_stat_frame_counter_reg[23:16] <= rfg_write_value;
                end
                {1'b1,16'h78}: begin
                    layer_12_stat_frame_counter_reg[31:24] <= rfg_write_value;
                end
                {1'b1,16'h79}: begin
                    layer_13_stat_frame_counter_reg[7:0] <= rfg_write_value;
                end
                {1'b1,16'h7a}: begin
                    layer_13_stat_frame_counter_reg[15:8] <= rfg_write_value;
                end
                {1'b1,16'h7b}: begin
                    layer_13_stat_frame_counter_reg[23:16] <= rfg_write_value;
                end
                {1'b1,16'h7c}: begin
                    layer_13_stat_frame_counter_reg[31:24] <= rfg_write_value;
                end
                {1'b1,16'h7d}: begin
                    layer_14_stat_frame_counter_reg[7:0] <= rfg_write_value;
                end
                {1'b1,16'h7e}: begin
                    layer_14_stat_frame_counter_reg[15:8] <= rfg_write_value;
                end
                {1'b1,16'h7f}: begin
                    layer_14_stat_frame_counter_reg[23:16] <= rfg_write_value;
                end
                {1'b1,16'h80}: begin
                    layer_14_stat_frame_counter_reg[31:24] <= rfg_write_value;
                end
                {1'b1,16'h81}: begin
                    layer_15_stat_frame_counter_reg[7:0] <= rfg_write_value;
                end
                {1'b1,16'h82}: begin
                    layer_15_stat_frame_counter_reg[15:8] <= rfg_write_value;
                end
                {1'b1,16'h83}: begin
                    layer_15_stat_frame_counter_reg[23:16] <= rfg_write_value;
                end
                {1'b1,16'h84}: begin
                    layer_15_stat_frame_counter_reg[31:24] <= rfg_write_value;
                end
                {1'b1,16'h85}: begin
                    layer_16_stat_frame_counter_reg[7:0] <= rfg_write_value;
                end
                {1'b1,16'h86}: begin
                    layer_16_stat_frame_counter_reg[15:8] <= rfg_write_value;
                end
                {1'b1,16'h87}: begin
                    layer_16_stat_frame_counter_reg[23:16] <= rfg_write_value;
                end
                {1'b1,16'h88}: begin
                    layer_16_stat_frame_counter_reg[31:24] <= rfg_write_value;
                end
                {1'b1,16'h89}: begin
                    layer_17_stat_frame_counter_reg[7:0] <= rfg_write_value;
                end
                {1'b1,16'h8a}: begin
                    layer_17_stat_frame_counter_reg[15:8] <= rfg_write_value;
                end
                {1'b1,16'h8b}: begin
                    layer_17_stat_frame_counter_reg[23:16] <= rfg_write_value;
                end
                {1'b1,16'h8c}: begin
                    layer_17_stat_frame_counter_reg[31:24] <= rfg_write_value;
                end
                {1'b1,16'h8d}: begin
                    layer_18_stat_frame_counter_reg[7:0] <= rfg_write_value;
                end
                {1'b1,16'h8e}: begin
                    layer_18_stat_frame_counter_reg[15:8] <= rfg_write_value;
                end
                {1'b1,16'h8f}: begin
                    layer_18_stat_frame_counter_reg[23:16] <= rfg_write_value;
                end
                {1'b1,16'h90}: begin
                    layer_18_stat_frame_counter_reg[31:24] <= rfg_write_value;
                end
                {1'b1,16'h91}: begin
                    layer_19_stat_frame_counter_reg[7:0] <= rfg_write_value;
                end
                {1'b1,16'h92}: begin
                    layer_19_stat_frame_counter_reg[15:8] <= rfg_write_value;
                end
                {1'b1,16'h93}: begin
                    layer_19_stat_frame_counter_reg[23:16] <= rfg_write_value;
                end
                {1'b1,16'h94}: begin
                    layer_19_stat_frame_counter_reg[31:24] <= rfg_write_value;
                end
                {1'b1,16'h95}: begin
                    layer_0_stat_idle_counter_reg[7:0] <= rfg_write_value;
                end
                {1'b1,16'h96}: begin
                    layer_0_stat_idle_counter_reg[15:8] <= rfg_write_value;
                end
                {1'b1,16'h97}: begin
                    layer_0_stat_idle_counter_reg[23:16] <= rfg_write_value;
                end
                {1'b1,16'h98}: begin
                    layer_0_stat_idle_counter_reg[31:24] <= rfg_write_value;
                end
                {1'b1,16'h99}: begin
                    layer_1_stat_idle_counter_reg[7:0] <= rfg_write_value;
                end
                {1'b1,16'h9a}: begin
                    layer_1_stat_idle_counter_reg[15:8] <= rfg_write_value;
                end
                {1'b1,16'h9b}: begin
                    layer_1_stat_idle_counter_reg[23:16] <= rfg_write_value;
                end
                {1'b1,16'h9c}: begin
                    layer_1_stat_idle_counter_reg[31:24] <= rfg_write_value;
                end
                {1'b1,16'h9d}: begin
                    layer_2_stat_idle_counter_reg[7:0] <= rfg_write_value;
                end
                {1'b1,16'h9e}: begin
                    layer_2_stat_idle_counter_reg[15:8] <= rfg_write_value;
                end
                {1'b1,16'h9f}: begin
                    layer_2_stat_idle_counter_reg[23:16] <= rfg_write_value;
                end
                {1'b1,16'ha0}: begin
                    layer_2_stat_idle_counter_reg[31:24] <= rfg_write_value;
                end
                {1'b1,16'ha1}: begin
                    layer_3_stat_idle_counter_reg[7:0] <= rfg_write_value;
                end
                {1'b1,16'ha2}: begin
                    layer_3_stat_idle_counter_reg[15:8] <= rfg_write_value;
                end
                {1'b1,16'ha3}: begin
                    layer_3_stat_idle_counter_reg[23:16] <= rfg_write_value;
                end
                {1'b1,16'ha4}: begin
                    layer_3_stat_idle_counter_reg[31:24] <= rfg_write_value;
                end
                {1'b1,16'ha5}: begin
                    layer_4_stat_idle_counter_reg[7:0] <= rfg_write_value;
                end
                {1'b1,16'ha6}: begin
                    layer_4_stat_idle_counter_reg[15:8] <= rfg_write_value;
                end
                {1'b1,16'ha7}: begin
                    layer_4_stat_idle_counter_reg[23:16] <= rfg_write_value;
                end
                {1'b1,16'ha8}: begin
                    layer_4_stat_idle_counter_reg[31:24] <= rfg_write_value;
                end
                {1'b1,16'ha9}: begin
                    layer_5_stat_idle_counter_reg[7:0] <= rfg_write_value;
                end
                {1'b1,16'haa}: begin
                    layer_5_stat_idle_counter_reg[15:8] <= rfg_write_value;
                end
                {1'b1,16'hab}: begin
                    layer_5_stat_idle_counter_reg[23:16] <= rfg_write_value;
                end
                {1'b1,16'hac}: begin
                    layer_5_stat_idle_counter_reg[31:24] <= rfg_write_value;
                end
                {1'b1,16'had}: begin
                    layer_6_stat_idle_counter_reg[7:0] <= rfg_write_value;
                end
                {1'b1,16'hae}: begin
                    layer_6_stat_idle_counter_reg[15:8] <= rfg_write_value;
                end
                {1'b1,16'haf}: begin
                    layer_6_stat_idle_counter_reg[23:16] <= rfg_write_value;
                end
                {1'b1,16'hb0}: begin
                    layer_6_stat_idle_counter_reg[31:24] <= rfg_write_value;
                end
                {1'b1,16'hb1}: begin
                    layer_7_stat_idle_counter_reg[7:0] <= rfg_write_value;
                end
                {1'b1,16'hb2}: begin
                    layer_7_stat_idle_counter_reg[15:8] <= rfg_write_value;
                end
                {1'b1,16'hb3}: begin
                    layer_7_stat_idle_counter_reg[23:16] <= rfg_write_value;
                end
                {1'b1,16'hb4}: begin
                    layer_7_stat_idle_counter_reg[31:24] <= rfg_write_value;
                end
                {1'b1,16'hb5}: begin
                    layer_8_stat_idle_counter_reg[7:0] <= rfg_write_value;
                end
                {1'b1,16'hb6}: begin
                    layer_8_stat_idle_counter_reg[15:8] <= rfg_write_value;
                end
                {1'b1,16'hb7}: begin
                    layer_8_stat_idle_counter_reg[23:16] <= rfg_write_value;
                end
                {1'b1,16'hb8}: begin
                    layer_8_stat_idle_counter_reg[31:24] <= rfg_write_value;
                end
                {1'b1,16'hb9}: begin
                    layer_9_stat_idle_counter_reg[7:0] <= rfg_write_value;
                end
                {1'b1,16'hba}: begin
                    layer_9_stat_idle_counter_reg[15:8] <= rfg_write_value;
                end
                {1'b1,16'hbb}: begin
                    layer_9_stat_idle_counter_reg[23:16] <= rfg_write_value;
                end
                {1'b1,16'hbc}: begin
                    layer_9_stat_idle_counter_reg[31:24] <= rfg_write_value;
                end
                {1'b1,16'hbd}: begin
                    layer_10_stat_idle_counter_reg[7:0] <= rfg_write_value;
                end
                {1'b1,16'hbe}: begin
                    layer_10_stat_idle_counter_reg[15:8] <= rfg_write_value;
                end
                {1'b1,16'hbf}: begin
                    layer_10_stat_idle_counter_reg[23:16] <= rfg_write_value;
                end
                {1'b1,16'hc0}: begin
                    layer_10_stat_idle_counter_reg[31:24] <= rfg_write_value;
                end
                {1'b1,16'hc1}: begin
                    layer_11_stat_idle_counter_reg[7:0] <= rfg_write_value;
                end
                {1'b1,16'hc2}: begin
                    layer_11_stat_idle_counter_reg[15:8] <= rfg_write_value;
                end
                {1'b1,16'hc3}: begin
                    layer_11_stat_idle_counter_reg[23:16] <= rfg_write_value;
                end
                {1'b1,16'hc4}: begin
                    layer_11_stat_idle_counter_reg[31:24] <= rfg_write_value;
                end
                {1'b1,16'hc5}: begin
                    layer_12_stat_idle_counter_reg[7:0] <= rfg_write_value;
                end
                {1'b1,16'hc6}: begin
                    layer_12_stat_idle_counter_reg[15:8] <= rfg_write_value;
                end
                {1'b1,16'hc7}: begin
                    layer_12_stat_idle_counter_reg[23:16] <= rfg_write_value;
                end
                {1'b1,16'hc8}: begin
                    layer_12_stat_idle_counter_reg[31:24] <= rfg_write_value;
                end
                {1'b1,16'hc9}: begin
                    layer_13_stat_idle_counter_reg[7:0] <= rfg_write_value;
                end
                {1'b1,16'hca}: begin
                    layer_13_stat_idle_counter_reg[15:8] <= rfg_write_value;
                end
                {1'b1,16'hcb}: begin
                    layer_13_stat_idle_counter_reg[23:16] <= rfg_write_value;
                end
                {1'b1,16'hcc}: begin
                    layer_13_stat_idle_counter_reg[31:24] <= rfg_write_value;
                end
                {1'b1,16'hcd}: begin
                    layer_14_stat_idle_counter_reg[7:0] <= rfg_write_value;
                end
                {1'b1,16'hce}: begin
                    layer_14_stat_idle_counter_reg[15:8] <= rfg_write_value;
                end
                {1'b1,16'hcf}: begin
                    layer_14_stat_idle_counter_reg[23:16] <= rfg_write_value;
                end
                {1'b1,16'hd0}: begin
                    layer_14_stat_idle_counter_reg[31:24] <= rfg_write_value;
                end
                {1'b1,16'hd1}: begin
                    layer_15_stat_idle_counter_reg[7:0] <= rfg_write_value;
                end
                {1'b1,16'hd2}: begin
                    layer_15_stat_idle_counter_reg[15:8] <= rfg_write_value;
                end
                {1'b1,16'hd3}: begin
                    layer_15_stat_idle_counter_reg[23:16] <= rfg_write_value;
                end
                {1'b1,16'hd4}: begin
                    layer_15_stat_idle_counter_reg[31:24] <= rfg_write_value;
                end
                {1'b1,16'hd5}: begin
                    layer_16_stat_idle_counter_reg[7:0] <= rfg_write_value;
                end
                {1'b1,16'hd6}: begin
                    layer_16_stat_idle_counter_reg[15:8] <= rfg_write_value;
                end
                {1'b1,16'hd7}: begin
                    layer_16_stat_idle_counter_reg[23:16] <= rfg_write_value;
                end
                {1'b1,16'hd8}: begin
                    layer_16_stat_idle_counter_reg[31:24] <= rfg_write_value;
                end
                {1'b1,16'hd9}: begin
                    layer_17_stat_idle_counter_reg[7:0] <= rfg_write_value;
                end
                {1'b1,16'hda}: begin
                    layer_17_stat_idle_counter_reg[15:8] <= rfg_write_value;
                end
                {1'b1,16'hdb}: begin
                    layer_17_stat_idle_counter_reg[23:16] <= rfg_write_value;
                end
                {1'b1,16'hdc}: begin
                    layer_17_stat_idle_counter_reg[31:24] <= rfg_write_value;
                end
                {1'b1,16'hdd}: begin
                    layer_18_stat_idle_counter_reg[7:0] <= rfg_write_value;
                end
                {1'b1,16'hde}: begin
                    layer_18_stat_idle_counter_reg[15:8] <= rfg_write_value;
                end
                {1'b1,16'hdf}: begin
                    layer_18_stat_idle_counter_reg[23:16] <= rfg_write_value;
                end
                {1'b1,16'he0}: begin
                    layer_18_stat_idle_counter_reg[31:24] <= rfg_write_value;
                end
                {1'b1,16'he1}: begin
                    layer_19_stat_idle_counter_reg[7:0] <= rfg_write_value;
                end
                {1'b1,16'he2}: begin
                    layer_19_stat_idle_counter_reg[15:8] <= rfg_write_value;
                end
                {1'b1,16'he3}: begin
                    layer_19_stat_idle_counter_reg[23:16] <= rfg_write_value;
                end
                {1'b1,16'he4}: begin
                    layer_19_stat_idle_counter_reg[31:24] <= rfg_write_value;
                end
                {1'b1,16'h211}: begin
                    layers_cfg_frame_tag_counter_ctrl_reg[7:0] <= rfg_write_value;
                end
                {1'b1,16'h212}: begin
                    layers_cfg_frame_tag_counter_trigger_reg[7:0] <= rfg_write_value;
                end
                {1'b1,16'h213}: begin
                    layers_cfg_frame_tag_counter_trigger_reg[15:8] <= rfg_write_value;
                end
                {1'b1,16'h214}: begin
                    layers_cfg_frame_tag_counter_trigger_reg[23:16] <= rfg_write_value;
                end
                {1'b1,16'h215}: begin
                    layers_cfg_frame_tag_counter_trigger_reg[31:24] <= rfg_write_value;
                end
                {1'b1,16'h216}: begin
                    layers_cfg_frame_tag_counter_reg[7:0] <= rfg_write_value;
                end
                {1'b1,16'h217}: begin
                    layers_cfg_frame_tag_counter_reg[15:8] <= rfg_write_value;
                end
                {1'b1,16'h218}: begin
                    layers_cfg_frame_tag_counter_reg[23:16] <= rfg_write_value;
                end
                {1'b1,16'h219}: begin
                    layers_cfg_frame_tag_counter_reg[31:24] <= rfg_write_value;
                end
                {1'b1,16'h21a}: begin
                    layers_cfg_nodata_continue_reg[7:0] <= rfg_write_value;
                end
                {1'b1,16'h21b}: begin
                    layers_sr_out_reg[7:0] <= rfg_write_value;
                end
                {1'b1,16'h21c}: begin
                    layers_sr_in_reg[7:0] <= rfg_write_value;
                end
                {1'b1,16'h21d}: begin
                    layers_inj_ctrl_reg[7:0] <= rfg_write_value;
                end
                {1'b1,16'h21e}: begin
                    layers_inj_waddr_reg[3:0] <= rfg_write_value[3:0];
                end
                {1'b1,16'h21f}: begin
                    layers_inj_wdata_reg[7:0] <= rfg_write_value;
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
                    layers_cfg_frame_tag_counter_trigger_match_reg[7:0] <= rfg_write_value;
                end
                {1'b1,16'h22d}: begin
                    layers_cfg_frame_tag_counter_trigger_match_reg[15:8] <= rfg_write_value;
                end
                {1'b1,16'h22e}: begin
                    layers_cfg_frame_tag_counter_trigger_match_reg[23:16] <= rfg_write_value;
                end
                {1'b1,16'h22f}: begin
                    layers_cfg_frame_tag_counter_trigger_match_reg[31:24] <= rfg_write_value;
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
                layer_0_mosi_m_axis_tvalid <= 1'b1;
                layer_0_mosi_m_axis_tdata  <= rfg_write_value;
                layer_0_mosi_m_axis_tlast  <= rfg_write_last;
            end else begin
                layer_0_mosi_m_axis_tvalid <= 1'b0;
                layer_0_mosi_m_axis_tlast  <= 1'b0;
            end
            if(rfg_write && rfg_address==16'hea) begin
                layer_1_mosi_m_axis_tvalid <= 1'b1;
                layer_1_mosi_m_axis_tdata  <= rfg_write_value;
                layer_1_mosi_m_axis_tlast  <= rfg_write_last;
            end else begin
                layer_1_mosi_m_axis_tvalid <= 1'b0;
                layer_1_mosi_m_axis_tlast  <= 1'b0;
            end
            if(rfg_write && rfg_address==16'hef) begin
                layer_2_mosi_m_axis_tvalid <= 1'b1;
                layer_2_mosi_m_axis_tdata  <= rfg_write_value;
                layer_2_mosi_m_axis_tlast  <= rfg_write_last;
            end else begin
                layer_2_mosi_m_axis_tvalid <= 1'b0;
                layer_2_mosi_m_axis_tlast  <= 1'b0;
            end
            if(rfg_write && rfg_address==16'hf4) begin
                layer_3_mosi_m_axis_tvalid <= 1'b1;
                layer_3_mosi_m_axis_tdata  <= rfg_write_value;
                layer_3_mosi_m_axis_tlast  <= rfg_write_last;
            end else begin
                layer_3_mosi_m_axis_tvalid <= 1'b0;
                layer_3_mosi_m_axis_tlast  <= 1'b0;
            end
            if(rfg_write && rfg_address==16'hf9) begin
                layer_4_mosi_m_axis_tvalid <= 1'b1;
                layer_4_mosi_m_axis_tdata  <= rfg_write_value;
                layer_4_mosi_m_axis_tlast  <= rfg_write_last;
            end else begin
                layer_4_mosi_m_axis_tvalid <= 1'b0;
                layer_4_mosi_m_axis_tlast  <= 1'b0;
            end
            if(rfg_write && rfg_address==16'hfe) begin
                layer_5_mosi_m_axis_tvalid <= 1'b1;
                layer_5_mosi_m_axis_tdata  <= rfg_write_value;
                layer_5_mosi_m_axis_tlast  <= rfg_write_last;
            end else begin
                layer_5_mosi_m_axis_tvalid <= 1'b0;
                layer_5_mosi_m_axis_tlast  <= 1'b0;
            end
            if(rfg_write && rfg_address==16'h103) begin
                layer_6_mosi_m_axis_tvalid <= 1'b1;
                layer_6_mosi_m_axis_tdata  <= rfg_write_value;
                layer_6_mosi_m_axis_tlast  <= rfg_write_last;
            end else begin
                layer_6_mosi_m_axis_tvalid <= 1'b0;
                layer_6_mosi_m_axis_tlast  <= 1'b0;
            end
            if(rfg_write && rfg_address==16'h108) begin
                layer_7_mosi_m_axis_tvalid <= 1'b1;
                layer_7_mosi_m_axis_tdata  <= rfg_write_value;
                layer_7_mosi_m_axis_tlast  <= rfg_write_last;
            end else begin
                layer_7_mosi_m_axis_tvalid <= 1'b0;
                layer_7_mosi_m_axis_tlast  <= 1'b0;
            end
            if(rfg_write && rfg_address==16'h10d) begin
                layer_8_mosi_m_axis_tvalid <= 1'b1;
                layer_8_mosi_m_axis_tdata  <= rfg_write_value;
                layer_8_mosi_m_axis_tlast  <= rfg_write_last;
            end else begin
                layer_8_mosi_m_axis_tvalid <= 1'b0;
                layer_8_mosi_m_axis_tlast  <= 1'b0;
            end
            if(rfg_write && rfg_address==16'h112) begin
                layer_9_mosi_m_axis_tvalid <= 1'b1;
                layer_9_mosi_m_axis_tdata  <= rfg_write_value;
                layer_9_mosi_m_axis_tlast  <= rfg_write_last;
            end else begin
                layer_9_mosi_m_axis_tvalid <= 1'b0;
                layer_9_mosi_m_axis_tlast  <= 1'b0;
            end
            if(rfg_write && rfg_address==16'h117) begin
                layer_10_mosi_m_axis_tvalid <= 1'b1;
                layer_10_mosi_m_axis_tdata  <= rfg_write_value;
                layer_10_mosi_m_axis_tlast  <= rfg_write_last;
            end else begin
                layer_10_mosi_m_axis_tvalid <= 1'b0;
                layer_10_mosi_m_axis_tlast  <= 1'b0;
            end
            if(rfg_write && rfg_address==16'h11c) begin
                layer_11_mosi_m_axis_tvalid <= 1'b1;
                layer_11_mosi_m_axis_tdata  <= rfg_write_value;
                layer_11_mosi_m_axis_tlast  <= rfg_write_last;
            end else begin
                layer_11_mosi_m_axis_tvalid <= 1'b0;
                layer_11_mosi_m_axis_tlast  <= 1'b0;
            end
            if(rfg_write && rfg_address==16'h121) begin
                layer_12_mosi_m_axis_tvalid <= 1'b1;
                layer_12_mosi_m_axis_tdata  <= rfg_write_value;
                layer_12_mosi_m_axis_tlast  <= rfg_write_last;
            end else begin
                layer_12_mosi_m_axis_tvalid <= 1'b0;
                layer_12_mosi_m_axis_tlast  <= 1'b0;
            end
            if(rfg_write && rfg_address==16'h126) begin
                layer_13_mosi_m_axis_tvalid <= 1'b1;
                layer_13_mosi_m_axis_tdata  <= rfg_write_value;
                layer_13_mosi_m_axis_tlast  <= rfg_write_last;
            end else begin
                layer_13_mosi_m_axis_tvalid <= 1'b0;
                layer_13_mosi_m_axis_tlast  <= 1'b0;
            end
            if(rfg_write && rfg_address==16'h12b) begin
                layer_14_mosi_m_axis_tvalid <= 1'b1;
                layer_14_mosi_m_axis_tdata  <= rfg_write_value;
                layer_14_mosi_m_axis_tlast  <= rfg_write_last;
            end else begin
                layer_14_mosi_m_axis_tvalid <= 1'b0;
                layer_14_mosi_m_axis_tlast  <= 1'b0;
            end
            if(rfg_write && rfg_address==16'h130) begin
                layer_15_mosi_m_axis_tvalid <= 1'b1;
                layer_15_mosi_m_axis_tdata  <= rfg_write_value;
                layer_15_mosi_m_axis_tlast  <= rfg_write_last;
            end else begin
                layer_15_mosi_m_axis_tvalid <= 1'b0;
                layer_15_mosi_m_axis_tlast  <= 1'b0;
            end
            if(rfg_write && rfg_address==16'h135) begin
                layer_16_mosi_m_axis_tvalid <= 1'b1;
                layer_16_mosi_m_axis_tdata  <= rfg_write_value;
                layer_16_mosi_m_axis_tlast  <= rfg_write_last;
            end else begin
                layer_16_mosi_m_axis_tvalid <= 1'b0;
                layer_16_mosi_m_axis_tlast  <= 1'b0;
            end
            if(rfg_write && rfg_address==16'h13a) begin
                layer_17_mosi_m_axis_tvalid <= 1'b1;
                layer_17_mosi_m_axis_tdata  <= rfg_write_value;
                layer_17_mosi_m_axis_tlast  <= rfg_write_last;
            end else begin
                layer_17_mosi_m_axis_tvalid <= 1'b0;
                layer_17_mosi_m_axis_tlast  <= 1'b0;
            end
            if(rfg_write && rfg_address==16'h13f) begin
                layer_18_mosi_m_axis_tvalid <= 1'b1;
                layer_18_mosi_m_axis_tdata  <= rfg_write_value;
                layer_18_mosi_m_axis_tlast  <= rfg_write_last;
            end else begin
                layer_18_mosi_m_axis_tvalid <= 1'b0;
                layer_18_mosi_m_axis_tlast  <= 1'b0;
            end
            if(rfg_write && rfg_address==16'h144) begin
                layer_19_mosi_m_axis_tvalid <= 1'b1;
                layer_19_mosi_m_axis_tdata  <= rfg_write_value;
                layer_19_mosi_m_axis_tlast  <= rfg_write_last;
            end else begin
                layer_19_mosi_m_axis_tvalid <= 1'b0;
                layer_19_mosi_m_axis_tlast  <= 1'b0;
            end
            if(rfg_write && rfg_address==16'h149) begin
                layer_0_loopback_miso_m_axis_tvalid <= 1'b1;
                layer_0_loopback_miso_m_axis_tdata  <= rfg_write_value;
            end else begin
                layer_0_loopback_miso_m_axis_tvalid <= 1'b0;
            end
            if(rfg_write && rfg_address==16'h14e) begin
                layer_1_loopback_miso_m_axis_tvalid <= 1'b1;
                layer_1_loopback_miso_m_axis_tdata  <= rfg_write_value;
            end else begin
                layer_1_loopback_miso_m_axis_tvalid <= 1'b0;
            end
            if(rfg_write && rfg_address==16'h153) begin
                layer_2_loopback_miso_m_axis_tvalid <= 1'b1;
                layer_2_loopback_miso_m_axis_tdata  <= rfg_write_value;
            end else begin
                layer_2_loopback_miso_m_axis_tvalid <= 1'b0;
            end
            if(rfg_write && rfg_address==16'h158) begin
                layer_3_loopback_miso_m_axis_tvalid <= 1'b1;
                layer_3_loopback_miso_m_axis_tdata  <= rfg_write_value;
            end else begin
                layer_3_loopback_miso_m_axis_tvalid <= 1'b0;
            end
            if(rfg_write && rfg_address==16'h15d) begin
                layer_4_loopback_miso_m_axis_tvalid <= 1'b1;
                layer_4_loopback_miso_m_axis_tdata  <= rfg_write_value;
            end else begin
                layer_4_loopback_miso_m_axis_tvalid <= 1'b0;
            end
            if(rfg_write && rfg_address==16'h162) begin
                layer_5_loopback_miso_m_axis_tvalid <= 1'b1;
                layer_5_loopback_miso_m_axis_tdata  <= rfg_write_value;
            end else begin
                layer_5_loopback_miso_m_axis_tvalid <= 1'b0;
            end
            if(rfg_write && rfg_address==16'h167) begin
                layer_6_loopback_miso_m_axis_tvalid <= 1'b1;
                layer_6_loopback_miso_m_axis_tdata  <= rfg_write_value;
            end else begin
                layer_6_loopback_miso_m_axis_tvalid <= 1'b0;
            end
            if(rfg_write && rfg_address==16'h16c) begin
                layer_7_loopback_miso_m_axis_tvalid <= 1'b1;
                layer_7_loopback_miso_m_axis_tdata  <= rfg_write_value;
            end else begin
                layer_7_loopback_miso_m_axis_tvalid <= 1'b0;
            end
            if(rfg_write && rfg_address==16'h171) begin
                layer_8_loopback_miso_m_axis_tvalid <= 1'b1;
                layer_8_loopback_miso_m_axis_tdata  <= rfg_write_value;
            end else begin
                layer_8_loopback_miso_m_axis_tvalid <= 1'b0;
            end
            if(rfg_write && rfg_address==16'h176) begin
                layer_9_loopback_miso_m_axis_tvalid <= 1'b1;
                layer_9_loopback_miso_m_axis_tdata  <= rfg_write_value;
            end else begin
                layer_9_loopback_miso_m_axis_tvalid <= 1'b0;
            end
            if(rfg_write && rfg_address==16'h17b) begin
                layer_10_loopback_miso_m_axis_tvalid <= 1'b1;
                layer_10_loopback_miso_m_axis_tdata  <= rfg_write_value;
            end else begin
                layer_10_loopback_miso_m_axis_tvalid <= 1'b0;
            end
            if(rfg_write && rfg_address==16'h180) begin
                layer_11_loopback_miso_m_axis_tvalid <= 1'b1;
                layer_11_loopback_miso_m_axis_tdata  <= rfg_write_value;
            end else begin
                layer_11_loopback_miso_m_axis_tvalid <= 1'b0;
            end
            if(rfg_write && rfg_address==16'h185) begin
                layer_12_loopback_miso_m_axis_tvalid <= 1'b1;
                layer_12_loopback_miso_m_axis_tdata  <= rfg_write_value;
            end else begin
                layer_12_loopback_miso_m_axis_tvalid <= 1'b0;
            end
            if(rfg_write && rfg_address==16'h18a) begin
                layer_13_loopback_miso_m_axis_tvalid <= 1'b1;
                layer_13_loopback_miso_m_axis_tdata  <= rfg_write_value;
            end else begin
                layer_13_loopback_miso_m_axis_tvalid <= 1'b0;
            end
            if(rfg_write && rfg_address==16'h18f) begin
                layer_14_loopback_miso_m_axis_tvalid <= 1'b1;
                layer_14_loopback_miso_m_axis_tdata  <= rfg_write_value;
            end else begin
                layer_14_loopback_miso_m_axis_tvalid <= 1'b0;
            end
            if(rfg_write && rfg_address==16'h194) begin
                layer_15_loopback_miso_m_axis_tvalid <= 1'b1;
                layer_15_loopback_miso_m_axis_tdata  <= rfg_write_value;
            end else begin
                layer_15_loopback_miso_m_axis_tvalid <= 1'b0;
            end
            if(rfg_write && rfg_address==16'h199) begin
                layer_16_loopback_miso_m_axis_tvalid <= 1'b1;
                layer_16_loopback_miso_m_axis_tdata  <= rfg_write_value;
            end else begin
                layer_16_loopback_miso_m_axis_tvalid <= 1'b0;
            end
            if(rfg_write && rfg_address==16'h19e) begin
                layer_17_loopback_miso_m_axis_tvalid <= 1'b1;
                layer_17_loopback_miso_m_axis_tdata  <= rfg_write_value;
            end else begin
                layer_17_loopback_miso_m_axis_tvalid <= 1'b0;
            end
            if(rfg_write && rfg_address==16'h1a3) begin
                layer_18_loopback_miso_m_axis_tvalid <= 1'b1;
                layer_18_loopback_miso_m_axis_tdata  <= rfg_write_value;
            end else begin
                layer_18_loopback_miso_m_axis_tvalid <= 1'b0;
            end
            if(rfg_write && rfg_address==16'h1a8) begin
                layer_19_loopback_miso_m_axis_tvalid <= 1'b1;
                layer_19_loopback_miso_m_axis_tdata  <= rfg_write_value;
            end else begin
                layer_19_loopback_miso_m_axis_tvalid <= 1'b0;
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
            if(layer_0_mosi_write_size_write) begin
                layer_0_mosi_write_size_reg <= layer_0_mosi_write_size ;
            end
            if(layer_1_mosi_write_size_write) begin
                layer_1_mosi_write_size_reg <= layer_1_mosi_write_size ;
            end
            if(layer_2_mosi_write_size_write) begin
                layer_2_mosi_write_size_reg <= layer_2_mosi_write_size ;
            end
            if(layer_3_mosi_write_size_write) begin
                layer_3_mosi_write_size_reg <= layer_3_mosi_write_size ;
            end
            if(layer_4_mosi_write_size_write) begin
                layer_4_mosi_write_size_reg <= layer_4_mosi_write_size ;
            end
            if(layer_5_mosi_write_size_write) begin
                layer_5_mosi_write_size_reg <= layer_5_mosi_write_size ;
            end
            if(layer_6_mosi_write_size_write) begin
                layer_6_mosi_write_size_reg <= layer_6_mosi_write_size ;
            end
            if(layer_7_mosi_write_size_write) begin
                layer_7_mosi_write_size_reg <= layer_7_mosi_write_size ;
            end
            if(layer_8_mosi_write_size_write) begin
                layer_8_mosi_write_size_reg <= layer_8_mosi_write_size ;
            end
            if(layer_9_mosi_write_size_write) begin
                layer_9_mosi_write_size_reg <= layer_9_mosi_write_size ;
            end
            if(layer_10_mosi_write_size_write) begin
                layer_10_mosi_write_size_reg <= layer_10_mosi_write_size ;
            end
            if(layer_11_mosi_write_size_write) begin
                layer_11_mosi_write_size_reg <= layer_11_mosi_write_size ;
            end
            if(layer_12_mosi_write_size_write) begin
                layer_12_mosi_write_size_reg <= layer_12_mosi_write_size ;
            end
            if(layer_13_mosi_write_size_write) begin
                layer_13_mosi_write_size_reg <= layer_13_mosi_write_size ;
            end
            if(layer_14_mosi_write_size_write) begin
                layer_14_mosi_write_size_reg <= layer_14_mosi_write_size ;
            end
            if(layer_15_mosi_write_size_write) begin
                layer_15_mosi_write_size_reg <= layer_15_mosi_write_size ;
            end
            if(layer_16_mosi_write_size_write) begin
                layer_16_mosi_write_size_reg <= layer_16_mosi_write_size ;
            end
            if(layer_17_mosi_write_size_write) begin
                layer_17_mosi_write_size_reg <= layer_17_mosi_write_size ;
            end
            if(layer_18_mosi_write_size_write) begin
                layer_18_mosi_write_size_reg <= layer_18_mosi_write_size ;
            end
            if(layer_19_mosi_write_size_write) begin
                layer_19_mosi_write_size_reg <= layer_19_mosi_write_size ;
            end
            if(layer_0_loopback_miso_write_size_write) begin
                layer_0_loopback_miso_write_size_reg <= layer_0_loopback_miso_write_size ;
            end
            if(layer_1_loopback_miso_write_size_write) begin
                layer_1_loopback_miso_write_size_reg <= layer_1_loopback_miso_write_size ;
            end
            if(layer_2_loopback_miso_write_size_write) begin
                layer_2_loopback_miso_write_size_reg <= layer_2_loopback_miso_write_size ;
            end
            if(layer_3_loopback_miso_write_size_write) begin
                layer_3_loopback_miso_write_size_reg <= layer_3_loopback_miso_write_size ;
            end
            if(layer_4_loopback_miso_write_size_write) begin
                layer_4_loopback_miso_write_size_reg <= layer_4_loopback_miso_write_size ;
            end
            if(layer_5_loopback_miso_write_size_write) begin
                layer_5_loopback_miso_write_size_reg <= layer_5_loopback_miso_write_size ;
            end
            if(layer_6_loopback_miso_write_size_write) begin
                layer_6_loopback_miso_write_size_reg <= layer_6_loopback_miso_write_size ;
            end
            if(layer_7_loopback_miso_write_size_write) begin
                layer_7_loopback_miso_write_size_reg <= layer_7_loopback_miso_write_size ;
            end
            if(layer_8_loopback_miso_write_size_write) begin
                layer_8_loopback_miso_write_size_reg <= layer_8_loopback_miso_write_size ;
            end
            if(layer_9_loopback_miso_write_size_write) begin
                layer_9_loopback_miso_write_size_reg <= layer_9_loopback_miso_write_size ;
            end
            if(layer_10_loopback_miso_write_size_write) begin
                layer_10_loopback_miso_write_size_reg <= layer_10_loopback_miso_write_size ;
            end
            if(layer_11_loopback_miso_write_size_write) begin
                layer_11_loopback_miso_write_size_reg <= layer_11_loopback_miso_write_size ;
            end
            if(layer_12_loopback_miso_write_size_write) begin
                layer_12_loopback_miso_write_size_reg <= layer_12_loopback_miso_write_size ;
            end
            if(layer_13_loopback_miso_write_size_write) begin
                layer_13_loopback_miso_write_size_reg <= layer_13_loopback_miso_write_size ;
            end
            if(layer_14_loopback_miso_write_size_write) begin
                layer_14_loopback_miso_write_size_reg <= layer_14_loopback_miso_write_size ;
            end
            if(layer_15_loopback_miso_write_size_write) begin
                layer_15_loopback_miso_write_size_reg <= layer_15_loopback_miso_write_size ;
            end
            if(layer_16_loopback_miso_write_size_write) begin
                layer_16_loopback_miso_write_size_reg <= layer_16_loopback_miso_write_size ;
            end
            if(layer_17_loopback_miso_write_size_write) begin
                layer_17_loopback_miso_write_size_reg <= layer_17_loopback_miso_write_size ;
            end
            if(layer_18_loopback_miso_write_size_write) begin
                layer_18_loopback_miso_write_size_reg <= layer_18_loopback_miso_write_size ;
            end
            if(layer_19_loopback_miso_write_size_write) begin
                layer_19_loopback_miso_write_size_reg <= layer_19_loopback_miso_write_size ;
            end
            if(layer_0_loopback_mosi_read_size_write) begin
                layer_0_loopback_mosi_read_size_reg <= layer_0_loopback_mosi_read_size ;
            end
            if(layer_1_loopback_mosi_read_size_write) begin
                layer_1_loopback_mosi_read_size_reg <= layer_1_loopback_mosi_read_size ;
            end
            if(layer_2_loopback_mosi_read_size_write) begin
                layer_2_loopback_mosi_read_size_reg <= layer_2_loopback_mosi_read_size ;
            end
            if(layer_3_loopback_mosi_read_size_write) begin
                layer_3_loopback_mosi_read_size_reg <= layer_3_loopback_mosi_read_size ;
            end
            if(layer_4_loopback_mosi_read_size_write) begin
                layer_4_loopback_mosi_read_size_reg <= layer_4_loopback_mosi_read_size ;
            end
            if(layer_5_loopback_mosi_read_size_write) begin
                layer_5_loopback_mosi_read_size_reg <= layer_5_loopback_mosi_read_size ;
            end
            if(layer_6_loopback_mosi_read_size_write) begin
                layer_6_loopback_mosi_read_size_reg <= layer_6_loopback_mosi_read_size ;
            end
            if(layer_7_loopback_mosi_read_size_write) begin
                layer_7_loopback_mosi_read_size_reg <= layer_7_loopback_mosi_read_size ;
            end
            if(layer_8_loopback_mosi_read_size_write) begin
                layer_8_loopback_mosi_read_size_reg <= layer_8_loopback_mosi_read_size ;
            end
            if(layer_9_loopback_mosi_read_size_write) begin
                layer_9_loopback_mosi_read_size_reg <= layer_9_loopback_mosi_read_size ;
            end
            if(layer_10_loopback_mosi_read_size_write) begin
                layer_10_loopback_mosi_read_size_reg <= layer_10_loopback_mosi_read_size ;
            end
            if(layer_11_loopback_mosi_read_size_write) begin
                layer_11_loopback_mosi_read_size_reg <= layer_11_loopback_mosi_read_size ;
            end
            if(layer_12_loopback_mosi_read_size_write) begin
                layer_12_loopback_mosi_read_size_reg <= layer_12_loopback_mosi_read_size ;
            end
            if(layer_13_loopback_mosi_read_size_write) begin
                layer_13_loopback_mosi_read_size_reg <= layer_13_loopback_mosi_read_size ;
            end
            if(layer_14_loopback_mosi_read_size_write) begin
                layer_14_loopback_mosi_read_size_reg <= layer_14_loopback_mosi_read_size ;
            end
            if(layer_15_loopback_mosi_read_size_write) begin
                layer_15_loopback_mosi_read_size_reg <= layer_15_loopback_mosi_read_size ;
            end
            if(layer_16_loopback_mosi_read_size_write) begin
                layer_16_loopback_mosi_read_size_reg <= layer_16_loopback_mosi_read_size ;
            end
            if(layer_17_loopback_mosi_read_size_write) begin
                layer_17_loopback_mosi_read_size_reg <= layer_17_loopback_mosi_read_size ;
            end
            if(layer_18_loopback_mosi_read_size_write) begin
                layer_18_loopback_mosi_read_size_reg <= layer_18_loopback_mosi_read_size ;
            end
            if(layer_19_loopback_mosi_read_size_write) begin
                layer_19_loopback_mosi_read_size_reg <= layer_19_loopback_mosi_read_size ;
            end
            if(layers_readout_read_size_write) begin
                layers_readout_read_size_reg <= layers_readout_read_size ;
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
            if(!(rfg_write && rfg_address==16'h45) && layer_0_stat_frame_counter_enable) begin
                layer_0_stat_frame_counter_reg <= layer_0_stat_frame_counter_reg + 1 ;
            end
            if(!(rfg_write && rfg_address==16'h49) && layer_1_stat_frame_counter_enable) begin
                layer_1_stat_frame_counter_reg <= layer_1_stat_frame_counter_reg + 1 ;
            end
            if(!(rfg_write && rfg_address==16'h4d) && layer_2_stat_frame_counter_enable) begin
                layer_2_stat_frame_counter_reg <= layer_2_stat_frame_counter_reg + 1 ;
            end
            if(!(rfg_write && rfg_address==16'h51) && layer_3_stat_frame_counter_enable) begin
                layer_3_stat_frame_counter_reg <= layer_3_stat_frame_counter_reg + 1 ;
            end
            if(!(rfg_write && rfg_address==16'h55) && layer_4_stat_frame_counter_enable) begin
                layer_4_stat_frame_counter_reg <= layer_4_stat_frame_counter_reg + 1 ;
            end
            if(!(rfg_write && rfg_address==16'h59) && layer_5_stat_frame_counter_enable) begin
                layer_5_stat_frame_counter_reg <= layer_5_stat_frame_counter_reg + 1 ;
            end
            if(!(rfg_write && rfg_address==16'h5d) && layer_6_stat_frame_counter_enable) begin
                layer_6_stat_frame_counter_reg <= layer_6_stat_frame_counter_reg + 1 ;
            end
            if(!(rfg_write && rfg_address==16'h61) && layer_7_stat_frame_counter_enable) begin
                layer_7_stat_frame_counter_reg <= layer_7_stat_frame_counter_reg + 1 ;
            end
            if(!(rfg_write && rfg_address==16'h65) && layer_8_stat_frame_counter_enable) begin
                layer_8_stat_frame_counter_reg <= layer_8_stat_frame_counter_reg + 1 ;
            end
            if(!(rfg_write && rfg_address==16'h69) && layer_9_stat_frame_counter_enable) begin
                layer_9_stat_frame_counter_reg <= layer_9_stat_frame_counter_reg + 1 ;
            end
            if(!(rfg_write && rfg_address==16'h6d) && layer_10_stat_frame_counter_enable) begin
                layer_10_stat_frame_counter_reg <= layer_10_stat_frame_counter_reg + 1 ;
            end
            if(!(rfg_write && rfg_address==16'h71) && layer_11_stat_frame_counter_enable) begin
                layer_11_stat_frame_counter_reg <= layer_11_stat_frame_counter_reg + 1 ;
            end
            if(!(rfg_write && rfg_address==16'h75) && layer_12_stat_frame_counter_enable) begin
                layer_12_stat_frame_counter_reg <= layer_12_stat_frame_counter_reg + 1 ;
            end
            if(!(rfg_write && rfg_address==16'h79) && layer_13_stat_frame_counter_enable) begin
                layer_13_stat_frame_counter_reg <= layer_13_stat_frame_counter_reg + 1 ;
            end
            if(!(rfg_write && rfg_address==16'h7d) && layer_14_stat_frame_counter_enable) begin
                layer_14_stat_frame_counter_reg <= layer_14_stat_frame_counter_reg + 1 ;
            end
            if(!(rfg_write && rfg_address==16'h81) && layer_15_stat_frame_counter_enable) begin
                layer_15_stat_frame_counter_reg <= layer_15_stat_frame_counter_reg + 1 ;
            end
            if(!(rfg_write && rfg_address==16'h85) && layer_16_stat_frame_counter_enable) begin
                layer_16_stat_frame_counter_reg <= layer_16_stat_frame_counter_reg + 1 ;
            end
            if(!(rfg_write && rfg_address==16'h89) && layer_17_stat_frame_counter_enable) begin
                layer_17_stat_frame_counter_reg <= layer_17_stat_frame_counter_reg + 1 ;
            end
            if(!(rfg_write && rfg_address==16'h8d) && layer_18_stat_frame_counter_enable) begin
                layer_18_stat_frame_counter_reg <= layer_18_stat_frame_counter_reg + 1 ;
            end
            if(!(rfg_write && rfg_address==16'h91) && layer_19_stat_frame_counter_enable) begin
                layer_19_stat_frame_counter_reg <= layer_19_stat_frame_counter_reg + 1 ;
            end
            if(!(rfg_write && rfg_address==16'h95) && layer_0_stat_idle_counter_enable) begin
                layer_0_stat_idle_counter_reg <= layer_0_stat_idle_counter_reg + 1 ;
            end
            if(!(rfg_write && rfg_address==16'h99) && layer_1_stat_idle_counter_enable) begin
                layer_1_stat_idle_counter_reg <= layer_1_stat_idle_counter_reg + 1 ;
            end
            if(!(rfg_write && rfg_address==16'h9d) && layer_2_stat_idle_counter_enable) begin
                layer_2_stat_idle_counter_reg <= layer_2_stat_idle_counter_reg + 1 ;
            end
            if(!(rfg_write && rfg_address==16'ha1) && layer_3_stat_idle_counter_enable) begin
                layer_3_stat_idle_counter_reg <= layer_3_stat_idle_counter_reg + 1 ;
            end
            if(!(rfg_write && rfg_address==16'ha5) && layer_4_stat_idle_counter_enable) begin
                layer_4_stat_idle_counter_reg <= layer_4_stat_idle_counter_reg + 1 ;
            end
            if(!(rfg_write && rfg_address==16'ha9) && layer_5_stat_idle_counter_enable) begin
                layer_5_stat_idle_counter_reg <= layer_5_stat_idle_counter_reg + 1 ;
            end
            if(!(rfg_write && rfg_address==16'had) && layer_6_stat_idle_counter_enable) begin
                layer_6_stat_idle_counter_reg <= layer_6_stat_idle_counter_reg + 1 ;
            end
            if(!(rfg_write && rfg_address==16'hb1) && layer_7_stat_idle_counter_enable) begin
                layer_7_stat_idle_counter_reg <= layer_7_stat_idle_counter_reg + 1 ;
            end
            if(!(rfg_write && rfg_address==16'hb5) && layer_8_stat_idle_counter_enable) begin
                layer_8_stat_idle_counter_reg <= layer_8_stat_idle_counter_reg + 1 ;
            end
            if(!(rfg_write && rfg_address==16'hb9) && layer_9_stat_idle_counter_enable) begin
                layer_9_stat_idle_counter_reg <= layer_9_stat_idle_counter_reg + 1 ;
            end
            if(!(rfg_write && rfg_address==16'hbd) && layer_10_stat_idle_counter_enable) begin
                layer_10_stat_idle_counter_reg <= layer_10_stat_idle_counter_reg + 1 ;
            end
            if(!(rfg_write && rfg_address==16'hc1) && layer_11_stat_idle_counter_enable) begin
                layer_11_stat_idle_counter_reg <= layer_11_stat_idle_counter_reg + 1 ;
            end
            if(!(rfg_write && rfg_address==16'hc5) && layer_12_stat_idle_counter_enable) begin
                layer_12_stat_idle_counter_reg <= layer_12_stat_idle_counter_reg + 1 ;
            end
            if(!(rfg_write && rfg_address==16'hc9) && layer_13_stat_idle_counter_enable) begin
                layer_13_stat_idle_counter_reg <= layer_13_stat_idle_counter_reg + 1 ;
            end
            if(!(rfg_write && rfg_address==16'hcd) && layer_14_stat_idle_counter_enable) begin
                layer_14_stat_idle_counter_reg <= layer_14_stat_idle_counter_reg + 1 ;
            end
            if(!(rfg_write && rfg_address==16'hd1) && layer_15_stat_idle_counter_enable) begin
                layer_15_stat_idle_counter_reg <= layer_15_stat_idle_counter_reg + 1 ;
            end
            if(!(rfg_write && rfg_address==16'hd5) && layer_16_stat_idle_counter_enable) begin
                layer_16_stat_idle_counter_reg <= layer_16_stat_idle_counter_reg + 1 ;
            end
            if(!(rfg_write && rfg_address==16'hd9) && layer_17_stat_idle_counter_enable) begin
                layer_17_stat_idle_counter_reg <= layer_17_stat_idle_counter_reg + 1 ;
            end
            if(!(rfg_write && rfg_address==16'hdd) && layer_18_stat_idle_counter_enable) begin
                layer_18_stat_idle_counter_reg <= layer_18_stat_idle_counter_reg + 1 ;
            end
            if(!(rfg_write && rfg_address==16'he1) && layer_19_stat_idle_counter_enable) begin
                layer_19_stat_idle_counter_reg <= layer_19_stat_idle_counter_reg + 1 ;
            end
            if(!(rfg_write && rfg_address==16'h212) && layers_cfg_frame_tag_counter_trigger_enable) begin
                layers_cfg_frame_tag_counter_trigger_reg <= layers_cfg_frame_tag_counter_trigger_up ? layers_cfg_frame_tag_counter_trigger_reg + 1 : layers_cfg_frame_tag_counter_trigger_reg -1 ;
            end
            if(( (layers_cfg_frame_tag_counter_trigger_up && layers_cfg_frame_tag_counter_trigger_reg == (layers_cfg_frame_tag_counter_trigger_match_reg - 1)) || (!layers_cfg_frame_tag_counter_trigger_up && layers_cfg_frame_tag_counter_trigger_reg==1 )) && layers_cfg_frame_tag_counter_trigger_enable) begin
                layers_cfg_frame_tag_counter_trigger_interrupt <= 1'b1;
                layers_cfg_frame_tag_counter_trigger_up <= !layers_cfg_frame_tag_counter_trigger_up;
            end else begin
                layers_cfg_frame_tag_counter_trigger_interrupt <= 1'b0;
            end
            if(!(rfg_write && rfg_address==16'h216) && layers_cfg_frame_tag_counter_enable) begin
                layers_cfg_frame_tag_counter_reg <= layers_cfg_frame_tag_counter_reg + 1 ;
            end
        end
    end
    
    
    // Read for FIFO Slave
    assign hk_adc_miso_fifo_s_axis_tready = rfg_read && rfg_address==16'h16;
    assign layer_0_loopback_mosi_s_axis_tready = rfg_read && rfg_address==16'h1ad;
    assign layer_1_loopback_mosi_s_axis_tready = rfg_read && rfg_address==16'h1b2;
    assign layer_2_loopback_mosi_s_axis_tready = rfg_read && rfg_address==16'h1b7;
    assign layer_3_loopback_mosi_s_axis_tready = rfg_read && rfg_address==16'h1bc;
    assign layer_4_loopback_mosi_s_axis_tready = rfg_read && rfg_address==16'h1c1;
    assign layer_5_loopback_mosi_s_axis_tready = rfg_read && rfg_address==16'h1c6;
    assign layer_6_loopback_mosi_s_axis_tready = rfg_read && rfg_address==16'h1cb;
    assign layer_7_loopback_mosi_s_axis_tready = rfg_read && rfg_address==16'h1d0;
    assign layer_8_loopback_mosi_s_axis_tready = rfg_read && rfg_address==16'h1d5;
    assign layer_9_loopback_mosi_s_axis_tready = rfg_read && rfg_address==16'h1da;
    assign layer_10_loopback_mosi_s_axis_tready = rfg_read && rfg_address==16'h1df;
    assign layer_11_loopback_mosi_s_axis_tready = rfg_read && rfg_address==16'h1e4;
    assign layer_12_loopback_mosi_s_axis_tready = rfg_read && rfg_address==16'h1e9;
    assign layer_13_loopback_mosi_s_axis_tready = rfg_read && rfg_address==16'h1ee;
    assign layer_14_loopback_mosi_s_axis_tready = rfg_read && rfg_address==16'h1f3;
    assign layer_15_loopback_mosi_s_axis_tready = rfg_read && rfg_address==16'h1f8;
    assign layer_16_loopback_mosi_s_axis_tready = rfg_read && rfg_address==16'h1fd;
    assign layer_17_loopback_mosi_s_axis_tready = rfg_read && rfg_address==16'h202;
    assign layer_18_loopback_mosi_s_axis_tready = rfg_read && rfg_address==16'h207;
    assign layer_19_loopback_mosi_s_axis_tready = rfg_read && rfg_address==16'h20c;
    assign layers_readout_s_axis_tready = rfg_read && rfg_address==16'h220;
    
    
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
                    rfg_read_value <= spi_layers_ckdivider_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1c}: begin
                    rfg_read_value <= spi_hk_ckdivider_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1d}: begin
                    rfg_read_value <= layer_0_cfg_ctrl_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1e}: begin
                    rfg_read_value <= layer_1_cfg_ctrl_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1f}: begin
                    rfg_read_value <= layer_2_cfg_ctrl_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h20}: begin
                    rfg_read_value <= layer_3_cfg_ctrl_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h21}: begin
                    rfg_read_value <= layer_4_cfg_ctrl_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h22}: begin
                    rfg_read_value <= layer_5_cfg_ctrl_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h23}: begin
                    rfg_read_value <= layer_6_cfg_ctrl_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h24}: begin
                    rfg_read_value <= layer_7_cfg_ctrl_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h25}: begin
                    rfg_read_value <= layer_8_cfg_ctrl_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h26}: begin
                    rfg_read_value <= layer_9_cfg_ctrl_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h27}: begin
                    rfg_read_value <= layer_10_cfg_ctrl_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h28}: begin
                    rfg_read_value <= layer_11_cfg_ctrl_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h29}: begin
                    rfg_read_value <= layer_12_cfg_ctrl_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h2a}: begin
                    rfg_read_value <= layer_13_cfg_ctrl_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h2b}: begin
                    rfg_read_value <= layer_14_cfg_ctrl_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h2c}: begin
                    rfg_read_value <= layer_15_cfg_ctrl_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h2d}: begin
                    rfg_read_value <= layer_16_cfg_ctrl_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h2e}: begin
                    rfg_read_value <= layer_17_cfg_ctrl_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h2f}: begin
                    rfg_read_value <= layer_18_cfg_ctrl_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h30}: begin
                    rfg_read_value <= layer_19_cfg_ctrl_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h31}: begin
                    rfg_read_value <= layer_0_status_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h32}: begin
                    rfg_read_value <= layer_1_status_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h33}: begin
                    rfg_read_value <= layer_2_status_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h34}: begin
                    rfg_read_value <= layer_3_status_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h35}: begin
                    rfg_read_value <= layer_4_status_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h36}: begin
                    rfg_read_value <= layer_5_status_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h37}: begin
                    rfg_read_value <= layer_6_status_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h38}: begin
                    rfg_read_value <= layer_7_status_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h39}: begin
                    rfg_read_value <= layer_8_status_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h3a}: begin
                    rfg_read_value <= layer_9_status_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h3b}: begin
                    rfg_read_value <= layer_10_status_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h3c}: begin
                    rfg_read_value <= layer_11_status_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h3d}: begin
                    rfg_read_value <= layer_12_status_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h3e}: begin
                    rfg_read_value <= layer_13_status_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h3f}: begin
                    rfg_read_value <= layer_14_status_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h40}: begin
                    rfg_read_value <= layer_15_status_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h41}: begin
                    rfg_read_value <= layer_16_status_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h42}: begin
                    rfg_read_value <= layer_17_status_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h43}: begin
                    rfg_read_value <= layer_18_status_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h44}: begin
                    rfg_read_value <= layer_19_status_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h45}: begin
                    rfg_read_value <= layer_0_stat_frame_counter_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h46}: begin
                    rfg_read_value <= layer_0_stat_frame_counter_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h47}: begin
                    rfg_read_value <= layer_0_stat_frame_counter_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h48}: begin
                    rfg_read_value <= layer_0_stat_frame_counter_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h49}: begin
                    rfg_read_value <= layer_1_stat_frame_counter_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h4a}: begin
                    rfg_read_value <= layer_1_stat_frame_counter_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h4b}: begin
                    rfg_read_value <= layer_1_stat_frame_counter_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h4c}: begin
                    rfg_read_value <= layer_1_stat_frame_counter_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h4d}: begin
                    rfg_read_value <= layer_2_stat_frame_counter_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h4e}: begin
                    rfg_read_value <= layer_2_stat_frame_counter_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h4f}: begin
                    rfg_read_value <= layer_2_stat_frame_counter_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h50}: begin
                    rfg_read_value <= layer_2_stat_frame_counter_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h51}: begin
                    rfg_read_value <= layer_3_stat_frame_counter_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h52}: begin
                    rfg_read_value <= layer_3_stat_frame_counter_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h53}: begin
                    rfg_read_value <= layer_3_stat_frame_counter_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h54}: begin
                    rfg_read_value <= layer_3_stat_frame_counter_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h55}: begin
                    rfg_read_value <= layer_4_stat_frame_counter_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h56}: begin
                    rfg_read_value <= layer_4_stat_frame_counter_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h57}: begin
                    rfg_read_value <= layer_4_stat_frame_counter_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h58}: begin
                    rfg_read_value <= layer_4_stat_frame_counter_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h59}: begin
                    rfg_read_value <= layer_5_stat_frame_counter_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h5a}: begin
                    rfg_read_value <= layer_5_stat_frame_counter_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h5b}: begin
                    rfg_read_value <= layer_5_stat_frame_counter_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h5c}: begin
                    rfg_read_value <= layer_5_stat_frame_counter_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h5d}: begin
                    rfg_read_value <= layer_6_stat_frame_counter_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h5e}: begin
                    rfg_read_value <= layer_6_stat_frame_counter_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h5f}: begin
                    rfg_read_value <= layer_6_stat_frame_counter_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h60}: begin
                    rfg_read_value <= layer_6_stat_frame_counter_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h61}: begin
                    rfg_read_value <= layer_7_stat_frame_counter_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h62}: begin
                    rfg_read_value <= layer_7_stat_frame_counter_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h63}: begin
                    rfg_read_value <= layer_7_stat_frame_counter_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h64}: begin
                    rfg_read_value <= layer_7_stat_frame_counter_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h65}: begin
                    rfg_read_value <= layer_8_stat_frame_counter_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h66}: begin
                    rfg_read_value <= layer_8_stat_frame_counter_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h67}: begin
                    rfg_read_value <= layer_8_stat_frame_counter_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h68}: begin
                    rfg_read_value <= layer_8_stat_frame_counter_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h69}: begin
                    rfg_read_value <= layer_9_stat_frame_counter_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h6a}: begin
                    rfg_read_value <= layer_9_stat_frame_counter_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h6b}: begin
                    rfg_read_value <= layer_9_stat_frame_counter_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h6c}: begin
                    rfg_read_value <= layer_9_stat_frame_counter_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h6d}: begin
                    rfg_read_value <= layer_10_stat_frame_counter_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h6e}: begin
                    rfg_read_value <= layer_10_stat_frame_counter_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h6f}: begin
                    rfg_read_value <= layer_10_stat_frame_counter_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h70}: begin
                    rfg_read_value <= layer_10_stat_frame_counter_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h71}: begin
                    rfg_read_value <= layer_11_stat_frame_counter_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h72}: begin
                    rfg_read_value <= layer_11_stat_frame_counter_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h73}: begin
                    rfg_read_value <= layer_11_stat_frame_counter_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h74}: begin
                    rfg_read_value <= layer_11_stat_frame_counter_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h75}: begin
                    rfg_read_value <= layer_12_stat_frame_counter_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h76}: begin
                    rfg_read_value <= layer_12_stat_frame_counter_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h77}: begin
                    rfg_read_value <= layer_12_stat_frame_counter_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h78}: begin
                    rfg_read_value <= layer_12_stat_frame_counter_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h79}: begin
                    rfg_read_value <= layer_13_stat_frame_counter_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h7a}: begin
                    rfg_read_value <= layer_13_stat_frame_counter_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h7b}: begin
                    rfg_read_value <= layer_13_stat_frame_counter_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h7c}: begin
                    rfg_read_value <= layer_13_stat_frame_counter_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h7d}: begin
                    rfg_read_value <= layer_14_stat_frame_counter_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h7e}: begin
                    rfg_read_value <= layer_14_stat_frame_counter_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h7f}: begin
                    rfg_read_value <= layer_14_stat_frame_counter_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h80}: begin
                    rfg_read_value <= layer_14_stat_frame_counter_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h81}: begin
                    rfg_read_value <= layer_15_stat_frame_counter_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h82}: begin
                    rfg_read_value <= layer_15_stat_frame_counter_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h83}: begin
                    rfg_read_value <= layer_15_stat_frame_counter_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h84}: begin
                    rfg_read_value <= layer_15_stat_frame_counter_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h85}: begin
                    rfg_read_value <= layer_16_stat_frame_counter_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h86}: begin
                    rfg_read_value <= layer_16_stat_frame_counter_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h87}: begin
                    rfg_read_value <= layer_16_stat_frame_counter_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h88}: begin
                    rfg_read_value <= layer_16_stat_frame_counter_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h89}: begin
                    rfg_read_value <= layer_17_stat_frame_counter_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h8a}: begin
                    rfg_read_value <= layer_17_stat_frame_counter_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h8b}: begin
                    rfg_read_value <= layer_17_stat_frame_counter_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h8c}: begin
                    rfg_read_value <= layer_17_stat_frame_counter_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h8d}: begin
                    rfg_read_value <= layer_18_stat_frame_counter_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h8e}: begin
                    rfg_read_value <= layer_18_stat_frame_counter_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h8f}: begin
                    rfg_read_value <= layer_18_stat_frame_counter_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h90}: begin
                    rfg_read_value <= layer_18_stat_frame_counter_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h91}: begin
                    rfg_read_value <= layer_19_stat_frame_counter_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h92}: begin
                    rfg_read_value <= layer_19_stat_frame_counter_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h93}: begin
                    rfg_read_value <= layer_19_stat_frame_counter_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h94}: begin
                    rfg_read_value <= layer_19_stat_frame_counter_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h95}: begin
                    rfg_read_value <= layer_0_stat_idle_counter_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h96}: begin
                    rfg_read_value <= layer_0_stat_idle_counter_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h97}: begin
                    rfg_read_value <= layer_0_stat_idle_counter_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h98}: begin
                    rfg_read_value <= layer_0_stat_idle_counter_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h99}: begin
                    rfg_read_value <= layer_1_stat_idle_counter_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h9a}: begin
                    rfg_read_value <= layer_1_stat_idle_counter_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h9b}: begin
                    rfg_read_value <= layer_1_stat_idle_counter_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h9c}: begin
                    rfg_read_value <= layer_1_stat_idle_counter_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h9d}: begin
                    rfg_read_value <= layer_2_stat_idle_counter_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h9e}: begin
                    rfg_read_value <= layer_2_stat_idle_counter_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h9f}: begin
                    rfg_read_value <= layer_2_stat_idle_counter_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'ha0}: begin
                    rfg_read_value <= layer_2_stat_idle_counter_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'ha1}: begin
                    rfg_read_value <= layer_3_stat_idle_counter_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'ha2}: begin
                    rfg_read_value <= layer_3_stat_idle_counter_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'ha3}: begin
                    rfg_read_value <= layer_3_stat_idle_counter_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'ha4}: begin
                    rfg_read_value <= layer_3_stat_idle_counter_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'ha5}: begin
                    rfg_read_value <= layer_4_stat_idle_counter_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'ha6}: begin
                    rfg_read_value <= layer_4_stat_idle_counter_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'ha7}: begin
                    rfg_read_value <= layer_4_stat_idle_counter_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'ha8}: begin
                    rfg_read_value <= layer_4_stat_idle_counter_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'ha9}: begin
                    rfg_read_value <= layer_5_stat_idle_counter_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'haa}: begin
                    rfg_read_value <= layer_5_stat_idle_counter_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'hab}: begin
                    rfg_read_value <= layer_5_stat_idle_counter_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'hac}: begin
                    rfg_read_value <= layer_5_stat_idle_counter_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'had}: begin
                    rfg_read_value <= layer_6_stat_idle_counter_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'hae}: begin
                    rfg_read_value <= layer_6_stat_idle_counter_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'haf}: begin
                    rfg_read_value <= layer_6_stat_idle_counter_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'hb0}: begin
                    rfg_read_value <= layer_6_stat_idle_counter_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'hb1}: begin
                    rfg_read_value <= layer_7_stat_idle_counter_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'hb2}: begin
                    rfg_read_value <= layer_7_stat_idle_counter_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'hb3}: begin
                    rfg_read_value <= layer_7_stat_idle_counter_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'hb4}: begin
                    rfg_read_value <= layer_7_stat_idle_counter_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'hb5}: begin
                    rfg_read_value <= layer_8_stat_idle_counter_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'hb6}: begin
                    rfg_read_value <= layer_8_stat_idle_counter_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'hb7}: begin
                    rfg_read_value <= layer_8_stat_idle_counter_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'hb8}: begin
                    rfg_read_value <= layer_8_stat_idle_counter_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'hb9}: begin
                    rfg_read_value <= layer_9_stat_idle_counter_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'hba}: begin
                    rfg_read_value <= layer_9_stat_idle_counter_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'hbb}: begin
                    rfg_read_value <= layer_9_stat_idle_counter_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'hbc}: begin
                    rfg_read_value <= layer_9_stat_idle_counter_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'hbd}: begin
                    rfg_read_value <= layer_10_stat_idle_counter_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'hbe}: begin
                    rfg_read_value <= layer_10_stat_idle_counter_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'hbf}: begin
                    rfg_read_value <= layer_10_stat_idle_counter_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'hc0}: begin
                    rfg_read_value <= layer_10_stat_idle_counter_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'hc1}: begin
                    rfg_read_value <= layer_11_stat_idle_counter_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'hc2}: begin
                    rfg_read_value <= layer_11_stat_idle_counter_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'hc3}: begin
                    rfg_read_value <= layer_11_stat_idle_counter_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'hc4}: begin
                    rfg_read_value <= layer_11_stat_idle_counter_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'hc5}: begin
                    rfg_read_value <= layer_12_stat_idle_counter_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'hc6}: begin
                    rfg_read_value <= layer_12_stat_idle_counter_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'hc7}: begin
                    rfg_read_value <= layer_12_stat_idle_counter_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'hc8}: begin
                    rfg_read_value <= layer_12_stat_idle_counter_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'hc9}: begin
                    rfg_read_value <= layer_13_stat_idle_counter_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'hca}: begin
                    rfg_read_value <= layer_13_stat_idle_counter_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'hcb}: begin
                    rfg_read_value <= layer_13_stat_idle_counter_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'hcc}: begin
                    rfg_read_value <= layer_13_stat_idle_counter_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'hcd}: begin
                    rfg_read_value <= layer_14_stat_idle_counter_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'hce}: begin
                    rfg_read_value <= layer_14_stat_idle_counter_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'hcf}: begin
                    rfg_read_value <= layer_14_stat_idle_counter_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'hd0}: begin
                    rfg_read_value <= layer_14_stat_idle_counter_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'hd1}: begin
                    rfg_read_value <= layer_15_stat_idle_counter_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'hd2}: begin
                    rfg_read_value <= layer_15_stat_idle_counter_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'hd3}: begin
                    rfg_read_value <= layer_15_stat_idle_counter_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'hd4}: begin
                    rfg_read_value <= layer_15_stat_idle_counter_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'hd5}: begin
                    rfg_read_value <= layer_16_stat_idle_counter_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'hd6}: begin
                    rfg_read_value <= layer_16_stat_idle_counter_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'hd7}: begin
                    rfg_read_value <= layer_16_stat_idle_counter_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'hd8}: begin
                    rfg_read_value <= layer_16_stat_idle_counter_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'hd9}: begin
                    rfg_read_value <= layer_17_stat_idle_counter_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'hda}: begin
                    rfg_read_value <= layer_17_stat_idle_counter_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'hdb}: begin
                    rfg_read_value <= layer_17_stat_idle_counter_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'hdc}: begin
                    rfg_read_value <= layer_17_stat_idle_counter_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'hdd}: begin
                    rfg_read_value <= layer_18_stat_idle_counter_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'hde}: begin
                    rfg_read_value <= layer_18_stat_idle_counter_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'hdf}: begin
                    rfg_read_value <= layer_18_stat_idle_counter_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'he0}: begin
                    rfg_read_value <= layer_18_stat_idle_counter_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'he1}: begin
                    rfg_read_value <= layer_19_stat_idle_counter_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'he2}: begin
                    rfg_read_value <= layer_19_stat_idle_counter_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'he3}: begin
                    rfg_read_value <= layer_19_stat_idle_counter_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'he4}: begin
                    rfg_read_value <= layer_19_stat_idle_counter_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'he6}: begin
                    rfg_read_value <= layer_0_mosi_write_size_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'he7}: begin
                    rfg_read_value <= layer_0_mosi_write_size_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'he8}: begin
                    rfg_read_value <= layer_0_mosi_write_size_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'he9}: begin
                    rfg_read_value <= layer_0_mosi_write_size_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'heb}: begin
                    rfg_read_value <= layer_1_mosi_write_size_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'hec}: begin
                    rfg_read_value <= layer_1_mosi_write_size_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'hed}: begin
                    rfg_read_value <= layer_1_mosi_write_size_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'hee}: begin
                    rfg_read_value <= layer_1_mosi_write_size_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'hf0}: begin
                    rfg_read_value <= layer_2_mosi_write_size_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'hf1}: begin
                    rfg_read_value <= layer_2_mosi_write_size_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'hf2}: begin
                    rfg_read_value <= layer_2_mosi_write_size_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'hf3}: begin
                    rfg_read_value <= layer_2_mosi_write_size_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'hf5}: begin
                    rfg_read_value <= layer_3_mosi_write_size_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'hf6}: begin
                    rfg_read_value <= layer_3_mosi_write_size_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'hf7}: begin
                    rfg_read_value <= layer_3_mosi_write_size_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'hf8}: begin
                    rfg_read_value <= layer_3_mosi_write_size_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'hfa}: begin
                    rfg_read_value <= layer_4_mosi_write_size_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'hfb}: begin
                    rfg_read_value <= layer_4_mosi_write_size_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'hfc}: begin
                    rfg_read_value <= layer_4_mosi_write_size_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'hfd}: begin
                    rfg_read_value <= layer_4_mosi_write_size_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'hff}: begin
                    rfg_read_value <= layer_5_mosi_write_size_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h100}: begin
                    rfg_read_value <= layer_5_mosi_write_size_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h101}: begin
                    rfg_read_value <= layer_5_mosi_write_size_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h102}: begin
                    rfg_read_value <= layer_5_mosi_write_size_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h104}: begin
                    rfg_read_value <= layer_6_mosi_write_size_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h105}: begin
                    rfg_read_value <= layer_6_mosi_write_size_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h106}: begin
                    rfg_read_value <= layer_6_mosi_write_size_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h107}: begin
                    rfg_read_value <= layer_6_mosi_write_size_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h109}: begin
                    rfg_read_value <= layer_7_mosi_write_size_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h10a}: begin
                    rfg_read_value <= layer_7_mosi_write_size_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h10b}: begin
                    rfg_read_value <= layer_7_mosi_write_size_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h10c}: begin
                    rfg_read_value <= layer_7_mosi_write_size_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h10e}: begin
                    rfg_read_value <= layer_8_mosi_write_size_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h10f}: begin
                    rfg_read_value <= layer_8_mosi_write_size_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h110}: begin
                    rfg_read_value <= layer_8_mosi_write_size_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h111}: begin
                    rfg_read_value <= layer_8_mosi_write_size_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h113}: begin
                    rfg_read_value <= layer_9_mosi_write_size_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h114}: begin
                    rfg_read_value <= layer_9_mosi_write_size_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h115}: begin
                    rfg_read_value <= layer_9_mosi_write_size_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h116}: begin
                    rfg_read_value <= layer_9_mosi_write_size_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h118}: begin
                    rfg_read_value <= layer_10_mosi_write_size_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h119}: begin
                    rfg_read_value <= layer_10_mosi_write_size_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h11a}: begin
                    rfg_read_value <= layer_10_mosi_write_size_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h11b}: begin
                    rfg_read_value <= layer_10_mosi_write_size_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h11d}: begin
                    rfg_read_value <= layer_11_mosi_write_size_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h11e}: begin
                    rfg_read_value <= layer_11_mosi_write_size_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h11f}: begin
                    rfg_read_value <= layer_11_mosi_write_size_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h120}: begin
                    rfg_read_value <= layer_11_mosi_write_size_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h122}: begin
                    rfg_read_value <= layer_12_mosi_write_size_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h123}: begin
                    rfg_read_value <= layer_12_mosi_write_size_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h124}: begin
                    rfg_read_value <= layer_12_mosi_write_size_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h125}: begin
                    rfg_read_value <= layer_12_mosi_write_size_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h127}: begin
                    rfg_read_value <= layer_13_mosi_write_size_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h128}: begin
                    rfg_read_value <= layer_13_mosi_write_size_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h129}: begin
                    rfg_read_value <= layer_13_mosi_write_size_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h12a}: begin
                    rfg_read_value <= layer_13_mosi_write_size_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h12c}: begin
                    rfg_read_value <= layer_14_mosi_write_size_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h12d}: begin
                    rfg_read_value <= layer_14_mosi_write_size_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h12e}: begin
                    rfg_read_value <= layer_14_mosi_write_size_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h12f}: begin
                    rfg_read_value <= layer_14_mosi_write_size_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h131}: begin
                    rfg_read_value <= layer_15_mosi_write_size_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h132}: begin
                    rfg_read_value <= layer_15_mosi_write_size_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h133}: begin
                    rfg_read_value <= layer_15_mosi_write_size_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h134}: begin
                    rfg_read_value <= layer_15_mosi_write_size_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h136}: begin
                    rfg_read_value <= layer_16_mosi_write_size_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h137}: begin
                    rfg_read_value <= layer_16_mosi_write_size_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h138}: begin
                    rfg_read_value <= layer_16_mosi_write_size_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h139}: begin
                    rfg_read_value <= layer_16_mosi_write_size_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h13b}: begin
                    rfg_read_value <= layer_17_mosi_write_size_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h13c}: begin
                    rfg_read_value <= layer_17_mosi_write_size_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h13d}: begin
                    rfg_read_value <= layer_17_mosi_write_size_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h13e}: begin
                    rfg_read_value <= layer_17_mosi_write_size_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h140}: begin
                    rfg_read_value <= layer_18_mosi_write_size_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h141}: begin
                    rfg_read_value <= layer_18_mosi_write_size_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h142}: begin
                    rfg_read_value <= layer_18_mosi_write_size_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h143}: begin
                    rfg_read_value <= layer_18_mosi_write_size_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h145}: begin
                    rfg_read_value <= layer_19_mosi_write_size_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h146}: begin
                    rfg_read_value <= layer_19_mosi_write_size_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h147}: begin
                    rfg_read_value <= layer_19_mosi_write_size_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h148}: begin
                    rfg_read_value <= layer_19_mosi_write_size_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h14a}: begin
                    rfg_read_value <= layer_0_loopback_miso_write_size_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h14b}: begin
                    rfg_read_value <= layer_0_loopback_miso_write_size_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h14c}: begin
                    rfg_read_value <= layer_0_loopback_miso_write_size_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h14d}: begin
                    rfg_read_value <= layer_0_loopback_miso_write_size_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h14f}: begin
                    rfg_read_value <= layer_1_loopback_miso_write_size_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h150}: begin
                    rfg_read_value <= layer_1_loopback_miso_write_size_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h151}: begin
                    rfg_read_value <= layer_1_loopback_miso_write_size_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h152}: begin
                    rfg_read_value <= layer_1_loopback_miso_write_size_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h154}: begin
                    rfg_read_value <= layer_2_loopback_miso_write_size_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h155}: begin
                    rfg_read_value <= layer_2_loopback_miso_write_size_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h156}: begin
                    rfg_read_value <= layer_2_loopback_miso_write_size_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h157}: begin
                    rfg_read_value <= layer_2_loopback_miso_write_size_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h159}: begin
                    rfg_read_value <= layer_3_loopback_miso_write_size_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h15a}: begin
                    rfg_read_value <= layer_3_loopback_miso_write_size_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h15b}: begin
                    rfg_read_value <= layer_3_loopback_miso_write_size_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h15c}: begin
                    rfg_read_value <= layer_3_loopback_miso_write_size_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h15e}: begin
                    rfg_read_value <= layer_4_loopback_miso_write_size_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h15f}: begin
                    rfg_read_value <= layer_4_loopback_miso_write_size_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h160}: begin
                    rfg_read_value <= layer_4_loopback_miso_write_size_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h161}: begin
                    rfg_read_value <= layer_4_loopback_miso_write_size_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h163}: begin
                    rfg_read_value <= layer_5_loopback_miso_write_size_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h164}: begin
                    rfg_read_value <= layer_5_loopback_miso_write_size_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h165}: begin
                    rfg_read_value <= layer_5_loopback_miso_write_size_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h166}: begin
                    rfg_read_value <= layer_5_loopback_miso_write_size_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h168}: begin
                    rfg_read_value <= layer_6_loopback_miso_write_size_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h169}: begin
                    rfg_read_value <= layer_6_loopback_miso_write_size_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h16a}: begin
                    rfg_read_value <= layer_6_loopback_miso_write_size_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h16b}: begin
                    rfg_read_value <= layer_6_loopback_miso_write_size_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h16d}: begin
                    rfg_read_value <= layer_7_loopback_miso_write_size_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h16e}: begin
                    rfg_read_value <= layer_7_loopback_miso_write_size_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h16f}: begin
                    rfg_read_value <= layer_7_loopback_miso_write_size_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h170}: begin
                    rfg_read_value <= layer_7_loopback_miso_write_size_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h172}: begin
                    rfg_read_value <= layer_8_loopback_miso_write_size_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h173}: begin
                    rfg_read_value <= layer_8_loopback_miso_write_size_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h174}: begin
                    rfg_read_value <= layer_8_loopback_miso_write_size_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h175}: begin
                    rfg_read_value <= layer_8_loopback_miso_write_size_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h177}: begin
                    rfg_read_value <= layer_9_loopback_miso_write_size_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h178}: begin
                    rfg_read_value <= layer_9_loopback_miso_write_size_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h179}: begin
                    rfg_read_value <= layer_9_loopback_miso_write_size_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h17a}: begin
                    rfg_read_value <= layer_9_loopback_miso_write_size_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h17c}: begin
                    rfg_read_value <= layer_10_loopback_miso_write_size_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h17d}: begin
                    rfg_read_value <= layer_10_loopback_miso_write_size_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h17e}: begin
                    rfg_read_value <= layer_10_loopback_miso_write_size_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h17f}: begin
                    rfg_read_value <= layer_10_loopback_miso_write_size_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h181}: begin
                    rfg_read_value <= layer_11_loopback_miso_write_size_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h182}: begin
                    rfg_read_value <= layer_11_loopback_miso_write_size_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h183}: begin
                    rfg_read_value <= layer_11_loopback_miso_write_size_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h184}: begin
                    rfg_read_value <= layer_11_loopback_miso_write_size_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h186}: begin
                    rfg_read_value <= layer_12_loopback_miso_write_size_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h187}: begin
                    rfg_read_value <= layer_12_loopback_miso_write_size_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h188}: begin
                    rfg_read_value <= layer_12_loopback_miso_write_size_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h189}: begin
                    rfg_read_value <= layer_12_loopback_miso_write_size_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h18b}: begin
                    rfg_read_value <= layer_13_loopback_miso_write_size_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h18c}: begin
                    rfg_read_value <= layer_13_loopback_miso_write_size_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h18d}: begin
                    rfg_read_value <= layer_13_loopback_miso_write_size_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h18e}: begin
                    rfg_read_value <= layer_13_loopback_miso_write_size_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h190}: begin
                    rfg_read_value <= layer_14_loopback_miso_write_size_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h191}: begin
                    rfg_read_value <= layer_14_loopback_miso_write_size_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h192}: begin
                    rfg_read_value <= layer_14_loopback_miso_write_size_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h193}: begin
                    rfg_read_value <= layer_14_loopback_miso_write_size_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h195}: begin
                    rfg_read_value <= layer_15_loopback_miso_write_size_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h196}: begin
                    rfg_read_value <= layer_15_loopback_miso_write_size_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h197}: begin
                    rfg_read_value <= layer_15_loopback_miso_write_size_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h198}: begin
                    rfg_read_value <= layer_15_loopback_miso_write_size_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h19a}: begin
                    rfg_read_value <= layer_16_loopback_miso_write_size_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h19b}: begin
                    rfg_read_value <= layer_16_loopback_miso_write_size_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h19c}: begin
                    rfg_read_value <= layer_16_loopback_miso_write_size_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h19d}: begin
                    rfg_read_value <= layer_16_loopback_miso_write_size_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h19f}: begin
                    rfg_read_value <= layer_17_loopback_miso_write_size_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1a0}: begin
                    rfg_read_value <= layer_17_loopback_miso_write_size_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1a1}: begin
                    rfg_read_value <= layer_17_loopback_miso_write_size_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1a2}: begin
                    rfg_read_value <= layer_17_loopback_miso_write_size_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1a4}: begin
                    rfg_read_value <= layer_18_loopback_miso_write_size_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1a5}: begin
                    rfg_read_value <= layer_18_loopback_miso_write_size_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1a6}: begin
                    rfg_read_value <= layer_18_loopback_miso_write_size_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1a7}: begin
                    rfg_read_value <= layer_18_loopback_miso_write_size_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1a9}: begin
                    rfg_read_value <= layer_19_loopback_miso_write_size_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1aa}: begin
                    rfg_read_value <= layer_19_loopback_miso_write_size_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1ab}: begin
                    rfg_read_value <= layer_19_loopback_miso_write_size_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1ac}: begin
                    rfg_read_value <= layer_19_loopback_miso_write_size_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1ad}: begin
                    rfg_read_value <= layer_0_loopback_mosi_s_axis_tvalid ? layer_0_loopback_mosi_s_axis_tdata : 8'hff;
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1ae}: begin
                    rfg_read_value <= layer_0_loopback_mosi_read_size_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1af}: begin
                    rfg_read_value <= layer_0_loopback_mosi_read_size_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1b0}: begin
                    rfg_read_value <= layer_0_loopback_mosi_read_size_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1b1}: begin
                    rfg_read_value <= layer_0_loopback_mosi_read_size_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1b2}: begin
                    rfg_read_value <= layer_1_loopback_mosi_s_axis_tvalid ? layer_1_loopback_mosi_s_axis_tdata : 8'hff;
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1b3}: begin
                    rfg_read_value <= layer_1_loopback_mosi_read_size_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1b4}: begin
                    rfg_read_value <= layer_1_loopback_mosi_read_size_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1b5}: begin
                    rfg_read_value <= layer_1_loopback_mosi_read_size_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1b6}: begin
                    rfg_read_value <= layer_1_loopback_mosi_read_size_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1b7}: begin
                    rfg_read_value <= layer_2_loopback_mosi_s_axis_tvalid ? layer_2_loopback_mosi_s_axis_tdata : 8'hff;
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1b8}: begin
                    rfg_read_value <= layer_2_loopback_mosi_read_size_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1b9}: begin
                    rfg_read_value <= layer_2_loopback_mosi_read_size_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1ba}: begin
                    rfg_read_value <= layer_2_loopback_mosi_read_size_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1bb}: begin
                    rfg_read_value <= layer_2_loopback_mosi_read_size_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1bc}: begin
                    rfg_read_value <= layer_3_loopback_mosi_s_axis_tvalid ? layer_3_loopback_mosi_s_axis_tdata : 8'hff;
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1bd}: begin
                    rfg_read_value <= layer_3_loopback_mosi_read_size_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1be}: begin
                    rfg_read_value <= layer_3_loopback_mosi_read_size_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1bf}: begin
                    rfg_read_value <= layer_3_loopback_mosi_read_size_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1c0}: begin
                    rfg_read_value <= layer_3_loopback_mosi_read_size_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1c1}: begin
                    rfg_read_value <= layer_4_loopback_mosi_s_axis_tvalid ? layer_4_loopback_mosi_s_axis_tdata : 8'hff;
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1c2}: begin
                    rfg_read_value <= layer_4_loopback_mosi_read_size_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1c3}: begin
                    rfg_read_value <= layer_4_loopback_mosi_read_size_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1c4}: begin
                    rfg_read_value <= layer_4_loopback_mosi_read_size_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1c5}: begin
                    rfg_read_value <= layer_4_loopback_mosi_read_size_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1c6}: begin
                    rfg_read_value <= layer_5_loopback_mosi_s_axis_tvalid ? layer_5_loopback_mosi_s_axis_tdata : 8'hff;
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1c7}: begin
                    rfg_read_value <= layer_5_loopback_mosi_read_size_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1c8}: begin
                    rfg_read_value <= layer_5_loopback_mosi_read_size_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1c9}: begin
                    rfg_read_value <= layer_5_loopback_mosi_read_size_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1ca}: begin
                    rfg_read_value <= layer_5_loopback_mosi_read_size_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1cb}: begin
                    rfg_read_value <= layer_6_loopback_mosi_s_axis_tvalid ? layer_6_loopback_mosi_s_axis_tdata : 8'hff;
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1cc}: begin
                    rfg_read_value <= layer_6_loopback_mosi_read_size_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1cd}: begin
                    rfg_read_value <= layer_6_loopback_mosi_read_size_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1ce}: begin
                    rfg_read_value <= layer_6_loopback_mosi_read_size_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1cf}: begin
                    rfg_read_value <= layer_6_loopback_mosi_read_size_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1d0}: begin
                    rfg_read_value <= layer_7_loopback_mosi_s_axis_tvalid ? layer_7_loopback_mosi_s_axis_tdata : 8'hff;
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1d1}: begin
                    rfg_read_value <= layer_7_loopback_mosi_read_size_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1d2}: begin
                    rfg_read_value <= layer_7_loopback_mosi_read_size_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1d3}: begin
                    rfg_read_value <= layer_7_loopback_mosi_read_size_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1d4}: begin
                    rfg_read_value <= layer_7_loopback_mosi_read_size_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1d5}: begin
                    rfg_read_value <= layer_8_loopback_mosi_s_axis_tvalid ? layer_8_loopback_mosi_s_axis_tdata : 8'hff;
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1d6}: begin
                    rfg_read_value <= layer_8_loopback_mosi_read_size_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1d7}: begin
                    rfg_read_value <= layer_8_loopback_mosi_read_size_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1d8}: begin
                    rfg_read_value <= layer_8_loopback_mosi_read_size_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1d9}: begin
                    rfg_read_value <= layer_8_loopback_mosi_read_size_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1da}: begin
                    rfg_read_value <= layer_9_loopback_mosi_s_axis_tvalid ? layer_9_loopback_mosi_s_axis_tdata : 8'hff;
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1db}: begin
                    rfg_read_value <= layer_9_loopback_mosi_read_size_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1dc}: begin
                    rfg_read_value <= layer_9_loopback_mosi_read_size_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1dd}: begin
                    rfg_read_value <= layer_9_loopback_mosi_read_size_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1de}: begin
                    rfg_read_value <= layer_9_loopback_mosi_read_size_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1df}: begin
                    rfg_read_value <= layer_10_loopback_mosi_s_axis_tvalid ? layer_10_loopback_mosi_s_axis_tdata : 8'hff;
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1e0}: begin
                    rfg_read_value <= layer_10_loopback_mosi_read_size_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1e1}: begin
                    rfg_read_value <= layer_10_loopback_mosi_read_size_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1e2}: begin
                    rfg_read_value <= layer_10_loopback_mosi_read_size_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1e3}: begin
                    rfg_read_value <= layer_10_loopback_mosi_read_size_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1e4}: begin
                    rfg_read_value <= layer_11_loopback_mosi_s_axis_tvalid ? layer_11_loopback_mosi_s_axis_tdata : 8'hff;
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1e5}: begin
                    rfg_read_value <= layer_11_loopback_mosi_read_size_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1e6}: begin
                    rfg_read_value <= layer_11_loopback_mosi_read_size_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1e7}: begin
                    rfg_read_value <= layer_11_loopback_mosi_read_size_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1e8}: begin
                    rfg_read_value <= layer_11_loopback_mosi_read_size_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1e9}: begin
                    rfg_read_value <= layer_12_loopback_mosi_s_axis_tvalid ? layer_12_loopback_mosi_s_axis_tdata : 8'hff;
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1ea}: begin
                    rfg_read_value <= layer_12_loopback_mosi_read_size_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1eb}: begin
                    rfg_read_value <= layer_12_loopback_mosi_read_size_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1ec}: begin
                    rfg_read_value <= layer_12_loopback_mosi_read_size_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1ed}: begin
                    rfg_read_value <= layer_12_loopback_mosi_read_size_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1ee}: begin
                    rfg_read_value <= layer_13_loopback_mosi_s_axis_tvalid ? layer_13_loopback_mosi_s_axis_tdata : 8'hff;
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1ef}: begin
                    rfg_read_value <= layer_13_loopback_mosi_read_size_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1f0}: begin
                    rfg_read_value <= layer_13_loopback_mosi_read_size_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1f1}: begin
                    rfg_read_value <= layer_13_loopback_mosi_read_size_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1f2}: begin
                    rfg_read_value <= layer_13_loopback_mosi_read_size_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1f3}: begin
                    rfg_read_value <= layer_14_loopback_mosi_s_axis_tvalid ? layer_14_loopback_mosi_s_axis_tdata : 8'hff;
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1f4}: begin
                    rfg_read_value <= layer_14_loopback_mosi_read_size_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1f5}: begin
                    rfg_read_value <= layer_14_loopback_mosi_read_size_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1f6}: begin
                    rfg_read_value <= layer_14_loopback_mosi_read_size_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1f7}: begin
                    rfg_read_value <= layer_14_loopback_mosi_read_size_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1f8}: begin
                    rfg_read_value <= layer_15_loopback_mosi_s_axis_tvalid ? layer_15_loopback_mosi_s_axis_tdata : 8'hff;
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1f9}: begin
                    rfg_read_value <= layer_15_loopback_mosi_read_size_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1fa}: begin
                    rfg_read_value <= layer_15_loopback_mosi_read_size_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1fb}: begin
                    rfg_read_value <= layer_15_loopback_mosi_read_size_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1fc}: begin
                    rfg_read_value <= layer_15_loopback_mosi_read_size_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1fd}: begin
                    rfg_read_value <= layer_16_loopback_mosi_s_axis_tvalid ? layer_16_loopback_mosi_s_axis_tdata : 8'hff;
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1fe}: begin
                    rfg_read_value <= layer_16_loopback_mosi_read_size_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h1ff}: begin
                    rfg_read_value <= layer_16_loopback_mosi_read_size_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h200}: begin
                    rfg_read_value <= layer_16_loopback_mosi_read_size_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h201}: begin
                    rfg_read_value <= layer_16_loopback_mosi_read_size_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h202}: begin
                    rfg_read_value <= layer_17_loopback_mosi_s_axis_tvalid ? layer_17_loopback_mosi_s_axis_tdata : 8'hff;
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h203}: begin
                    rfg_read_value <= layer_17_loopback_mosi_read_size_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h204}: begin
                    rfg_read_value <= layer_17_loopback_mosi_read_size_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h205}: begin
                    rfg_read_value <= layer_17_loopback_mosi_read_size_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h206}: begin
                    rfg_read_value <= layer_17_loopback_mosi_read_size_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h207}: begin
                    rfg_read_value <= layer_18_loopback_mosi_s_axis_tvalid ? layer_18_loopback_mosi_s_axis_tdata : 8'hff;
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h208}: begin
                    rfg_read_value <= layer_18_loopback_mosi_read_size_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h209}: begin
                    rfg_read_value <= layer_18_loopback_mosi_read_size_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h20a}: begin
                    rfg_read_value <= layer_18_loopback_mosi_read_size_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h20b}: begin
                    rfg_read_value <= layer_18_loopback_mosi_read_size_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h20c}: begin
                    rfg_read_value <= layer_19_loopback_mosi_s_axis_tvalid ? layer_19_loopback_mosi_s_axis_tdata : 8'hff;
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h20d}: begin
                    rfg_read_value <= layer_19_loopback_mosi_read_size_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h20e}: begin
                    rfg_read_value <= layer_19_loopback_mosi_read_size_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h20f}: begin
                    rfg_read_value <= layer_19_loopback_mosi_read_size_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h210}: begin
                    rfg_read_value <= layer_19_loopback_mosi_read_size_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h211}: begin
                    rfg_read_value <= layers_cfg_frame_tag_counter_ctrl_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h212}: begin
                    rfg_read_value <= layers_cfg_frame_tag_counter_trigger_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h213}: begin
                    rfg_read_value <= layers_cfg_frame_tag_counter_trigger_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h214}: begin
                    rfg_read_value <= layers_cfg_frame_tag_counter_trigger_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h215}: begin
                    rfg_read_value <= layers_cfg_frame_tag_counter_trigger_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h216}: begin
                    rfg_read_value <= layers_cfg_frame_tag_counter_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h217}: begin
                    rfg_read_value <= layers_cfg_frame_tag_counter_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h218}: begin
                    rfg_read_value <= layers_cfg_frame_tag_counter_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h219}: begin
                    rfg_read_value <= layers_cfg_frame_tag_counter_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h21a}: begin
                    rfg_read_value <= layers_cfg_nodata_continue_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h21b}: begin
                    rfg_read_value <= layers_sr_out_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h21c}: begin
                    rfg_read_value <= layers_sr_in_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h21d}: begin
                    rfg_read_value <= layers_inj_ctrl_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h21f}: begin
                    rfg_read_value <= layers_inj_wdata_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h220}: begin
                    rfg_read_value <= layers_readout_s_axis_tvalid ? layers_readout_s_axis_tdata : 8'hff;
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h221}: begin
                    rfg_read_value <= layers_readout_read_size_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h222}: begin
                    rfg_read_value <= layers_readout_read_size_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h223}: begin
                    rfg_read_value <= layers_readout_read_size_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h224}: begin
                    rfg_read_value <= layers_readout_read_size_reg[31:24];
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
                    rfg_read_value <= layers_cfg_frame_tag_counter_trigger_match_reg[7:0];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h22d}: begin
                    rfg_read_value <= layers_cfg_frame_tag_counter_trigger_match_reg[15:8];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h22e}: begin
                    rfg_read_value <= layers_cfg_frame_tag_counter_trigger_match_reg[23:16];
                    rfg_read_valid <= 1 ;
                end
                {1'b1,16'h22f}: begin
                    rfg_read_value <= layers_cfg_frame_tag_counter_trigger_match_reg[31:24];
                    rfg_read_valid <= 1 ;
                end
                default: begin
                rfg_read_valid <= 0 ;
                end
            endcase
            
        end
    end
    
    
    always@(posedge spi_layers_ckdivider_source_clk) begin
        if (!spi_layers_ckdivider_source_resn) begin
            spi_layers_ckdivider_divided_clk <= 1'b0;
            spi_layers_ckdivider_counter <= 8'h00;
        end else begin
            if (spi_layers_ckdivider_counter==spi_layers_ckdivider_reg) begin
                spi_layers_ckdivider_divided_clk <= !spi_layers_ckdivider_divided_clk;
                spi_layers_ckdivider_counter <= 8'h00;
            end else begin
                spi_layers_ckdivider_counter <= spi_layers_ckdivider_counter+1;
            end
        end
    end
    reg [7:0] spi_layers_ckdivider_divided_resn_delay;
    assign spi_layers_ckdivider_divided_resn = spi_layers_ckdivider_divided_resn_delay[7];
    always@(posedge spi_layers_ckdivider_divided_clk or negedge spi_layers_ckdivider_source_resn) begin
        if (!spi_layers_ckdivider_source_resn) begin
            spi_layers_ckdivider_divided_resn_delay <= 8'h00;
        end else begin
            spi_layers_ckdivider_divided_resn_delay <= {spi_layers_ckdivider_divided_resn_delay[6:0],1'b1};
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
