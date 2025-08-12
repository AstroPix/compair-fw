
from deprecated import deprecated

import drivers.astep.housekeeping
import rfg.io
import rfg.core
import asyncio

from drivers.astropix.asic import Asic

from drivers.astropix.loopback_model import Astropix3LBModel

class BoardDriver():

    def __init__(self,rfg):
        self.rfg = rfg
        self.houseKeeping = drivers.astep.housekeeping.Housekeeping(self,rfg)
        self.asics = {}
        ## Opened Event -> Set/unset by close/open
        ## Useful to start or stop tasks dependent on open/close state of the driver
        self.openedEvent = asyncio.Event()

    ## FPGA I/O
    ##################
    def selectUARTIO(self,portPath : str | None = None, baud = 115200):
        """This method is common to all targets now, because all targets have a USB-UART Converter available"""
        if portPath is None:
            from drivers.astep.serial import getSerialPort
            port = drivers.astep.serial.getSerialPort()
            if port is None:
                raise RuntimeError("No Serial Port from vendor FTDI could be listed")
            else:
                portPath = port.device
        self.rfg.withUARTIO(portPath, baud)
        return self
        

    async def open(self):
        """Open the Register File I/O Connection to the underlying driver"""
        await self.rfg.io.open()
        self.openedEvent.set()

    async def close(self):
        """Close the Register File I/O Connection to the underlying driver"""
        self.openedEvent.clear()
        await self.rfg.io.close()

    async def waitOpened(self):
        await self.openedEvent.wait()

    def isOpened(self) -> bool: 
        return self.openedEvent.is_set()

    def debug_full(self):
        rfg.core.debug()

    async def flush(self):
        """Flushed the RFG instance, use to be sure no bytes are pending writting"""
        await self.rfg.flush()

    async def readFirmwareVersion(self):
        """Returns the raw integer with the firmware Version"""
        return (await (self.rfg.read_hk_firmware_version()))

    async def readFirmwareID(self):
        """Returns the raw integer with the firmware id"""
        return await (self.rfg.read_hk_firmware_id())

    async def readFirmwareIDName(self):
        """"""
        boards  =  {0xab02: 'Nexys GECCO Astropix v2',0xab03: 'Nexys GECCO Astropix v3',0xac03:"CMOD Astropix v3"}
        boardID =  await (self.readFirmwareID())
        return boards.get(boardID,"Firmware ID unknown: {0}".format(hex(boardID)))

    async def checkFirmwareVersionAfter(self,v):
        return await (self.readFirmwareVersion()) >= v

    def getFPGACoreFrequency(self):
        """Returns the Core Clock frequency to help clock divider configuration - this method is overriden by implementation class (Gecco or Cmod)"""
        pass

    ## Loopback Model
    ##################
    def getLoopbackModelForLane(self,lane):
        return Astropix3LBModel(self,lane)

    ## Asic
    ##################
    def setupASIC(self, version: int, lane: int = 0, chipsPerLane: int=1, configFile: str|None = None):
        """
        Load a config yaml file to memory
        :param version: int, AstroPix chip version
        :param lane: int, number of the current lane, default=0
        :param chipsPerLane: int, number of chips per lane (aka daisy chain), default=1
        :param configFile: srt, path to yaml config file, defaults to None (no configuration applied?)
        """
        asic = Asic(rfg = self.rfg, lane = lane)
        asic.chipversion = version
        if configFile is not None: 
            asic.load_conf_from_yaml(configFile)
        asic._num_chips = chipsPerLane
        self.asics.update({lane: asic})

    #def getAsic(self, lane:int):
    #    """
    #    Return the Asic object for the specified lane
    #    :param lane: int, lane ID (0-19)
    #    :retuns: Asic object containing configuration from yaml file
    #    """
    #    return self.asics[lane]
    #    #for asic in self.asics:
    #    #    if asic.lane == lane:
    #    #        return asic
    #    #raise IndexError("Lane {} not found!".format(lane))

    ## Ctrl reg
    ##################
    async def enableSensorClocks(self, ToT=True, TS=True, flush:bool = False):
        v = await self.rfg.read_io_ctrl()
        if ToT:  v|=0x1
        else:  v &= ~(0x1)
        if TS: v|=0x2
        else: v &= ~(0x2)
        await self.rfg.write_io_ctrl(v,flush)

    async def ioSetInjectionToChip(self,enable:bool = True,flush:bool = False):
        v = await self.rfg.read_io_ctrl()
        if enable: v &= ~(0x8)
        else: v |= 0x8
        await self.rfg.write_io_ctrl(v,flush) 


    ## Lanes
    ##################
    async def configureLanesFrameTag(self,enable, flush = False):
        await self.rfg.write_layers_cfg_frame_tag_counter_ctrl(1 if enable is True else 0,flush)

    async def configureLanesFrameTagFrequency(self, targetFrequencyHz : int , flush = False):
        """Calculated required divider to reach the provided target SPI clock frequency"""
        coreFrequency = self.getFPGACoreFrequency()
        divider = int( coreFrequency / ( targetFrequencyHz))
        assert divider >=1 and divider <=255 , (f"Divider {divider} is too high, min. clock frequency: {int(coreFrequency/255)}")
        await self.configureLanesFrameTagDivider(divider,flush)

    async def configureLanesFrameTagDivider(self, divider , flush = False):
        await self.rfg.write_layers_cfg_frame_tag_counter_trigger_match(divider,False)
        await self.rfg.write_layers_cfg_frame_tag_counter_trigger(0,flush)
        
    async def configureLaneSPIFrequency(self, targetFrequencyHz : int , flush = False):
        """Calculated required divider to reach the provided target SPI clock frequency"""
        coreFrequency = self.getFPGACoreFrequency()
        divider = int( coreFrequency / (2 * targetFrequencyHz))
        assert divider >=1 and divider <=255 , (f"Divider {divider} is too high, min. clock frequency: {int(coreFrequency/2/255)}")
        await self.configureLaneSPIDivider(divider,flush)

    async def configureLaneSPIDivider(self, divider:int , flush = False):
        await self.rfg.write_spi_layers_ckdivider(divider,flush)

