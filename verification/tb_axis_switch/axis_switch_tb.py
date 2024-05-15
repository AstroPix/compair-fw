

import cocotb
from cocotb.binary      import BinaryValue
from cocotb.triggers    import Timer,RisingEdge,FallingEdge, Combine
from cocotb.clock       import Clock

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
     


@cocotb.test(timeout_time = 1,timeout_unit="ms")
async def test_clocking_resets(dut):

    ## Clk 
    dut.clk.value = 0
    await common_clock(dut)
    
    ## Create and reset Masters
    masters = []
    slaves = []
    for i in range(4):
        print(f"Creating MasterIf {i}")
        masters.append(MasterIf(dut,port=i))
        masters[i].reset()
        slaves.append(SlaveIf(dut,port=i))
        slaves[i].reset()

    ## Reset
    dut.res_n.value = 0
    await Timer(2, units="us")
    dut.res_n.value = 1
    await Timer(2, units="us")
    

    ## Set Masters valid 
    #for i in range(4):
    #    masters[i] = MasterIf(dut,port=i)
    #    masters[i].valid()
    masters[2].valid(target = 1)
    slaves[1].ready()
    

    ##dut.m_axis_tvalid[1].value = 1

    await Timer(100, units="us")
