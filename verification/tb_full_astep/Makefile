# This file is public domain, it can be freely copied without restrictions.
# SPDX-License-Identifier: CC0-1.0
SHELL=/bin/bash
# Makefile

# defaults
SIM ?= questa
TOPLEVEL_LANG ?= verilog

VERILOG_SOURCES ?= $(PWD)/../../rtl/top/tmp/astep24_3l_top.sv $(PWD)/../../rtl/top/tmp/astep24_3l_top_clocking.sv  \
 $(PWD)/../../rtl/top/tmp/main_rfg.sv  $(PWD)/../../rtl/host/sw_spi_uart.sv $(PWD)/../../rtl/rfg/ftdi/ftdi_sync_fifo_axis.sv \
 $(PWD)/../../rtl/rfg/ftdi/ftdi_sync_fifo_axis.sv $(PWD)/../../rtl/rfg/ftdi/ftdi_interface_control_fsm.sv \
 $(PWD)/../../rtl/rfg/spi/spi_slave_axis_egress.sv $(PWD)/../../rtl/rfg/spi/spi_slave_axis_igress.sv \
 $(PWD)/../../rtl/lattice/uart_lattice_axis_driver.sv $(PWD)/../../rtl/rfg/protocol/rfg_axis_protocol.sv \
 $(PWD)/../../rtl/rfg/protocol/rfg_axis_readout_framing.sv $(PWD)/../../rtl/axis_switch/axis_switch.sv \
 $(PWD)/../../rtl/axis_switch/round_robin_arbiter.sv $(PWD)/../../rtl/fifo/fifo_axis_common.sv \
 $(PWD)/../../rtl/fifo/mini_fwft_fifo.sv $(PWD)/../../rtl/fifo/fifo_ptr_logic.sv \
 $(PWD)/../../rtl/layers/sync_async_patgen.sv $(PWD)/../../rtl/layers/loopback_spi_if.sv \
 $(PWD)/../../rtl/layers/layers_readout_switched.sv $(PWD)/../../rtl/layers/layer_if_a.sv \
 $(PWD)/../../rtl/layers/astropix_spi_protocol_av1.sv $(PWD)/../../rtl/spi/spi_axis_if_v1.sv \
 $(PWD)/../../rtl/housekeeping/housekeeping_main.sv $(PWD)/../../rtl/utilities/async_input_sync.sv \
$(PWD)/../ip/gsr.v $(PWD)/../ip/clock_pll_1.v  $(PWD)/../ip/fifo_1clk_1024x32.v  $(PWD)/../ip/fifo_2clk_64x32.v \
$(PWD)/../ip/fifo_2clk_64x8.v 

#VERILOG_SOURCES += $(PWD)/my_design.sv
# use VHDL_SOURCES for VHDL files

# TOPLEVEL is the name of the toplevel module in your Verilog or VHDL file
TOPLEVEL ?= astep24_3l_top

# MODULE is the basename of the Python test file -define LFCPNX -define LFCPNX_100 -define jd5d00
#MODULE ?= sim_fifo
WAVES ?= 1
USER_ARGS?=
#EXTRA_ARGS?=-input xcelium.tcl -f $(PWD)/astep24_3l_top.sim.f  -reflib ../xcelium_preparelib/lattice_compiled/lfcpnx $(USER_ARGS)
EXTRA_ARGS?=-L ../xcelium_preparelib/lattice_compiled/lfcpnx $(USER_ARGS)

RANDOM_SEED=1722517216
GUI?=0
TESTCASE?=
MODULE?=$(shell echo $(basename $(wildcard sim*.py)) | tr ' ' ',')


#####
export BASE=$(PWD)/../../
export PYTHONPATH := $(shell pwd)/../:$(shell pwd)/../../rtl/top:$(shell pwd)/../../sw:$(shell pwd)/../../vendor/icflow_hdl_240807/hdl_rfg_v1/python:$(shell pwd)/../../vendor/icflow_hdl_240807/cocotb_runner_v1/python:$(PYTHONPATH)

verify.full:
	@echo "Modules: $(MODULE)"
#@PYTHONPATH=$(PYTHONPATH) make GUI=$(GUI) sim

## Arguments for simulator
ifeq ($(SIM),xcelium)
        EXTRA_ARGS?=-input xcelium.tcl -define SIMULATION +incdir+$(PWD)/../../rtl/includes  -reflib ../xcelium_preparelib/lattice_compiled/lfcpnx $(USER_ARGS)
else
        EXTRA_ARGS?=-define SIMULATION  -reflib ../xcelium_preparelib/lattice_compiled/lfcpnx $(USER_ARGS)
endif

inspect: export USER_ARGS=-gui
inspect: sim

# include cocotb's make rules to take care of the simulator setup
include $(shell cocotb-config --makefiles)/Makefile.sim

#%.verify: 
%.verify: MODULE = $(basename $@)
%.verify: 
	@PYTHONPATH=$(PYTHONPATH) make GUI=$(GUI) MODULE=$(MODULE) TESTCASE=$(TESTCASE) sim
	

