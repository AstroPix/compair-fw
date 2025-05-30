"""
Test program to configure a ComPair segment (adapted from A-STEP test bench).

Author: Adrien Laviron, adrien.laviron@nasa.gov
"""
import asyncio
import time, os, sys, binascii, math
from tqdm import tqdm
import argparse

import drivers.boards
import drivers.astep.serial



#######################################################
#################### MAIN FUNCTION ####################

async def main(args):
    # Welcome to the main (and only) function of this script!
    # Setup FPGA communications
    boardDriver = drivers.boards.getCMODUartDriver("COM11", baud=115200)
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
    ymlpath = [os.getcwd()+pathdelim+"scripts"+pathdelim+"config"+pathdelim+ y +".yml" for y in args.yaml] # Define YAML path variables
    try:
        for layer, (nchips, yml) in enumerate(zip(args.chipsPerRow, ymlpath)):
            boardDriver.setupASIC(version = 3, row = layer, chipsPerRow = nchips , configFile = yml )
    except FileNotFoundError as e :
        logger.error(f'Config File {ymlpath} was not found, pass the name of a config file from the scripts/config folder')
        raise e
    print(f"{len(boardDriver.asics)} ASIC drivers instanciated.")

    layerlst = [10]#range(len(args.yaml)) Set SPI lane(s) here
    await boardDriver.disableLayersReadout(flush=True)#Hold, disableMISO, disableAutoread, CS=inactive
    await boardDriver.resetLayersFull()#Toggle RST

    # Set chip IDs
    await boardDriver.layersSelectSPI(flush=True)#Set chipSelect
    for layer in layerlst:
        await boardDriver.asics[layer].writeSPIRoutingFrame(0)
    await boardDriver.layersDeselectSPI(flush=True)#Unset chipSelect
    print("Chip IDs set")
        
#    # Configure chips - probably requires a little update of asic.py driver
#    for i in range(args.chipsPerRow[layer]):
#        await boardDriver.layersSelectSPI(flush=True)#Set chipSelect
#        for layer in layerlst:
#            if i < args.chipsPerRow[layer]:
#                payload = boardDriver.asics[layer].createSPIConfigFrame(load=True, n_load=10, broadcast=False, targetChip=i)
#                await boardDriver.asics[layer].writeSPI(payload)
#        await boardDriver.layersDeselectSPI(flush=True)#Unset chipSelect
#    print("Chips configured")




#######################################################
#################### TOP LEVEL ########################

if __name__ == "__main__":
    # Quick highjacking of arguments
    args = object()
    args.yaml = ['20chips_allOff']*20
    args.chipsPerRow = [20]*20

    #Layer counting begins at 0.
    #Make sure config arguments make sense
    if len(args.yaml) > len(args.chipsPerRow):
        if len(args.chipsPerRow) > 1:
            logger.warning(f"Number of chips per row not provided for every layer - default to {args.chipsPerRow[0]} for all {len(args.yaml)} layers.")
        args.chipsPerRow = [args.chipsPerRow[0]]*len(args.yaml)
    elif len(args.yaml) < len(args.chipsPerRow):
        raise ValueError("You need to provide one yaml configuration file for every chipsPerRow argument.")

    #Make sure analog/inject arguments make sense
    if args.analog is not None and (len(args.analog)!=3 or args.analog[0]<0 or args.analog[0]>2 or args.analog[1]<0 or args.analog[1]>3 or args.analog[2]<0):
        raise ValueError("Incorrect analog argument layer={0[0]},chip={0[1]},column={0[2]}".format(args.analog))
    if args.inject is not None and (len(args.inject)!=4 or args.inject[0]<0 or args.inject[0]>2 or args.inject[1]<0 or args.inject[1]>3 or args.inject[2]<0 or args.inject[3]<0):
        raise ValueError("Incorrect analog argument layer={0[0]},chip={0[1]},row={0[2]},column={0[3]}".format(args.inject))


    asyncio.run(main(args))

