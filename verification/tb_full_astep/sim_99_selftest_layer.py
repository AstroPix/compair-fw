import sys
import os
import os.path

import rfg.core
import cocotb
from cocotb.triggers    import Timer,RisingEdge,Join,Combine
from cocotb.clock       import Clock

import vip.cctb
import vip.astropix3

## Import simulation target driver
import astep24_3l_sim

@cocotb.test(timeout_time = 2 , timeout_unit = "ms")
async def test_layer_3_write_dummy_byte(dut):

    ## Get Target Driver
    driver = astep24_3l_sim.getUARTDriver(dut)

    ## Clock/Reset
    await vip.cctb.common_clock_reset(dut)
    #await vip.cctb.common_clock_reset_nexys(dut)
    await Timer(10, units="us")

    await driver.writeLayerBytes(3,[0x00],True)

    ## Read Stat
    await Timer(10, units="us")
    statCounter = await driver.rfg.read_layer_3_stat_idle_counter()
    print("Stat counter: "+str(statCounter))
    await Timer(50, units="us")
