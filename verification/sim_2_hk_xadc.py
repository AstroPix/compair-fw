
import cocotb
from cocotb.triggers    import Timer,RisingEdge,FallingEdge
from cocotb.clock       import Clock

import vip.cctb

## Import simulation target driver
import astep24_3l_sim

@cocotb.test(timeout_time = 1 , timeout_unit = "ms")
async def test_xadc_read_temperature(dut):

    ## Init Driver
    board = astep24_3l_sim.getUARTDriver(dut)

    ## Reset/Clock
    await vip.cctb.common_clock_reset(dut)
    await Timer(10, units="us")

    ## Wait for the first trigger to happen
    await FallingEdge(dut.housekeeping.xadc_temperature_write)

    ## Read temperature
    temperature = await board.houseKeeping.readFPGATemperature()
    print("Temperature: ",temperature)
    assert temperature == 63.0
    await Timer(100, units="us")