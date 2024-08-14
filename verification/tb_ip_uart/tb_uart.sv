/**
This Module instantiates UART IP and driver for testing purpose
*/
module tb_uart(

    input wire clk,
    input wire resn,
    input wire rx,
    output wire tx,

    // AXI Stream master port, for received bytes to be written out
    output wire [7:0]              m_axis_tdata,
    output wire                    m_axis_tvalid,
    input  wire                   m_axis_tready,
    output wire [7:0]               m_axis_tid, // Source ID for RFG to route back
    output wire [7:0]            m_axis_tdest, // Destination for RFG Switch

    
    // AXIS slave for received bytes to send out to UART
    // Written to by crossbar in NOC design
    input  wire [7:0]             s_axis_tdata,
    input  wire                   s_axis_tvalid,
    output wire                    s_axis_tready,

    input wire read_reg
);

    wire        apb_penable_i ; 
    wire        apb_psel_i ; 
    wire        apb_pwrite_i ; 
    wire [5:0]  apb_paddr_i ; 
    wire [31:0] apb_pwdata_i ; 
    wire        apb_pready_o ; 
    wire        apb_pslverr_o ; 
    wire [31:0] apb_prdata_o ; 

    // UART
    uart  uart_inst (
        .rxd_i(rx),
        .txd_o(tx),
        .clk_i(clk),
        .rst_n_i(resn),
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


  

  uart_lattice_axis_driver  uart_lattice_axis_driver_inst (
    .clk(clk),
    .resn(resn),
    .m_axis_tdata(m_axis_tdata),
    .m_axis_tvalid(m_axis_tvalid),
    .m_axis_tready(m_axis_tready),
    .m_axis_tid(m_axis_tid),
    .m_axis_tdest(m_axis_tdest),

    .s_axis_tdata(s_axis_tdata),
    .s_axis_tvalid(s_axis_tvalid),
    .s_axis_tready(s_axis_tready),

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
    .read_reg(read_reg)
  );


endmodule