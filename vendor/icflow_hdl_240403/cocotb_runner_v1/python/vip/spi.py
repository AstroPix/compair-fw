import logging

import cocotb
from cocotb.triggers    import Timer , RisingEdge , FallingEdge , Join , First ,Event
from cocotb.clock       import Clock
from cocotb.queue       import Queue

from enum import Enum

ResultCodes = Enum('RES', ['OK','OVERRUN'])

logger = logging.getLogger(__name__)

def debug():
    logger.setLevel(logging.DEBUG)

def info():
    logger.setLevel(logging.INFO)

class VSPISlave():

    ## Queue for Bytes to transmit to master started cycles
    misoQueue : Queue | None

    ## Queue for Bytes Received from MAster
    mosiQueue : Queue | None

    def __init__(self,clk,csn,mosi,miso,misoDefaultValue = 0x3D,misoSize = 2):
        self.clk                = clk 
        self.csn                = csn 
        self.mosi               = mosi 
        self.mosiQueue          = Queue()

        self.miso               = miso
        self.misoSize           = misoSize
        self.misoQueue          = Queue()
        self.misoDefaultValue   = misoDefaultValue
        self.misoDoneEvent      = None 

        
        
        


    async def _monitor(self):
        """This method monitors Chip Select and Clock to get bits from Master, and send bits back"""
        while True:
            await FallingEdge(self.csn)
            bitCounter = 0
            currentByte = 0 
            running = True 

            misoCurrentByte          = self.misoDefaultValue
            misoCurrentByteFromQueue = False 
            misoBitCounter           = 0

            while running:
                ## Wait for clock or chip select deassertion
                await First(FallingEdge(self.clk), RisingEdge(self.clk), RisingEdge(self.csn))
                if self.csn == 1:
                    running = False
                else:
                    ## Write bit on leading edge
                    if self.clk.value == 1:

                        ## Output bit, range over misoSize because Miso can have multiple bits in parallel
                        for bitIndex in range(self.misoSize):
                            if self.misoSize > 1:
                                self.miso[bitIndex].value = (misoCurrentByte >> misoBitCounter) & 0x1
                            else:
                                self.miso.value = (misoCurrentByte >> misoBitCounter) & 0x1
                            misoBitCounter += 1

                        ## Next Byte process 
                        if misoBitCounter == 8:
                            
                            ## Take next byte
                            misoBitCounter = 0
                            if self.misoQueue.empty():
                                
                                ## If the current byte was taken from queue and no bytes anymore in queue, call event set
                                ## This allows another task to wait until all the bytes have been send
                                if misoCurrentByteFromQueue and self.misoDoneEvent != None :
                                    self.misoDoneEvent.set()

                                misoCurrentByteFromQueue    = False
                                misoCurrentByte             = self.misoDefaultValue

                            else:
                                misoCurrentByte             = await self.misoQueue.get()
                                misoCurrentByteFromQueue    = True

                    else:

                        ## Receive bit on falling edge 
                        ## Get bit and pack to byte
                        bit = self.mosi.value
                        currentByte = currentByte | (bit << bitCounter)
                        bitCounter += 1

                        ## Push to Queue if byte reached
                        if bitCounter == 8:
                            logger.info("Received Byte %x",currentByte)
                            await self.mosiQueue.put(currentByte)
                            currentByte = 0
                            bitCounter = 0

    async def getByte(self):
        return await self.mosiQueue.get()

    def start_monitor(self):
        return cocotb.start_soon(self._monitor())

class VSPIMaster():

    clockPeriod = 10
    

    miso_queue : Queue | None = Queue()

    def __init__(self,dut,clk,csn,mosi,miso):
        self.dut    = dut 
        self.clk    = clk 
        self.csn    = csn 
        self.mosi   = mosi
        self.miso   = miso
        self.miso_queue = Queue()
        self.reset()

    def reset(self):
        self.clk.value  = 0 
        self.csn.value  = 1
        self.mosi.value = 0

    async def clock_one_byte(self):
        for cycle in range(8):
            self.clk.value = 1
            await Timer(self.clockPeriod, units="ns")
            self.clk.value = 0
            await Timer(self.clockPeriod, units="ns")

    def assert_chip_select(self):
        self.csn.value = 0
    
    def deassert_chip_select(self):
        self.csn.value = 1

    async def chip_select_reset(self,count : int):
        await self.send_frame(map(lambda x: 0x00, range(count)),use_chip_select = True,no_readout=True)
        await self.send_frame(map(lambda x: 0x00, range(count)),use_chip_select = False,no_readout=True)
        
    async def send_frame(self,toSend : bytes, use_chip_select : bool = False, no_readout : bool = False):

        ## Start frame
        if use_chip_select :
            self.csn.value = 0
        await Timer(200,units="ns")
        
        for byte in toSend:
            clocking = cocotb.start_soon(self.clock_one_byte())
            logger.debug("Writing byte %x",byte)
            rcv = 0 
            for i in range(8):
                await RisingEdge(self.clk)
                self.mosi.value = (byte >> i) & 1
                await FallingEdge(self.clk)
                if not no_readout and ( not use_chip_select or self.csn == 0) :
                    ## MSB first
                    rcv = rcv | (self.miso.value << (7-i))
            
            # Save miso byte and wait for clock to be done
            if not no_readout:
                await self.miso_queue.put(rcv)
            await Join(clocking)

        ## End of frame
        await Timer(200,units="ns")
        result = ResultCodes.OK 
        #print("Dir: ",dir(self.dut))
        if "err_overrun" in dir(self.dut) and self.dut.err_overrun.value == 1 :
            result = ResultCodes.OVERRUN
        self.csn.value = 1
        await Timer(200,units="ns")
        return result
