set device "LFCPNX-100"
set device_int "jd5d80"
set package "LFG672"
set package_int "LFG672"
set speed "7_High-Performance_1.0V"
set speed_int "10"
set operation "Commercial"
set family "LFCPNX"
set architecture "jd5d00"
set partnumber "LFCPNX-100-7LFG672C"
set WRAPPER_INST "lscc_fifo_dc_inst"
set WADDR_DEPTH 64
set WDATA_WIDTH 8
set RADDR_DEPTH 64
set RDATA_WIDTH 8
set FIFO_CONTROLLER "FABRIC"
set FWFT 0
set FORCE_FAST_CONTROLLER 0
set IMPLEMENTATION "EBR"
set WADDR_WIDTH 6
set RADDR_WIDTH 6
set REGMODE "noreg"
set OREG_IMPLEMENTATION "LUT"
set RESETMODE "sync"
set ENABLE_ALMOST_FULL_FLAG "TRUE"
set ALMOST_FULL_ASSERTION "static-dual"
set ALMOST_FULL_ASSERT_LVL 63
set ALMOST_FULL_DEASSERT_LVL 62
set ENABLE_ALMOST_EMPTY_FLAG "TRUE"
set ALMOST_EMPTY_ASSERTION "static-dual"
set ALMOST_EMPTY_ASSERT_LVL 1
set ALMOST_EMPTY_DEASSERT_LVL 2
set ENABLE_DATA_COUNT_WR "TRUE"
set ENABLE_DATA_COUNT_RD "TRUE"
set FAMILY "LFCPNX"



if { $radiant(stage) == "premap" } {

    if {$FAMILY == "LIFCL" | $FAMILY == "LFCPNX" | $FAMILY == "LFD2NX" | $FAMILY == "LFMXO5"} {
        set WR_CLK_PERIOD 8
        set RD_CLK_PERIOD 8
        
        if {$FIFO_CONTROLLER == "HARD_IP"} {
            set WR_MAXDLY [expr {$WR_CLK_PERIOD*0.8}]
            set RD_MAXDLY [expr {$RD_CLK_PERIOD*0.8}]
            
            set_max_delay -datapath_only -from [get_cells -hierarchical */*.FIFO16K_MODE_inst] -to [get_cells -hierarchical */*.full_r*.*_inst] $WR_MAXDLY
            set_max_delay -datapath_only -from [get_cells -hierarchical */*.FIFO16K_MODE_inst] -to [get_cells -hierarchical */*.afull_r*.*_inst] $WR_MAXDLY
            set_max_delay -datapath_only -from [get_cells -hierarchical */*.FIFO16K_MODE_inst] -to [get_cells -hierarchical */*.empty_r*.*_inst] $RD_MAXDLY
            set_max_delay -datapath_only -from [get_cells -hierarchical */*.FIFO16K_MODE_inst] -to [get_cells -hierarchical */*.aempty_r*.*_inst] $RD_MAXDLY
            set_false_path -from [get_pins -hierarchical */*.FIFO16K_MODE_inst/EMPTY] -to [get_pins -hierarchical */*.FIFO16K_MODE_inst/EMPTYI]
            set_false_path -from [get_pins -hierarchical */*.FIFO16K_MODE_inst/FULL] -to [get_pins -hierarchical */*.FIFO16K_MODE_inst/FULLI] 
            
            if {$REGMODE == "reg"} {
                set_max_delay -datapath_only -from [get_cells -hierarchical */*.empty_r*.*_inst] -to [get_cells -hierarchical */*.empty_sync_r*.*_inst] $RD_MAXDLY
                set_max_delay -datapath_only -from [get_cells -hierarchical */*.FIFO16K_MODE_inst] -to [get_cells -hierarchical */*.empty_sync_r*.*_inst] $RD_MAXDLY
                set_max_delay -datapath_only -from [get_cells -hierarchical */*.aempty_r*.*_inst] -to [get_cells -hierarchical */*.aempty_sync_r*.*_inst] $RD_MAXDLY
                set_max_delay -datapath_only -from [get_cells -hierarchical */*.FIFO16K_MODE_inst] -to [get_cells -hierarchical */*.aempty_sync_r*.*_inst] $RD_MAXDLY
            }
        }
        
        if {$FIFO_CONTROLLER == "FABRIC" & $IMPLEMENTATION == "LUT" & $radiant(synthesis) == "synpro"} {
            set_false_path -from [get_pins -hierarchical */_FABRIC.u_fifo/*distmem*.*/DO*] -to [get_pins -hierarchical */_FABRIC.u_fifo/DIST.out_raw*.ff_inst/DF]
        }
    
        if {$FIFO_CONTROLLER == "FABRIC" & $IMPLEMENTATION == "LUT" & $radiant(synthesis) == "lse"} {
            set_false_path -from [get_pins -hierarchical */_FABRIC.u_fifo/DIST.distmem*.dpram*/DO*] -to [get_pins -hierarchical */_FABRIC.u_fifo/DIST.out_raw*.ff_inst/DF]
        }
        
    }

}
