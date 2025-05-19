
import asyncio 

## Load Board
##############
import drivers.boards
import drivers.astropix.asic

import time
import binascii

async def callHK(flipped=True): # adding a setting that can change the byte ordering in the future if we ever fix/change this
    """
    Calls housekeeping from TI ADC128S102 ADC. Loops over each of the 8 input channels.
    Input is two bytes:
    First 2 bits: ignored
    Next 3 bits: Set Channel #
    Last 11 bits: ignored

    Shift register input style requires bytes to be read in left to right. May be fixed in future versions
    """
    ## Open UART Driver for CMOD
    driver = drivers.boards.getCMODUartDriver("COM8")
    await driver.open() #does the driver need to be closed between reads?
    await driver.houseKeeping.selectADC(1)
    
    ## Loop over ADC Settings
    for chan in range(0,8):
        bits = format(chan,'08b') #fix the formatting 
        if flipped == True:
            byte1 = int(bits,2) #this is a hex string is this ok?
        else:
            byte1 = int(bits,2) #this is a hex string is this ok?

        print(f"{hex(byte1)}")
        await driver.houseKeeping.writeADCDACBytes([byte1,0x00])
        adcBytesCount = await driver.houseKeeping.getADCBytesCount()
        adcBytes = await driver.houseKeeping.readADCBytes(adcBytesCount) #still need to output this from task
        print(f"Got ADC bytes {binascii.hexlify(adcBytes)}")
        
        #sleep to give it time between read/writes, maybe not needed for asyncio?
        task = asyncio.create_task(asyncio.sleep(1)) #is this in seconds? us?
        await task

    await driver.close()

async def main():

    #while time.time() < t_end:
     await callHK()



if __name__ == "__main__":
    asyncio.run(callHK())