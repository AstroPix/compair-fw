module compair_fpga_top(

	input   wire            sysclk_125, // Clock on N25, JP15 is removed, or output J23 is 1 or hi-z
    input   wire            rstn,
    
    input   wire            ftdi_tx, // TX of FTDI UART
    output  wire            ftdi_rx, // RX of FTDI UART
	
    input   wire            spi_clk,
    input   wire            spi_csn,
   
    output  wire    [7:0]   LED_RED
);

    wire [7:0] LED_RED_internal;
    wire [7:0] rfg_led;

    // Richard: Uart init done is set after a reset of the uart driver, and one successful read from the ip core happened
    // if the first Red LED is off, it is likely that the communication with the board won't work
    wire uart_init_done;

    // Invert the register bit before output, on the board, LED is on if the output is 0
    assign LED_RED = ~LED_RED_internal;

    assign LED_RED_internal[0] = uart_init_done;
    assign LED_RED_internal[7:1] = rfg_led[6:0];


    // Module Instance
    // verilator lint_off DECLFILENAME 
    // verilator lint_off UNDRIVEN
    astep24_3l_top  astep24_3l_top_I(
        .sysclk(sysclk_125),
        .clk_sample(),
        .clk_timestamp(),
        
        .warm_resn(rstn), // Warm reset either from IO or a local button
        .cold_resn(1'b1),

        .io_aresn(/* This output signals a strong reset situation where we might want to put some IO in High-Z, not used for now */),

        .ext_adc_spi_csn(ext_spi_adc_csn),
        .ext_adc_spi_miso(ext_spi_adc_miso),
        .ext_dac_spi_csn(ext_spi_dac_csn),
        .ext_spi_clk(ext_spi_clk),
        .ext_spi_mosi(ext_spi_mosi),


        .layer_0_hold(),
        .layer_0_resn(),
        .layer_0_interruptn(1'b1),
        .layer_0_spi_clk(),
        .layer_0_spi_csn(),
        .layer_0_spi_miso(2'b00),
        .layer_0_spi_mosi(),
        

        // Layers Wiring: Fix layers 1-2 to constants if in single layer mode, otherwise route out
        .layer_1_hold(/* unused */),
        .layer_1_interruptn(1'd1),
        .layer_1_resn(/* WAIVED: User requested no connection during wrapping */),
        .layer_1_spi_clk(/* WAIVED: User requested no connection during wrapping */),
        .layer_1_spi_csn(/* unused */),
        .layer_1_spi_miso(2'd0),
        .layer_1_spi_mosi(/* WAIVED: User requested no connection during wrapping */),
        .layer_2_hold(/* unused */),
        .layer_2_interruptn(1'd1),
        .layer_2_resn(/* WAIVED: User requested no connection during wrapping */),
        .layer_2_spi_clk(/* WAIVED: User requested no connection during wrapping */),
        .layer_2_spi_csn(/* unused */),
        .layer_2_spi_miso(2'd0),
        .layer_2_spi_mosi(/* WAIVED: User requested no connection during wrapping */),
    

        // Layers Config
        .layers_inj(),
        .layers_spi_csn(),
        .layers_sr_in_rb(),
        .layers_sr_in_sout0(1'b0),
        .layers_sr_in_sout1(1'b0),
        .layers_sr_in_sout2(1'b0),
        .layers_sr_out_sin(),
        .layers_sr_out_ck1(),
        .layers_sr_out_ck2(),
        .layers_sr_out_ld0(),
        .layers_sr_out_ld1(),
        .layers_sr_out_ld2(),

        .rfg_io_led(rfg_led),

        // SPI Slave interface for HOST
        .spi_clk(spi_clk),
        .spi_csn(spi_csn), // always deselect
        .spi_miso(),
        .spi_mosi(1'b0),
        
        .uart_rx(ftdi_tx),
        .uart_tx(ftdi_rx),
        .uart_init_done(uart_init_done),
        .uart_got_byte(),
    
        
        .gecco_sr_ctrl_ck(),
        .gecco_sr_ctrl_sin(),
        .gecco_sr_ctrl_ld(),

        .io_ctrl_sample_clock_enable(),
        .io_ctrl_timestamp_clock_enable(),
        .io_ctrl_gecco_sample_clock_se(),
        .io_ctrl_gecco_inj_enable()
    );





endmodule