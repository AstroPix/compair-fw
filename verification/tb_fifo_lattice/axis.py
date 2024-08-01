import cocotb
from cocotb.triggers    import Timer , RisingEdge , FallingEdge , Join
from cocotb.clock       import Clock
from cocotb.queue       import Queue
from cocotb.binary      import BinaryValue
from enum import Enum

import random

class AxisCycle:
    """This Class represents a Cycle of Axis bus. Used to generate data sequences with pauses"""

    def __init__(self,data,empty:bool = False , last : bool = False ):
        self.data = data
        self.last = last
        self.empty = empty 

    def isEmpty(self):
        return self.empty

    def getData(self):
        return self.data

class AXIS_Slave_Monitor:



    def __init__( self, dut , clk):
        self.dut = dut 
        self.outputQueue = Queue(maxsize = 4096 )
        self.clk = clk

    def isValid(self):
        return True if self.dut.m_axis_tvalid.value.is_resolvable and self.dut.m_axis_tvalid.value == 1 and self.dut.m_axis_tready.value == 1  else False

    def getData(self):
        """Builds an int by going over the single bits"""
        resVal = 0
        for i in range(8):
            resVal |= (self.dut.m_axis_tdata[i].value << i)
        return resVal

    async def monitor_task(self):
        while True:
            await FallingEdge(self.clk)
            if self.isValid():
                self.dut._log.debug(f"AXIS Slave Monitor: received byte ({self.outputQueue.qsize()+1})")
                cycle = AxisCycle(data = self.getData() , empty = False)
                await self.outputQueue.put(cycle)

    def start_monitor(self):
        self.monitor_task_handle =  cocotb.start_soon(self.monitor_task())
        return self.monitor_task_handle

    async def stop_monitor(self):
        await self.monitor_task_handle.kill()

    
    async def getBytes(self,count = 1 ):
        res = []
        for i in range (count):
            cycle = await self.outputQueue.get()
            if cycle.empty == False:
                res.append(cycle.data)
        return res
    
    async def getAllBytes(self):
        return await self.getBytes(self.getBytesCount())

    def getBytesCount(self):
        return self.outputQueue.qsize()


class AXIS_Master_Monitor:
  

    def __init__( self, dut , clk, emptyCycles = False):
        self.dut = dut 
        self.outputQueue = Queue(maxsize = 4096 )
        self.clk = clk
        self.emptyCycles = emptyCycles

    def isValid(self):
        return True if self.dut.s_axis_tvalid.value.is_resolvable and self.dut.s_axis_tvalid.value == 1 and self.dut.s_axis_tready.value == 1  else False

    def isReadyNoData(self):
        return True if self.dut.s_axis_tvalid.value.is_resolvable and self.dut.s_axis_tvalid.value == 0 and self.dut.s_axis_tready.value == 1  else False

    def getData(self):
        """Builds an int by going over the single bits"""
        resVal = 0
        ##self.dut._log.info(f"Found Data on sink {self.dut.m_axis_tdata.value.binstr}")
        for i in range(8):
            resVal |= (self.dut.s_axis_tdata[i].value << i)
        return resVal

    async def monitor_task(self):
        while True:
            await FallingEdge(self.clk)
            # self.dut.m_axis_tvalid.value.is_resolvable and self.dut.m_axis_tvalid.value == 1
            if self.isValid():

                self.dut._log.debug(f"AXIS Master Monitor: received byte (queuesize={self.outputQueue.qsize()+1})")
                cycle = AxisCycle(data = self.getData() , empty = False)
                await self.outputQueue.put(cycle)

            elif self.isReadyNoData() and self.emptyCycles:

                self.dut._log.debug("AXIS Master Monitor: Empty data cycle")
                cycle = AxisCycle(data = 0 , empty = True)
                await self.outputQueue.put(cycle)
                

    def start_monitor(self):
        self.monitor_task_handle =  cocotb.start_soon(self.monitor_task())
        return self.monitor_task_handle

    async def stop_monitor(self):
        await self.monitor_task_handle.kill()


    async def getBytes(self,count = 1 ):
        res = []
        for i in range (count):
            cycle = await self.outputQueue.get()
            if cycle.empty == False:
                res.append(cycle.data)
        return res
    
    async def getAllBytes(self):
        return await self.getBytes(self.getBytesCount())

    def getBytesCount(self):
        return self.outputQueue.qsize()

