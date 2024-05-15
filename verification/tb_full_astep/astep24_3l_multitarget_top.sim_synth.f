
-sv 
-64bit
-access +rw
-define SIMULATION

## Xilinx
-reflib ${UNISIM}/
${XILINX_VIVADO}/data/verilog/src/glbl.v

+define+RFG_FW_ID=32'h0000ff00
+define+RFG_FW_BUILD=32'h0000ff00

## Main Verilog
#${BASE}/fw/astep24-3l/verification/astep24_3l_multitarget_top_func_synth.v
#${BASE}/fw/astep24-3l/verification/astep24_3l_multitarget_top_func_impl.v

${BASE}/fw/astep24-3l/verification/astep24_3l_multitarget_top_time_impl.v
#-sdf ${BASE}/fw/astep24-3l/verification/astep24_3l_multitarget_top_time_impl.sdf