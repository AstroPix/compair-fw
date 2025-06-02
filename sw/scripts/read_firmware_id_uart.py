import sys
import os
os.environ['BASE'] = os.path.abspath(".")
print(sys.path)
sys.path.insert(1, os.path.abspath("sw"))
sys.path.insert(1, os.path.abspath("vendor/icflow_hdl_240807/hdl_rfg_v1/python"))
sys.path.insert(1, os.path.abspath("rtl/top"))

import asyncio
import drivers.boards

async def test_fpga():

    boardDriver = drivers.boards.getGeccoUARTDriver("COM11",baud=115200)
    print('Open')
    await boardDriver.open()
    
    print('ID')
    id =      await boardDriver.readFirmwareID()
    print(f"Firmware ID: {hex(id)}")
    version = await boardDriver.readFirmwareVersion()
    print(f"Firmware Version: {str(version)}")

    await boardDriver.close()

if __name__ == "__main__":
    asyncio.run(test_fpga())
