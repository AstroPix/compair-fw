
from cocotb.triggers    import Timer , RisingEdge , FallingEdge , Join , First ,Event
import vip.spi
vip.spi.info()

class Astropix3Model:
    """This Model can be used to return some bytes"""

    def __init__(self,dut,prefix,chipID):
        self.interruptn       = dut._id(prefix+"_interruptn", extended=False)
        self.interruptn.value = 1
        self.chipID           = chipID

        ## Create Slave VIP
        ## Create SPI Slave
        self.spiSlave = vip.spi.VSPISlave(
            clk = dut._id(prefix+"_spi_clk", extended=False), 
            csn = dut._id(prefix+"_spi_csn", extended=False),
            mosi= dut._id(prefix+"_spi_mosi", extended=False),
            miso= dut._id(prefix+"_spi_miso", extended=False),
            misoDefaultValue = 0x3D)
        self.spiSlave.misoDoneEvent = Event("spi_miso_done")
        self.spiSlave.start_monitor()

       

    ## Config
    ###################
    async def loadConfigFromYAML(self, srName: str ):
        """This method loads the list of SR config from YAML - A name must be provided since multiple SR chains can be available in the chip"""

    ## Frame generation
    ############

    async def generateTestFrame(self,length:int,framesCount: int = 1 ): 
        """Generate a Frame of a certain length with a counter as value"""

        print(f"Starting frame generator, queue length={self.spiSlave.misoQueue.qsize()}")

        ## Generate Bytes counter
        for frameI in range(framesCount):
            bytes = []
            await self.spiSlave.misoQueue.put(length | (self.chipID << 3))
            for x in range(length):
                await self.spiSlave.misoQueue.put(x+1)
        
        ## Trigger interrupt
        self.interruptn.value = 0

        ## Wait until sending done
        try:
            await self.spiSlave.misoDoneEvent.wait()
            self.spiSlave.misoDoneEvent.clear()
        except:
            ## Clean queue
            #self.spiSlave.misoQueue._init()
            #print("Timedout finishing")
            for x in range(self.spiSlave.misoQueue.qsize()):
                await self.spiSlave.misoQueue.get()
            #print("Cleared queue")
            #await self.spiSlave.misoQueue.clear()
            #pass
            #print("Wait for done timed out")
        finally:
            ## Release interrupt
            self.interruptn.value = 1
        

        #print("Done frame generator")