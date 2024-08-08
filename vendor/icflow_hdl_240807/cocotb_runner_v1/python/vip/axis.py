import cocotb
from cocotb.triggers    import Timer , RisingEdge , FallingEdge , Join
from cocotb.clock       import Clock
from cocotb.queue       import Queue
from cocotb.binary      import BinaryValue
from enum import Enum

import random

class AxisCycle:
    """This Class represents a Cycle of Axis bus. Used to generate data sequences with pauses"""

    def __init__(self,data,tid = None , last : bool = False ):
        self.data = data
        self.last = last
        self.tid = tid

class VAXIS_Slave:
    """Slave Axis connects to master interface"""
    search = "m_axis"


    def __init__( self, dut , clk , offset = 0 ,  queueSize = 4096 ) -> None:
        self.dut = dut 
        self.inputQueue = Queue(maxsize = queueSize )
        self.clk = clk
        self.offset = offset

    def changeQueueSize(self,queueSize):
        self.inputQueue = Queue(maxsize = queueSize )

    def reset(self):
        self.notReady()


    def ready(self):
        self.dut.m_axis_tready[self.offset].value = 1

    def notReady(self):
        self.dut.m_axis_tready[self.offset].value = 0

    def isValid(self):
        return True if self.dut.m_axis_tvalid[self.offset].value.is_resolvable and self.dut.m_axis_tvalid[self.offset].value == 1 else False

    def isReady(self):
        return True if self.dut.m_axis_tready[self.offset].value == 1 else False

    def getData(self):
        """Builds an int by going over the single bits"""
        resVal = 0
        ##self.dut._log.info(f"Found Data on sink {self.dut.m_axis_tdata.value.binstr}")
        for i in range(8):
            resVal |= (self.dut.m_axis_tdata[self.offset*8+i].value << i)
        return resVal

    async def monitor_task(self):
        while True:
            await FallingEdge(self.clk)
            # self.dut.m_axis_tvalid[self.offset].value.is_resolvable and self.dut.m_axis_tvalid[self.offset].value == 1
            if self.isValid() and self.isReady():
                self.dut._log.info(f"[{self.offset}] Got AXIS Slave byte ({self.inputQueue.qsize()+1})")
                await self.inputQueue.put(self.getData())
                 
            #print(f"QS={self.data_queue.qsize()},AS={self.data_queue.maxsize}")
            ## If queue is full, set not ready
            if self.inputQueue.qsize() == self.inputQueue.maxsize:
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
    
    async def getAllBytes(self,count = 1 ):
        return await self.getBytes(self.getBytesCount())

    def getBytesCount(self):
        return self.inputQueue.qsize()


class VAXIS_Master:
    """Master Axis connects to master interface"""
    search = "s_axis"

    data_queue : Queue | None = None

    def __init__( self, dut , clk , offset = 0 , queueSize = 16 ) -> None:
        """Offset is used in case the Interface is connected to a Switch"""
        self.dut = dut 
        self.clk = clk 
        self.outputQueue = Queue(maxsize = queueSize)
        self.offset = offset

    def reset(self):
        self.notValid()
        self.notLast()

    def notValid(self):
        self.dut.s_axis_tvalid[self.offset].value = 0

    def valid(self):
        self.dut.s_axis_tvalid[self.offset].value = 1

    def isValid(self):
        return True if self.dut.s_axis_tvalid[self.offset].value == 1 else False

    def notLast(self):
        self.dut.s_axis_tlast[self.offset].value = 0

    def last(self):
        self.dut.s_axis_tlast[self.offset].value = 1


    def isReady(self):
        return True if self.dut.s_axis_tready[self.offset].value == 1 else False

    def setTid(self,target):
        for i in range(8):
            self.dut.s_axis_tid[self.offset*8+i].value  = (target >> i & 0x1)

    def setTuser(self,val):
        for i in range(8):
            self.dut.s_axis_tuser[self.offset*8+i].value  = (val >> i & 0x1)
    

    def setData(self,value):
        for i in range(8):
            self.dut.s_axis_tdata[self.offset*8+i].value  = (value >> i & 0x1)
       

    async def driver_task(self):
        while True:
            frame = await self.outputQueue.get()
            for i,axisCycle in enumerate(frame):
                
                # Data contained in cycle.data parameter
                byte = axisCycle.data

                #byte = await self.outputQueue.get()
                #if waitCycle == True:
                
                # Output byte on next clock cycle
                await RisingEdge(self.clk)
                

                ## If last, set tlast
                self.dut.s_axis_tlast[self.offset].value = 1 if i == len(frame)-1 else 0

                self.dut._log.info(f"[{self.offset}] AXIS Master writing byte {hex(byte)}")

                ## If the cycle has no data, don't set valid
                if axisCycle.data is None:
                    self.notValid()
                else:
                    self.valid()
                    self.setData(byte)
                    if axisCycle.tid is not None:
                        self.setTid(axisCycle.tid)

                # Wait until previous byte was taken if necessary
                # Do this on next edge to avoid sync issues with simulator
                await FallingEdge(self.clk)
                if  not self.isReady():
                    self.dut._log.info("AXIS Master waiting for ready")
                    while not self.isReady():
                        await FallingEdge(self.clk)

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

    async def writeFrame(self,cycles):
        await self.outputQueue.put(cycles)
        #for b in bytes:
        #    await self.outputQueue.put(b)

    async def generateDataCycles(self,count, tid = 0 , pauses=False):
        """Generate some Axys Data Cycles and add them to the queue - Returns the raw bytes generated"""
        res = []
        bytes = []
        for i in range(count):
            b = random.randint(1,128)
            res.append(AxisCycle(b,tid=tid))
            bytes.append(b)

        res[count-1].last = True
        await self.outputQueue.put(res)
        return bytes

    