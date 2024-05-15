


import sys
import os
import os.path

#sys.path.append(os.path.dirname(__file__)+"/.generated/")

import cocotb
from cocotb.triggers    import Timer,RisingEdge
from cocotb.clock       import Clock

import vip.cctb
import vip.astropix3

import vip.spi
vip.spi.info()

## Import simulation target driver
import astep24_3l_sim

@cocotb.test(timeout_time = 0.5 , timeout_unit = "ms")
async def test_layer_0_spi_mosi(dut):

    ## Get Target Driver
    driver = astep24_3l_sim.getUARTDriver(dut)

    ## Clock/Reset
    await vip.cctb.common_clock_reset(dut)
    await Timer(10, units="us")
   
    ## Create SPI Slave
    slave = vip.spi.VSPISlave(clk = dut.layer_0_spi_clk, csn = dut.layer_0_spi_csn,mosi=dut.layer_0_spi_mosi,miso=dut.layer_0_spi_miso)
    slave.start_monitor()

    ## Write MOSI Bytes to Layer
    await driver.setLayerReset(layer = 0, reset = False)
    await driver.writeLayerBytes(layer = 0 , bytes = [0xAB],flush=True)
    assert (await slave.getByte()) == 0xAB

    ## Check IDLE byte counter, we are getting 2 bytes on MISO for one send byte on MOSI
    assert (await driver.getLayerStatIDLECounter(0)) == 2

    ## Write 2 MOSI Bytes to Layer
    await driver.writeLayerBytes(layer = 0 , bytes = [0xCD,0xEF],flush=True)
    assert (await slave.getByte()) == 0xCD
    assert (await slave.getByte()) == 0xEF

    assert (await driver.getLayerStatIDLECounter(0)) == 6

    await Timer(50, units="us")

@cocotb.test(timeout_time = 1 , timeout_unit = "ms",skip = False)
async def test_layers_spi_mosi(dut):

    ## Setup
    driver = astep24_3l_sim.getUARTDriver(dut)
    await vip.cctb.common_clock_reset(dut)
    await Timer(10, units="us")

    ## Create SPI Slaves
    spiSlaves = []
    slave = vip.spi.VSPISlave(clk = dut.layer_0_spi_clk, csn = dut.layer_0_spi_csn,mosi=dut.layer_0_spi_mosi,miso=dut.layer_0_spi_miso)
    slave.start_monitor()
    spiSlaves.append(slave)

    slave = vip.spi.VSPISlave(clk = dut.layer_1_spi_clk, csn = dut.layer_1_spi_csn,mosi=dut.layer_1_spi_mosi,miso=dut.layer_1_spi_miso)
    slave.start_monitor()
    spiSlaves.append(slave)

    slave = vip.spi.VSPISlave(clk = dut.layer_2_spi_clk, csn = dut.layer_2_spi_csn,mosi=dut.layer_2_spi_mosi,miso=dut.layer_2_spi_miso)
    slave.start_monitor()
    spiSlaves.append(slave)

        

    ## Send Bytes to all layers
    for i in range(4):
        await driver.setLayerReset(layer = i, reset = False)
        await driver.writeLayerBytes(layer = i , bytes = [0x01,0x02],flush=True)

    ## Check
    for i in range(4):
        if i < 3:
            assert (await spiSlaves[i].getByte()) == 0x01
            assert (await spiSlaves[i].getByte()) == 0x02
        
        ## Check IDLE byte counter, we are getting 2 bytes on MISO for one send byte on MOSI
        assert (await driver.getLayerStatIDLECounter(i)) == 4
        dut._log.info(f"Checked Bytes and Counter for layer={i}")

    await Timer(50, units="us")
