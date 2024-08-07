


/*
    Generated by HDL Build
*/
module xadc_hk_driver(
    input  wire				clk,
    input  wire				resn,
    output wire [15:0]		temperature,
    output wire				temperature_write,
    input  wire				trigger,
    output wire [15:0]		vccint,
    output wire				vccint_write
);

    // Connections
    //----------------
    wire xadc_busy_sync; // size=1
    wire xadc_busy_out; // size=1
    wire xadc_m_axis_tvalid; // size=1
    wire xadc_m_axis_tready; // size=1
    wire [15:0] xadc_m_axis_tdata; // size=16
    wire [4:0] xadc_m_axis_tid; // size=5
    wire [4:0] xadc_channel_out; // size=5
    wire xadc_eoc_out; // size=1
    wire xadc_alarm_out; // size=1
    wire xadc_eos_out; // size=1 

    // Sections
    //---------------

        //assign rfg_hk_temperature_low_write = temperature_write;
        //assign rfg_hk_temperature_high_write = temperature_write;
    

    // Instances
    //------------
        
    // Module Instance
    /*xadc_astep  xadc(
        .alarm_out(xadc_alarm_out),
        .busy_out(xadc_busy_out),
        .channel_out(xadc_channel_out),
        .convst_in(trigger && !xadc_busy_sync),
        .eoc_out(xadc_eoc_out),
        .eos_out(xadc_eos_out),
        .m_axis_aclk(clk),
        .m_axis_resetn(resn),
        .m_axis_tdata(xadc_m_axis_tdata),
        .m_axis_tid(xadc_m_axis_tid),
        .m_axis_tready(xadc_m_axis_tready),
        .m_axis_tvalid(xadc_m_axis_tvalid),
        .s_axis_aclk(clk),
        .vn_in(1'd0),
        .vp_in(1'd0)
    );*/
            
    
    // Module Instance
    async_input_sync #(.RESET_VALUE(1'b1),.DEBOUNCE_DELAY(2)) xadc_busy_sync_I(
        .async_input(xadc_busy_out),
        .clk(clk),
        .resn(resn),
        .sync_out(xadc_busy_sync)
    );
            
    
    // Module Instance
    xadc_driver_internal  xadc_driver_internal(
        .adc_alarm_out(xadc_alarm_out),
        .adc_busy_out(xadc_busy_out),
        .adc_channel_out(xadc_channel_out),
        .adc_eoc_out(xadc_eoc_out),
        .adc_eos_out(xadc_eos_out),
        .clk(clk),
        .resn(resn),
        .s_axis_tdata(xadc_m_axis_tdata),
        .s_axis_tid(xadc_m_axis_tid),
        .s_axis_tready(xadc_m_axis_tready),
        .s_axis_tvalid(xadc_m_axis_tvalid),
        .temperature(temperature),
        .temperature_write(temperature_write),
        .vccint(vccint),
        .vccint_write(vccint_write)
    );
                

endmodule

        
