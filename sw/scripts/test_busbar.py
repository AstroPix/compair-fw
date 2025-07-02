import sys
import os
os.environ['BASE'] = os.path.abspath(".")
print(sys.path)
sys.path.insert(1, os.path.abspath("sw"))
sys.path.insert(1, os.path.abspath("vendor/icflow_hdl_240807/hdl_rfg_v1/python"))
sys.path.insert(1, os.path.abspath("rtl/top"))

import asyncio
import drivers.boards
import rfg.core

async def test_fpga():
    x = 115200
    boardDriver = drivers.boards.getGeccoUARTDriver("COM17",baud=115200)
    #print('Open')
    await boardDriver.open()
    
    #print('ID')
    id =      await boardDriver.readFirmwareID()
    print(f"Firmware ID: {hex(id)}")
    version = await boardDriver.readFirmwareVersion()
    print(f"Firmware Version: {str(version)}")

    await boardDriver.close()

async def test_busbar():
    boardDriver = drivers.boards.getGeccoUARTDriver("COM17",baud=115200)
    #print('Open')
    waitTime = 0.1
    await boardDriver.open()
    await boardDriver.ioSetSampleClockSingleEnded(True)
    fpga_core_freq = boardDriver.getFPGACoreFrequency()
    print(fpga_core_freq)
    await boardDriver.enableSensorClocks(True)
    await boardDriver.ioSetSampleClock(True)
    config_fname = "./verification/tb_full_astep/files/config_v3_mc_auto.yml"
    await boardDriver.configureLayerSPIFrequency(1e6,flush=True)
    await boardDriver.setLayerConfig(12,reset=False,autoread=False,hold=False,chipSelect=False,flush=True)
    await asyncio.sleep(waitTime)
    await boardDriver.rfg.write_layer_12_mosi(int(3),flush=True)
    await asyncio.sleep(waitTime)

    await boardDriver.setLayerReset(layer =12, reset = True , flush = True )
    # for layer in range(13):
    #     await boardDriver.setLayerReset(layer = layer, reset = True , flush = True )
        
    #     await asyncio.sleep(waitTime)
    #     await boardDriver.setLayerReset(layer = layer, reset = False , flush = True )
    #     await asyncio.sleep(waitTime)
    await boardDriver.layerSelectSPI(12,cs=True,flush = True)
    boardDriver.setupASICS(version=3,rows=12,chipsPerRow=1,configFile=config_fname)
    await boardDriver.setLayerConfig(12,reset=False,autoread=False,hold=False,chipSelect=False,flush=True)
    await asyncio.sleep(waitTime)
    await boardDriver.layerSelectSPI(12,cs=True,flush = True)
    await asyncio.sleep(waitTime)
    await boardDriver.close()

if __name__ == "__main__":
    asyncio.run(test_fpga())

    asyncio.run(test_busbar())

