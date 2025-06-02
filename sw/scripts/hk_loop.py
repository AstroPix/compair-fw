import sys
import os
os.environ['BASE'] = os.path.abspath(".")
print(sys.path)
sys.path.insert(1, os.path.abspath("sw"))
sys.path.insert(1, os.path.abspath("vendor/icflow_hdl_240807/hdl_rfg_v1/python"))
sys.path.insert(1, os.path.abspath("rtl/top"))

import asyncio 

## Load Board
##############
import drivers.boards

import binascii

async def callHK(lsbFirst=True):
    """
    Calls housekeeping from TI ADC128S102 ADC. Loops over each of the 8 input channels.
    Input is two bytes:
    First 2 bits: ignored
    Next 3 bits: Set Channel #
    Last 11 bits: ignored

    Option for writing as LSB or MSB
    """
    ## Open UART Driver for CMOD
    driver = drivers.boards.getCMODUartDriver("COM11")
    
    await driver.open() 
    
    # Select appropriate 
    await driver.houseKeeping.selectADC(0)
    #await driver.houseKeeping.selectADC(2)

    #await driver.houseKeeping.configureHKSPIFrequency(500000, True)
    
    ## Loop over ADC Settings
    for chan in range(0,8):
        bits = format(chan,'08b') #fix the formatting 
        if lsbFirst == True:
            byte1 = int(bits[::-1],2) #this is a hex string is this ok?
        else:
            byte1 = int(bits,2) #this is a hex string is this ok?

        print(f"{hex(byte1)}")
        await driver.houseKeeping.writeADCDACBytes([byte1,0x00])
        await driver.houseKeeping.selectADC(3)
        adcBytesCount = await driver.houseKeeping.getADCBytesCount()
        adcBytes = await driver.houseKeeping.readADCBytes(adcBytesCount) 
        print(f"Got ADC bytes {binascii.hexlify(adcBytes)}")
        
        #sleep between read/writes (seconds)
        task = asyncio.create_task(asyncio.sleep(1)) 
        await task
    
    await driver.close()

async def main():

    #while time.time() < t_end:
     await callHK()

if __name__ == "__main__":
    asyncio.run(callHK())
