package require icflow::hdlbuild::xilinx 

set ::RFG_FW_ID             32'h0000FF00
set ::IC_HDLBUILD_OUTPUTS .generated/rtl
set ::IC_FSP_OUTPUTS      .generated/fsp

## Load base IP definitions from the common folder
## The actual target folder should configure the project using the actual target board ip location
icflow::hdlbuild::xilinx::loadIPDefinitions $env(FW_BASE)/gecco_mr_base/ipsrc/definitions

source $::env(FW_BASE)/astep24-3l/common/astep24_3l_top.module.tcl

$astep24_3l_top generate:verilog:mergeTo  ./.generated