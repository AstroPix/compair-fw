


import sys
import os
import os.path

#sys.path.append(os.path.dirname(__file__)+"/.generated/")

import cocotb
from cocotb.triggers    import Timer,RisingEdge
from cocotb.clock       import Clock

import vip.cctb

import vip.spi
vip.spi.info()

## Import simulation target driver
import astep24_3l_sim

@cocotb.test(timeout_time = 1 , timeout_unit = "ms")
async def test_hk_ext_spi_adc(dut):

    ## Init Driver
    driver = astep24_3l_sim.getUARTDriver(dut)
    await vip.cctb.common_clock_reset(dut)
    await Timer(10, units="us")
   
    ## Create VIP SPi Slave
    slave = vip.spi.VSPISlave(clk = dut.ext_spi_clk, csn = dut.ext_adc_spi_csn,mosi=dut.ext_spi_mosi,miso = dut.ext_adc_spi_miso,misoSize=1)
    slave.start_monitor()

    ## 
    await driver.houseKeeping.writeADCBytes([0xAB,0xCD])
    

    assert (await slave.getByte()) == 0xAB
    assert (await slave.getByte()) == 0xCD

    await Timer(50, units="us")