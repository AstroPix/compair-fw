# This file is public domain, it can be freely copied without restrictions.
# SPDX-License-Identifier: CC0-1.0
SHELL=/bin/bash
# Makefile

# defaults
SIM ?= xcelium
TOPLEVEL_LANG ?= verilog

VERILOG_SOURCES ?=
#VERILOG_SOURCES += $(PWD)/my_design.sv
# use VHDL_SOURCES for VHDL files

# TOPLEVEL is the name of the toplevel module in your Verilog or VHDL file
TOPLEVEL ?= astep24_3l_top

# MODULE is the basename of the Python test file -define LFCPNX -define LFCPNX_100 -define jd5d00
#MODULE ?= sim_fifo
WAVES ?= 1
USER_ARGS?=
EXTRA_ARGS?=-input xcelium.tcl -f $(PWD)/astep24_3l_top.sim.f  -reflib ../xcelium_preparelib/lattice_compiled/lfcpnx $(USER_ARGS)

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

#%.verify: 
%.verify: MODULE = $(basename $@)
%.verify: 
	@PYTHONPATH=$(PYTHONPATH) make GUI=$(GUI) MODULE=$(MODULE) TESTCASE=$(TESTCASE) sim
	
# include cocotb's make rules to take care of the simulator setup
include $(shell cocotb-config --makefiles)/Makefile.sim

