

## RFG  -md $(BASE)/docs/markdown/fw/main_rfg.md
rfg: rtl/top/main_rfg.sv
rtl/top/main_rfg.sv: rtl/top/astep24_3layers.rfg.tcl
	@cd rtl/top/ && icf_rfg ./astep24_3layers.rfg.tcl