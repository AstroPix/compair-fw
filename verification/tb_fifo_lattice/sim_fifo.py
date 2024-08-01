import cocotb
from cocotb.binary      import BinaryValue
from cocotb.triggers    import Timer,RisingEdge,FallingEdge, Combine
from cocotb.clock       import Clock
from cocotb.queue       import Queue
from cocotb.task        import Task
import random
from axis import AXIS_Master_Driver, AXIS_Slave_Driver ,AXIS_Master_Monitor,AXIS_Slave_Monitor, AxisCycle

clockJob : Task

async def common_clock(dut):
    ## This starts a task that will create a clock waveform every 10ns
    writeClock = cocotb.start_soon(Clock(dut.s_axis_aclk, 9, units='ns').start())
    readClock = cocotb.start_soon(Clock(dut.m_axis_aclk, 22, units='ns').start())
    await RisingEdge(dut.s_axis_aclk)
    await RisingEdge(dut.m_axis_aclk)

async def stop_clock(dut):
    clockJob.cancel()

async def reset_common_clock(dut):
    """This method resets the FIFO and creates Master/Slave drivers + monitors for the test to use"""
    ## Init I/O at simulation begin
    #dut.shiftin.value = 0
    #dut.shiftout.value = 0
    #dut.resn.value = 0 
    #dut.clk.value = 0

    ## Init Axis Master and Slave Drivers
    master  = AXIS_Master_Driver(dut,dut.s_axis_aclk)
    master.reset()
    master.start_driver()

    slave   = AXIS_Slave_Driver(dut,dut.m_axis_aclk)
    slave.reset()

    ## Add Monitors - Master Monitor is a Monitor for master side, so checking slave signals
    masterMonitor = AXIS_Master_Monitor(dut,dut.s_axis_aclk)
    slaveMonitor = AXIS_Slave_Monitor(dut,dut.m_axis_aclk)

    ## Start the clock
    await common_clock(dut)

    ## Reset the design for a few clock cycles
    dut.s_axis_aresetn.value = 0 
    for i in range(10):
        await RisingEdge(dut.s_axis_aclk)
    for i in range(10):
        await RisingEdge(dut.m_axis_aclk)
    dut.s_axis_aresetn.value = 1
    await RisingEdge(dut.s_axis_aclk)


    # Start monitors
    masterMonitor.start_monitor()
    slaveMonitor.start_monitor()
    #slave.ready()

    return master,slave,masterMonitor,slaveMonitor

async def waitForXMasterClocks(dut,count):
    for i in range(count):
        await RisingEdge(dut.m_axis_aclk)

async def waitForXMasterClocksNegedge(dut,count):
    for i in range(count):
        await FallingEdge(dut.m_axis_aclk)

async def waitForXSlaveClocks(dut,count):
    for i in range(count):
        await RisingEdge(dut.s_axis_aclk)

## Driving
################
async def writeByte(dut,b):
    await master.writeFrame([b])
    #await RisingEdge(dut.clk)
    #dut.data_in.value = b 
    #dut.shiftin.value = 1

async def readByte(dut):
    await RisingEdge(dut.clk)
    dut.shiftout.value = 1

async def noRead(dut):
    await RisingEdge(dut.clk)
    dut.shiftout.value = 0

async def noWrite(dut):
    await RisingEdge(dut.clk)
    dut.shiftin.value = 0



async def scoreBoardValidate(masterMonitor,slaveMonitor,expectedCount):

    ## Check data counts are the same in both input and output, and according to expecting size
    assert masterMonitor.getBytesCount() == expectedCount, f"Expected {expectedCount} bytes"
    assert masterMonitor.getBytesCount() == slaveMonitor.getBytesCount() , "In/Out Queues should be of same size"
    

    # Get bytes
    inBytes  = await masterMonitor.getAllBytes()
    outBytes = await slaveMonitor.getAllBytes()

    if inBytes != outBytes:
        for i in range(len(inBytes)):
            print(f"in={hex(inBytes[i])},out={hex(outBytes[i])}")


    assert inBytes == outBytes , "In/Out Bytes should be identical"

    print(f"** Scoreboard success in={len(inBytes)} bytes,out={len(inBytes)} bytes**")

    
@cocotb.test(timeout_time = 1,timeout_unit="ms",skip=False)
async def test_single_write_single_read(dut):
    
    master,slave,masterMonitor,slaveMonitor = await reset_common_clock(dut)
    await Timer(2,units="us")


    # Write
    await master.writeByte(random.randint(1,128))


    # Check that Master interface becomes valid
    await waitForXMasterClocks(dut,10)
    assert (dut.m_axis_tvalid.value == 1 ) , "Master interface is valid after write (not empty)"

    # Read by setting the Slave receiver to ready -> Use Falling edge to avoid sync issue with simulator on posedge
    await waitForXMasterClocksNegedge(dut,1)
    slave.ready()
    await waitForXMasterClocks(dut,3)
    assert (dut.m_axis_tvalid.value == 0 ) , "Master interface is not valid after read (empty)"

    # Check results
    await waitForXMasterClocks(dut,2)
    await scoreBoardValidate(masterMonitor,slaveMonitor,1)

    await Timer(10, units="us")

    ## Repeat the test but the Ready state of Simulation Slave receiver is always on
    ## If the Fifo is generated with "reg output", the data is delayed by one cycle, which is not what we want
    await master.writeByte(random.randint(1,128))
    await waitForXMasterClocksNegedge(dut,10)
    await scoreBoardValidate(masterMonitor,slaveMonitor,1)

    await Timer(10, units="us")