class AXIS_Slave_Driver:


    def __init__( self, dut , clk , offset = 0 ,  queueSize = 4096 ) -> None:
        self.dut = dut
        self.clk = clk

    def reset(self):
        self.notReady()

    def ready(self):
        self.dut.m_axis_tready.value = 1

    def notReady(self):
        self.dut.m_axis_tready.value = 0

    def isValid(self):
        return True if self.dut.m_axis_tvalid.value.is_resolvable and self.dut.m_axis_tvalid.value == 1 else False

    def isReady(self):
        return True if self.dut.m_axis_tready.value == 1 else False

    def getData(self):
        """Builds an int by going over the single bits"""
        resVal = 0
        ##self.dut._log.info(f"Found Data on sink {self.dut.m_axis_tdata.value.binstr}")
        for i in range(8):
            resVal |= (self.dut.m_axis_tdata[i].value << i)
        return resVal


class AXIS_Master_Driver:


    def __init__( self, dut , clk , queueSize = 4096 ) -> None:
  
        self.dut = dut 
        self.clk = clk 
        self.outputQueue = Queue(maxsize = queueSize)
  

    def reset(self):
        self.notValid()

    def notValid(self):
        self.dut.s_axis_tvalid.value = 0

    def valid(self):
        self.dut.s_axis_tvalid.value = 1

    def isValid(self):
        return True if self.dut.s_axis_tvalid.value == 1 else False

    def isReady(self):
        return True if self.dut.s_axis_tready.value == 1 else False


    def setData(self,value):
        for i in range(8):
            self.dut.s_axis_tdata[i].value  = (value >> i & 0x1)
       

    async def driver_task(self):
        while True:
            frame = await self.outputQueue.get()
            self.dut._log.info(f"AXIS Master got frame with {len(frame)} bytes")
            for i,axisCycle in enumerate(frame):
                
                # Data contained in cycle.data parameter
                byte = axisCycle.data

                #byte = await self.outputQueue.get()
                #if waitCycle == True:
                
                # Output byte on next clock cycle
                await RisingEdge(self.clk)
                

                

                ## If the cycle has no data, don't set valid
                if axisCycle.data is None:
                    self.dut._log.info(f"AXIS Master writing empty Cycle")
                    self.notValid()
                else:
                    self.dut._log.info(f"AXIS Master writing byte {hex(byte)}")
                    self.valid()
                    self.setData(byte)

                # Wait until previous byte was taken if necessary
                # Do this on next edge to avoid sync issues with simulator
                await FallingEdge(self.clk)
                if  not self.isReady():
                    self.dut._log.info("AXIS Master waiting for ready")
                    while not self.isReady():
                        await FallingEdge(self.clk)

            ## If empty, stop
            if self.outputQueue.empty() == True: 
                await RisingEdge(self.clk)
                self.notValid()

            

    def start_driver(self):
        self.driver_task_handle =  cocotb.start_soon(self.driver_task())
        return self.driver_task_handle

    async def writeFrame(self,cycles):
        await self.outputQueue.put(cycles)

    async def writeByte(self,b):
        await self.writeFrame([AxisCycle(b)])

    async def generateDataCycles(self,count,pausesRandMin = 0,pausesRandMax=0):
        """Generate some Axys Data Cycles and add them to the queue - Returns the raw bytes generated"""
        res = []
        bytes = []
        for i in range(count):
            # Generate data cycle
            b = random.randint(1,128)
            res.append(AxisCycle(b))
            bytes.append(b)

            # Generate some pauses if requested
            if pausesRandMax>pausesRandMin:
                for j in range(random.randint(pausesRandMin,pausesRandMax)):
                    res.append(AxisCycle(None,True))

        await self.outputQueue.put(res)
        return bytes

    