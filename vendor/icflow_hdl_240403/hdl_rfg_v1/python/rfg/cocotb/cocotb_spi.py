
import logging

from queue          import Queue 


from   vip.spi      import VSPIMaster

import rfg.core
from   rfg.io.spi   import SPIBytesDecoder

import cocotb
from cocotb.triggers import Join

logger = logging.getLogger(__name__)

def debug():
    logger.setLevel(logging.DEBUG)
    vip.spi.debug()

def info():
    logger.setLevel(logging.INFO)
    vip.spi.info()

class SPIIO(rfg.core.RFGIO):
    """"""

    readout_timeout = 2

    def __init__(self,dut):
        
        ## Init VSPI
        self.spi = vip.spi.VSPIMaster(dut,dut.spi_clk,dut.spi_csn,dut.spi_mosi,dut.spi_miso)

        ## Init Bytes decoder on receiving queue
        self.spiDecoder = SPIBytesDecoder(self.spi.miso_queue)

    def open(self):
        pass
        #cocotb.start_soon(self.spiDecoder.start_protocol_decoding())


    async def writeBytes(self,b : bytearray):
        b.append(0x00)
        b.append(0x00)
        logger.debug("Writing %d bytes",len(b))
        await self.spi.send_frame(b)
        return len(b)

    async def readBytes(self,count : int ) -> bytes:
        ## Wait on the decoding queue
        self.spiDecoder.currentExpectedLength = count
        decodeTask = cocotb.start_soon(self.spiDecoder.run_frame_decoding())
        
        await self.spi.send_frame(map(lambda x: 0x00, range(count+10)))
        readBytes = []
        for x in range(count):
            b = self.spiDecoder.decoded_bytes_queue.get(timeout = self.readout_timeout)
            readBytes.append(b)

        await Join(decodeTask)
        
        return readBytes 
