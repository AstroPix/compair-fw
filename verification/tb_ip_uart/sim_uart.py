

import sys
import os

import cocotb
from cocotb.triggers    import Timer,RisingEdge
from cocotb.clock       import Clock
from cocotbext.uart     import UartSource, UartSink

from rfg.cocotb.cocotb_uart import UARTIO

from vip.axis import  VAXIS_Slave ,AXIS_Slave_Monitor, VAXIS_Master, AXIS_Master_Monitor

async def common_clock_reset(dut):

    ## Init IO
    dut.resn.value = 0 

    slave   = VAXIS_Slave(dut,dut.clk)
    slave.reset()
    slaveMonitor = AXIS_Slave_Monitor(dut,dut.clk)

    master = VAXIS_Master(dut,dut.clk)
    master.reset()
    masterMonitor = AXIS_Master_Monitor(dut,dut.clk)

    uart = UARTIO(tx = dut.rx, rx = dut.tx ,baud = 115200 )
    uart.open()

    dut.read_reg.value = 0
    

    ## This starts a task that will create a clock waveform every 10ns
    uartClock = cocotb.start_soon(Clock(dut.clk, 33.33, units='ns').start())
    
    ## Reset
    await RisingEdge(dut.clk)
    for i in range(20):
        await RisingEdge(dut.clk)
    dut.resn.value = 1
    for i in range(10):
        await RisingEdge(dut.clk)

    slaveMonitor.start_monitor()
    masterMonitor.start_monitor()
    master.start_driver()

    return uart,slave,slaveMonitor,master,masterMonitor


@cocotb.test(timeout_time = 1 , timeout_unit = "ms")
async def test_write_byte(dut):

    ## Init clock and reset
    uart, slave, slaveMonitor, master, masterMonitor = await common_clock_reset(dut);
    
    ## Make receiver ready
    await RisingEdge(dut.clk)
    slave.ready()

    ## Write 5 Bytes
    await uart.writeBytes([0xAB,0xCD,0xEF,0xAB,0XCD])

    await Timer(1,"us")
    await RisingEdge(dut.clk)

    ## Check Slave driver got the data
    assert slaveMonitor.getBytesCount() == 5 , "Slave should receive 5 bytes"


    await Timer(5,"us")

@cocotb.test(timeout_time = 1 , timeout_unit = "ms")
async def test_read_bytes(dut):

    ## Init clock and reset
    uart, slave, slaveMonitor, master, masterMonitor = await common_clock_reset(dut);
    
    ## Make receiver ready
    await RisingEdge(dut.clk)
    slave.ready()

    ## Generate data
    await master.generateDataCycles(count = 5 )
    await uart.readBytes(count = 5)

    await Timer(100,"us")