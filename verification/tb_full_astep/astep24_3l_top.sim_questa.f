+define+SIMULATION
+define+RFG_FW_ID=32'h0000ff00
+define+RFG_FW_BUILD=32'h0000ffAB

## Main Verilog
-f ${BASE}/rtl/top/astep24_3l_top.f


## Lattice sim
${BASE}/verification/ip/fifo_2clk_64x32.v
${BASE}/verification/ip/fifo_2clk_64x8.v
${BASE}/verification/ip/fifo_1clk_1024x32.v
${BASE}/verification/ip/clock_pll_1.v
${BASE}/verification/ip/uart.v

