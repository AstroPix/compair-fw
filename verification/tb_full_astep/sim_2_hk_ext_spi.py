


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
from vip import astep24_3l_sim
astep24_3l_sim.info()

@cocotb.test(timeout_time = 3 , timeout_unit = "ms",skip=False)
async def test_hk_ext_spi_adc(dut):

    ## Init Driver
    await vip.cctb.common_clock_reset(dut)
    await Timer(10, units="us")
    driver = await astep24_3l_sim.getDriver(dut,spi = False)

    ## Create VIP SPi Slave
    slave = vip.spi.VSPISlave(clk = dut.ext_spi_clk, csn = dut.ext_adc_spi_csn[0],mosi=dut.ext_spi_mosi,miso = dut.ext_adc_spi_miso,misoSize=1,cpol=0)
    slaveTask = slave.start_monitor()

    ##
    await driver.houseKeeping.writeADCDACBytes([0xAB,0xCD])
    await driver.houseKeeping.selectADC(1)
    await Timer(20, units="us")

    dut._log.info("Wait for Slave Bytes")
    assert (await slave.getByte()) == 0xAB
    assert (await slave.getByte()) == 0xCD
    dut._log.info("Got Slave Bytes")

    await driver.houseKeeping.selectADC(0)

    ## Read buffer
    adcBytesCount = await driver.houseKeeping.getADCBytesCount()
    assert(adcBytesCount == 2)
    adcBytes = await driver.houseKeeping.readADCBytes(adcBytesCount)
    assert(len(adcBytes) ==2)
    await Timer(5, units="us")

    await driver.close()
    await Timer(50, units="us")



@cocotb.test(timeout_time = 1 , timeout_unit = "ms",skip=True)
async def test_hk_ext_spi_dac(dut):

    ## Init Driver
    await vip.cctb.common_clock_reset(dut)
    await Timer(10, units="us")
    driver = await astep24_3l_sim.getDriver(dut)


    ## Create VIP SPi Slave
    slave = vip.spi.VSPISlave(clk = dut.ext_spi_clk, csn = dut.ext_dac_spi_csn,mosi=dut.ext_spi_mosi,miso = dut.ext_adc_spi_miso,misoSize=1,cpol=0)
    slaveTask = slave.start_monitor()

    ##
    await driver.houseKeeping.selectDAC()
    await driver.houseKeeping.writeADCDACBytes([0xAB,0xCD])
    await Timer(50, units="us")
    assert((await driver.houseKeeping.getADCBytesCount())==0)


    slaveByte = await slave.getByte()
    print("Slave Byte: ",slaveByte)
    assert (slaveByte) == 0xAB
    assert (await slave.getByte()) == 0xCD

    await driver.close()
    await Timer(50, units="us")
