"""
Test program to run the A-STEP test bench.

Author: Adrien Laviron, adrien.laviron@nasa.gov
"""
# Needed modules. They all import their own suppourt libraries, 
# and eventually there will be a list of which ones are needed to run
import pandas as pd
import asyncio
import time, os, sys, binascii, math
from tqdm import tqdm
import argparse

import drivers.boards
import drivers.astep.serial
import drivers.astropix.decode

# Logging stuff
import logging

async def buffer_flush(boardDriver, lanelst = range(3)):
    """This method flushes data from SPI lanes then from FPGA buffer, and resets counters"""
    logger.info("Flush chips before data collection")
    for lane in lanelst:
        await boardDriver.holdLane(lane, hold=False, flush=True)
        interrupt_counter=0
        interrupt = await boardDriver.getLaneStatus(lane)
        while interrupt&1 == 0 and interrupt_counter<20:
            logger.info("interrupt low")
            await boardDriver.setLaneCS(lane, cs=True, flush=True)
            await boardDriver.asics[lane].writeSPI([0x00] * 128)
            await boardDriver.setLaneCS(lane, cs=False, flush=True)
            #time.sleep(.1)
            # Let's not bother emptying the FPGA buffer, at this point it can overflow, and this data is trashed anyways since disableMISO in probably True
            interrupt_counter+=1
            interrupt = await boardDriver.getLaneStatus(lane)
            #logger.info(f"lane {lane} int={interrupt} ({interrupt_counter}/20)")
        # Reassert hold to be safe
        await boardDriver.holdLane(lane, hold=True, flush=True)
    # Now all interrupts are high, empty FPGA buffer
    logger.info("Flush FPGA buffer before data collection")
    await(boardDriver.readoutReadBytes(4098))
    await boardDriver.resetLaneStatCounters(lane)

# async def buffer_flush(boardDriver, lanelst = range(3)):
#     """This method will ensure the lane interrupt is not low and flush buffer, and reset counters"""
#     # Flush data from sensor
#     logger.info("Flush chip before data collection")
#     # Deassert hold
#     await boardDriver.holdLane(lane, hold=False, flush=True)#TBC
#     # Flush chips and SPI lines
#     interruptn = [1 for i in lanelst]
#     for lane in lanelst:
#         await boardDriver.writeLaneBytes(lane=lane, bytes=[0x00]*128, flush=True)
#         interruptn[lane] &= await boardDriver.getLaneStatus(lane)
#     # Keep flushing until interrupt is high
#     interupt_counter=0
#     while 0 in interruptn and interupt_counter<20:
#         logger.info("interrupt low")
#         #logger.info(interruptn)
#         for lane, i in enumerate(interruptn):
#             if i == 0:#if interrupt low
#                 await boardDriver.writeLaneBytes(lane = lane, bytes = [0x00] * 128, flush=True)
#         nmbBytes = await boardDriver.readoutGetBufferSize()
#         if nmbBytes > 0:
#             await boardDriver.readoutReadBytes(4096)
#         interruptn = [1 for i in lanelst]
#         for lane in lanelst:
#             #interruptn[lane] = await boardDriver.getLaneStatus(lane)
#             interruptn[lane] &= await boardDriver.getLaneStatus(lane)
#         interupt_counter+=1
#         logger.info(f"Buffer size = {nmbBytes} B")
#         #time.sleep(1)
#     # Now all interrupts are high, empty FPGA buffer
#     await(boardDriver.readoutReadBytes(4098))
#     # Reassert hold to be safe
#     await boardDriver.holdLane(lane, hold=True, flush=True)#TBC
#     logger.info("interrupt recovered, ready to collect data, resetting stat counters")
#     await boardDriver.resetLaneStatCounters(lane)

async def get_readout(boardDriver, counts:int = 4096):
    bufferSize = await(boardDriver.readoutGetBufferSize())
    readout = await(boardDriver.readoutReadBytes(counts))
    return bufferSize, readout

async def getBuffer(boardDriver):
  bufferSize = await boardDriver.readoutGetBufferSize()
  readout = await boardDriver.readoutReadBytes(bufferSize)
  return bufferSize, readout

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

