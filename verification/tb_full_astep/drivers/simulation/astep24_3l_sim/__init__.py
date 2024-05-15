
import sys 
import os 


import  rfg.discovery
from    rfg.cocotb.cocotb_uart import UARTIO
from    rfg.cocotb.cocotb_spi  import SPIIO


from   drivers.boards.board_driver import BoardDriver
from   drivers.gecco.voltageboard import VoltageBoard



class SimBoard(BoardDriver): 

    def __init__(self,rfg):
        BoardDriver.__init__(self,rfg)


    def getVoltageBoard(self):
        vb = VoltageBoard(rfg = self.rfg, slot = 4)
        vb.vsupply  = 2.7
        vb.vcal     = .989
        return vb

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
    rfg_io.open()

    boardDriver = SimBoard(firmwareRF)

    


    return boardDriver

    