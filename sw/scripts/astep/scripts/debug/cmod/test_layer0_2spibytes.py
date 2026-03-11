
import asyncio, time
import drivers.astep.serial
import drivers.boards

## Use first UART automatically
boardDriver = drivers.boards.getCMODUartDriver("COM4")#drivers.astep.serial.getFirstCOMPort())
boardDriver.open()

async def main():
    ## Write 2 Bytes to Lane 0
    await boardDriver.configureLaneSPIFrequency(2000000,flush= False)
    await boardDriver.setLaneConfig(0,reset=False,autoread = False, hold= True, flush=True)

    ## Write bytes
    await boardDriver.setLaneCS(0, cs=True, flush=True)
    await boardDriver.asic[0].writeSPI([0x00,0x01],flush=True)
    await boardDriver.setLaneCS(0, cs=False, flush=True)
    print("Writing [0x00,0x01]")

    time.sleep(2)

    ## Read bytes
    nmbBytes = await boardDriver.readoutGetBufferSize()
    print(f"Got {nmbBytes} bytes")
    print(await boardDriver.readoutReadBytes(nmbBytes*2))


asyncio.run(main())
