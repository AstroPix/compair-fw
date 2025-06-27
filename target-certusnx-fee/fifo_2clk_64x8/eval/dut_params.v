localparam WADDR_DEPTH = 64;
localparam WDATA_WIDTH = 8;
localparam RADDR_DEPTH = 64;
localparam RDATA_WIDTH = 8;
localparam FIFO_CONTROLLER = "FABRIC";
localparam FWFT = 0;
localparam FORCE_FAST_CONTROLLER = 0;
localparam IMPLEMENTATION = "EBR";
localparam WADDR_WIDTH = 6;
localparam RADDR_WIDTH = 6;
localparam REGMODE = "noreg";
localparam OREG_IMPLEMENTATION = "LUT";
localparam RESETMODE = "sync";
localparam ENABLE_ALMOST_FULL_FLAG = "TRUE";
localparam ALMOST_FULL_ASSERTION = "static-dual";
localparam ALMOST_FULL_ASSERT_LVL = 63;
localparam ALMOST_FULL_DEASSERT_LVL = 62;
localparam ENABLE_ALMOST_EMPTY_FLAG = "TRUE";
localparam ALMOST_EMPTY_ASSERTION = "static-dual";
localparam ALMOST_EMPTY_ASSERT_LVL = 1;
localparam ALMOST_EMPTY_DEASSERT_LVL = 2;
localparam ENABLE_DATA_COUNT_WR = "TRUE";
localparam ENABLE_DATA_COUNT_RD = "TRUE";
localparam FAMILY = "LFCPNX";
`define jd5d00
`define LFCPNX
`define LFCPNX_100
