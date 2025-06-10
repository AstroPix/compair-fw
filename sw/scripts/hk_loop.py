import sys
import os
os.environ['BASE'] = os.path.abspath(".")
print(sys.path)
sys.path.insert(1, os.path.abspath("sw"))
sys.path.insert(1, os.path.abspath("vendor/icflow_hdl_240807/hdl_rfg_v1/python"))
sys.path.insert(1, os.path.abspath("rtl/top"))

import asyncio 
import time

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
    driver = drivers.boards.getCMODUartDriver("COM17",baud=115200) #115200
    
    await driver.open() 
    
    # Select appropriate 
    # print('ID')
    # id =      await driver.readFirmwareID()
    # print(f"Firmware ID: {hex(id)}")
    # version = await driver.readFirmwareVersion()
    # print(f"Firmware Version: {str(version)}")
    #await driver.houseKeeping.configureHKSPIFrequency(500000, True)
    
    ## Loop over ADC Settings
    timeouts = 0
    # for adc_num in [1,2,3]:
    num_adcs = 3
    num_channels = 8
    readout_codes = [0] * num_adcs * num_channels
    readout_values = [0.00] * num_adcs * num_channels
    readout_names = [""] * num_adcs * num_channels
    readout_units = [""] * num_adcs * num_channels
    hk_idx = 0
    for adc_num in [1,2,3]:
        for chan in range(8):
            (units, shortname) = hk_eqns.get_info(adc_num-1,chan)
            readout_names[hk_idx] = shortname
            readout_units[hk_idx] = units
            hk_idx = hk_idx + 1
    
    for top in range(1):
        hk_idx = 0
        for adc_num in [1,2,3]:
            for chan in range(8):
                for retry in range(3):
                    await driver.houseKeeping.selectADC(0)
                    time.sleep(0.01)
                    await driver.houseKeeping.writeADCDACBytes(bytes([chan<<3,0])) # Roll chan left 3 bits per ADC128S102 datasheet
                    time.sleep(0.01)
                    await driver.houseKeeping.selectADC(adc_num)
                    time.sleep(0.01)
                    #print("{0:b}".format(chan<<3))
                    adcBytesCount = await driver.houseKeeping.getADCBytesCount()
                    
                    if adcBytesCount != 2:
                            print(f"ERROR: byte count = {hex(adcBytesCount)}")
                    time.sleep(0.01)
                    adcBytes = await driver.houseKeeping.readADCBytes(adcBytesCount) 
                    (units, shortname) = hk_eqns.get_info(adc_num-1,chan)
                    adc_code = int.from_bytes(adcBytes)
                    #value = hk_eqns.convert(adc_num-1,chan,adc_code)
                    if retry == 2:
                        readout_codes[hk_idx] = adc_code
                        value = hk_eqns.convert(adc_num-1,chan,adc_code)
                        readout_values[hk_idx] = value
                        hk_idx = hk_idx + 1
                    
                        #print(f"ADC, {adc_num}, CH, {chan}, Name, {shortname}, Volts {round(int.from_bytes(adcBytes)*3.3/4095,3)}V, Hex {hex(int.from_bytes(adcBytes))}, Dec, {int.from_bytes(adcBytes)}, Value, {round(value,3)}, Units, {units}")
                        #print(f"ADC, {adc_num}, CH, {hex(chan<<3)}, Hex, {hex(int.from_bytes(adcBytes))}, Name, {shortname}, Value, {value}, Units, {units}")
                    
                        
                        #sleep between read/writes (seconds)

    print(readout_codes)
    await driver.close()


async def main():

    #while time.time() < t_end:
     await callHK()

if __name__ == "__main__":
    asyncio.run(callHK())
