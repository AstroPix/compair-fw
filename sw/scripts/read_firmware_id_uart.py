import asyncio
import drivers.astep.serial
import drivers.boards

import rfg
rfg.io.uart.debug()

boardDriver = drivers.boards.getGeccoUARTDriver("/dev/ttyUSB0",115200)
boardDriver.open()


asyncio.run(boardDriver.rfg.write_io_led(0xFF,flush=True))



pass 
id =      asyncio.run(boardDriver.readFirmwareID())
version = asyncio.run(boardDriver.readFirmwareVersion())

print(f"Firmware ID: {hex(id)}")
print(f"Firmware Version: {str(version)}")
