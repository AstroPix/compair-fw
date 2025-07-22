module axi_lite_master_driver #(
    parameter ADDR_WIDTH = 32,
    parameter DATA_WIDTH = 32
)(
    input  logic clk,
    input  logic rst_n,

    // AXI4-Lite Master Interface
    output logic [ADDR_WIDTH-1:0] awaddr,
    output logic                  awvalid,
    input  logic                  awready,

    output logic [DATA_WIDTH-1:0] wdata,
    output logic [3:0]            wstrb,
    output logic                  wvalid,
    input  logic                  wready,

    input  logic [1:0]            bresp,
    input  logic                  bvalid,
    output logic                  bready,

    output logic [ADDR_WIDTH-1:0] araddr,
    output logic                  arvalid,
    input  logic                  arready,

    input  logic [DATA_WIDTH-1:0] rdata,
    input  logic [1:0]            rresp,
    input  logic                  rvalid,
    output logic                  rready
);

    // Simple write task
    task automatic axi_write(input [ADDR_WIDTH-1:0] addr, input [DATA_WIDTH-1:0] data);
        begin
            @(posedge clk);
            awaddr  <= addr;
            awvalid <= 1;
            wdata   <= data;
            wstrb   <= 4'b1111;
            wvalid  <= 1;

            // Wait for handshakes
            wait (awready && awvalid);
            awvalid <= 0;
            wait (wready && wvalid);
            wvalid <= 0;

            // Wait for write response
            bready <= 1;
            wait (bvalid);
            bready <= 0;
            @(posedge clk);
        end
    endtask

    // Simple read task
    task automatic axi_read(input [ADDR_WIDTH-1:0] addr, output [DATA_WIDTH-1:0] data_out);
        begin
            @(posedge clk);
            araddr  <= addr;
            arvalid <= 1;

            wait (arready && arvalid);
            arvalid <= 0;

            rready <= 1;
            wait (rvalid);
            data_out = rdata;
            rready <= 0;
            @(posedge clk);
        end
    endtask

    // Init outputs
    initial begin
        awaddr  = 0;
        awvalid = 0;
        wdata   = 0;
        wstrb   = 4'b0000;
        wvalid  = 0;
        bready  = 0;
        araddr  = 0;
        arvalid = 0;
        rready  = 0;
    end

endmodule
