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
import drivers.compair.housekeeping_equations as hk_eqns
async def callHK():
    """
    Calls housekeeping from TI ADC128S102 ADC. Loops over each of the 8 input channels.
    Input is two bytes:
    First 2 bits: ignored
    Next 3 bits: Set Channel #
    Last 11 bits: ignored

    Option for writing as LSB or MSB
    """
    ## Open UART Driver for CMOD
    driver = drivers.boards.getCMODUartDriver("COM9")
    
    await driver.open() 
    
    # Select appropriate 

    #await driver.houseKeeping.configureHKSPIFrequency(500000, True)
    
    ## Loop over ADC Settings
    for adc_num in [1,2,3]:
        for chan in range(0,8):
            for retry in range(2):
                print(f"try {retry}")
                await driver.houseKeeping.selectADC(0)
                await driver.houseKeeping.writeADCDACBytes(bytes([chan<<3,0])) # Roll chan left 3 bits per ADC128S102 datasheet
                await driver.houseKeeping.selectADC(adc_num)
                adcBytesCount = await driver.houseKeeping.getADCBytesCount()
                adcBytes = await driver.houseKeeping.readADCBytes(adcBytesCount) 
                (units, shortname) = hk_eqns.get_info(adc_num-1,chan)
                value = hk_eqns.convert(adc_num-1,chan,int.from_bytes(adcBytes))
                print(f"ADC, {adc_num}, CH, {chan}, Dec, {int.from_bytes(adcBytes)}, Name, {shortname}, Value, {value}, Units, {units}")
                
                #sleep between read/writes (seconds)
                task = asyncio.create_task(asyncio.sleep(1)) 
                await task
    
    await driver.close()

async def main():

    #while time.time() < t_end:
     await callHK()

if __name__ == "__main__":
    asyncio.run(callHK())
