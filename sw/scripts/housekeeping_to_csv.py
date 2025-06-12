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
import logging
logger = logging.getLogger(__name__)
logger.setLevel(logging.INFO)
SAVE_DIRECTORY = "C:/TCData/"
FILE_PREFIX = "compair2_fee_SNx_test"
COM_PORT_SETTING = "COM8"
NUM_ADCS     = 3
NUM_CHANNELS = 8
N            = NUM_ADCS * NUM_CHANNELS

# 1) Build a filename with a timestamp so each run gets its own file:
readout_names = [""] * NUM_ADCS * NUM_CHANNELS
readout_units = [""] * NUM_ADCS * NUM_CHANNELS
hk_idx = 0
for adc_num in [1,2,3]:
    for chan in range(NUM_CHANNELS):
        (units, shortname) = hk_eqns.get_info(adc_num-1,chan)
        readout_names[hk_idx] = shortname
        readout_units[hk_idx] = units
        hk_idx = hk_idx + 1

#print(readout_names.join(','))
header = "timestamp,"
header = header + ",".join(readout_names)

start_time = datetime.now()

FILE_TIMESTAMP   = start_time.strftime('%Y%m%d_%H%M%S')
values_filename = os.path.abspath(os.path.join(SAVE_DIRECTORY,FILE_PREFIX + "_HK_VALUES_" + FILE_TIMESTAMP + ".csv"))
codes_filename = os.path.abspath(os.path.join(SAVE_DIRECTORY,FILE_PREFIX + "_HK_CODES_" +FILE_TIMESTAMP + ".csv"))


async def read_adc_code(adc_num,chan,driver):
    #await driver.houseKeeping.selectADC(0)
    await driver.houseKeeping.writeADCDACBytes(bytes([chan<<3,0]))
    await driver.houseKeeping.selectADC(adc_num)
    adcBytesCount = await driver.houseKeeping.getADCBytesCount()
    if adcBytesCount != 2:
        logging.warning(f"ERROR: byte count = {hex(adcBytesCount)}")
    adcBytes = await driver.houseKeeping.readADCBytes(adcBytesCount) 
    return int.from_bytes(adcBytes)

channel_list = [0, 0, 1, 2, 3, 4, 5, 6, 7, 0]
async def get_hk_row(driver):
    readout_codes = [0] * N
    readout_values = [0.00] * N
    hk_idx = 0
    for adc_num in [1,2,3]:
        adc_code = await read_adc_code(adc_num,0,driver) # prime next read to 0
        for chan in range(NUM_CHANNELS):
            if chan  < 8: 
                adc_code = await read_adc_code(adc_num,(chan+1) % 8,driver) # set next read to chan + 1, start at ch1
            else:
                adc_code = await read_adc_code(adc_num,0,driver)
            readout_codes[hk_idx] = adc_code
            value = hk_eqns.convert(adc_num-1,chan,adc_code)
            readout_values[hk_idx] = round(value,3)
            hk_idx = hk_idx + 1
            
    return readout_codes, readout_values


async def get_hk_row_tripple(driver):
    readout_codes = [0] * N
    readout_values = [0.00] * N
    hk_idx = 0
    for adc_num in [1,2,3]:
        for chan in range(NUM_CHANNELS):
            for retry in range(6): 
                adc_code = await read_adc_code(adc_num,chan,driver) # set next read to chan + 1, start at ch1
                if retry == 5:
                    readout_codes[hk_idx] = adc_code
                    value = hk_eqns.convert(adc_num-1,chan,adc_code)
                    readout_values[hk_idx] = round(value,3)
                    hk_idx = hk_idx + 1
            
    return readout_codes, readout_values
async def do_housekeeping():
    driver = drivers.boards.getCMODUartDriver(COM_PORT_SETTING,baud=115200) #115200 
    await driver.open() 
    with open(values_filename, 'w', newline='') as csvfile:
        writer = csv.writer(csvfile)
        writer.writerow(header.split(","))
        for line_number in range(1000):
            now = datetime.now().isoformat()
            print(now)
            (readout_codes, readout_values) =  await get_hk_row_tripple(driver)
            row = now + "," + ",".join([str(x) for x in readout_values])
            print(row)
            writer.writerow(row.split(","))
            if (line_number % 10): # only sometimes flush write queue
                csvfile.flush()
        driver.close()
        csvfile.flush()
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
#     readout_names = [""] * NUM_ADCS * NUM_CHANNELS
#     readout_units = [""] * NUM_ADCS * NUM_CHANNELS
#     hk_idx = 0
#     for adc_num in [1,2,3]:
#         for chan in range(8):
#             (units, shortname) = hk_eqns.get_info(adc_num-1,chan)
#             readout_names[hk_idx] = shortname
#             readout_units[hk_idx] = units
#             hk_idx = hk_idx + 1
    
#     readout_codes = [0] * NUM_ADCS * NUM_CHANNELS
#     readout_values = [0.00] * NUM_ADCS * NUM_CHANNELS

#     for top in range(1):



# #     print(readout_codes)
# #     await driver.close()


# # async def main():

# #     #while time.time() < t_end:
# #      await callHK()

# # if __name__ == "__main__":
# #     asyncio.run(callHK())
