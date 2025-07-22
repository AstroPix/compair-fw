module spi_axi_tb;

  // Clock and Reset
  logic clk;
  logic rst_n;

  // AXI4-Lite Interface Signals
  logic [31:0] axi_awaddr, axi_araddr, axi_wdata;
  logic [2:0]  axi_awprot, axi_arprot;
  logic        axi_awvalid, axi_arvalid, axi_wvalid;
  logic        axi_awready, axi_arready, axi_wready;
  logic        axi_bvalid, axi_rvalid;
  logic [1:0]  axi_bresp, axi_rresp;
  logic        axi_bready, axi_rready;
  logic [31:0] axi_rdata;
  logic [3:0]  axi_wstrb;

  // SPI Signals
  logic spi_clk;
  logic spi_mosi;
  logic spi_miso;
  logic spi_cs;

axi_lite_master_driver #(.ADDR_WIDTH (32), .DATA_WIDTH(32))
axi_m (
  .clk(clk),
  .rst_n(rst_n),

  .awaddr   (axi_awaddr),
  .awvalid  (axi_awvalid),
  .awready  (axi_awready),

  .wdata    (axi_wdata),
  .wstrb    (axi_wstrb),
  .wvalid   (axi_wvalid),
  .wready   (axi_wready),

  .bresp    (axi_bresp),
  .bvalid   (axi_bvalid),
  .bready   (axi_bready),

  .araddr   (axi_araddr),
  .arvalid  (axi_arvalid),
  .arready  (axi_arready),

  .rdata    (axi_rdata),
  .rresp    (axi_rresp),
  .rvalid   (axi_rvalid),
  .rready   (axi_rready)

//  .wr_en(wr_en), .wr_addr(wr_addr), .wr_data(wr_data), .wr_done(wr_done),
//  .rd_en(rd_en), .rd_addr(rd_addr), .rd_data(rd_data), .rd_done(rd_done)
);

  // DUT Instance
  spi_axi_dut u_dut (
    .clk        (clk),
    .rst_n      (rst_n),

    .axi_awaddr (axi_awaddr),
    .axi_awprot (axi_awprot),
    .axi_awvalid(axi_awvalid),
    .axi_awready(axi_awready),

    .axi_wdata  (axi_wdata),
    .axi_wstrb  (axi_wstrb),
    .axi_wvalid (axi_wvalid),
    .axi_wready (axi_wready),

    .axi_bresp  (axi_bresp),
    .axi_bvalid (axi_bvalid),
    .axi_bready (axi_bready),

    .axi_araddr (axi_araddr),
    .axi_arprot (axi_arprot),
    .axi_arvalid(axi_arvalid),
    .axi_arready(axi_arready),

    .axi_rdata  (axi_rdata),
    .axi_rresp  (axi_rresp),
    .axi_rvalid (axi_rvalid),
    .axi_rready (axi_rready),

    .spi_clk    (spi_clk),
    .spi_mosi   (spi_mosi),
    .spi_miso   (spi_miso),
    .spi_cs     (spi_cs)
  );

  // Clock Generator
  always #5 clk = ~clk;

  // Reset Generator
  initial begin
    clk = 0;
    rst_n = 0;
    #100 rst_n = 1;
  end

  // AXI Master Task: Write
  task axi_write(input [31:0] addr, input [31:0] data);
    begin
      axi_awaddr <= addr;
      axi_awvalid <= 1;
      axi_awprot <= 3'b000;

      axi_wdata <= data;
      axi_wvalid <= 1;
      axi_wstrb <= 4'b1111;

      wait (axi_awready && axi_wready);
      axi_awvalid <= 0;
      axi_wvalid <= 0;

      axi_bready <= 1;
      wait (axi_bvalid);
      axi_bready <= 0;
    end
  endtask

  // AXI Master Task: Read
  task axi_read(input [31:0] addr, output [31:0] data_out);
    begin
      axi_araddr <= addr;
      axi_arvalid <= 1;
      axi_arprot <= 3'b000;

      wait (axi_arready);
      axi_arvalid <= 0;

      axi_rready <= 1;
      wait (axi_rvalid);
      data_out <= axi_rdata;
      axi_rready <= 0;
    end
  endtask

    logic [31:0] rx_data;
  // Test Procedure
  initial begin

    wait(rst_n == 1);

    // SPI enable (write to control register)
    axi_write(32'h00, 32'h00000001); // Enable SPI

    // Send byte over SPI
    axi_write(32'h08, 32'h000000A5); // TX data

    // Optional: Read status or wait for completion
    #200;

    // Read back RX data
    axi_read(32'h0C, rx_data);
    $display("Received SPI data: %h", rx_data);

    #1000 $finish;
  end

endmodule
