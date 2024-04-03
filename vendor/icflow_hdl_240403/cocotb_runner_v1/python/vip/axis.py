import cocotb
from cocotb.triggers    import Timer , RisingEdge , FallingEdge , Join
from cocotb.clock       import Clock
from cocotb.queue       import Queue
from enum import Enum

class VAXIS_Slave:
    """Slave Axis connects to master interface"""
    search = "m_axis"


    def __init__( self, dut , clk, queueSize = 16 ) -> None:
        self.dut = dut 
        self.dut.m_axis_tready.value = 0
        self.inputQueue = Queue(maxsize = queueSize )
        self.clk = clk

    def ready(self):
        self.dut.m_axis_tready.value = 1

    def notReady(self):
        self.dut.m_axis_tready.value = 0

    async def monitor_task(self):
        while True:
            self.ready()
            await RisingEdge(self.clk)
            if self.dut.m_axis_tvalid.value == 1:
                await self.inputQueue.put(int(self.dut.m_axis_tdata.value))
                 
            #print(f"QS={self.data_queue.qsize()},AS={self.data_queue.maxsize}")
            ## If queue is full, set not ready
            while self.inputQueue.qsize() == self.inputQueue.maxsize :
                self.notReady()
                await RisingEdge(self.clk)
            self.ready()

    def start_monitor(self):
        self.monitor_task_handle =  cocotb.start_soon(self.monitor_task())
        return self.monitor_task_handle

    async def stop_monitor(self):
        await self.monitor_task_handle.kill()

    async def getBytes(self,count = 1 ):
        res = []
        for i in range (count):
            res.append(await self.inputQueue.get())
        return res


class VAXIS_Master:
    """Master Axis connects to master interface"""
    search = "s_axis"

    data_queue : Queue | None = None

    def __init__( self, dut , clk , queueSize = 16 ) -> None:
        self.dut = dut 
        self.dut.s_axis_tvalid.value = 0
        self.clk = clk 
        self.outputQueue = Queue(maxsize = queueSize)

    def notValid(self):
        self.dut.s_axis_tvalid.value = 0

    def valid(self):
        self.dut.s_axis_tvalid.value = 1

    async def driver_task(self):
        while True:
            byte = await self.outputQueue.get()
            #if waitCycle == True:
            
            # Output byte on next clock cycle
            await RisingEdge(self.clk)
            # Wait until previous byte was taken if necessary
            if self.dut.s_axis_tvalid.value == 1 and self.dut.s_axis_tready == 0:
                while self.dut.s_axis_tready == 0:
                    await RisingEdge(self.clk)

            self.valid()
            self.dut.s_axis_tdata.value = byte

            # If Slave was ready, byte is accepted
            #if self.dut.s_axis_tready == 1:
            #    continue 
            #else:
            #    while self.dut.s_axis_tready == 0:
            #        await RisingEdge(self.clk)
            
            ## If empty, stop
            if self.outputQueue.empty() == True: 
                await RisingEdge(self.clk)
                self.notValid()

            

    def start_driver(self):
        self.driver_task_handle =  cocotb.start_soon(self.driver_task())
        return self.driver_task_handle

    async def writeBytes(self,bytes):
        for b in bytes:
            await self.outputQueue.put(b)

    