async def printStatus(boardDriver, time=0., buff=0):
    pass
    # status = [await boardDriver.getLaneStatus(lane) for lane in range(3)]
    # ctrl = [await boardDriver.getLaneControl(lane) for lane in range(3)]
    # wrongl = [await boardDriver.getLaneWrongLength(lane) for lane in range(3)]
    # logger.info("[{time:04.2} s] buff={0:04d} status: 0={1[0]:02b}-{2[0]:06b}-{3[0]:04d} 1={1[1]:02b}-{2[1]:06b}-{3[1]:04d} 2={1[2]:02b}-{2[2]:06b}-{3[2]:04d}"\
    #             .format(buff, status, ctrl, wrongl, time=time))

# Needed to decode data
class myhack:
    def __init__(self):
        self.sampleclock_period_ns = 10

def bin2csv(fprefix):
    with open("{}.bin".format(fprefix), "rb") as ofile:
        datalst = []
        i = 0
        while (data := ofile.read(4096)):
            datalst.append( drivers.astropix.decode.decode_readout(myhack(), data, i = i, printer=False) )
            # logger.info(binascii.hexlify(data))
            i += 1
    if len(datalst) > 0:
        csvframe = ['readout', 'lane', 'chipID', 'payload', 'location', 'isCol', 'timestamp', 'tot_msb', 'tot_lsb', 'tot_total', 'tot_us', 'fpga_ts']
        df = pd.concat(datalst)
        df.columns = csvframe
        df.to_csv(fprefix+".csv")
    else:
        logger.warning("csv file not created because no data is present in binary file.")

#######################################################
#################### MAIN FUNCTION ####################

