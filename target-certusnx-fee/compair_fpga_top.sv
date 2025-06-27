module compair_fpga_top(

	input   wire            sysclk_100, // Clock on N25, JP15 is removed, or output J23 is 1 or hi-z
    input   wire            rstn,
    input   wire            ftdi_tx, // TX of FTDI UART
    output  wire            ftdi_rx, // RX of FTDI UART
	output  wire            dcdc_5p0_sync_mode,
	output                  dcdc_d3p3_sync_mode,
	
	output wire             row0_hold,
	output wire             row0_row3_reset,
	input  wire             row0_int,
	output wire             row0_spi_clk,
	output wire             row0_spi_cs,
	input  wire    [1:0]    row0_spi_miso,
	output wire             row0_spi_mosi,
	
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
        //output wire             sample_clk,
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

    assign dcdc_5p0_sync_mode =  ftdi_rx;
    assign dcdc_d3p3_sync_mode = ftdi_tx;
	
	
	
    assign row0_row3_reset = row0_resn || row1_resn || row2_resn || row3_resn;
    assign row4_row7_reset = row4_resn || row5_resn || row6_resn || row7_resn;
    assign row8_row11_reset = row8_resn || row9_resn || row10_resn || row11_resn;
    assign row12_row15_reset = row12_resn || row13_resn || row14_resn || row15_resn;
    assign row16_row19_reset = row16_resn || row17_resn || row18_resn || row19_resn;

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

        .ext_adc_spi_csn(ext_spi_adc_csn),
        .ext_adc_spi_miso(ext_spi_adc_miso),
        //.ext_dac_spi_csn(),
        .ext_spi_clk(ext_spi_clk),
        .ext_spi_mosi(ext_spi_mosi),


        .layer_0_hold(row0_hold),
        .layer_0_interruptn(row0_int),
        .layer_0_resn(row0_resn),
        .layer_0_spi_clk(row0_spi_clk),
        .layer_0_spi_csn(row0_spi_cs),
        .layer_0_spi_miso(row0_spi_miso),
        .layer_0_spi_mosi(row0_spi_mosi),

        .layer_1_hold(row1_hold),
        .layer_1_interruptn(row1_int),
        .layer_1_resn(row1_resn),
        .layer_1_spi_clk(row1_spi_clk),
        .layer_1_spi_csn(row1_spi_cs),
        .layer_1_spi_miso(row1_spi_miso),
        .layer_1_spi_mosi(row1_spi_mosi),

        .layer_2_hold(row2_hold),
        .layer_2_interruptn(row2_int),
        .layer_2_resn(row2_resn),
        .layer_2_spi_clk(row2_spi_clk),
        .layer_2_spi_csn(row2_spi_cs),
        .layer_2_spi_miso(row2_spi_miso),
        .layer_2_spi_mosi(row2_spi_mosi),
    
        .layer_3_hold(row3_hold),
        .layer_3_interruptn(row3_int),
        .layer_3_resn(row3_resn),
        .layer_3_spi_clk(row3_spi_clk),
        .layer_3_spi_csn(row3_spi_cs),
        .layer_3_spi_miso(row3_spi_miso),
        .layer_3_spi_mosi(row3_spi_mosi),

        .layer_4_hold(row4_hold),
        .layer_4_interruptn(row4_int),
        .layer_4_resn(row4_resn),
        .layer_4_spi_clk(row4_spi_clk),
        .layer_4_spi_csn(row4_spi_cs),
        .layer_4_spi_miso(row4_spi_miso),
        .layer_4_spi_mosi(row4_spi_mosi),

        .layer_5_hold(row5_hold),
        .layer_5_interruptn(row5_int),
        .layer_5_resn(row5_resn),
        .layer_5_spi_clk(row5_spi_clk),
        .layer_5_spi_csn(row5_spi_cs),
        .layer_5_spi_miso(row5_spi_miso),
        .layer_5_spi_mosi(row5_spi_mosi),

        .layer_6_hold(row6_hold),
        .layer_6_interruptn(row6_int),
        .layer_6_resn(row6_resn),
        .layer_6_spi_clk(row6_spi_clk),
        .layer_6_spi_csn(row6_spi_cs),
        .layer_6_spi_miso(row6_spi_miso),
        .layer_6_spi_mosi(row6_spi_mosi),

        .layer_7_hold(row7_hold),
        .layer_7_interruptn(row7_int),
        .layer_7_resn(row7_resn),
        .layer_7_spi_clk(row7_spi_clk),
        .layer_7_spi_csn(row7_spi_cs),
        .layer_7_spi_miso(row7_spi_miso),
        .layer_7_spi_mosi(row7_spi_mosi),

        .layer_8_hold(row8_hold),
        .layer_8_interruptn(row8_int),
        .layer_8_resn(row8_resn),
        .layer_8_spi_clk(row8_spi_clk),
        .layer_8_spi_csn(row8_spi_cs),
        .layer_8_spi_miso(row8_spi_miso),
        .layer_8_spi_mosi(row8_spi_mosi),

        .layer_9_hold(row9_hold),
        .layer_9_interruptn(row9_int),
        .layer_9_resn(row9_resn),
        .layer_9_spi_clk(row9_spi_clk),
        .layer_9_spi_csn(row9_spi_cs),
        .layer_9_spi_miso(row9_spi_miso),
        .layer_9_spi_mosi(row9_spi_mosi),

        .layer_10_hold(row10_hold),
        .layer_10_interruptn(row10_int),
        .layer_10_resn(row10_resn),
        .layer_10_spi_clk(row10_spi_clk),
        .layer_10_spi_csn(row10_spi_cs),
        .layer_10_spi_miso(row10_spi_miso),
        .layer_10_spi_mosi(row10_spi_mosi),

        .layer_11_hold(row11_hold),
        .layer_11_interruptn(row11_int),
        .layer_11_resn(row11_resn),
        .layer_11_spi_clk(row11_spi_clk),
        .layer_11_spi_csn(row11_spi_cs),
        .layer_11_spi_miso(row11_spi_miso),
        .layer_11_spi_mosi(row11_spi_mosi),

        .layer_12_hold(row12_hold),
        .layer_12_interruptn(row12_int),
        .layer_12_resn(row12_resn),
        .layer_12_spi_clk(row12_spi_clk),
        .layer_12_spi_csn(row12_spi_cs),
        .layer_12_spi_miso(row12_spi_miso),
        .layer_12_spi_mosi(row12_spi_mosi),

        .layer_13_hold(row13_hold),
        .layer_13_interruptn(row13_int),
        .layer_13_resn(row13_resn),
        .layer_13_spi_clk(row13_spi_clk),
        .layer_13_spi_csn(row13_spi_cs),
        .layer_13_spi_miso(row13_spi_miso),
        .layer_13_spi_mosi(row13_spi_mosi),

        .layer_14_hold(row14_hold),
        .layer_14_interruptn(row14_int),
        .layer_14_resn(row14_resn),
        .layer_14_spi_clk(row14_spi_clk),
        .layer_14_spi_csn(row14_spi_cs),
        .layer_14_spi_miso(row14_spi_miso),
        .layer_14_spi_mosi(row14_spi_mosi),

        .layer_15_hold(row15_hold),
        .layer_15_interruptn(row15_int),
        .layer_15_resn(row15_resn),
        .layer_15_spi_clk(row15_spi_clk),
        .layer_15_spi_csn(row15_spi_cs),
        .layer_15_spi_miso(row15_spi_miso),
        .layer_15_spi_mosi(row15_spi_mosi),

        .layer_16_hold(row16_hold),
        .layer_16_interruptn(row16_int),
        .layer_16_resn(row16_resn),
        .layer_16_spi_clk(row16_spi_clk),
        .layer_16_spi_csn(row16_spi_cs),
        .layer_16_spi_miso(row16_spi_miso),
        .layer_16_spi_mosi(row16_spi_mosi),

        .layer_17_hold(row17_hold),
        .layer_17_interruptn(row17_int),
        .layer_17_resn(row17_resn),
        .layer_17_spi_clk(row17_spi_clk),
        .layer_17_spi_csn(row17_spi_cs),
        .layer_17_spi_miso(row17_spi_miso),
        .layer_17_spi_mosi(row17_spi_mosi),

        .layer_18_hold(row18_hold),
        .layer_18_interruptn(row18_int),
        .layer_18_resn(row18_resn),
        .layer_18_spi_clk(row18_spi_clk),
        .layer_18_spi_csn(row18_spi_cs),
        .layer_18_spi_miso(row18_spi_miso),
        .layer_18_spi_mosi(row18_spi_mosi),

        .layer_19_hold(row19_hold),
        .layer_19_interruptn(row19_int),
        .layer_19_resn(row19_resn),
        .layer_19_spi_clk(row19_spi_clk),
        .layer_19_spi_csn(row19_spi_cs),
        .layer_19_spi_miso(row19_spi_miso),
        .layer_19_spi_mosi(row19_spi_mosi),
        // Layers Config
        .layers_inj(inj),    // this is DigInj?
        .layers_spi_csn(),   // is this no connect
        .layers_sr_in_rb(),
        .layers_sr_in_sout0(),
        .layers_sr_in_sout1(1'b0),
        .layers_sr_in_sout2(1'b0),
        .layers_sr_out_sin(),
        .layers_sr_out_ck1(),
        .layers_sr_out_ck2(),
        .layers_sr_out_ld0(),
        .layers_sr_out_ld1(),
        .layers_sr_out_ld2(),

 
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

        .io_ctrl_sample_clock_enable(),
        .io_ctrl_timestamp_clock_enable(),
        .io_ctrl_gecco_sample_clock_se(),
        .io_ctrl_gecco_inj_enable()
    );





endmodule