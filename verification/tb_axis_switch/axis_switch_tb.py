

import cocotb
from cocotb.binary      import BinaryValue
from cocotb.triggers    import Timer,RisingEdge,FallingEdge, Combine
from cocotb.clock       import Clock

from vip.axis import VAXIS_Master, VAXIS_Slave , AxisCycle

import random 

async def common_clock(dut):
    cocotb.start_soon(Clock(dut.clk, 10, units='ns').start())
    await RisingEdge(dut.clk)


class MasterIf(): 

    def __init__(self,dut,port):
        self.dut = dut
        self.port = port 

    def reset(self):
        self.dut.m_axis_tvalid[self.port].value = 0
        self.set_tid(0)
        #tid =  BinaryValue(value = 0, n_bits = 8)
        #for i in range(8):
        #    self.dut.m_axis_tid[self.port*8+i].value  = int(tid.binstr[7-i])
        #self.dut.m_axis_tid[self.port*8:self.port*8+8].value  = BinaryValue(value = 0, n_bits = 8)

    def valid(self,target:int):
        self.dut.m_axis_tvalid[self.port].value = 1
        self.set_tid(target)
        #self.dut.m_axis_tid[self.port*8:self.port*8+8].value = BinaryValue(value = target, n_bits = 8)

    def set_tid(self,target:int):
        tid =  BinaryValue(value = target, n_bits = 8)
        for i in range(8):
            self.dut.m_axis_tid[self.port*8+i].value  = int(tid.binstr[i])


class SlaveIf(): 

    def __init__(self,dut,port):
        self.dut = dut
        self.port = port 

    def reset(self):
        self.dut.s_axis_tready[self.port].value = 0
       

    def ready(self):
        self.dut.s_axis_tready[self.port].value = 1
     


async def init_clocking_interfaces(dut):
    ## Clk 
    dut.clk.value = 0
    await common_clock(dut)
    
    ## Create and reset Masters
    masters = []
    slaves = []
    for i in range(4):
        print(f"Creating MasterIf {i}")
        #masters.append(MasterIf(dut,port=i))
        masters.append(VAXIS_Master(dut,dut.clk,offset=i))
        masters[i].reset()
        masters[i].setTid(0)
        masters[i].setTuser(i)
        masters[i].start_driver()

        slaves.append(VAXIS_Slave(dut,dut.clk,offset=i))
        slaves[i].reset()
        slaves[i].start_monitor()
        

    ## Reset
    dut.resn.value = 0
    await Timer(2, units="us")
    dut.resn.value = 1
    await Timer(2, units="us")

    return masters,slaves

@cocotb.test(timeout_time = 1,timeout_unit="ms")
async def test_simple_2bytes_2frames(dut):

    ## Init
    sources, sinks = await init_clocking_interfaces(dut)
        
    ## Set Slave Ready
    sinks[1].ready()
    sinks[2].ready()

    ## Write some bytes targeting 2
    ##############
    sources[0].setTdest(2)
    await sources[0].writeFrame([AxisCycle(0xAB),AxisCycle(0xCD)])

    ## Check number of bytes received on slave
    await Timer(100, units="us")
    slaveBytesCount = sinks[2].getBytesCount()
    dut._log.info(f"Number of bytes received on Slave 2: {slaveBytesCount}")
    assert(2 == slaveBytesCount)

    ## Write some bytes targetting 1
    sources[0].setTdest(1)
    await sources[0].writeFrame([AxisCycle(0xAB),AxisCycle(0xCD)])
    await Timer(100, units="us")

    slaveBytesCount = sinks[1].getBytesCount()
    dut._log.info(f"Number of bytes received on Slave 1: {slaveBytesCount}")
    assert(2 == slaveBytesCount)


    ## End
    await Timer(100, units="us")

@cocotb.test(timeout_time = 1,timeout_unit="ms")
async def test_1frame_1byte(dut):
    pass

