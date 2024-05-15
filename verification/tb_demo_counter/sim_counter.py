
import cocotb
from cocotb.triggers    import Timer,RisingEdge,FallingEdge, Combine
from cocotb.clock       import Clock

@cocotb.test(timeout_time = 1,timeout_unit="ms")
async def test_clocking_reset(dut):

    ## Clock and reset
    cocotb.start_soon(Clock(dut.clk, 10, units='ns').start())
    dut.resn.value = 0
    dut.enable = 0
    await Timer(1, units="us")
    dut.resn.value = 1
    await Timer(100, units="us")
    dut.enable = 1
    await Timer(100, units="us")