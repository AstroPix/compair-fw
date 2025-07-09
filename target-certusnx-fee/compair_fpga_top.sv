module compair_fpga_top(

	input   wire            sysclk_100, // Clock on N25, JP15 is removed, or output J23 is 1 or hi-z
    input   wire            rstn,
    input   wire            ftdi_tx, // TX of FTDI UART
    output  wire            ftdi_rx, // RX of FTDI UART
	output  wire            dcdc_5p0_sync_mode,
	output  wire            dcdc_d3p3_sync_mode,
	output  wire            watchdog, 
	
	output wire             row0_hold,
	output wire             row0_row3_reset,
	input  wire             row0_int,
	output wire             row0_spi_clk,
	output wire             row0_spi_cs,
	input  wire    [1:0]    row0_spi_miso,
	output wire             row0_spi_mosi,
	output wire [19:0]      row_ts_clk,
	output wire [19:0]      row_samp_clk,
	
	output wire             row1_hold,
	input  wire             row1_int,
	output wire             row1_spi_clk,
	output wire             row1_spi_cs,
	input  wire    [1:0]    row1_spi_miso,
	output wire             row1_spi_mosi,

	
	output wire             row2_hold,
	input  wire             row2_int,
	output wire             row2_spi_clk,
	output wire             row2_spi_cs,
	input  wire    [1:0]    row2_spi_miso,
	output wire             row2_spi_mosi,

	
	output wire             row3_hold,
	input  wire             row3_int,
	output wire             row3_spi_clk,
	output wire             row3_spi_cs,
	input  wire    [1:0]    row3_spi_miso,
	output wire             row3_spi_mosi,

	
	output wire             row4_hold,
	output wire             row4_row7_reset,
	input  wire             row4_int,
	output wire             row4_spi_clk,
	output wire             row4_spi_cs,
	input  wire    [1:0]    row4_spi_miso,
	output wire             row4_spi_mosi,

	output wire             row5_hold,
	input  wire             row5_int,
	output wire             row5_spi_clk,
	output wire             row5_spi_cs,
	input  wire    [1:0]    row5_spi_miso,
	output wire             row5_spi_mosi,

	
	output wire             row6_hold,
    input  wire             row6_int,
	output wire             row6_spi_clk,
	output wire             row6_spi_cs,
	input  wire    [1:0]    row6_spi_miso,
	output wire             row6_spi_mosi,

	output wire             row7_hold,
	input  wire             row7_int,
	output wire             row7_spi_clk,
	output wire             row7_spi_cs,
	input  wire    [1:0]    row7_spi_miso,
	output wire             row7_spi_mosi,

	output wire             row8_hold,
	output wire             row8_row11_reset,
	input  wire             row8_int,
	output wire             row8_spi_clk,
	output wire             row8_spi_cs,
	input  wire    [1:0]    row8_spi_miso,
	output wire             row8_spi_mosi,
	
	output wire             row9_hold,
	input  wire             row9_int,
	output wire             row9_spi_clk,
	output wire             row9_spi_cs,
	input  wire    [1:0]    row9_spi_miso,
	output wire             row9_spi_mosi,
	
	output wire             row10_hold,
	input  wire             row10_int,
	output wire             row10_spi_clk,
	output wire             row10_spi_cs,
	input  wire    [1:0]    row10_spi_miso,
	output wire             row10_spi_mosi,
	
	output wire             row11_hold,
	input  wire             row11_int,
	output wire             row11_spi_clk,
	output wire             row11_spi_cs,
	input  wire    [1:0]    row11_spi_miso,
	output wire             row11_spi_mosi,

	output wire             row12_hold,
	output wire             row12_row15_reset,
	input  wire             row12_int,
	output wire             row12_spi_clk,
	output wire             row12_spi_cs,
	input  wire    [1:0]    row12_spi_miso,
	output wire             row12_spi_mosi,

	
	output wire             row13_hold,
	input  wire             row13_int,
	output wire             row13_spi_clk,
	output wire             row13_spi_cs,
	input  wire    [1:0]    row13_spi_miso,
	output wire             row13_spi_mosi,

	
	output wire             row14_hold,
	input  wire             row14_int,
	output wire             row14_spi_clk,
	output wire             row14_spi_cs,
	input  wire    [1:0]    row14_spi_miso,
	output wire             row14_spi_mosi,

	
	output wire             row15_hold,
	input  wire             row15_int,
	output wire             row15_spi_clk,
	output wire             row15_spi_cs,
	input  wire    [1:0]    row15_spi_miso,
	output wire             row15_spi_mosi,

	
	output wire             row16_hold,
	output wire             row16_row19_reset,
	input  wire             row16_int,
	output wire             row16_spi_clk,
	output wire             row16_spi_cs,
	input  wire    [1:0]    row16_spi_miso,
	output wire             row16_spi_mosi,

	
	output wire             row17_hold,
	input  wire             row17_int,
	output wire             row17_spi_clk,
	output wire             row17_spi_cs,
	input  wire    [1:0]    row17_spi_miso,
	output wire             row17_spi_mosi,

	output wire             row18_hold,
	input  wire             row18_int,
	output wire             row18_spi_clk,
	output wire             row18_spi_cs,
	input  wire    [1:0]    row18_spi_miso,
	output wire             row18_spi_mosi,

	output wire             row19_hold,
	input  wire             row19_int,
	output wire             row19_spi_clk,
	output wire             row19_spi_cs,
	input  wire    [1:0]    row19_spi_miso,
	output wire             row19_spi_mosi,
	
	//output wire             inj,

	
	//Astropix Sample Clk
    //output wire             clk_sample,
        //output wire             sample_clk_se,
	//output wire             clk_timestamp,
	

	input  wire             ext_spi_adc_miso,
	output wire             ext_spi_clk,
	output wire[2:0]        ext_spi_adc_csn,
	output wire             ext_spi_mosi

);


    // Richard: Uart init done is set after a reset of the uart driver, and one successful read from the ip core happened
    // if the first Red LED is off, it is likely that the communication with the board won't work
    wire uart_init_done;
    wire row0_resn, row1_resn, row2_resn, row3_resn, row4_resn;
    wire row5_resn, row6_resn, row7_resn, row8_resn, row9_resn;
    wire row10_resn, row11_resn, row12_resn, row13_resn, row14_resn;
    wire row15_resn, row16_resn, row17_resn, row18_resn, row19_resn;
	wire clk_timestamp, clk_sample;

    assign dcdc_5p0_sync_mode =  ftdi_rx;
    assign dcdc_d3p3_sync_mode = ftdi_tx;
	
	
	
    assign row0_row3_reset = row0_resn || row1_resn || row2_resn || row3_resn;
    assign row4_row7_reset = row4_resn || row5_resn || row6_resn || row7_resn;
    assign row8_row11_reset = row8_resn || row9_resn || row10_resn || row11_resn;
    assign row12_row15_reset = row12_resn || row13_resn || row14_resn || row15_resn;
    assign row16_row19_reset = row16_resn || row17_resn || row18_resn || row19_resn;

    genvar k;
    generate;
        for (k=0; k<19; k++) begin
            assign row_ts_clk[k]= clk_timestamp;
            assign row_samp_clk[k] = clk_sample;
        end
    endgenerate  

    // Module Instance
    // verilator lint_off DECLFILENAME 
    // verilator lint_off UNDRIVEN
    astep24_20l_top  astep24_20l_top_I(
        .sysclk(sysclk_100),
        .clk_sample(clk_sample),
        .clk_timestamp(clk_timestamp),
        
        .warm_resn(rstn), // Warm reset either from IO or a local button
        .cold_resn(1'b1),

        .io_aresn(/* This output signals a strong reset situation where we might want to put some IO in High-Z, not used for now */),
		.watchdog(watchdog),

        .ext_adc_spi_csn(ext_spi_adc_csn),
        .ext_adc_spi_miso(ext_spi_adc_miso),
        //.ext_dac_spi_csn(),
        .ext_spi_clk(ext_spi_clk),
        .ext_spi_mosi(ext_spi_mosi),


        .lane_0_hold(row0_hold),
        .lane_0_interruptn(row0_int),
        .lane_0_resn(row0_resn),
        .lane_0_spi_clk(row0_spi_clk),
        .lane_0_spi_csn(row0_spi_cs),
        .lane_0_spi_miso(row0_spi_miso),
        .lane_0_spi_mosi(row0_spi_mosi),

        .lane_1_hold(row1_hold),
        .lane_1_interruptn(row1_int),
        .lane_1_resn(row1_resn),
        .lane_1_spi_clk(row1_spi_clk),
        .lane_1_spi_csn(row1_spi_cs),
        .lane_1_spi_miso(row1_spi_miso),
        .lane_1_spi_mosi(row1_spi_mosi),

        .lane_2_hold(row2_hold),
        .lane_2_interruptn(row2_int),
        .lane_2_resn(row2_resn),
        .lane_2_spi_clk(row2_spi_clk),
        .lane_2_spi_csn(row2_spi_cs),
        .lane_2_spi_miso(row2_spi_miso),
        .lane_2_spi_mosi(row2_spi_mosi),
    
        .lane_3_hold(row3_hold),
        .lane_3_interruptn(row3_int),
        .lane_3_resn(row3_resn),
        .lane_3_spi_clk(row3_spi_clk),
        .lane_3_spi_csn(row3_spi_cs),
        .lane_3_spi_miso(row3_spi_miso),
        .lane_3_spi_mosi(row3_spi_mosi),

        .lane_4_hold(row4_hold),
        .lane_4_interruptn(row4_int),
        .lane_4_resn(row4_resn),
        .lane_4_spi_clk(row4_spi_clk),
        .lane_4_spi_csn(row4_spi_cs),
        .lane_4_spi_miso(row4_spi_miso),
        .lane_4_spi_mosi(row4_spi_mosi),

        .lane_5_hold(row5_hold),
        .lane_5_interruptn(row5_int),
        .lane_5_resn(row5_resn),
        .lane_5_spi_clk(row5_spi_clk),
        .lane_5_spi_csn(row5_spi_cs),
        .lane_5_spi_miso(row5_spi_miso),
        .lane_5_spi_mosi(row5_spi_mosi),

        .lane_6_hold(row6_hold),
        .lane_6_interruptn(row6_int),
        .lane_6_resn(row6_resn),
        .lane_6_spi_clk(row6_spi_clk),
        .lane_6_spi_csn(row6_spi_cs),
        .lane_6_spi_miso(row6_spi_miso),
        .lane_6_spi_mosi(row6_spi_mosi),

        .lane_7_hold(row7_hold),
        .lane_7_interruptn(row7_int),
        .lane_7_resn(row7_resn),
        .lane_7_spi_clk(row7_spi_clk),
        .lane_7_spi_csn(row7_spi_cs),
        .lane_7_spi_miso(row7_spi_miso),
        .lane_7_spi_mosi(row7_spi_mosi),

        .lane_8_hold(row8_hold),
        .lane_8_interruptn(row8_int),
        .lane_8_resn(row8_resn),
        .lane_8_spi_clk(row8_spi_clk),
        .lane_8_spi_csn(row8_spi_cs),
        .lane_8_spi_miso(row8_spi_miso),
        .lane_8_spi_mosi(row8_spi_mosi),

        .lane_9_hold(row9_hold),
        .lane_9_interruptn(row9_int),
        .lane_9_resn(row9_resn),
        .lane_9_spi_clk(row9_spi_clk),
        .lane_9_spi_csn(row9_spi_cs),
        .lane_9_spi_miso(row9_spi_miso),
        .lane_9_spi_mosi(row9_spi_mosi),

        .lane_10_hold(row10_hold),
        .lane_10_interruptn(row10_int),
        .lane_10_resn(row10_resn),
        .lane_10_spi_clk(row10_spi_clk),
        .lane_10_spi_csn(row10_spi_cs),
        .lane_10_spi_miso(row10_spi_miso),
        .lane_10_spi_mosi(row10_spi_mosi),

        .lane_11_hold(row11_hold),
        .lane_11_interruptn(row11_int),
        .lane_11_resn(row11_resn),
        .lane_11_spi_clk(row11_spi_clk),
        .lane_11_spi_csn(row11_spi_cs),
        .lane_11_spi_miso(row11_spi_miso),
        .lane_11_spi_mosi(row11_spi_mosi),

        .lane_12_hold(row12_hold),
        .lane_12_interruptn(row12_int),
        .lane_12_resn(row12_resn),
        .lane_12_spi_clk(row12_spi_clk),
        .lane_12_spi_csn(row12_spi_cs),
        .lane_12_spi_miso(row12_spi_miso),
        .lane_12_spi_mosi(row12_spi_mosi),

        .lane_13_hold(row13_hold),
        .lane_13_interruptn(row13_int),
        .lane_13_resn(row13_resn),
        .lane_13_spi_clk(row13_spi_clk),
        .lane_13_spi_csn(row13_spi_cs),
        .lane_13_spi_miso(row13_spi_miso),
        .lane_13_spi_mosi(row13_spi_mosi),

        .lane_14_hold(row14_hold),
        .lane_14_interruptn(row14_int),
        .lane_14_resn(row14_resn),
        .lane_14_spi_clk(row14_spi_clk),
        .lane_14_spi_csn(row14_spi_cs),
        .lane_14_spi_miso(row14_spi_miso),
        .lane_14_spi_mosi(row14_spi_mosi),

        .lane_15_hold(row15_hold),
        .lane_15_interruptn(row15_int),
        .lane_15_resn(row15_resn),
        .lane_15_spi_clk(row15_spi_clk),
        .lane_15_spi_csn(row15_spi_cs),
        .lane_15_spi_miso(row15_spi_miso),
        .lane_15_spi_mosi(row15_spi_mosi),

        .lane_16_hold(row16_hold),
        .lane_16_interruptn(row16_int),
        .lane_16_resn(row16_resn),
        .lane_16_spi_clk(row16_spi_clk),
        .lane_16_spi_csn(row16_spi_cs),
        .lane_16_spi_miso(row16_spi_miso),
        .lane_16_spi_mosi(row16_spi_mosi),

        .lane_17_hold(row17_hold),
        .lane_17_interruptn(row17_int),
        .lane_17_resn(row17_resn),
        .lane_17_spi_clk(row17_spi_clk),
        .lane_17_spi_csn(row17_spi_cs),
        .lane_17_spi_miso(row17_spi_miso),
        .lane_17_spi_mosi(row17_spi_mosi),

        .lane_18_hold(row18_hold),
        .lane_18_interruptn(row18_int),
        .lane_18_resn(row18_resn),
        .lane_18_spi_clk(row18_spi_clk),
        .lane_18_spi_csn(row18_spi_cs),
        .lane_18_spi_miso(row18_spi_miso),
        .lane_18_spi_mosi(row18_spi_mosi),

        .lane_19_hold(row19_hold),
        .lane_19_interruptn(row19_int),
        .lane_19_resn(row19_resn),
        .lane_19_spi_clk(row19_spi_clk),
        .lane_19_spi_csn(row19_spi_cs),
        .lane_19_spi_miso(row19_spi_miso),
        .lane_19_spi_mosi(row19_spi_mosi),
        // Layers Config
        .lanes_inj(inj),    // this is DigInj?
        .lanes_spi_csn(),   // is this no connect
        .lanes_sr_in_rb(),
        .lanes_sr_in_sout0(),
        .lanes_sr_in_sout1(1'b0),
        .lanes_sr_in_sout2(1'b0),
        .lanes_sr_out_sin(),
        .lanes_sr_out_ck1(),
        .lanes_sr_out_ck2(),
        .lanes_sr_out_ld0(),
        .lanes_sr_out_ld1(),
        .lanes_sr_out_ld2(),

 
        // SPI Slave interface for HOST
        .spi_clk(),
        .spi_csn(), // always deselect
        .spi_miso(),       
        .spi_mosi(1'b0),   
        
        .uart_rx(ftdi_tx),
        .uart_tx(ftdi_rx),
        .uart_init_done(uart_init_done),
        .uart_got_byte(),
    
        
        .gecco_sr_ctrl_ck(),   // what are these 3 and following 4 signals
        .gecco_sr_ctrl_sin(),
        .gecco_sr_ctrl_ld(),

        //.io_ctrl_sample_clock_enable(),
        //.io_ctrl_timestamp_clock_enable(),
        .io_ctrl_gecco_sample_clock_se(),
        .io_ctrl_gecco_inj_enable()
    );





endmodule