#    async def lanesSetSPICSN(self, cs = False, flush = False):
#        """This helper method asserts the shared CSN to 0 by selecting CS on lane 0
#        it's a helper to be used only if the hardware uses a shared Chip Select!!
#        If any lane is in autoread mode, chip select will be already asserted
#        """
#        lane0Cfg = await self.rfg.read_layer_0_cfg_ctrl()
#        if cs:
#            lane0Cfg = lane0Cfg | (1 << 3)
#        else:
#            lane0Cfg = lane0Cfg & ~(1 << 3)
#            
#        await self.rfg.write_layer_0_cfg_ctrl(lane0Cfg,flush)
#
#    async def lanesSelectSPI(self, flush = False):
#        """This helper method asserts the shared CSN to 0 by selecting CS on layer 0
#        it's a helper to be used only if the hardware uses a shared Chip Select!!
#        If any Lane is in autoread mode, chip select will be already asserted
#        """
#        lane0Cfg = await self.rfg.read_layer_0_cfg_ctrl()
#        lane0Cfg = lane0Cfg | (1 << 3)
#        await self.rfg.write_layer_0_cfg_ctrl(lane0Cfg,flush)
#
#    async def lanesDeselectSPI(self, flush = False):
#        """This helper method deasserts the shared CSN to 1 by deselecting CS on layer 0
#        it's a helper to be used only if the hardware uses a shared Chip Select!!
#        If any Lane is in autoread mode, chip select will stay asserted
#        """
#        lane0Cfg = await self.rfg.read_layer_0_cfg_ctrl()
#        lane0Cfg = lane0Cfg & ~(1 << 3)
#        await self.rfg.write_layer_0_cfg_ctrl(lane0Cfg,flush)

    async def setLaneConfig(self,lane:int, reset : bool, autoread : bool, hold:bool , chipSelect:bool = False,disableMISO:bool = False, flush = False):
        """Modified the lane config with provided bools
           Note: Reset is shared and only connected to lane #0, Hold and CSN piloted per-lane
        Args:
            lane (int): lane to reset
            reset (bool): Assert/deassert reset I/O to ASIC
            autoread (bool): Enables or Disables interrupt-based automatic reading
            hold (bool): Assert/deassert hold I/O to ASIC
            chipSelect (bool): Assert/deassert Chip Select for this lane (I/O is inverted in firmware to produce low-active signal)
            disableMISO (bool): Disable SPI MISO bytes reading. Setting this bit to 1 prevents the Firmware from reading bytes
            flush (bool): Write the register right away
        """
        regval =  await getattr(self.rfg, f"read_layer_{lane}_cfg_ctrl")()
        if reset is True: regval |= (1<<1)
        else: regval &= ~(1<<1)
        if hold is True: regval |= 1 
        else:  regval &= 0XFE
        # Autoread is "disable" in config, so True here means False in the register
        if autoread is False: regval |= (1<<2)
        else: regval &= ~(1<<2)
        if chipSelect is True: regval |= (1<<3)
        else: regval &= ~(1<<3)
        if disableMISO is True: regval |= (1<<4)
        else: regval &= ~(1<<4)
        await getattr(self.rfg, f"write_layer_{lane}_cfg_ctrl")(regval,flush)

    async def resetLanes(self, waitTime: float = 0.5, flush=True):
        """Reset all lanes because the reset line is shared.

        Args:
            waitTime (float):  Reset duration - Default 0.5s
        """
        lane0Cfg = await self.rfg.read_layer_0_cfg_ctrl()
        lane0Cfg |= (1<<1)
        await self.rfg.write_layer_0_cfg_ctrl(lane0Cfg,flush)
        await asyncio.sleep(waitTime)
        lane0Cfg &= ~(1<<1)
        await self.rfg.write_layer_0_cfg_ctrl(lane0Cfg,flush)

    async def holdLane(self, lane:int, hold:bool, flush:bool = False):
        """
        Set Hold to active/inactive for a lane
        """
        ctrl = await getattr(self.rfg, f"read_layer_{lane}_cfg_ctrl")()
        if hold: ctrl |= (1 << 3) 
        else: ctrl &= ~(1 << 3)
        await getattr(self.rfg, f"write_layer_{lane}_cfg_ctrl")(ctrl,flush=flush)

    async def setLaneCS(self, lane:int, cs:bool = True, flush:bool = True):
        """
        Set CS to active/inactive for a lane
        """
        ctrl = await getattr(self.rfg, f"read_layer_{lane}_cfg_ctrl")()
        if cs: ctrl |= 1 
        else: ctrl &= 0XFE
        await getattr(self.rfg, f"write_layer_{lane}_cfg_ctrl")(ctrl,flush=flush)

    async def enableLanesReadout(self, lanelst:list, autoread:bool, flush:bool = False):
        """
        Enables readout for a list of lanes:
         - Disable autoread and chipselect for all lanes
         - Disable MISO for all lanes
         - Enable autoread and chipselect for selected lanes
         - Enable MISO for select lanes
         - Lower shared hold
        :param lanelst: list of lanes numbers (int) for which readout will be enabled
        :param autoread: bool, True for autoread
        :param flush:
        """
        await self.disableLanesReadout(flush=False)
        for lane in lanelst:
            await self.setLaneConfig(lane=lane, hold=False, reset=False, autoread=autoread, chipSelect=True, disableMISO=False, flush=False)
        await self.rfg.flush()

    async def disableLanesReadout(self, flush:bool = True):
        """
        Disable readout for all lanes
         - Raise Hold
         - Disable autoread, chipselect and MISO
        """
        for lane in range(20):
            await self.setLaneConfig(lane=lane, hold=True, reset=False, autoread=False, chipSelect=False, disableMISO=True, flush=flush)

