import sys
import os
os.environ['BASE'] = os.path.abspath(".")
print(sys.path)
sys.path.insert(1, os.path.abspath("sw"))
sys.path.insert(1, os.path.abspath("vendor/icflow_hdl_240807/hdl_rfg_v1/python"))
sys.path.insert(1, os.path.abspath("rtl/top"))

import asyncio 
import time
import drivers.boards

import drivers.compair.housekeeping_equations as hk_eqns
import csv
from datetime import datetime

num_adcs     = 3
num_channels = 8
N            = num_adcs * num_channels

# 1) Build a filename with a timestamp so each run gets its own file:
readout_names = [""] * num_adcs * num_channels
readout_units = [""] * num_adcs * num_channels
hk_idx = 0
for adc_num in [1,2,3]:
    for chan in range(num_channels):
        (units, shortname) = hk_eqns.get_info(adc_num-1,chan)
        readout_names[hk_idx] = shortname
        readout_units[hk_idx] = units
        hk_idx = hk_idx + 1

#print(readout_names.join(','))
header = "timestamp,"
header = header + ",".join(readout_names)

start_time = datetime.now()
values_filename   = start_time.strftime('hk_values_%Y%m%d_%H%M%S.csv')
codes_filename   = start_time.strftime('hk_codes_%Y%m%d_%H%M%S.csv')


async def get_hk_row(driver):
    readout_codes = [0] * N
    readout_values = [0.00] * N
    hk_idx = 0
    for adc_num in [1,2,3]:
        for chan in range(8):
            for retry in range(3):
                await driver.houseKeeping.selectADC(0)
                await driver.houseKeeping.writeADCDACBytes(bytes([chan<<3,0])) # Roll chan left 3 bits per ADC128S102 datasheet
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
                    readout_values[hk_idx] = round(value,3)
                    hk_idx = hk_idx + 1
    return readout_codes, readout_values

async def do_housekeeping():
    driver = drivers.boards.getCMODUartDriver("COM17",baud=115200) #115200 
    await driver.open() 
    with open(values_filename, 'w', newline='') as csvfile:
        writer = csv.writer(csvfile)
        writer.writerow(header.split(","))
        for line_number in range(1000):
            now = datetime.now().isoformat()
            (readout_codes, readout_values) =  await get_hk_row(driver)
            row = now + "," + ",".join([str(x) for x in readout_values])
            print(row)
            writer.writerow(row.split(","))
            csvfile.flush()
            time.sleep(1)
        driver.close()
# for i in range(N):
#     header += [f"{readout_names[]}"]
asyncio.run(do_housekeeping())

# def houskeeping_loop():
#     start_time = datetime.now()
#     filename   = start_time.strftime('readouts_%Y%m%d_%H%M%S.csv')
#     with open(filename, 'w', newline='') as csvfile:
#         writer = csv.writer(csvfile)
#         header = ['timestamp']
#         for i in range(N):
#             header += [f'code_{i}', f'value_{i}', f'name_{i}', f'unit_{i}']
#         writer.writerow(header)

#     header = ['timestamp']
#     for i in range(N):
        
# async def callHK():
#     driver = drivers.boards.getCMODUartDriver("COM17",baud=115200) #115200 
#     await driver.open() 
#     readout_names = [""] * num_adcs * num_channels
#     readout_units = [""] * num_adcs * num_channels
#     hk_idx = 0
#     for adc_num in [1,2,3]:
#         for chan in range(8):
#             (units, shortname) = hk_eqns.get_info(adc_num-1,chan)
#             readout_names[hk_idx] = shortname
#             readout_units[hk_idx] = units
#             hk_idx = hk_idx + 1
    
#     readout_codes = [0] * num_adcs * num_channels
#     readout_values = [0.00] * num_adcs * num_channels

#     for top in range(1):



# #     print(readout_codes)
# #     await driver.close()


# # async def main():

# #     #while time.time() < t_end:
# #      await callHK()

# # if __name__ == "__main__":
# #     asyncio.run(callHK())