async def main(args):
    # Welcome to the main (and only) function of this script!
    print(args) # Soon to be removed
    logger.debug("Start main()")
    # Setup FPGA communications
    boardDriver = drivers.boards.getCMODUartDriver()
    logger.debug(f"boardDriver instanciated: {boardDriver}")
    await boardDriver.open()
    logger.info("Opened FPGA, testing...")
    try:
        fwid = await boardDriver.readFirmwareID()
        logger.debug(f"FW ID: {fwid}")
    except Exception: 
        raise RuntimeError("Could not read or write from astropix!")
    logger.info("FPGA test successful.")
    logger.debug("Set sensor clocks.")
    await boardDriver.enableSensorClocks(flush = True)
    # Setup FPGA timestamps
    await boardDriver.lanesConfigFPGATimestampFrequency(targetFrequencyHz = 1000000, flush = True)
    await boardDriver.lanesConfigFPGATimestamp(enable = True, force = False, source_match_counter = True, source_external = False, flush = True)

    logger.debug("Configure SPI readout")
    await boardDriver.configureLaneSPIDivider(20, flush = True)
    await boardDriver.rfg.write_layers_cfg_nodata_continue(value=8, flush=True)#8
    logger.debug("Instanciate ASIC drivers ...")
    # Configure chips in memory
    pathdelim = os.path.sep #determine if Mac or Windows separators in path name
    ymlpath = [os.getcwd()+pathdelim+"scripts"+pathdelim+"config"+pathdelim+ y +".yml" for y in args.yaml] # Define YAML path variables
    chipoff = os.getcwd()+pathdelim+"scripts"+pathdelim+"config"+pathdelim+ args.chipoffyml +".yml"#Default config: 1 chip, all pixels off
    try:
        boardDriver.setupASIC(version = 3, lane = -1, chipsPerLane = 1, configFile = chipoff)
        for lane, nchips, yml in zip(args.lanes, args.chipsPerLane, ymlpath):
            boardDriver.setupASIC(version = 3, lane = lane, chipsPerLane = nchips , configFile = yml)
    except FileNotFoundError as e :
        logger.error(f'Config File {ymlpath} was not found, pass the name of a config file from the scripts/config folder')
        raise e

    # Set multi-pix injection chip
    # if args.confOverride:
    #     boardDriver.getLaneConfig(1).asic_config["config_3"] = boardDriver.getLaneConfig(1).asic_config["config_4"]

    logger.info(f"{len(boardDriver.asics)} ASIC drivers instanciated.")
    # Setup / configure injection
    if args.inject:
        logger.debug("Enable injection pixel")
        try:
            boardDriver.asics[args.inject[0]].enable_inj_col(args.inject[1], args.inject[3], inplace=False)
            boardDriver.asics[args.inject[0]].enable_inj_row(args.inject[1], args.inject[2], inplace=False)
            boardDriver.asics[args.inject[0]].enable_pixel(chip=args.inject[1], col=args.inject[3], row=args.inject[2], inplace=False)
            logger.debug("Set injection voltage")
            # Priority to command line, defaults to yaml - already in vdac units
            if args.vinj is not None:
                boardDriver.asics[args.inject[0]].asic_config[f"config_{args.inject[1]}"]["vdacs"]["vinj"][1] = int(args.vinj/1000*1024/1.8)#1.8 V coded on 10 bits
            injector = boardDriver.getInjector()
            injector.setPattern(100, 300, 100, 0, 1)#Default set of parameters
            await boardDriver.ioSetInjectionToChip(enable = True, flush = True) # Routes injection pattern to on-chip injector
        except (KeyError, IndexError):
            logger.error(f"Injection arguments lane={args.inject[0]}, chip={args.inject[1]} invalid. Cannot initialize injection.")
            args.inject = None
    # Setup / configure analog
    if args.analog:
        logger.debug("enable analog")
        boardDriver.asics[args.analog[0]].enable_ampout_col(args.analog[1], args.analog[2], inplace=False)

    # await printStatus(boardDriver)
    # for lane in range(20): await boardDriver.zeroLaneWrongLength(lane, flush=True)

    await boardDriver.disableLanesReadout(flush=True)#Hold, disableMISO, disableAutoread, CS=inactive
    #await boardDriver.resetLanes()#Toggle RST with next firmware
    print("Reset chips")
    for lane in range(20):
        await boardDriver.setLaneConfig(lane, reset=True, autoread=False, hold=True, chipSelect=False, disableMISO=True, flush=True)
    time.sleep(0.5)
    for lane in range(20):
        await boardDriver.setLaneConfig(lane, reset=False, autoread=False, hold=True, chipSelect=False, disableMISO=True, flush=True)
    time.sleep(1)
    # Set chip IDs
    print("Set chip ID")
    for lane in args.lanes:
        await boardDriver.setLaneCS(lane, cs=True, flush=True)#Set chipSelect
        await boardDriver.asics[lane].writeSPIRoutingFrame(0)
        await boardDriver.setLaneCS(lane, cs=False, flush=True)#Unset chipSelect
    # return
    for i in range(max(args.chipsPerLane)):
        await boardDriver.setLaneCS(lane, cs=True, flush=True)#Set chipSelect
        for j, lane in enumerate(args.lanes):
            if i < args.chipsPerLane[j]:
                payload = boardDriver.asics[lane].createSPIConfigFrame(load=True, n_load=10, broadcast=False, targetChip=i)
                await boardDriver.asics[lane].writeSPI(payload)
        await boardDriver.setLaneCS(lane, cs=False, flush=True)#Unset chipSelect
    # Flush old data
    #await boardDriver.setLaneCS(lane, cs=True, flush=True)#Set chipSelect
    await buffer_flush(boardDriver, args.lanes)#Exit with hold active and manages chipselect itself
    #await boardDriver.setLaneCS(lane, cs=False, flush=True)#Unset chipSelect

    # Final setup
    if args.inject:
        await injector.start()
        dataStream_lst = []
        bufferLength_lst = []
    else:
        ofile = open("{}.bin".format(args.outputPrefix), "wb")
    if args.runTime is not None: 
        end_time=time.time()+(args.runTime*60.)
    else:
        end_time = float('inf')
    
    # Enable readout
    await boardDriver.enableLanesReadout(args.lanes, autoread=not(args.noAutoread), flush=True)
    
    # Main loop
    run = time.time() < end_time
    while run:
        try:
            if args.noAutoread:
                for lane in args.lanes:
                    await boardDriver.asics[lane].writeSPI([0x00] * 255)
            # Read data
            if args.readout is None: task = asyncio.create_task(getBuffer(boardDriver))
            else: task = asyncio.create_task(get_readout(boardDriver, args.readout))
            await task
            buff, readout = task.result()
            if args.inject:
                # Store data
                dataStream_lst.append(readout)
                bufferLength_lst.append(buff)
                await printStatus(boardDriver, time.time()-end_time, buff=buff)
            else:
                if buff > 0:
                    ofile.write(readout)
                #logger.info(binascii.hexlify(readout))
                #await printStatus(boardDriver, time.time()-end_time, buff=buff)
            print(f"  {buff:04d}  ", end="\r")
            # logger.info(binascii.hexlify(readout[:buff]))
            # Check time
            run = time.time() < end_time
        except (KeyboardInterrupt, asyncio.CancelledError):
            logger.info("[Ctrl+C] while in main loop - exiting.")
            run=False
    await printStatus(boardDriver, time.time()-end_time)
    # Pause readout
    await boardDriver.disableLanesReadout(flush=True)
    
    # End injection
    if args.inject: await injector.stop()
    else: ofile.close()
    
    # End connection
    await boardDriver.close()

    #Process data
    if args.inject:
        print(len(bufferLength_lst), max(bufferLength_lst))
        dataStream = dataParse_autoread(dataStream_lst, bufferLength_lst, None)
        df = drivers.astropix.decode.decode_readout(myhack(), logger, dataStream, i=0, printer=False)
        if len(df) > 0:
            csvframe = ['readout', 'lane', 'chipID', 'payload', 'location', 'isCol', 'timestamp', 'tot_msb', 'tot_lsb', 'tot_total', 'tot_us', 'fpga_ts']
            df.columns = csvframe
            df.to_csv(args.outputPrefix+".csv")
        else:
            logger.warning("No data written to disk because none have been received.")
    else:
        bin2csv(args.outputPrefix)
        