@cocotb.test(timeout_time = 1,timeout_unit="ms",skip=False)
async def test_2write_2read(dut):
    
    master,slave,masterMonitor,slaveMonitor = await reset_common_clock(dut)
    await Timer(2,units="us")
  

    ## Write/Read with consecutive cycles
    ##############

    # Write
    await master.generateDataCycles(2)
    

    # Wait for Master side to be ready - set slave receiver ready 
    await RisingEdge(dut.m_axis_tvalid)
    await waitForXMasterClocks(dut,1)
    slave.ready()
    await waitForXMasterClocksNegedge(dut,5)
    slave.notReady()
    await waitForXMasterClocksNegedge(dut,5)

    # Check results
    await scoreBoardValidate(masterMonitor,slaveMonitor,2)

    await Timer(50, units="us")


@cocotb.test(timeout_time = 1,timeout_unit="ms",skip=False)
async def test_write_readalways(dut):

    master,slave,masterMonitor,slaveMonitor = await reset_common_clock(dut)
    await Timer(2,units="us")
    

    # Make Slave ready to enable always read
    await waitForXSlaveClocks(dut,10)
    slave.ready()
    

    # Write Cycles with pauses
    bytesCount = random.randint(5,64)
    await master.generateDataCycles(count = bytesCount , pausesRandMin = 0 , pausesRandMax = 3)
    
    # Wait a while
    await Timer(1,units="us")

    # Verify
    await scoreBoardValidate(masterMonitor,slaveMonitor,bytesCount)

    #await stop_clock(dut)
    await Timer(50, units="us")



@cocotb.test(timeout_time = 1,timeout_unit="ms",skip=True)
async def test_write_full_then_readcontinuous(dut):

    master,slave,masterMonitor,slaveMonitor = await reset_common_clock(dut)
    await Timer(2,units="us")

    
    # Read task
    async def randomReader(dut):
        while True: 
            # Read byte, then pause, maybe
            await readByte(dut)
            if dut.empty.value==0:
                for j in range(random.randint(0,3)):
                    await noRead(dut)
    
    # Write until full with pauses
    # Write with pauses
    for i in range(random.randint(600,1024)):
        if dut.full.value != 1:
            await writeByte(dut,random.randint(1,128))
            for j in range(random.randint(0,3)):
                await noWrite(dut)
        else:
            await noWrite(dut)
            break
        
    await noWrite(dut)

    dut.shiftout.value = 1

    # Wait until empty
    await RisingEdge(dut.empty)

    # Verify
    await Timer(1,units="us")
    #job.kill()
    await FallingEdge(dut.clk)
    await scoreBoardValidate()

    #await stop_clock(dut)
    await Timer(50, units="us")


@cocotb.test(timeout_time = 1,timeout_unit="ms",skip=True)
async def test_write_full_randomread(dut):
    await reset_common_clock(dut)
    await Timer(2,units="us")

    start_monitors(dut)
    await Timer(1,units="us")

    
    # Read task
    async def randomReader(dut):
        while True: 
            # Read byte, then pause, maybe
            await readByte(dut)
            if dut.empty.value==0:
                for j in range(random.randint(0,3)):
                    await noRead(dut)
    
    # Write until full with pauses
    # Write with pauses
    for i in range(random.randint(600,1024)):
        if dut.full.value != 1:
            await writeByte(dut,random.randint(1,128))
            for j in range(random.randint(0,3)):
                await noWrite(dut)
        else:
            await noWrite(dut)
            break
        
    await noWrite(dut)

    # Start reading and write again with pauses
    job = cocotb.start_soon(randomReader(dut))
    # Write with pauses
    for i in range(random.randint(5,64)):
        await writeByte(dut,random.randint(1,128))
        for j in range(random.randint(0,3)):
            await noWrite(dut)
    await noWrite(dut)

    # Wait until empty
    await RisingEdge(dut.empty)

    # Verify
    await Timer(1,units="us")
    job.kill()
    await FallingEdge(dut.clk)
    await scoreBoardValidate()

    #await stop_clock(dut)
    await Timer(50, units="us")

            
@cocotb.test(timeout_time = 1,timeout_unit="ms",skip=True)
async def test_write_randomread(dut):
    await reset_common_clock(dut)
    await Timer(2,units="us")

    start_monitors(dut)
    await Timer(1,units="us")

    
    # Read task
    async def randomReader(dut):
        while True: 
            # Read byte, then pause, maybe
            await readByte(dut)
            for j in range(random.randint(0,3)):
                await noRead(dut)
    job = cocotb.start_soon(randomReader(dut))

    # Write with pauses
    for i in range(random.randint(5,64)):
        await writeByte(dut,random.randint(1,128))
        for j in range(random.randint(0,3)):
            await noWrite(dut)
    await noWrite(dut)


    # Verify
    await Timer(5,units="us")
    job.kill()
    await FallingEdge(dut.clk)
    await scoreBoardValidate()

   #await stop_clock(dut)
    await Timer(50, units="us")



            
@cocotb.test(timeout_time = 1,timeout_unit="ms",skip=True)
async def test_write_randomread_long(dut):
    await reset_common_clock(dut)
    await Timer(2,units="us")

    start_monitors(dut)
    await Timer(1,units="us")

    
    # Read task
    async def randomReader(dut):
        while True: 
            # Read byte, then pause, maybe
            await readByte(dut)
            for j in range(random.randint(0,3)):
                await noRead(dut)
    job = cocotb.start_soon(randomReader(dut))

    # Write with pauses
    for i in range(random.randint(1024,2048)):
        await writeByte(dut,random.randint(1,128))
        for j in range(random.randint(0,5)):
            await noWrite(dut)
    await noWrite(dut)


    # Verify
    await Timer(5,units="us")
    job.kill()
    await FallingEdge(dut.clk)
    await scoreBoardValidate()

    await Timer(50, units="us")