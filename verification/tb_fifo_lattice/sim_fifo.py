import cocotb
from cocotb.binary      import BinaryValue
from cocotb.triggers    import Timer,RisingEdge,FallingEdge, Combine
from cocotb.clock       import Clock
from cocotb.queue       import Queue
from cocotb.task        import Task
import random
from axis import AXIS_Master_Driver, AXIS_Slave_Driver ,AXIS_Master_Monitor,AXIS_Slave_Monitor, AxisCycle

clockJob : Task

masterClockPeriod = 22
slaveClockPeriod = 13

async def common_clock(dut):
    ## This starts a task that will create a clock waveform every 10ns
    writeClock = cocotb.start_soon(Clock(dut.s_axis_aclk, slaveClockPeriod, units='ns').start())
    readClock = cocotb.start_soon(Clock(dut.m_axis_aclk, masterClockPeriod, units='ns').start())
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

def slaveReadyWithPauses(slave,pauseRandMax):
    async def __lt():
        print("Started read with pauses task")
        while True: 
            # Read byte, then pause, maybe
            await RisingEdge(slave.clk)
            slave.ready()
            for j in range(random.randint(0,pauseRandMax)):
                await RisingEdge(slave.clk)
                slave.notReady()
    job = cocotb.start_soon(__lt())
    return job

## Driving
################

async def scoreBoardValidate(masterMonitor,slaveMonitor,expectedCount):

    ## Check data counts are the same in both input and output, and according to expecting size
    assert masterMonitor.getBytesCount() == expectedCount, f"Expected {expectedCount} bytes"
    
    

    # Get bytes
    inBytes  = await masterMonitor.getAllBytes()
    outBytes = await slaveMonitor.getAllBytes()

    if inBytes != outBytes:
        print(f"In len={len(inBytes)},Out len={len(outBytes)}")
        for i in range(len(inBytes)):
            inb = hex(inBytes[i])
            outb = "OOR" if i >= len(outBytes) else hex(outBytes[i])
            print(f"in={hex(inBytes[i])},out={outb}")

    assert masterMonitor.getBytesCount() == slaveMonitor.getBytesCount() , "In/Out Queues should be of same size"
    assert inBytes == outBytes , "In/Out Bytes should be identical"

    print(f"** Scoreboard success in={len(inBytes)} bytes,out={len(inBytes)} bytes**")

    
@cocotb.test(timeout_time = 1,timeout_unit="ms",skip=False)
async def test_single_write_single_read(dut):
    
    master,slave,masterMonitor,slaveMonitor = await reset_common_clock(dut)
    await Timer(2,units="us")


    # Write
    await master.writeByte(random.randint(1,128))


    # Check that Master interface becomes valid
    await waitForXMasterClocks(dut,20)
    assert (dut.m_axis_tvalid.value == 1 ) , "Master interface is valid after write (not empty)"

    # Read by setting the Slave receiver to ready -> Use Falling edge to avoid sync issue with simulator on posedge
    await waitForXMasterClocks(dut,2)
    slave.ready()
    await waitForXMasterClocks(dut,4)
    slave.notReady()
    assert (dut.m_axis_tvalid.value == 0 ) , "Master interface is not valid after read (empty)"


    await scoreBoardValidate(masterMonitor,slaveMonitor,1)

    await Timer(10, units="us")

    ## Repeat the test but the Ready state of Simulation Slave receiver is always on
    ## If the Fifo is generated with "reg output", the data is delayed by one cycle, which is not what we want
    await waitForXMasterClocks(dut,2)
    slave.ready()
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
    await waitForXMasterClocks(dut,3)
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
    await Timer(2,units="us")

    # Verify
    await scoreBoardValidate(masterMonitor,slaveMonitor,bytesCount)

    #await stop_clock(dut)
    await Timer(50, units="us")



@cocotb.test(timeout_time = 1,timeout_unit="ms",skip=False)
async def test_write_full_then_readcontinuous(dut):

    master,slave,masterMonitor,slaveMonitor = await reset_common_clock(dut)
    await Timer(2,units="us")

    
    # Write 64 bytes +5 , it should turn the FIFO full - the +5 is because there is a caching 4 entrie fifo in the read path, so the fifo capacity is Fifo_Depth + 5
    bytesCount = 64+5
    await master.generateDataCycles(count = bytesCount , pausesRandMin = 0 , pausesRandMax = 2)
    
    # Wait until full, i.e slave interface not ready
    await FallingEdge(dut.s_axis_tready)

    # Now start reading
    await waitForXMasterClocks(dut,10)
    slave.ready()
    await waitForXMasterClocks(dut,72)

    # Verify
    await scoreBoardValidate(masterMonitor,slaveMonitor,bytesCount)

    await Timer(50, units="us")
    return 