#######################################################
#################### TOP LEVEL ########################

if __name__ == "__main__":

    parser = argparse.ArgumentParser(description='Test program to run the A-STEP test bench.',
                                     formatter_class=argparse.RawTextHelpFormatter, #allow formatting of the epilog
                                     epilog="""""") 

    # Options related to outputs
    parser.add_argument('-o', '--outputPrefix', type=str, default="{0}{2}data{2}{1}".format(os.getcwd(), time.strftime("%Y%m%d-%H%M%S"), os.path.sep), 
                        help="Path to and beginning of the name of the data file(s) and log file, default: data/YYYYMMDD-HHMMSS")

    # Options related to software run settings
    parser.add_argument('-L', '--loglevel', type=str, choices = ['D', 'I', 'E', 'W', 'C'], action="store", default='I',
                        help='Set loglevel used. Options: D - debug, I - info, E - error, W - warning, C - critical. DEFAULT: I')
    parser.add_argument('-T', '--runTime', type=float, action='store',  default=None,
                        help = 'Maximum run time (in minutes). Default: NONE (run until user CTL+C)')
    parser.add_argument('-r', '--readout', default=0, type=int,
                        help = 'Number of bytes of FPGA buffer to read for each readout (1 to 4098, 0->As much as buffer contains, other->4096). Default: 0')
    
    # Options related to Setup / Configuration of system
    parser.add_argument('-y', '--yaml', action='store', required=False, type=str, default = [], nargs="*", 
                        help = 'filepath (in scripts/config/ directory) .yml file containing chip configuration. \
                                One file must be passed for each lane, from lane #0 to lane #2. \
                                Default: All pixels off')
    parser.add_argument('-c', '--chipsPerLane', action='store', required=False, type=int, default = [], nargs="*", 
                        help = 'Number of chips per SPI lanes to enable. Can provide a single number or one number per lane. Default: 20')
    parser.add_argument('-l', '--lanes', action='store', required=False, type=int, default = [], nargs="*",
                        help = 'Lane IDs to configure. Can provide a single number or many, lane numbering starts at 0. \
                        If -c and -y present, the lanes will be configured using the yaml file and number of chips provided.')
    parser.add_argument('--config-override', dest='confOverride', action='store_true',
                        help = "Execute a special line of code that applies hard-coded configuration changes -- \
                        do not use unless you have read the code and know what you are doing!")
    
    # Options related to Setup / Configuration of the chip in data collection run
    parser.add_argument('-na', '--noAutoread', action='store_true', required=False, 
                        help='If passed, does not enable autoread features off chip. If not passed, read data with autoread. Default: autoread')
    parser.add_argument('-t', '--threshold', type = int, action='store', default=100,
                        help = 'Threshold voltage for digital ToT (in mV). DEFAULT: 100')
    parser.add_argument('-a', '--analog', action='store', required=False, type=int, default = None, nargs=3,
                        help = 'Turn on analog output in the given column. Can only enable one analog pixel per lane. \
                        Requires input in the form {lane, chip, col} (no wrapping brackets). \
                        Default: None')
                        #Default: lane 1, chip 0, col 0')
    
    # Options related to chip injection
    parser.add_argument('-i', '--inject', action='store', default=None, type=int, nargs=4,
                    help =  'Turn on injection in the given lane, chip, row, and column. Default: No injection')
    parser.add_argument('-v','--vinj', action='store', default = None,  type=int,
                        help = 'Specify injection voltage (in mV). DEFAULT: value in config ')

    args = parser.parse_args()
    args.chipoffyml = '1chip_allOff'#Default config: 1 chip, all pixels off

    # Define the loglevel
    ll = args.loglevel
    if ll == 'D':
        loglevel = logging.DEBUG ## DAN - not working! Causes runs to crash and read in tons of railed buffers after the alloted time???
    elif ll == 'I':
        loglevel = logging.INFO
    elif ll == 'E':
        loglevel = logging.ERROR
    elif ll == 'W':
        loglevel = logging.WARNING
    elif ll == 'C':
        loglevel = logging.CRITICAL
    logname = args.outputPrefix+"_run.log"
    formatter = logging.Formatter('%(asctime)s:%(msecs)d.%(name)s.%(levelname)s:%(message)s')
    fh = logging.FileHandler(logname)
    fh.setFormatter(formatter)
    sh = logging.StreamHandler()
    sh.setFormatter(formatter)
    logging.getLogger().addHandler(sh) 
    logging.getLogger().addHandler(fh)
    logging.getLogger().setLevel(loglevel)
    global logger 
    logger = logging.getLogger(__name__)
    logger.info("Setup logger")

    #Lane counting begins at 0.
    #Make sure config arguments make sense
    if len(args.yaml) > len(args.chipsPerLane) or len(args.yaml) > len(args.lanes):
        raise ValueError("You need to provide one chipsPerLane (-c) argument and one lane ID (-l) argument per yaml file!")
    if len(args.chipsPerLane) != 0 and len(args.chipsPerLane) != len(args.lanes):
        raise ValueError("You need to provide one lane ID (-l) per chipsPerLane argument!")
    #if len(args.lanes) != len(args.yaml) or len(args.lanes) != len(args.chipsPerLane):
    #    raise ValueError("You need to provide one yaml configuration file (with -y) and one chipsPerLane argument (with -c) for every lane to configure (with -l).")

    #Make sure analog/inject arguments make sense
    if args.analog is not None and (len(args.analog)!=3 or args.analog[0]<0 or args.analog[0]>19 or args.analog[1]<0 or args.analog[1]>19 or args.analog[2]<0):
        raise ValueError("Incorrect analog argument lane={0[0]},chip={0[1]},column={0[2]}".format(args.analog))
    if args.inject is not None and (len(args.inject)!=4 or args.inject[0]<0 or args.inject[0]>19 or args.inject[1]<0 or args.inject[1]>19 or args.inject[2]<0 or args.inject[3]<0):
        raise ValueError("Incorrect analog argument lane={0[0]},chip={0[1]},row={0[2]},column={0[3]}".format(args.inject))

    #Sanitizing args.readout
    if args.readout == 0: args.readout = None
    elif args.readout < 0 or args.readout > 4098: args.readout = 4096


    asyncio.run(main(args))

