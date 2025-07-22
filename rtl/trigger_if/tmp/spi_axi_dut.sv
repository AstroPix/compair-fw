module spi_axi_dut (
  input  logic        clk,
  input  logic        rst_n,

  // AXI4-Lite slave interface
  input  logic [31:0] axi_awaddr,
  input  logic [2:0]  axi_awprot,
  input  logic        axi_awvalid,
  output logic        axi_awready,

  input  logic [31:0] axi_wdata,
  input  logic [3:0]  axi_wstrb,
  input  logic        axi_wvalid,
  output logic        axi_wready,

  output logic [1:0]  axi_bresp,
  output logic        axi_bvalid,
  input  logic        axi_bready,

  input  logic [31:0] axi_araddr,
  input  logic [2:0]  axi_arprot,
  input  logic        axi_arvalid,
  output logic        axi_arready,

  output logic [31:0] axi_rdata,
  output logic [1:0]  axi_rresp,
  output logic        axi_rvalid,
  input  logic        axi_rready,

  // SPI Signals
  output logic        spi_clk,
  output logic        spi_mosi,
  input  logic        spi_miso,
  output logic        spi_cs
);

  // ----------------------------
  // Register Map
  // ----------------------------
  typedef enum logic [3:0] {
    REG_CONTROL = 4'h0,
    REG_STATUS  = 4'h4,
    REG_TXDATA  = 4'h8,
    REG_RXDATA  = 4'hC
  } reg_addr_e;

  logic [31:0] control_reg;
  logic [31:0] status_reg;
  logic [7:0]  tx_reg;
  logic [7:0]  rx_reg;

  logic [3:0]  bit_cnt;
  logic        spi_clk_int, spi_clk_en;

  // ----------------------------
  // AXI4-Lite Write Channel
  // ----------------------------
  logic        wr_en;
  logic [31:0] wr_addr, wr_data;

  assign axi_awready = ~axi_awvalid || (axi_awvalid && axi_wvalid);
  assign axi_wready  = axi_awready;

  assign wr_en   = axi_awvalid && axi_wvalid && axi_awready;
  assign wr_addr = axi_awaddr;
  assign wr_data = axi_wdata;

  always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      control_reg <= 32'd0;
      tx_reg      <= 8'd0;
    end else if (wr_en) begin
      case (wr_addr[5:2])
        REG_CONTROL: control_reg <= wr_data;
        REG_TXDATA:  tx_reg      <= wr_data[7:0];
      endcase
    end
  end

  assign axi_bvalid = wr_en;
  assign axi_bresp  = 2'b00;

  // ----------------------------
  // AXI4-Lite Read Channel
  // ----------------------------
  logic        rd_en;
  logic [31:0] rd_addr;

  assign axi_arready = axi_arvalid;
  assign rd_en       = axi_arvalid && axi_arready;
  assign rd_addr     = axi_araddr;

  always_comb begin
    axi_rdata = 32'd0;
    case (rd_addr[5:2])
      REG_CONTROL: axi_rdata = control_reg;
      REG_STATUS:  axi_rdata = status_reg;
      REG_RXDATA:  axi_rdata = {24'd0, rx_reg};
    endcase
  end

  assign axi_rvalid = rd_en;
  assign axi_rresp  = 2'b00;

  // ----------------------------
  // SPI Transmit Logic
  // ----------------------------
  logic spi_active;
  logic [7:0] tx_shift;
  logic [7:0] rx_shift;

  always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      spi_active <= 0;
      spi_clk_en <= 0;
      bit_cnt    <= 0;
      tx_shift   <= 8'd0;
      rx_shift   <= 8'd0;
      status_reg <= 0;
    end else begin
      if (control_reg[0] && ~spi_active) begin
        // Start transmission
        spi_active <= 1;
        spi_clk_en <= 1;
        tx_shift   <= tx_reg;
        bit_cnt    <= 8;
        status_reg <= 0;
      end else if (spi_active && spi_clk_en && spi_clk_int) begin
        tx_shift   <= {tx_shift[6:0], 1'b0};
        rx_shift   <= {rx_shift[6:0], spi_miso};
        bit_cnt    <= bit_cnt - 1;

        if (bit_cnt == 1) begin
          spi_active <= 0;
          spi_clk_en <= 0;
          rx_reg     <= {rx_shift[6:0], spi_miso};
          status_reg <= 1; // Done flag
        end
      end
    end
  end

  // SPI Clock Generation
  logic [2:0] clk_div;
  always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      clk_div    <= 0;
      spi_clk_int <= 0;
    end else if (spi_clk_en) begin
      clk_div <= clk_div + 1;
      if (clk_div == 3'd4)
        spi_clk_int <= ~spi_clk_int;
    end else begin
      spi_clk_int <= 0;
      clk_div <= 0;
    end
  end

  assign spi_clk = spi_clk_int;
  assign spi_cs  = ~spi_active;
  assign spi_mosi = tx_shift[7];

endmodule
