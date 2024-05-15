
import sys 
import os 


import  rfg.discovery
from    rfg.cocotb.cocotb_uart import UARTIO
from    rfg.cocotb.cocotb_spi  import SPIIO


from   drivers.boards.board_driver import BoardDriver
from   drivers.gecco.voltageboard import VoltageBoard
from   drivers.gecco.injectionboard import InjectionBoard


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

def getUARTDriver(dut):

    ## Load RF and Setup UARTIO
    firmwareRF = rfg.discovery.loadOneFSPRFGOrFail()

    ## UART
    #########
    if dut._name == "astep24_3l_top":
        rfg_io = UARTIO(dut.uart_rx,dut.uart_tx) ## INtervert Rx/Tx to send to rx and receive from tx!
    else:
        rfg_io = UARTIO(dut.uart_tx_in,dut.uart_rx_out)

    #rfg_io = UARTIO(dut.uart_rx,dut.uart_tx)
    firmwareRF.withIODriver(rfg_io)

    boardDriver = SimBoard(firmwareRF)
    boardDriver.open()

    


    return boardDriver

    