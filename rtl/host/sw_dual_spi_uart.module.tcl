
package require icflow::hdlbuild 
package require icflow::hdlbuild::xilinx 
package require icflow::hdlbuild::lib
package require icflow::hdlbuild::verilog
package require icflow::hdlbuild::spi
package require icflow::hdlbuild::axi
package require icflow::hdlbuild::generate
package require icflow::rfg::hdl

#icflow::hdlbuild::verilog::loadFile     ../rtl/uart/uart_lite_driver.sv
#icflow::hdlbuild::verilog::loadFile     ../rtl/registerfile/rf_protocol_axis.sv

#icflow::hdlbuild::xilinx::loadIP        ../ipsrc/axi_uartlite_core
#icflow::hdlbuild::xilinx::loadIP        ../ipsrc/fifo_axis_2clk_16e_routing
#icflow::hdlbuild::xilinx::loadIP        ../ipsrc/axis_switch_swifs
icflow::hdlbuild::xilinx::loadIPDefinitions $env(BASE)/fw/common/xilinx-ip/definitions
icflow::hdlbuild::verilog::loadFile         ./uart_lite_driver.sv
#icflow::hdlbuild::xilinx::loadIP        ../ipsrc/axi_uartlite_core


icflow::hdlbuild::module sw_dual_spi_uart  {

    - inputs  clk_uart   clk_core 
    - inputs  clk_uart_resn  clk_core_resn
    - io:spi:slave

    - inputs  uart_rx
    - outputs uart_tx

    #- @:finished generate:verilog generated


     ## Switch
    ############
    - +:xilinx:axis_switch axis_switch_swifs sw_switch {

        - clock:domain:connect core

        - io:waive *tuser* "User Bus not used"
        - io:waive *err    "Switch Error not reportable"
        
        ## Master/Slave 0 is for protocol
        ## Master/Slave 1 is for UART
        ## Master/Slave 2 is for SPI
    }
    

    ## UART
    ###########
    - module uart_path {
        - io:pull *_core* *uart*

        - @:finished axis:connect_path uart_driver <-> {igress_fifo egress_fifo}
        - @:finished on:instance axis:connect_to_master sw_switch.m*1*
        - @:finished on:instance axis:connect_to_slave  sw_switch.s*1*

        ## Core
        - +:axi_uartlite_core uart_core {
            - clock:domain:connect uart

            - connect rx        @.uart_rx
            - connect tx        @.uart_tx
        }
        ## Driver
        - +:uart_lite_driver uart_driver {
            - #:AXIS_SOURCE 1
            - #:AXIS_DEST   0

            - clock:domain:connect uart

            - connect M_AXI*            uart_core.s_axi*
            - connect interrupt_uart    uart_core.interrupt

            - io:waive uart_*_* "Helper bus not used"
        }
        
        ## FIFO
        # FIFO to transfer UART clock domain to main CK Domain
        - +:fifo_axis_2clk_16e_routing igress_fifo {
            
            - axis:slave_clock  clk_uart clk_uart_resn
            - axis:master_clock clk_core clk_core_resn

            - io:tie:up s_axis_tlast
            - io:push m_axis_t*
        }

        - +:fifo_axis_2clk_16e_routing egress_fifo {
            
            - axis:master_clock clk_uart clk_uart_resn
            - axis:slave_clock clk_core clk_core_resn

            - io:push s_axis_t*
        }
    }

    ## SPI
    ###########
    - module spi_path {
        - io:pull spi*
        - io:pull *_core* *_spi

        - @:finished axis:connect_path spi_igress  -> igress_fifo
        - @:finished axis:connect_path egress_fifo -> readout_framing -> spi_egress

        - @:finished on:instance axis:connect_to_master sw_switch.m*2*
        - @:finished on:instance axis:connect_to_slave  sw_switch.s*2*

        ## Igress
        ## Reset is Async and chip select is used as reset, not as select
        - +:rfg:spi:slave:axis:igress spi_igress {
            - #:AXIS_SOURCE 2
            - #:AXIS_DEST   0
            - #:ASYNC_RES   1 
            
            - connect spi* @.spi* resn @.spi_csn

            - io:waive err* "Overrun not relevant when CS not used"
        }
        #- +:rfg:spi:slave:axis:igress:to_clk spi_igress_toclk {
        #    - connect clk @.clk_core resn @.clk_core_resn
        #}
        
        - +:fifo_axis_2clk_16e_routing igress_fifo {
            - axis:slave_clock  spi_clk         spi_csn
            - axis:master_clock clk_core        clk_core_resn
            #- directConnect     s_axis_aresetn !spi_csn
            
            - io:push m_axis_t*

            - io:tie:up s_axis_tlast
            - io:waive  s_axis_tlast "Byte Igress not framed"
        }

        ## Egress with Readout framing
        - +:fifo_axis_2clk_16e_routing egress_fifo {
            - axis:slave_clock  clk_core clk_core_resn
            - axis:master_clock spi_clk  spi_csn

            - io:push s_axis_t*

            - io:waive { m*tdest m*tid m*tlast} "Byte Egress has not routing/vid capacity"
        }
        

        - +:rfg:axis:readout_framing readout_framing {
            - connect clk @.spi_clk resn @.spi_csn
        }

        - +:rfg:spi:slave:axis:egress spi_egress {
            - #:ASYNC_RES   1 
            - connect spi* @.spi* resn @.spi_csn
        }

    }

   
    ## Protocol
    ###############
    - +:rfg:axis:protocol rfg_protocol {
        - io:push rfg*

        - connect *clk @.clk_core *resetn @.clk_core_resn

        - axis:connect_to_master sw_switch.m*0*
        - axis:connect_to_slave  sw_switch.s*0*
    }


}

## Generate here
$sw_dual_spi_uart generate:verilog:to  ./sw_dual_spi_uart