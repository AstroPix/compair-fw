


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

@cocotb.test(timeout_time = 5 , timeout_unit = "ms",skip=False)
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
    ###

    ## Reported ADC Bytes should be 2
    adcBytesCount = await driver.houseKeeping.getADCBytesCount()
    assert(adcBytesCount == 2)

    ## Get the bytes
    adcBytes = await driver.houseKeeping.readADCBytes(adcBytesCount)
    assert(len(adcBytes) ==2)

    ## Now should be 0 again
    adcBytesCount = await driver.houseKeeping.getADCBytesCount()
    assert(adcBytesCount == 0)
    await Timer(5, units="us")

    await driver.close()
    await Timer(50, units="us")


@cocotb.test(timeout_time = 5 , timeout_unit = "ms",skip=False)
async def test_hk_ext_spi_readnodata(dut):

    ## Init Driver
    await vip.cctb.common_clock_reset(dut)
    await Timer(10, units="us")
    driver = await astep24_3l_sim.getDriver(dut,spi = False)

    await Timer(50, units="us")
    adcBytes = await driver.houseKeeping.readADCBytes(8)
    assert(len(adcBytes) ==8)

    await Timer(50, units="us")

async def read_adc_channels(driver,adc,firstChannel=0,count=8):

    mosiBytes =[]
    for i in range(count):
        mosiBytes += [firstChannel + i , 0x00]

    await driver.houseKeeping.writeADCDACBytes(mosiBytes)
    await driver.houseKeeping.selectADC(adc)
    await driver.houseKeeping.selectADC(0)

    # Get the bytes
    adcBytesCount = await driver.houseKeeping.getADCBytesCount()
    assert(adcBytesCount == len(mosiBytes))
    adcBytes = await driver.houseKeeping.readADCBytes(adcBytesCount)
    assert(len(adcBytes) ==len(mosiBytes))

    return adcBytes



@cocotb.test(timeout_time = 20 , timeout_unit = "ms",skip=False)
async def test_hk_ext_spi_adc_readchannels(dut):

    ## Init Driver
    await vip.cctb.common_clock_reset(dut)
    await Timer(10, units="us")
    driver = await astep24_3l_sim.getDriver(dut,spi = False)

    ## Create VIP SPi Slave
    slave = vip.spi.VSPISlave(clk = dut.ext_spi_clk, csn = dut.ext_adc_spi_csn[0],mosi=dut.ext_spi_mosi,miso = dut.ext_adc_spi_miso,misoSize=1,cpol=0)
    slaveTask = slave.start_monitor()

    await Timer(50, units="us")

    ## Read first ADC
    await read_adc_channels(driver,adc = 1, firstChannel = 0,count = 1)
    await read_adc_channels(driver,adc = 2, firstChannel = 0,count = 8)
    #await read_adc_channels(driver,adc = 3, channels = 8)

    await Timer(50, units="us")