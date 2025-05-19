import asyncio
import drivers.astep.serial
import drivers.boards
import rfg

async def test_fpga():

    boardDriver = drivers.boards.getGeccoUARTDriver("COM8")
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
