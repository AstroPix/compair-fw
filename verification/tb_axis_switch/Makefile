# This file is public domain, it can be freely copied without restrictions.
# SPDX-License-Identifier: CC0-1.0
SHELL=/bin/bash
# Makefile

# defaults
SIM ?= xcelium
TOPLEVEL_LANG ?= verilog

VERILOG_SOURCES += $(PWD)/../../rtl/axis_switch/axis_switch.sv $(PWD)/../../rtl/axis_switch/round_robin_arbiter.sv $(PWD)/../../rtl/utilities/mini_fwft_fifo.sv
#VERILOG_SOURCES += $(PWD)/my_design.sv
# use VHDL_SOURCES for VHDL files

# TOPLEVEL is the name of the toplevel module in your Verilog or VHDL file
TOPLEVEL = axis_switch

# MODULE is the basename of the Python test file -define LFCPNX -define LFCPNX_100 -define jd5d00
MODULE = axis_switch_tb
WAVES ?= 1
USER_ARGS?=
EXTRA_ARGS?=-input xcelium.tcl  -reflib ../xcelium_preparelib/lattice_compiled/lfcpnx $(USER_ARGS)

RANDOM_SEED=1722517216

export PYTHONPATH=$(PWD)/../:$(shell pwd)/../../vendor/icflow_hdl_240807/cocotb_runner_v1/python

inspect: export USER_ARGS=-gui
inspect: sim



# include cocotb's make rules to take care of the simulator setup
include $(shell cocotb-config --makefiles)/Makefile.sim