
## Top
${BASE}/rtl/top/astep24_3l_top.sv
${BASE}/rtl/top/astep24_3l_top_clocking.sv





## RFG Host
${BASE}/rtl/top/main_rfg.sv

${BASE}/rtl/host/sw_spi_uart.sv

${BASE}/rtl/rfg/ftdi/ftdi_sync_fifo_axis.sv
${BASE}/rtl/rfg/ftdi/ftdi_interface_control_fsm.sv

${BASE}/rtl/rfg/spi/spi_slave_axis_egress.sv
${BASE}/rtl/rfg/spi/spi_slave_axis_igress.sv

${BASE}/rtl/rfg/uart/uart_lite_driver.sv

${BASE}/rtl/rfg/protocol/rfg_axis_protocol_srl_fifo.sv
${BASE}/rtl/rfg/protocol/rfg_axis_protocol.sv
${BASE}/rtl/rfg/protocol/rfg_axis_readout_framing.sv


${BASE}/rtl/axis_switch/axis_switch.sv
${BASE}/rtl/axis_switch/round_robin_arbiter.sv

${BASE}/rtl/utilities/fifo_axis_common.sv
${BASE}/rtl/utilities/mini_fwft_fifo.sv


## Patgen for injection
${BASE}/rtl/layers/sync_async_patgen.sv

## Layer 
-f ${BASE}/rtl/layers/layers_readout_switched.f

## Housekeeping
#-f ${BASE}/rtl/housekeeping/housekeeping_main.f


## Helpers
+incdir+${BASE}/rtl/includes
${BASE}/rtl/utilities/reset_sync.sv
${BASE}/rtl/utilities/edge_detect.sv
${BASE}/rtl/utilities/async_input_sync.sv
${BASE}/rtl/utilities/async_signal_sync.sv
${BASE}/rtl/utilities/resets_synchronizer.sv