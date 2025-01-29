
import sys
import os

import cocotb
from cocotb.triggers    import Timer,RisingEdge
from cocotb.clock       import Clock
from cocotbext.uart import UartSource, UartSink

import vip.cctb

## Import simulation target driver
from vip import astep24_3l_sim



@cocotb.test(timeout_time = 2 , timeout_unit = "ms")
async def test_fw_id_uart(dut):

    driver =  await astep24_3l_sim.getUARTDriver(dut)
    await vip.cctb.common_clock_reset(dut)
    await Timer(10, units="us")
    

    ## Read Firmware Type
    version = await driver.readFirmwareVersion()
    print("Version: ",version)
    assert version == 0xffab

    ## Read Firmware ID
    id = await driver.readFirmwareID()
    print("FW ID:",hex(id))
    assert id == 0xff00


@cocotb.test(timeout_time = 1 , timeout_unit = "ms" , skip=False)
async def test_fw_id_spi(dut):

    
    await vip.cctb.common_clock_reset(dut)
    await Timer(10, units="us")
    driver = await astep24_3l_sim.getDriver(dut)
    

    ## Read Firmware Type
    version = await driver.readFirmwareVersion()
    print(f"Version: {hex(version)}")
    assert version == 0xffab

    ## Read Firmware ID
    id = await driver.readFirmwareID()
    print(f"FW ID: {hex(id)}")
    assert id == 0xff00

    await driver.close()
    await Timer(50, units="us")
