"""
Test program to configure a ComPair segment (adapted from A-STEP test bench).

Author: Adrien Laviron, adrien.laviron@nasa.gov
"""

import sys
import os
os.environ['BASE'] = os.path.abspath(".")
print(sys.path)
sys.path.insert(1, os.path.abspath("sw"))
sys.path.insert(1, os.path.abspath("vendor/icflow_hdl_240807/hdl_rfg_v1/python"))
sys.path.insert(1, os.path.abspath("rtl/top"))

import asyncio
import time, os, sys, binascii, math
from tqdm import tqdm
import argparse

import drivers.boards
import drivers.astropix.decode

async def get_readout(boardDriver, counts:int = 4096):
    bufferSize = await(boardDriver.readoutGetBufferSize())
    readout = await(boardDriver.readoutReadBytes(counts))
    return bufferSize, readout

# Needed to decode data
class myhack:
    def __init__(self):
        self.sampleclock_period_ns = 10

#Parse raw data readouts to remove railing. Moved to postprocessing method to avoid SW slowdown when using autoread
def dataParse_autoread(data_lst, buffer_lst, bitfile:str = None):
    allData = b''
    for i, buff in enumerate(buffer_lst):
        if buff>0:
            readout_data = data_lst[i][:buff]
            #logger.info(binascii.hexlify(readout_data))
            allData+=readout_data
            if bitfile:
                bitfile.write(f"{str(binascii.hexlify(readout_data))}\n")
    ## DAN - could also return buffer index to keep track of whether multiple hits occur in the same readout. Would need to propagate forward
    return allData

#######################################################
#################### MAIN FUNCTION ####################