@cocotb.test(timeout_time = 500,timeout_unit="us",skip=False)
async def test_write_full_randomread(dut):

    master,slave,masterMonitor,slaveMonitor = await reset_common_clock(dut)
    await Timer(2,units="us")

    
    
    # Write until full with pauses
    bytesCount = 64+5
    await master.generateDataCycles(count = bytesCount , pausesRandMin = 0 , pausesRandMax = 2)
    await FallingEdge(dut.s_axis_tready)


    # Start reading and write again with pauses to test at the full corner case
    # Now start reading
    await waitForXMasterClocks(dut,10)
    dut._log.info("Starting Slave ready with pauses task")
    job = slaveReadyWithPauses(slave,3)
    
    #await waitForXMasterClocks(dut,72)

    # Write with pauses
    #bytesCount = bytesCount + 42
    #await master.generateDataCycles(count = 42 , pausesRandMin = 0 , pausesRandMax = 3)

    # Wait until empty
    await FallingEdge(dut.m_axis_tvalid)

    # Verify
    await Timer(5,units="us")
    job.kill()
    
    await scoreBoardValidate(masterMonitor,slaveMonitor,bytesCount)

    #await stop_clock(dut)
    await Timer(50, units="us")

@cocotb.test(timeout_time = 500,timeout_unit="us",skip=False)
async def test_write_full_randomread_and_write(dut):

    master,slave,masterMonitor,slaveMonitor = await reset_common_clock(dut)
    await Timer(2,units="us")

    
    
    # Write until full with pauses
    bytesCount = 64+5
    await master.generateDataCycles(count = bytesCount , pausesRandMin = 0 , pausesRandMax = 2)
    await FallingEdge(dut.s_axis_tready)


    # Start reading and write again with pauses to test at the full corner case
    # Now start reading
    await waitForXMasterClocks(dut,10)
    dut._log.info("Starting Slave ready with pauses task")
    job = slaveReadyWithPauses(slave,3)
    
    #await waitForXMasterClocks(dut,72)

    # Write with pauses
    bytesCount = bytesCount + 42
    await master.generateDataCycles(count = 42 , pausesRandMin = 0 , pausesRandMax = 3)

    # Wait until empty
    await FallingEdge(dut.m_axis_tvalid)

    # Verify
    await Timer(5,units="us")
    job.kill()
    
    await scoreBoardValidate(masterMonitor,slaveMonitor,bytesCount)

    #await stop_clock(dut)
    await Timer(50, units="us")
            
@cocotb.test(timeout_time = 1,timeout_unit="ms",skip=False)
async def test_write_randomread(dut):

    master,slave,masterMonitor,slaveMonitor = await reset_common_clock(dut)
    await Timer(2,units="us")
    
    # Read task
    job = slaveReadyWithPauses(slave,3)

    # Write with pauses
    bytesCount = random.randint(5,96)
    await master.generateDataCycles(count = bytesCount , pausesRandMin = 0 , pausesRandMax = 3)


    # Verify
    await Timer(20,units="us")
    job.kill()
    
    await scoreBoardValidate(masterMonitor,slaveMonitor,bytesCount)

   #await stop_clock(dut)
    await Timer(50, units="us")



            
@cocotb.test(timeout_time = 1,timeout_unit="ms",skip=False)
async def test_write_randomread_long(dut):
    master,slave,masterMonitor,slaveMonitor = await reset_common_clock(dut)
    await Timer(2,units="us")
    
    # Read task
    job = slaveReadyWithPauses(slave,3)

    # Write with pauses
    bytesCount = random.randint(1024,4096)
    await master.generateDataCycles(count = bytesCount , pausesRandMin = 0 , pausesRandMax = 3)


    # Verify
    await Timer(200,units="us")
    job.kill()
    
    await scoreBoardValidate(masterMonitor,slaveMonitor,bytesCount)

   #await stop_clock(dut)
    await Timer(50, units="us")

    