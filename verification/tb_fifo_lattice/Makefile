# This file is public domain, it can be freely copied without restrictions.
# SPDX-License-Identifier: CC0-1.0
SHELL=/bin/bash
# Makefile

# defaults
SIM ?= xcelium
TOPLEVEL_LANG ?= verilog

VERILOG_SOURCES += $(PWD)/../../rtl/fifo/fifo_axis_common.sv $(PWD)/../../rtl/fifo/mini_fwft_fifo.sv $(PWD)/../../rtl/fifo/fifo_ptr_logic.sv $(PWD)/../ip/fifo_2clk_64x8.v $(PWD)/../ip/fifo_2clk_64x32.v
#VERILOG_SOURCES += $(PWD)/my_design.sv
# use VHDL_SOURCES for VHDL files

# TOPLEVEL is the name of the toplevel module in your Verilog or VHDL file
TOPLEVEL = fifo_axis_common

# MODULE is the basename of the Python test file -define LFCPNX -define LFCPNX_100 -define jd5d00
MODULE ?= sim_fifo
WAVES ?= 1
USER_ARGS?=
GUI?=0
RANDOM_SEED=1723034207

## Arguments for simulator
ifeq ($(SIM),xcelium)
	EXTRA_ARGS?=-input xcelium.tcl -define SIMULATION  -reflib ../xcelium_preparelib/lattice_compiled/lfcpnx -defparam fifo_axis_common.USE_TID=1 $(USER_ARGS)
else
	EXTRA_ARGS?=-define SIMULATION  -reflib ../xcelium_preparelib/lattice_compiled/lfcpnx $(USER_ARGS)
endif

inspect: export USER_ARGS=-gui
inspect: sim



# include cocotb's make rules to take care of the simulator setup
include $(shell cocotb-config --makefiles)/Makefile.sim