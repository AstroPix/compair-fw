

/**

Multi Layers parametezied

*/
module lanes_readout_switched #(
    parameter LAYER_COUNT = 3
) (

    // Clocking
    //-------------
    input wire clk_core,
    input wire clk_core_resn,

    input wire clk_io,
    input wire clk_io_resn,

    // Layers Interface
    //-----------------
    input  wire [LAYER_COUNT-1:0]       lanes_interruptn,
    output wire [LAYER_COUNT-1:0]       lanes_spi_clk,
    output wire [LAYER_COUNT-1:0]       lanes_spi_mosi,
    input  wire [LAYER_COUNT*2-1:0]     lanes_spi_miso,
    output wire [LAYER_COUNT-1:0]       lanes_spi_csn,

    // MOSI
    //----------------
    input wire  [(LAYER_COUNT*8)-1:0]   lanes_mosi_s_axis_tdata,
    input wire  [LAYER_COUNT-1:0]       lanes_mosi_s_axis_tvalid,
    input wire  [LAYER_COUNT-1:0]       lanes_mosi_s_axis_tlast,
    output wire [LAYER_COUNT-1:0]       lanes_mosi_s_axis_tready,
    output wire [(LAYER_COUNT*32)-1:0]  lanes_mosi_write_size,

    // MISO Merged readout
    //-------------
    output wire [31:0]		            readout_frames_data_count,
    output wire [7:0]		            readout_frames_m_axis_tdata,
    input  wire				            readout_frames_m_axis_tready,
    output wire				            readout_frames_m_axis_tvalid,

    // Configurations
    //---------------------
    input wire  [LAYER_COUNT-1:0]       config_disable_autoread,
    input wire  [31:0]                  config_frame_tag_counter,
    input wire  [7:0]                   config_nodata_continue,
    input wire  [LAYER_COUNT-1:0]       config_lanes_reset,
    input wire  [LAYER_COUNT-1:0]       config_lanes_disable_miso,

    // Status
    //---------------------
    output wire [LAYER_COUNT-1:0]        lanes_status_frame_decoding,

    // Statistics
    //----------------------
    output wire [LAYER_COUNT-1:0]       lanes_stat_count_idle,
    output wire [LAYER_COUNT-1:0]       lanes_stat_count_frame


);

    // Signals
    //-------------

    // Add Count Layers
    //----------------------

    // Master outputs from lanes readout
    wire  [((LAYER_COUNT+1)*8)-1:0]   lanes_miso_m_axis_tdata;
    wire  [((LAYER_COUNT+1)*8)-1:0]   lanes_miso_m_axis_tdest;
    wire  [(LAYER_COUNT+1)-1:0]       lanes_miso_m_axis_tvalid;
    wire  [(LAYER_COUNT+1)-1:0]       lanes_miso_m_axis_tlast;
    wire  [(LAYER_COUNT+1)-1:0]       lanes_miso_m_axis_tready;

    // The last input port is unused
    assign lanes_miso_m_axis_tvalid[(LAYER_COUNT+1)-1] = 1'b0;
    assign lanes_miso_m_axis_tlast[(LAYER_COUNT+1)-1] = 1'b0;
    assign lanes_miso_m_axis_tdata[(LAYER_COUNT+1)*8-1:(LAYER_COUNT+1)*8-8] = 8'b0;
    assign lanes_miso_m_axis_tdest[(LAYER_COUNT+1)*8-1:(LAYER_COUNT+1)*8-8] = 8'b0;

    genvar li;
    generate
        for (li = 0 ; li < LAYER_COUNT ; li++) begin 
            
            lane_if_a #(.LAYER_ID(li+1)) lane_if_I (
                
                .clk_core(clk_core),
                .clk_core_resn(clk_core_resn),
                .clk_spi(clk_io),
                .clk_spi_resn(clk_io_resn),
                .frames_m_axis_tdata(lanes_miso_m_axis_tdata[li*8+7:li*8]),
                .frames_m_axis_tdest(lanes_miso_m_axis_tdest[li*8+7:li*8]),
                .frames_m_axis_tlast(lanes_miso_m_axis_tlast[li]),
                .frames_m_axis_tready(lanes_miso_m_axis_tready[li]),
                .frames_m_axis_tvalid(lanes_miso_m_axis_tvalid[li]),

                .interruptn(lanes_interruptn[li]),

                .mosi_s_axis_tdata(lanes_mosi_s_axis_tdata[li*8+7:li*8]),
                .mosi_s_axis_tlast(lanes_mosi_s_axis_tlast[li]),
                .mosi_s_axis_tready(lanes_mosi_s_axis_tready[li]),
                .mosi_s_axis_tvalid(lanes_mosi_s_axis_tvalid[li]),
                .mosi_s_write_size(lanes_mosi_write_size[li*32+31:li*32]),

                .spi_clk(lanes_spi_clk[li]),
                .spi_csn(lanes_spi_csn[li]),
                .spi_miso(lanes_spi_miso[li*2+1:li*2]),
                .spi_mosi(lanes_spi_mosi[li]),

                .cfg_disable_autoread(config_disable_autoread[li]),
                .cfg_frame_tag_counter(config_frame_tag_counter),
                .cfg_nodata_continue(config_nodata_continue),
                .cfg_lane_reset(config_lanes_reset[li]),
                .cfg_disable_miso(config_lanes_disable_miso[li]),
                .status_frame_decoding(lanes_status_frame_decoding[li]),
                .stat_frame_detected(lanes_stat_count_frame[li]),
                .stat_idle_detected(lanes_stat_count_idle[li])
            );
          

        end

    
    endgenerate


    // Switch
    //---------------
    wire [(LAYER_COUNT+1)*8-1:0] switch_m_axis_tdata;
    wire [LAYER_COUNT+1-1:0] switch_m_axis_tlast;
    wire [LAYER_COUNT+1-1:0] switch_m_axis_tready;
    wire [LAYER_COUNT+1-1:0] switch_m_axis_tvalid;
    axis_switch #(.PORTS(LAYER_COUNT+1)) axis_switch_lane_frame_I(
        .clk(clk_core),
        .resn(clk_core_resn),

        .m_axis_tdata(switch_m_axis_tdata),
        .m_axis_tdest(),
        .m_axis_tlast(switch_m_axis_tlast),
        .m_axis_tready(switch_m_axis_tready),
        .m_axis_tvalid(switch_m_axis_tvalid),

        .s_axis_tdata(lanes_miso_m_axis_tdata),
        .s_axis_tdest(lanes_miso_m_axis_tdest),
        .s_axis_tlast(lanes_miso_m_axis_tlast),
        .s_axis_tready(lanes_miso_m_axis_tready),
        .s_axis_tvalid(lanes_miso_m_axis_tvalid),
        //.s_decode_err(),
        //.s_req_suppress({LAYER_COUNT{1'b0}})
        // Unused
        .m_axis_tuser(),
        .m_axis_tid(),
        .s_axis_tuser(),
        .s_axis_tid()
    );

    // Data FIFO
    //-----------------
    wire [7:0] output_buffer_tdata = switch_m_axis_tdata[7:0];
    fifo_axis_common #(.DUAL_CLOCK(0),.TID_WIDTH(8),.TDEST_WIDTH(8),.USE_TID(0),.USE_TDEST(0),.TLAST(0))  frames_buffer(
        .s_axis_aclk(clk_core),
        .s_axis_aresetn(clk_core_resn),

        // From Switch
        .s_axis_tdata(output_buffer_tdata),
        .s_axis_tready(switch_m_axis_tready[0]),
        .s_axis_tvalid(switch_m_axis_tvalid[0]),
        .s_axis_tlast(switch_m_axis_tlast[0]),

        // To RFG Readout
        .axis_rd_data_count(readout_frames_data_count),
        .m_axis_tdata(readout_frames_m_axis_tdata),
        .m_axis_tready(readout_frames_m_axis_tready),
        .m_axis_tvalid(readout_frames_m_axis_tvalid),
        .m_axis_tlast(),

        // Unused stuff
        .m_axis_aclk(clk_core),
        .m_axis_aresetn(clk_core_resn),
        .m_axis_tuser(),
        .m_axis_tid(),
        .m_axis_tdest(),

        .s_axis_tuser(),
        .s_axis_tid(),
        .s_axis_tdest(),

        .axis_wr_data_count(),
        .almost_full(),
        .almost_empty()
    );

endmodule