#    async def writeLaneBytes(self,lane : int , bytes: bytearray,flush:bool = False):
#        await getattr(self.rfg, f"write_layer_{lane}_mosi_bytes")(bytes,flush)
    
#    async def writeBytesToLane(self,lane : int , bytes: bytearray,waitBytesSend : bool = False, flush:bool = False):
#        await getattr(self.rfg, f"write_layer_{lane}_mosi_bytes")(bytes,flush)
#        if waitBytesSend is True:
#            await self.assertLaneNotInReset(lane)
#            while (await getattr(self.rfg, f"read_layer_{lane}_mosi_write_size")() > 0):
#                pass

    async def getLaneMOSIBytesCount(self,lane:int):
        return await getattr(self.rfg,f"read_layer_{lane}_mosi_write_size")()

    async def getLaneStatIDLECounter(self,lane:int):
        return await getattr(self.rfg, f"read_layer_{lane}_stat_idle_counter")()

    async def getLaneStatFRAMECounter(self,lane:int):
        return await getattr(self.rfg, f"read_layer_{lane}_stat_frame_counter")()

    async def getLaneStatus(self,lane:int):
        return await getattr(self.rfg, f"read_layer_{lane}_status")()

    async def getLaneControl(self,lane:int):
        return await getattr(self.rfg, f"read_layer_{lane}_cfg_ctrl")()
    
    async def getLaneWrongLength(self, lane:int):
        return await getattr(self.rfg, f"read_layer_{lane}_stat_wronglength_counter")()

    async def zeroLaneWrongLength(self, lane:int, flush:bool =True):
        await getattr(self.rfg, f"write_layer_{lane}_stat_wronglength_counter")(0, flush=flush)

    
    async def assertLaneNotInReset(self,lane:int):
        ctrlReg = await self.getLaneControl(lane)
        if ((ctrlReg >> 1) & 0x1) == 1:
            raise Exception(f"Lane {lane} is in reset, user requests it is not")

    async def resetLaneStatCounters(self,lane:int,flush:bool = True):
        await getattr(self.rfg, f"write_layer_{lane}_stat_frame_counter")(0,False)
        await getattr(self.rfg, f"write_layer_{lane}_stat_idle_counter")(0,flush)

    async def getLaneMISOBytesCount(self,lane:int):
        """Returns the number of bytes in the Slave Out Bytes Buffer"""
        return await getattr(self.rfg, f"read_layer_{lane}_mosi_write_size")()


    ## Readout
    ################
    async def readoutGetBufferSize(self):
        """Returns the actual size of buffer"""
        return await self.rfg.read_layers_readout_read_size()
    
    async def readoutReadBytes(self,count : int):
        ## Using the _raw version returns an array of bytes, while the normal method converts to int based on the number of bytes
        return  await self.rfg.read_layers_readout_raw(count = count) if count > 0 else  []
    

    ## FPGA Timestamp config
    ############

    async def lanesConfigFPGATimestamp(self,enable:bool,force : bool,source_match_counter:bool,source_external:bool,flush:bool = False):
        """Configure the FPGA Timestamp to count from the internal match counter, the external TS input or force at each clock cycle"""
        assert not (source_match_counter is True and source_external is True) , "Don't configure FPGA TS to both count from internal match counter or the external clock"
        regVal = 0
        regVal |= 0x0 if enable is False else 0x1
        regVal |= 0x0 if source_match_counter is False else 0x2
        regVal |= 0x0 if source_external is False else 0x4
        regVal |= 0x0 if force is False else 0x8
        await self.rfg.write_layers_cfg_frame_tag_counter_ctrl(regVal,flush)

    async def lanesConfigFPGATimestampFrequency(self,targetFrequencyHz:int,flush:bool = False):
        """Configure the internal matching counter to trigger an FPGA Timestmap count with a certain frequency"""
        coreFrequency = self.getFPGACoreFrequency()
        divider = int( coreFrequency / (targetFrequencyHz))
        assert divider >=1 and divider < pow(2,32) , (f"Target Freq is too slow, Divider {divider} is too high, min. clock frequency: {int(coreFrequency/pow(2,32))}")
        await self.rfg.write_layers_cfg_frame_tag_counter_trigger_match(divider,flush)
