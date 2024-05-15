# This file is public domain, it can be freely copied without restrictions.
# SPDX-License-Identifier: CC0-1.0
SHELL=/bin/bash
# Makefile

# defaults
SIM ?= questa
TOPLEVEL_LANG ?= verilog

VERILOG_SOURCES += $(PWD)/counter.v
#VERILOG_SOURCES += $(PWD)/my_design.sv
# use VHDL_SOURCES for VHDL files

# TOPLEVEL is the name of the toplevel module in your Verilog or VHDL file
TOPLEVEL = counter

# MODULE is the basename of the Python test file
MODULE = sim_counter
WAVES ?= 1

# include cocotb's make rules to take care of the simulator setup
include $(shell cocotb-config --makefiles)/Makefile.sim

