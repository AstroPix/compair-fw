


class Astropix3LBModel():


    def __init__(self,driver,lane):
        self.driver = driver
        self.lane = lane


    async def enableLoopback(self,flush=True):
        """Enable Loopback by setting bit in lane config register"""
        regval =  await getattr(self.driver.rfg, f"read_lane_{self.lane}_cfg_ctrl")()
        regval |= (1<<5)
        await getattr(self.driver.rfg, f"write_lane_{self.lane}_cfg_ctrl")(regval,flush)

    async def disableLoopback(self,flush=True):
        """Disable Loopback by clearing bit in lane config register"""
        regval =  await getattr(self.driver.rfg, f"read_lane_{self.lane}_cfg_ctrl")()
        regval &= ~(1<<5)
        await getattr(self.driver.rfg, f"write_lane_{self.lane}_cfg_ctrl")(regval,flush)


    async def writeMISOBytes(self,b:bytes,flush : bool =True):
        await getattr(self.driver.rfg, f"write_lane_{self.lane}_loopback_miso_bytes")(b,flush)