async def main(args):
    # Welcome to the main (and only) function of this script!
    # Setup FPGA communications
    boardDriver = drivers.boards.getCMODUartDriver("COM10", baud=115200)
    await boardDriver.open()
    print("Opened FPGA, testing...")
    try:
        fwid = await boardDriver.readFirmwareID()
        print(f"FW ID: {fwid}")
    except Exception: 
        raise RuntimeError("Could not read or write from astropix!")
    print("Set sensor clocks.")
    await boardDriver.enableSensorClocks(flush = True)
    # Setup FPGA timestamps
    await boardDriver.layersConfigFPGATimestampFrequency(targetFrequencyHz = 1000000, flush = True)
    await boardDriver.layersConfigFPGATimestamp(enable = True, force = False, source_match_counter = True, source_external = False, flush = True)
    # Setup SPI
    await boardDriver.configureLayerSPIDivider(20, flush = True)
    #await boardDriver.rfg.write_layers_cfg_nodata_continue(value=8, flush=True) only used in readout, early modification
    print("Instanciate ASIC drivers ...")
    # Configure chips in memory
    pathdelim = os.path.sep #determine if Mac or Windows separators in path name
    ymlpath = [os.getcwd()+pathdelim + "sw" + pathdelim+"scripts"+pathdelim+"config"+pathdelim+ y +".yml" for y in args.yaml] # Define YAML path variables
    try:
        #for layer, (nchips, yml) in enumerate(zip(args.chipsPerRow, ymlpath)):
        #    print("{}: {}, {}".format(layer, nchips, yml))
        boardDriver.setupASICS(version = 3, rows = 20, chipsPerRow = 20 , configFile = ymlpath[0] )
    except FileNotFoundError as e :
        print(f'Config File {ymlpath} was not found, pass the name of a config file from the scripts/config folder')
        raise e
    print(f"{len(boardDriver.asics)} ASIC drivers instanciated.")

    layerlst = [17]#range(len(args.yaml)) Set SPI lane(s) here
    #await boardDriver.disableLayersReadout(flush=True)#Hold, disableMISO, disableAutoread, CS=inactive
    for i in range(20):
        await boardDriver.setLayerConfig(i,reset=False,autoread=False,hold=True,chipSelect=False,disableMISO=True,flush=True)
    #await boardDriver.resetLayersFull()#Toggle RST
    for layer in layerlst:
        await boardDriver.setLayerConfig(layer,reset=True,autoread=False,hold=True,chipSelect=False,disableMISO=True,flush=True)
    asyncio.sleep(0.5)
    for layer in layerlst:
        await boardDriver.setLayerConfig(layer,reset=False,autoread=False,hold=True,chipSelect=False,disableMISO=True,flush=True)

    # Set chip IDs
    for layer in layerlst:
        await boardDriver.layerSelectSPI(layer, cs=True, flush=True)#Set chipSelect
        await boardDriver.asics[layer].writeSPIRoutingFrame(3)
        await boardDriver.layerSelectSPI(layer, cs=False, flush=True)#Unset chipSelect
    print("Chip IDs set")

    # Configure chips - probably requires a little update of asic.py driver
    for layer in layerlst:
        await boardDriver.layerSelectSPI(layer, cs=True, flush=True)
        await boardDriver.asics[layer].writeConfigSPIv2(broadcast=False, targetChip=0)
        await boardDriver.layerSelectSPI(layer, cs=False, flush=True)
    print("1 chip configured")
    # for i in range(args.chipsPerRow[layer]):
    #     await boardDriver.layerSelectSPI(4, cs=True, flush=True)#Set chipSelect
    #     for layer in layerlst:
    #         if i < args.chipsPerRow[layer]:
    #         #    payload = boardDriver.asics[layer].createSPIConfigFrame(load=True, n_load=10, broadcast=False, targetChip=i)
    #         #    await boardDriver.asics[layer].writeSPI(payload)
    # await boardDriver.layerSelectSPI(4, cs=False, flush=True)#Unset chipSelect
    # print("Chips configured")


    # Skip buffer flush

    # Activate chip readout
    for layer in layerlst:
        await boardDriver.setLayerConfig(layer,reset=False,autoread=True,hold=False,chipSelect=True,disableMISO=False,flush=True)

    # Main loop
    dataStream_lst = []
    bufferLength_lst = []
    end_time=time.time()+10 # 4 s run
    run = time.time() < end_time
    while run:
        try:
            task = asyncio.create_task(get_readout(boardDriver))
            await task
            buff, readout = task.result()
            print(f"  {buff:04d}  ", end="\r")
            dataStream_lst.append(readout)
            bufferLength_lst.append(buff)
            print(binascii.hexlify(readout[:buff]))
            # Check time
            run = time.time() < end_time
        except (KeyboardInterrupt, asyncio.CancelledError):
            print("[Ctrl+C] while in main loop - exiting.")
            run=False
    

    for layer in layerlst:
        await boardDriver.setLayerConfig(layer,reset=False,autoread=False,hold=True,chipSelect=False,disableMISO=True,flush=True)

    print(len(bufferLength_lst), max(bufferLength_lst))
    dataStream = dataParse_autoread(dataStream_lst, bufferLength_lst, None)
    print(len(dataStream))
    df = drivers.astropix.decode.decode_readout(myhack(), dataStream, i=0, printer=True)
    print(len(df))



#######################################################
#################### TOP LEVEL ########################

if __name__ == "__main__":
    # Quick highjacking of arguments
    parser = argparse.ArgumentParser()
    args = parser.parse_args()
    args.yaml = ['20chips_allOff']*20
    args.chipsPerRow = [20]*20

    #Layer counting begins at 0.
    #Make sure config arguments make sense
    if len(args.yaml) > len(args.chipsPerRow):
        if len(args.chipsPerRow) > 1:
            print(f"Number of chips per row not provided for every layer - default to {args.chipsPerRow[0]} for all {len(args.yaml)} layers.")
        args.chipsPerRow = [args.chipsPerRow[0]]*len(args.yaml)
    elif len(args.yaml) < len(args.chipsPerRow):
        raise ValueError("You need to provide one yaml configuration file for every chipsPerRow argument.")

    asyncio.run(main(args))

