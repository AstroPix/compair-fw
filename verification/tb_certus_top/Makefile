# This file is public domain, it can be freely copied without restrictions.
# SPDX-License-Identifier: CC0-1.0
SHELL=/bin/bash
# Makefile

# defaults
SIM ?= questa
TOPLEVEL_LANG ?= verilog

#VERILOG_SOURCES ?= $(PWD)/certusnx-devboard_impl_1_syn.v
#VERILOG_SOURCES += $(PWD)/my_design.sv
# use VHDL_SOURCES for VHDL files

#VERILOG_SOURCES ?= $(PWD)/../../target-certusnx-devboard/impl_1/certusnx-devboard_impl_1_vo.vo
VERILOG_SOURCES ?= $(PWD)/../../target-certusnx-devboard/impl_1/certusnx-devboard_impl_1_syn.vo

# TOPLEVEL is the name of the toplevel module in your Verilog or VHDL file
TOPLEVEL ?= compair_fpga_top

# MODULE is the basename of the Python test file -define LFCPNX -define LFCPNX_100 -define jd5d00
#MODULE ?= sim_fifo
WAVES ?= 1
USER_ARGS?=
EXTRA_ARGS?=-input xcelium.tcl -vlog_ext .vo -reflib ../xcelium_preparelib/lattice_compiled/lfcpnx $(USER_ARGS)

RANDOM_SEED=1722517216

GUI?=0
TESTCASE?=



#####
export BASE=$(PWD)/../../
export PYTHONPATH := $(shell pwd)/../:$(shell pwd)/../../rtl/top:$(shell pwd)/../../sw:$(shell pwd)/../../vendor/icflow_hdl_240807/hdl_rfg_v1/python:$(shell pwd)/../../vendor/icflow_hdl_240807/cocotb_runner_v1/python:$(PYTHONPATH)

mrproper:
	@rm -Rf sim_build waves.shm 


%.verify: MODULE = $(basename $@)
%.verify: 
	@PYTHONPATH=$(PYTHONPATH) make GUI=$(GUI) MODULE=$(MODULE) TESTCASE=$(TESTCASE) sim
	
# include cocotb's make rules to take care of the simulator setup
include $(shell cocotb-config --makefiles)/Makefile.sim

