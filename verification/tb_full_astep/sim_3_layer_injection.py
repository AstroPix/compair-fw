
import sys
import os

import cocotb
from cocotb.triggers    import Timer,RisingEdge,FallingEdge,with_timeout
from cocotb.clock       import Clock
from cocotbext.uart import UartSource, UartSink

import vip.cctb

import astep24_3l_sim

@cocotb.test(timeout_time = 10 , timeout_unit = "ms")
async def test_injection(dut):

    boardDriver = astep24_3l_sim.getUARTDriver(dut)
    ## Clock/Reset
    await vip.cctb.common_clock_reset(dut)
    await Timer(10, units="us")

    # Get Injection Board from driver
    injBoard = boardDriver.geccoGetInjectionBoard()

    # Configure
    injBoard.initdelay = 4
    injBoard.clkdiv = 2
    injBoard.period = 4
    injBoard.pulsesperset = 4
    injBoard.cycle = 1 # 0 Should mean indefinite

    ## Start
    await injBoard.start()

    ## Wait for x pulses
    for i in range(injBoard.pulsesperset):
        await RisingEdge(dut.layers_inj)
        await FallingEdge(dut.layers_inj)
    
    assert dut.injection_generator.done.value == 1 

    # Make another run 
    injBoard.pulsesperset = 2
    await injBoard.start()

    ## Wait for x pulses
    for i in range(injBoard.pulsesperset):
        await RisingEdge(dut.layers_inj)
        await FallingEdge(dut.layers_inj)
    
    assert dut.injection_generator.done.value == 1 
    
   
    await Timer(500, units="us")


@cocotb.test(timeout_time = 10 , timeout_unit = "ms")
async def test_vb_update(dut):


    boardDriver = astep24_3l_sim.getUARTDriver(dut)
    ## Clock/Reset
    await vip.cctb.common_clock_reset(dut)
    await Timer(10, units="us")

    # Get Injection Board from driver
    injBoard = boardDriver.geccoGetInjectionBoard()

    await injBoard.voltageBoard.update()

    await Timer(500, units="us")