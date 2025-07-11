
import sys
import os
import logging


import  rfg.discovery
import  rfg.cocotb.cocotb_spi
from    rfg.cocotb.cocotb_uart import UARTIO
from    rfg.cocotb.cocotb_spi  import SPIIO


from   drivers.boards.board_driver import BoardDriver
from   drivers.gecco.voltageboard import VoltageBoard
from   drivers.gecco.injectionboard import InjectionBoard

from cocotb.triggers import Timer,RisingEdge


logger = logging.getLogger(__name__)
def debug():
    logger.setLevel(logging.DEBUG)
def info():
    logger.setLevel(logging.INFO)

class SimBoard(BoardDriver):

    def __init__(self,rfg):
        BoardDriver.__init__(self,rfg)


    def getVoltageBoard(self,slot : int = 0 ):
        vb = VoltageBoard(rfg = self.rfg, slot = slot)
        vb.vsupply  = 2.7
        vb.vcal     = .989
        return vb

    def getInjectionBoard(self,slot : int = 1):
        ib = InjectionBoard(rfg = self.rfg, slot = slot)
        ib.voltageBoard = None
        return ib

    def getFPGACoreFrequency(self):
        return 60000000


async def getDriver(dut,spi = True):

    if spi is False:
        return await getUARTDriver(dut)
    else:
        return await getSPIDriver(dut)

async def getUARTDriver(dut):

    logger.info("Using UART Driver")

    ## Load RF and Setup UARTIO
    firmwareRF = rfg.discovery.loadOneFSPRFGOrFail()

    ## UART
    #########
    if dut._name == "astep24_20l_top":
        rfg_io = UARTIO(dut.uart_rx,dut.uart_tx,baud = 115200) ## INtervert Rx/Tx to send to rx and receive from tx!
    else:
        rfg_io = UARTIO(dut.ftdi_tx,dut.ftdi_rx,baud = 115200)

    #rfg_io = UARTIO(dut.uart_rx,dut.uart_tx)
    firmwareRF.withIODriver(rfg_io)

    boardDriver = SimBoard(firmwareRF)
    await boardDriver.open()




    return boardDriver


async def getSPIDriver(dut):

    logger.info("Using SPI Driver")

    ## Load RF and Setup UARTIO
    firmwareRF = rfg.discovery.loadOneFSPRFGOrFail()

    ## SPI
    #########
    rfg_io = SPIIO(dut,msbFirst=False)
    await Timer(10, units="us")

    #rfg.cocotb.cocotb_spi.debug()

    ## Sof Reset
    #await rfg_io.softReset()

    firmwareRF.withIODriver(rfg_io)
    #await rfg_io.open()
    await Timer(10, units="us")

    boardDriver = SimBoard(firmwareRF)
    await boardDriver.open()
    await Timer(10, units="us")

    return boardDriver
