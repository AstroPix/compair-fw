# This file is public domain, it can be freely copied without restrictions.
# SPDX-License-Identifier: CC0-1.0
SHELL=/bin/bash
# Makefile

# defaults
SIM ?= questa
TOPLEVEL_LANG ?= verilog

VERILOG_SOURCES += $(PWD)/tb_uart.sv $(PWD)/../ip/uart.v $(PWD)/../../rtl/lattice/uart_lattice_axis_driver.sv
#VERILOG_SOURCES += $(PWD)/my_design.sv
# use VHDL_SOURCES for VHDL files

# TOPLEVEL is the name of the toplevel module in your Verilog or VHDL file
TOPLEVEL = tb_uart

# MODULE is the basename of the Python test file -define LFCPNX -define LFCPNX_100 -define jd5d00
MODULE ?= sim_uart
WAVES ?= 1
USER_ARGS?=
GUI?=0
RANDOM_SEED=1723034207

export BASE=$(PWD)/../../
export PYTHONPATH := $(shell pwd)/../:$(shell pwd)/../../rtl/top:$(shell pwd)/../../sw:$(shell pwd)/../../vendor/icflow_hdl_240807/hdl_rfg_v1/python:$(shell pwd)/../../vendor/icflow_hdl_240807/cocotb_runner_v1/python:$(PYTHONPATH)


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
