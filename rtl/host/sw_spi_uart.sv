

`include "axi_ifs.sv" 

/*
    Generated by HDL Build
*/
module sw_spi_uart(
    input  wire				clk_core,
    input  wire				clk_core_resn,
    input  wire				clk_uart,
    input  wire				clk_uart_resn,

    output wire [7:0]		rfg_address,
    output wire				rfg_read,
    input  wire				rfg_read_valid,
    input  wire [7:0]		rfg_read_value,
    output wire				rfg_write,
    output wire				rfg_write_last,
    output wire [7:0]		rfg_write_value,

    input  wire				spi_clk,
    input  wire				spi_csn,
    output wire				spi_miso,
    input  wire				spi_mosi,

    input  wire				uart_rx,
    output wire				uart_tx

);  

    // AXIS Switch connections
    //--------------
    localparam NUM_INTERFACES = 3 ;
    wire [(NUM_INTERFACES*8)-1:0]   switch_m_tdata;
    wire [(NUM_INTERFACES*8)-1:0]   switch_m_tid;
    wire [(NUM_INTERFACES*8)-1:0]   switch_m_tdest;
    wire [NUM_INTERFACES-1:0]       switch_m_tready;
    wire [NUM_INTERFACES-1:0]       switch_m_tvalid;
    wire [NUM_INTERFACES-1:0]       switch_m_tlast;
    

    wire [(NUM_INTERFACES*8)-1:0]   switch_s_tdata;
    wire [(NUM_INTERFACES*8)-1:0]   switch_s_tid;
    wire [(NUM_INTERFACES*8)-1:0]   switch_s_tdest;
    wire [NUM_INTERFACES-1:0]       switch_s_tready;
    wire [NUM_INTERFACES-1:0]       switch_s_tvalid;
    wire [NUM_INTERFACES-1:0]       switch_s_tlast;
    

    //----------------------    
    // UART
    //----------------------

    wire        apb_penable_i ; 
    wire        apb_psel_i ; 
    wire        apb_pwrite_i ; 
    wire [5:0]  apb_paddr_i ; 
    wire [31:0] apb_pwdata_i ; 
    wire        apb_pready_o ; 
    wire        apb_pslverr_o ; 
    wire [31:0] apb_prdata_o ; 

    byte_t uart_driver_m_axis_tdata;
    byte_t uart_driver_m_axis_tdest;
    byte_t uart_driver_m_axis_tid;
    byte_t uart_egress_fifo_m_axis_tdata;

    // UART
    wire receive_interrupt;
    uart  uart_inst (

        .clk_i(clk_uart),
        .rst_n_i(clk_uart_resn),

        .rxd_i(uart_rx),
        .txd_o(uart_tx),
        
        .int_o(receive_interrupt),
        .apb_penable_i(apb_penable_i),
        .apb_psel_i(apb_psel_i),
        .apb_pwrite_i(apb_pwrite_i),
        .apb_paddr_i(apb_paddr_i),
        .apb_pwdata_i(apb_pwdata_i),
        .apb_pready_o(apb_pready_o),
        .apb_pslverr_o(apb_pslverr_o),
        .apb_prdata_o(apb_prdata_o)
    );

    wire uart_egress_fifo_m_axis_tready;
    wire uart_driver_m_axis_tvalid;
    uart_lattice_axis_driver #(.AXIS_SOURCE(8'd1),.AXIS_DEST(8'd0))  uart_lattice_axis_driver_inst (
        .clk(clk_uart),
        .resn(clk_uart_resn),

        /*.m_axis_tdata(m_axis_tdata),
        .m_axis_tvalid(m_axis_tvalid),
        .m_axis_tready(m_axis_tready),
        .m_axis_tid(m_axis_tid),
        .m_axis_tdest(m_axis_tdest),

        .s_axis_tdata(s_axis_tdata),
        .s_axis_tvalid(s_axis_tvalid),
        .s_axis_tready(s_axis_tready),*/

        .m_axis_tdata(uart_driver_m_axis_tdata),
        .m_axis_tdest(uart_driver_m_axis_tdest),
        .m_axis_tid(uart_driver_m_axis_tid),
        .m_axis_tready(uart_driver_m_axis_tready),
        .m_axis_tvalid(uart_driver_m_axis_tvalid),

        .s_axis_tdata(uart_egress_fifo_m_axis_tdata),
        .s_axis_tready(uart_egress_fifo_m_axis_tready),
        .s_axis_tvalid(uart_egress_fifo_m_axis_tvalid),

        .apb_penable_i(apb_penable_i),
        .apb_psel_i(apb_psel_i),
        .apb_pwrite_i(apb_pwrite_i),
        .apb_paddr_i(apb_paddr_i),
        .apb_pwdata_i(apb_pwdata_i),
        .apb_pready_o(apb_pready_o),
        .apb_pslverr_o(apb_pslverr_o),
        .apb_prdata_o(apb_prdata_o),

        .interrupt_uart(receive_interrupt),

        .uart_init_done(),
        .uart_got_byte(),
        .uart_rcv_byte(),
        .read_reg(1'b0)
    );


    fifo_axis_common #(.AWIDTH(4),.TID_WIDTH(8),.TDEST_WIDTH(8),.TLAST(1))  uart_igress_fifo(

        .m_axis_aclk  (clk_core),
        .m_axis_aresetn(clk_core_resn),
        .m_axis_tready (switch_s_tready[1]),
        .m_axis_tvalid (switch_s_tvalid[1]),
        .m_axis_tdata (switch_s_tdata[15:8]),
        .m_axis_tdest  (switch_s_tdest[15:8]),
        .m_axis_tid    (switch_s_tid[15:8]),
        .m_axis_tlast  (switch_s_tlast[1]),

        .s_axis_aclk(clk_uart),
        .s_axis_aresetn(clk_uart_resn),

        .s_axis_tdata(uart_driver_m_axis_tdata),
        .s_axis_tdest(uart_driver_m_axis_tdest),
        .s_axis_tid(uart_driver_m_axis_tid),
        .s_axis_tready(uart_driver_m_axis_tready),
        .s_axis_tvalid(uart_driver_m_axis_tvalid),
        .s_axis_tlast(1'b1),

        .s_axis_tuser(),
        .m_axis_tuser(),

        .axis_wr_data_count(),
        .axis_rd_data_count(),

        .almost_full(),
        .almost_empty()
    );
    fifo_axis_common #(.AWIDTH(4),.TID_WIDTH(8),.TDEST_WIDTH(8),.TLAST(1))  uart_egress_fifo(

        .m_axis_aclk(clk_uart),
        .m_axis_aresetn(clk_uart_resn),

        .m_axis_tdata(uart_egress_fifo_m_axis_tdata),
        .m_axis_tdest(),
        .m_axis_tid(),
        .m_axis_tready(uart_egress_fifo_m_axis_tready),
        .m_axis_tvalid(uart_egress_fifo_m_axis_tvalid),
        .m_axis_tlast(),
        
        .s_axis_aclk(clk_core),
        .s_axis_aresetn(clk_core_resn),

        .s_axis_tvalid(switch_m_tvalid[1]),
        .s_axis_tready(switch_m_tready[1]),   
        .s_axis_tdata(switch_m_tdata[15:8]),  
        .s_axis_tdest(switch_m_tdest[15:8]),
        .s_axis_tid(switch_m_tid[15:8]),
        .s_axis_tlast(switch_m_tlast[1]),

        .s_axis_tuser(),
        .m_axis_tuser(),

        .axis_wr_data_count(),
        .axis_rd_data_count(),

        .almost_full(),
        .almost_empty()
    );


    //----------------------
    // SPI
    //----------------------
    byte_t spi_igress_m_axis_tdata;
    byte_t spi_igress_m_axis_tid;
    byte_t spi_igress_m_axis_tdest;

    byte_t spi_egress_fifo_m_axis_tdata;
    byte_t spi_egress_fifo_m_axis_tid;
    byte_t readout_framing_m_axis_tdata;
    byte_t readout_framing_m_axis_tuser;


    // IGRESS
    spi_slave_axis_igress #(.AXIS_DEST(0),.AXIS_SOURCE(2),.MSB_FIRST(1)) spi_igress(
        .spi_clk(spi_clk),
        .resn(!spi_csn),
        .spi_csn(spi_csn),
        .spi_mosi(spi_mosi),

        .m_axis_tdata(spi_igress_m_axis_tdata),
        .m_axis_tdest(spi_igress_m_axis_tdest),
        .m_axis_tid(spi_igress_m_axis_tid),
        .m_axis_tready(spi_igress_m_axis_tready),
        .m_axis_tvalid(spi_igress_m_axis_tvalid),

        .err_overrun(/* WAIVED: Overrun not relevant when CS not used */)
    );      

    fifo_axis_common #(.AWIDTH(4),.TID_WIDTH(8),.TDEST_WIDTH(8),.USE_TID(1),.USE_TDEST(1), .TLAST(1))  spi_igress_fifo(
        
        .s_axis_aclk(spi_clk),
        .s_axis_aresetn(!spi_csn),
        .s_axis_tdata(spi_igress_m_axis_tdata),
        .s_axis_tdest(spi_igress_m_axis_tdest),
        .s_axis_tid(spi_igress_m_axis_tid),
        .s_axis_tready(spi_igress_m_axis_tready),
        .s_axis_tvalid(spi_igress_m_axis_tvalid),
        .s_axis_tlast(1'b1),

        .m_axis_aclk(clk_core),
        .m_axis_aresetn(clk_core_resn),
        .m_axis_tready (switch_s_tready[2]),
        .m_axis_tvalid (switch_s_tvalid[2]),
        .m_axis_tdata (switch_s_tdata[23:16]),
        .m_axis_tdest  (switch_s_tdest[23:16]),
        .m_axis_tid    (switch_s_tid[23:16]),
        .m_axis_tlast  (switch_s_tlast[2]),
        
        .s_axis_tuser(),
        .m_axis_tuser(),

        .axis_wr_data_count(),
        .axis_rd_data_count(),

        .almost_full(),
        .almost_empty()
    );
    fifo_axis_common #(.AWIDTH(4),.TID_WIDTH(8),.TDEST_WIDTH(8),.USE_TID(1),.USE_TDEST(1),.TLAST(1))  spi_egress_fifo(

        .s_axis_aclk(clk_core),
        .s_axis_aresetn(clk_core_resn),
        .s_axis_tvalid(switch_m_tvalid[2]),
        .s_axis_tready(switch_m_tready[2]),   
        .s_axis_tdata(switch_m_tdata[23:16]),  
        .s_axis_tdest(switch_m_tdest[23:16]),
        .s_axis_tid(switch_m_tid[23:16]), 
        .s_axis_tlast(switch_m_tlast[2]),

        .m_axis_aclk(spi_clk),
        .m_axis_aresetn(!spi_csn),
        .m_axis_tdata(spi_egress_fifo_m_axis_tdata),
        .m_axis_tid(spi_egress_fifo_m_axis_tid),
        .m_axis_tready(spi_egress_fifo_m_axis_tready),
        .m_axis_tvalid(spi_egress_fifo_m_axis_tvalid),
        .m_axis_tlast(spi_egress_fifo_m_axis_tlast),
        .m_axis_tdest(),

        
        .s_axis_tuser(),
        .m_axis_tuser(),

        .axis_wr_data_count(),
        .axis_rd_data_count(),

        .almost_full(),
        .almost_empty()
    );
                
        
    // Egress
    rfg_axis_readout_framing #(.MTU_SIZE(16),.IDLE_BYTE(8'hBC),.START_BYTE(8'hEF)) readout_framing(
        .clk(spi_clk),
        .resn(!spi_csn),
        .s_axis_tdata(spi_egress_fifo_m_axis_tdata),
        .s_axis_tid(spi_egress_fifo_m_axis_tid),
        .s_axis_tlast(spi_egress_fifo_m_axis_tlast),
        .s_axis_tready(spi_egress_fifo_m_axis_tready),
        .s_axis_tvalid(spi_egress_fifo_m_axis_tvalid),

        .m_axis_tdata(readout_framing_m_axis_tdata),
        .m_axis_tready(readout_framing_m_axis_tready),
        .m_axis_tuser(readout_framing_m_axis_tuser),
        .m_axis_tvalid(readout_framing_m_axis_tvalid)
    );
    spi_slave_axis_egress #(.ASYNC_RES(1),.MSB_FIRST(1),.MISO_SIZE(1),.MTU_SIZE(16)) spi_egress(
       
        .s_axis_tdata(readout_framing_m_axis_tdata),
        .s_axis_tready(readout_framing_m_axis_tready),
        .s_axis_tuser(readout_framing_m_axis_tuser),
        .s_axis_tvalid(readout_framing_m_axis_tvalid),

        .spi_clk(spi_clk),
        .resn(!spi_csn),
        .spi_csn(spi_csn),
        .spi_miso(spi_miso)
    );


     //-----------------------------
    // RFG
    //------------------------------
    rfg_axis_protocol  rfg_protocol(
        .aclk(clk_core),
        .aresetn(clk_core_resn),

        .m_axis_tdata(switch_s_tdata[7:0]),
        .m_axis_tdest(switch_s_tdest[7:0]),
        .m_axis_tid(switch_s_tid[7:0]),
        .m_axis_tlast(switch_s_tlast[0]),
        .m_axis_tready(switch_s_tready[0]),
        .m_axis_tvalid(switch_s_tvalid[0]),

        .s_axis_tdata(switch_m_tdata[7:0]),
        .s_axis_tid(switch_m_tid[7:0]),
        .s_axis_tready(switch_m_tready[0]),
        .s_axis_tvalid(switch_m_tvalid[0]),

        .rfg_address(rfg_address),
        .rfg_read(rfg_read),
        .rfg_read_valid(rfg_read_valid),
        .rfg_read_value(rfg_read_value),
        .rfg_write(rfg_write),
        .rfg_write_last(rfg_write_last),
        .rfg_write_value(rfg_write_value)
    );

    //----------------------    
    // SWITCH
    //----------------------
    axis_switch #(.PORTS(3))  axis_switch_swifs_I(
        .clk(clk_core),
        .resn(clk_core_resn),

        .m_axis_tdata(switch_m_tdata),
        .m_axis_tdest(switch_m_tdest),
        .m_axis_tid(switch_m_tid),
        .m_axis_tlast(switch_m_tlast),
        .m_axis_tready(switch_m_tready),
        .m_axis_tuser(),
        .m_axis_tvalid(switch_m_tvalid),

        
        .s_axis_tvalid(switch_s_tvalid),
        .s_axis_tready(switch_s_tready),
        .s_axis_tdata(switch_s_tdata),
        .s_axis_tdest(switch_s_tdest),
        .s_axis_tid(switch_s_tid),
        .s_axis_tlast(switch_s_tlast),
        .s_axis_tuser(24'h0)
        //.s_decode_err()
    );

            
    
   
                

endmodule

        