@cocotb.test(timeout_time = 1,timeout_unit="ms")
async def test_1frame_with_pauses(dut):

    ## Init
    sources, sinks = await init_clocking_interfaces(dut)

    ## Send One Frame of 5 bytes from port 1 to port 2
    #########
    source = sources[1]
    sink = sinks[2]

    sourceBytes = await source.generateDataCycles(5,tdest=2)

    sink.ready()

    await Timer(50, units="us")
    
    dut._log.info(f"Number of bytes received on Sink 2: {sink.getBytesCount()}")
    assert 5 == sink.getBytesCount() , f"Expected 5 bytes, received {sink.getBytesCount()}"

    sinkBytes = await sink.getBytes(5)
    for i,b in enumerate(sinkBytes):
        dut._log.info(f"sink={hex(b)},source={hex(sourceBytes[i])}")
    assert(sourceBytes == sinkBytes)

    ## Send One Frame of 5 bytes from port 1 to port 2 with Not Ready on sink at beginning
    #########
    dut._log.info(f"Starting test with delayed ready, bytes on Sink 2: {sink.getBytesCount()}")
    await Timer(50, units="us")
    sink.notReady()
    await Timer(10, units="us")

    ## Send data
    sourceBytes = await source.generateDataCycles(5,tdest=2)

    await Timer(20, units="us")

    ## Unlock sink
    sink.ready()
    await Timer(20, units="us")

    ## Check
    dut._log.info(f"Number of bytes received on Sink 2: {sink.getBytesCount()}")
    assert( 5 == sink.getBytesCount())
    sinkBytes = await sink.getBytes(5)
    for i,b in enumerate(sinkBytes):
        dut._log.info(f"sink={hex(b)},source={hex(sourceBytes[i])}")
    assert(sourceBytes == sinkBytes)

    ## End
    await Timer(100, units="us")


@cocotb.test(timeout_time = 1,timeout_unit="ms")
async def test_frames_2sources_to_sink(dut):

    ## Init
    sources, sinks = await init_clocking_interfaces(dut)

    firstSource  = random.randint(0,3)
    secondSource = random.randint(0,3)
    targetSink = random.randint(0,3)

    ## Generate Frames on 2 Sources  targeting 1 sink
    ########
    sourceBytes = []

    # Ensure data is generated on negedge so that both ports are ready at the same time
    await FallingEdge(dut.clk)
    sourceBytes.append(await sources[firstSource].generateDataCycles(5,tdest=targetSink))
    sourceBytes.append(await sources[secondSource].generateDataCycles(5,tdest=targetSink))

    # Wait and enable port 0
    await Timer(20, units="us")
    await RisingEdge(dut.clk)
    sinks[targetSink].ready()

    # Wait for Data to go through an checks
    await Timer(50, units="us")

    assert sinks[targetSink].getBytesCount() == 10 , f"10 bytes expected, got {sinks[targetSink].getBytesCount()}"
    await  sinks[targetSink].getAllBytes()

    dut._log.info("=== Done 10 bytes from 2 ports ===")

    ## Generate 2 Frames on Sources 1 and 2, interleaved
    ################

     # Ensure data is generated on negedge so that both ports are ready at the same time
    await FallingEdge(dut.clk)
    sinks[targetSink].notReady()
    sourceBytes.append(await sources[firstSource].generateDataCycles(5,tdest=targetSink))
    sourceBytes.append(await sources[secondSource].generateDataCycles(5,tdest=targetSink))
    sourceBytes.append(await sources[firstSource].generateDataCycles(8,tdest=targetSink))
    sourceBytes.append(await sources[secondSource].generateDataCycles(8,tdest=targetSink))

    # Wait and enable port 0
    await Timer(20, units="us")
    await RisingEdge(dut.clk)
    sinks[targetSink].ready()

    # Wait for Data to go through an checks
    await Timer(50, units="us")
    assert sinks[targetSink].getBytesCount() == 26 , f"26 bytes expected, got {sinks[targetSink].getBytesCount()}"

    ## End
    ##############
    await Timer(200, units="us")


@cocotb.test(timeout_time = 1,timeout_unit="ms",skip=False)
async def test_frames_from_sources_to_sinks(dut):

    ## Init
    sources, sinks = await init_clocking_interfaces(dut)

    ## Random Generate Frames for all Sources to all Sinks
    #########
    totalBytesCount = 0
    for runs in range(2):
        for sourcei in range(4):
            for sinki in range(4):
                bytesCount = random.randint(4,16)
                totalBytesCount += bytesCount
                await sources[sourcei].generateDataCycles(bytesCount,tdest=sinki)

    dut._log.info(f"Generated {totalBytesCount} bytes")

    ## Now Enable all Sinks
    await Timer(20, units="us")
    await RisingEdge(dut.clk)
    for sinki in range(4):
        sinks[sinki].ready()

    await Timer(200, units="us")
    receivedBytesCount = 0
    for sinki in range(4):
        receivedBytesCount += sinks[sinki].getBytesCount()
    dut._log.info(f" Received {receivedBytesCount} bytes, expected {totalBytesCount}")

    ## End
    await Timer(100, units="us")