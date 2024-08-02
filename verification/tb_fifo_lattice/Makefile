# This file is public domain, it can be freely copied without restrictions.
# SPDX-License-Identifier: CC0-1.0
SHELL=/bin/bash
# Makefile

# defaults
SIM ?= xcelium
TOPLEVEL_LANG ?= verilog

VERILOG_SOURCES += $(PWD)/../../rtl/utilities/fifo_lattice_axis_wrapper.sv $(PWD)/../../rtl/utilities/mini_fwft_fifo.sv $(PWD)/fifo_2clk_64e.v
#VERILOG_SOURCES += $(PWD)/my_design.sv
# use VHDL_SOURCES for VHDL files

# TOPLEVEL is the name of the toplevel module in your Verilog or VHDL file
TOPLEVEL = fifo_lattice_axis_wrapper

# MODULE is the basename of the Python test file
MODULE = sim_fifo
WAVES ?= 1
USER_ARGS?=
EXTRA_ARGS?=-input xcelium.tcl -define LFCPNX -define LFCPNX_100 -define jd5d00 -reflib ../xcelium_preparelib/lattice_compiled/lfcpnx $(USER_ARGS)

RANDOM_SEED=1722517216

inspect: export USER_ARGS=-gui
inspect: sim



# include cocotb's make rules to take care of the simulator setup
include $(shell cocotb-config --makefiles)/Makefile.sim