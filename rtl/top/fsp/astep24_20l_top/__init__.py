

import logging
from rfg.core import AbstractRFG
from rfg.core import RFGRegister
logger = logging.getLogger(__name__)


def load_rfg():
    return main_rfg()


HK_FIRMWARE_ID = 0x0
HK_FIRMWARE_VERSION = 0x4
HK_XADC_TEMPERATURE = 0x8
HK_XADC_VCCINT = 0xa
HK_CONVERSION_TRIGGER = 0xc
HK_STAT_CONVERSIONS_COUNTER = 0x10
HK_CTRL = 0x14
HK_ADCDAC_MOSI_FIFO = 0x15
HK_ADC_MISO_FIFO = 0x16
HK_ADC_MISO_FIFO_READ_SIZE = 0x17
SPI_LANES_CKDIVIDER = 0x1b
SPI_HK_CKDIVIDER = 0x1c
LANE_0_CFG_CTRL = 0x1d
LANE_1_CFG_CTRL = 0x1e
LANE_2_CFG_CTRL = 0x1f
LANE_3_CFG_CTRL = 0x20
LANE_4_CFG_CTRL = 0x21
LANE_5_CFG_CTRL = 0x22
LANE_6_CFG_CTRL = 0x23
LANE_7_CFG_CTRL = 0x24
LANE_8_CFG_CTRL = 0x25
LANE_9_CFG_CTRL = 0x26
LANE_10_CFG_CTRL = 0x27
LANE_11_CFG_CTRL = 0x28
LANE_12_CFG_CTRL = 0x29
LANE_13_CFG_CTRL = 0x2a
LANE_14_CFG_CTRL = 0x2b
LANE_15_CFG_CTRL = 0x2c
LANE_16_CFG_CTRL = 0x2d
LANE_17_CFG_CTRL = 0x2e
LANE_18_CFG_CTRL = 0x2f
LANE_19_CFG_CTRL = 0x30
LANE_0_STATUS = 0x31
LANE_1_STATUS = 0x32
LANE_2_STATUS = 0x33
LANE_3_STATUS = 0x34
LANE_4_STATUS = 0x35
LANE_5_STATUS = 0x36
LANE_6_STATUS = 0x37
LANE_7_STATUS = 0x38
LANE_8_STATUS = 0x39
LANE_9_STATUS = 0x3a
LANE_10_STATUS = 0x3b
LANE_11_STATUS = 0x3c
LANE_12_STATUS = 0x3d
LANE_13_STATUS = 0x3e
LANE_14_STATUS = 0x3f
LANE_15_STATUS = 0x40
LANE_16_STATUS = 0x41
LANE_17_STATUS = 0x42
LANE_18_STATUS = 0x43
LANE_19_STATUS = 0x44
LANE_0_STAT_FRAME_COUNTER = 0x45
LANE_1_STAT_FRAME_COUNTER = 0x49
LANE_2_STAT_FRAME_COUNTER = 0x4d
LANE_3_STAT_FRAME_COUNTER = 0x51
LANE_4_STAT_FRAME_COUNTER = 0x55
LANE_5_STAT_FRAME_COUNTER = 0x59
LANE_6_STAT_FRAME_COUNTER = 0x5d
LANE_7_STAT_FRAME_COUNTER = 0x61
LANE_8_STAT_FRAME_COUNTER = 0x65
LANE_9_STAT_FRAME_COUNTER = 0x69
LANE_10_STAT_FRAME_COUNTER = 0x6d
LANE_11_STAT_FRAME_COUNTER = 0x71
LANE_12_STAT_FRAME_COUNTER = 0x75
LANE_13_STAT_FRAME_COUNTER = 0x79
LANE_14_STAT_FRAME_COUNTER = 0x7d
LANE_15_STAT_FRAME_COUNTER = 0x81
LANE_16_STAT_FRAME_COUNTER = 0x85
LANE_17_STAT_FRAME_COUNTER = 0x89
LANE_18_STAT_FRAME_COUNTER = 0x8d
LANE_19_STAT_FRAME_COUNTER = 0x91
LANE_0_STAT_IDLE_COUNTER = 0x95
LANE_1_STAT_IDLE_COUNTER = 0x99
LANE_2_STAT_IDLE_COUNTER = 0x9d
LANE_3_STAT_IDLE_COUNTER = 0xa1
LANE_4_STAT_IDLE_COUNTER = 0xa5
LANE_5_STAT_IDLE_COUNTER = 0xa9
LANE_6_STAT_IDLE_COUNTER = 0xad
LANE_7_STAT_IDLE_COUNTER = 0xb1
LANE_8_STAT_IDLE_COUNTER = 0xb5
LANE_9_STAT_IDLE_COUNTER = 0xb9
LANE_10_STAT_IDLE_COUNTER = 0xbd
LANE_11_STAT_IDLE_COUNTER = 0xc1
LANE_12_STAT_IDLE_COUNTER = 0xc5
LANE_13_STAT_IDLE_COUNTER = 0xc9
LANE_14_STAT_IDLE_COUNTER = 0xcd
LANE_15_STAT_IDLE_COUNTER = 0xd1
LANE_16_STAT_IDLE_COUNTER = 0xd5
LANE_17_STAT_IDLE_COUNTER = 0xd9
LANE_18_STAT_IDLE_COUNTER = 0xdd
LANE_19_STAT_IDLE_COUNTER = 0xe1
LANE_0_MOSI = 0xe5
LANE_0_MOSI_WRITE_SIZE = 0xe6
LANE_1_MOSI = 0xea
LANE_1_MOSI_WRITE_SIZE = 0xeb
LANE_2_MOSI = 0xef
LANE_2_MOSI_WRITE_SIZE = 0xf0
LANE_3_MOSI = 0xf4
LANE_3_MOSI_WRITE_SIZE = 0xf5
LANE_4_MOSI = 0xf9
LANE_4_MOSI_WRITE_SIZE = 0xfa
LANE_5_MOSI = 0xfe
LANE_5_MOSI_WRITE_SIZE = 0xff
LANE_6_MOSI = 0x103
LANE_6_MOSI_WRITE_SIZE = 0x104
LANE_7_MOSI = 0x108
LANE_7_MOSI_WRITE_SIZE = 0x109
LANE_8_MOSI = 0x10d
LANE_8_MOSI_WRITE_SIZE = 0x10e
LANE_9_MOSI = 0x112
LANE_9_MOSI_WRITE_SIZE = 0x113
LANE_10_MOSI = 0x117
LANE_10_MOSI_WRITE_SIZE = 0x118
LANE_11_MOSI = 0x11c
LANE_11_MOSI_WRITE_SIZE = 0x11d
LANE_12_MOSI = 0x121
LANE_12_MOSI_WRITE_SIZE = 0x122
LANE_13_MOSI = 0x126
LANE_13_MOSI_WRITE_SIZE = 0x127
LANE_14_MOSI = 0x12b
LANE_14_MOSI_WRITE_SIZE = 0x12c
LANE_15_MOSI = 0x130
LANE_15_MOSI_WRITE_SIZE = 0x131
LANE_16_MOSI = 0x135
LANE_16_MOSI_WRITE_SIZE = 0x136
LANE_17_MOSI = 0x13a
LANE_17_MOSI_WRITE_SIZE = 0x13b
LANE_18_MOSI = 0x13f
LANE_18_MOSI_WRITE_SIZE = 0x140
LANE_19_MOSI = 0x144
LANE_19_MOSI_WRITE_SIZE = 0x145
LANE_0_LOOPBACK_MISO = 0x149
LANE_0_LOOPBACK_MISO_WRITE_SIZE = 0x14a
LANE_1_LOOPBACK_MISO = 0x14e
LANE_1_LOOPBACK_MISO_WRITE_SIZE = 0x14f
LANE_2_LOOPBACK_MISO = 0x153
LANE_2_LOOPBACK_MISO_WRITE_SIZE = 0x154
LANE_3_LOOPBACK_MISO = 0x158
LANE_3_LOOPBACK_MISO_WRITE_SIZE = 0x159
LANE_4_LOOPBACK_MISO = 0x15d
LANE_4_LOOPBACK_MISO_WRITE_SIZE = 0x15e
LANE_5_LOOPBACK_MISO = 0x162
LANE_5_LOOPBACK_MISO_WRITE_SIZE = 0x163
LANE_6_LOOPBACK_MISO = 0x167
LANE_6_LOOPBACK_MISO_WRITE_SIZE = 0x168
LANE_7_LOOPBACK_MISO = 0x16c
LANE_7_LOOPBACK_MISO_WRITE_SIZE = 0x16d
LANE_8_LOOPBACK_MISO = 0x171
LANE_8_LOOPBACK_MISO_WRITE_SIZE = 0x172
LANE_9_LOOPBACK_MISO = 0x176
LANE_9_LOOPBACK_MISO_WRITE_SIZE = 0x177
LANE_10_LOOPBACK_MISO = 0x17b
LANE_10_LOOPBACK_MISO_WRITE_SIZE = 0x17c
LANE_11_LOOPBACK_MISO = 0x180
LANE_11_LOOPBACK_MISO_WRITE_SIZE = 0x181
LANE_12_LOOPBACK_MISO = 0x185
LANE_12_LOOPBACK_MISO_WRITE_SIZE = 0x186
LANE_13_LOOPBACK_MISO = 0x18a
LANE_13_LOOPBACK_MISO_WRITE_SIZE = 0x18b
LANE_14_LOOPBACK_MISO = 0x18f
LANE_14_LOOPBACK_MISO_WRITE_SIZE = 0x190
LANE_15_LOOPBACK_MISO = 0x194
LANE_15_LOOPBACK_MISO_WRITE_SIZE = 0x195
LANE_16_LOOPBACK_MISO = 0x199
LANE_16_LOOPBACK_MISO_WRITE_SIZE = 0x19a
LANE_17_LOOPBACK_MISO = 0x19e
LANE_17_LOOPBACK_MISO_WRITE_SIZE = 0x19f
LANE_18_LOOPBACK_MISO = 0x1a3
LANE_18_LOOPBACK_MISO_WRITE_SIZE = 0x1a4
LANE_19_LOOPBACK_MISO = 0x1a8
LANE_19_LOOPBACK_MISO_WRITE_SIZE = 0x1a9
LANE_0_LOOPBACK_MOSI = 0x1ad
LANE_0_LOOPBACK_MOSI_READ_SIZE = 0x1ae
LANE_1_LOOPBACK_MOSI = 0x1b2
LANE_1_LOOPBACK_MOSI_READ_SIZE = 0x1b3
LANE_2_LOOPBACK_MOSI = 0x1b7
LANE_2_LOOPBACK_MOSI_READ_SIZE = 0x1b8
LANE_3_LOOPBACK_MOSI = 0x1bc
LANE_3_LOOPBACK_MOSI_READ_SIZE = 0x1bd
LANE_4_LOOPBACK_MOSI = 0x1c1
LANE_4_LOOPBACK_MOSI_READ_SIZE = 0x1c2
LANE_5_LOOPBACK_MOSI = 0x1c6
LANE_5_LOOPBACK_MOSI_READ_SIZE = 0x1c7
LANE_6_LOOPBACK_MOSI = 0x1cb
LANE_6_LOOPBACK_MOSI_READ_SIZE = 0x1cc
LANE_7_LOOPBACK_MOSI = 0x1d0
LANE_7_LOOPBACK_MOSI_READ_SIZE = 0x1d1
LANE_8_LOOPBACK_MOSI = 0x1d5
LANE_8_LOOPBACK_MOSI_READ_SIZE = 0x1d6
LANE_9_LOOPBACK_MOSI = 0x1da
LANE_9_LOOPBACK_MOSI_READ_SIZE = 0x1db
LANE_10_LOOPBACK_MOSI = 0x1df
LANE_10_LOOPBACK_MOSI_READ_SIZE = 0x1e0
LANE_11_LOOPBACK_MOSI = 0x1e4
LANE_11_LOOPBACK_MOSI_READ_SIZE = 0x1e5
LANE_12_LOOPBACK_MOSI = 0x1e9
LANE_12_LOOPBACK_MOSI_READ_SIZE = 0x1ea
LANE_13_LOOPBACK_MOSI = 0x1ee
LANE_13_LOOPBACK_MOSI_READ_SIZE = 0x1ef
LANE_14_LOOPBACK_MOSI = 0x1f3
LANE_14_LOOPBACK_MOSI_READ_SIZE = 0x1f4
LANE_15_LOOPBACK_MOSI = 0x1f8
LANE_15_LOOPBACK_MOSI_READ_SIZE = 0x1f9
LANE_16_LOOPBACK_MOSI = 0x1fd
LANE_16_LOOPBACK_MOSI_READ_SIZE = 0x1fe
LANE_17_LOOPBACK_MOSI = 0x202
LANE_17_LOOPBACK_MOSI_READ_SIZE = 0x203
LANE_18_LOOPBACK_MOSI = 0x207
LANE_18_LOOPBACK_MOSI_READ_SIZE = 0x208
LANE_19_LOOPBACK_MOSI = 0x20c
LANE_19_LOOPBACK_MOSI_READ_SIZE = 0x20d
LANES_CFG_FRAME_TAG_COUNTER_CTRL = 0x211
LANES_CFG_FRAME_TAG_COUNTER_TRIGGER = 0x212
LANES_CFG_FRAME_TAG_COUNTER = 0x216
LANES_CFG_NODATA_CONTINUE = 0x21a
LANES_SR_OUT = 0x21b
LANES_SR_IN = 0x21c
LANES_INJ_CTRL = 0x21d
LANES_INJ_WADDR = 0x21e
LANES_INJ_WDATA = 0x21f
LANES_READOUT = 0x220
LANES_READOUT_READ_SIZE = 0x221
IO_CTRL = 0x225
IO_LED = 0x226
GECCO_SR_CTRL = 0x227
HK_CONVERSION_TRIGGER_MATCH = 0x228
LANES_CFG_FRAME_TAG_COUNTER_TRIGGER_MATCH = 0x22c




class main_rfg(AbstractRFG):
    """Register File Entry Point Class"""
    
    
    class Registers(RFGRegister):
        HK_FIRMWARE_ID = 0x0
        HK_FIRMWARE_VERSION = 0x4
        HK_XADC_TEMPERATURE = 0x8
        HK_XADC_VCCINT = 0xa
        HK_CONVERSION_TRIGGER = 0xc
        HK_STAT_CONVERSIONS_COUNTER = 0x10
        HK_CTRL = 0x14
        HK_ADCDAC_MOSI_FIFO = 0x15
        HK_ADC_MISO_FIFO = 0x16
        HK_ADC_MISO_FIFO_READ_SIZE = 0x17
        SPI_LANES_CKDIVIDER = 0x1b
        SPI_HK_CKDIVIDER = 0x1c
        LANE_0_CFG_CTRL = 0x1d
        LANE_1_CFG_CTRL = 0x1e
        LANE_2_CFG_CTRL = 0x1f
        LANE_3_CFG_CTRL = 0x20
        LANE_4_CFG_CTRL = 0x21
        LANE_5_CFG_CTRL = 0x22
        LANE_6_CFG_CTRL = 0x23
        LANE_7_CFG_CTRL = 0x24
        LANE_8_CFG_CTRL = 0x25
        LANE_9_CFG_CTRL = 0x26
        LANE_10_CFG_CTRL = 0x27
        LANE_11_CFG_CTRL = 0x28
        LANE_12_CFG_CTRL = 0x29
        LANE_13_CFG_CTRL = 0x2a
        LANE_14_CFG_CTRL = 0x2b
        LANE_15_CFG_CTRL = 0x2c
        LANE_16_CFG_CTRL = 0x2d
        LANE_17_CFG_CTRL = 0x2e
        LANE_18_CFG_CTRL = 0x2f
        LANE_19_CFG_CTRL = 0x30
        LANE_0_STATUS = 0x31
        LANE_1_STATUS = 0x32
        LANE_2_STATUS = 0x33
        LANE_3_STATUS = 0x34
        LANE_4_STATUS = 0x35
        LANE_5_STATUS = 0x36
        LANE_6_STATUS = 0x37
        LANE_7_STATUS = 0x38
        LANE_8_STATUS = 0x39
        LANE_9_STATUS = 0x3a
        LANE_10_STATUS = 0x3b
        LANE_11_STATUS = 0x3c
        LANE_12_STATUS = 0x3d
        LANE_13_STATUS = 0x3e
        LANE_14_STATUS = 0x3f
        LANE_15_STATUS = 0x40
        LANE_16_STATUS = 0x41
        LANE_17_STATUS = 0x42
        LANE_18_STATUS = 0x43
        LANE_19_STATUS = 0x44
        LANE_0_STAT_FRAME_COUNTER = 0x45
        LANE_1_STAT_FRAME_COUNTER = 0x49
        LANE_2_STAT_FRAME_COUNTER = 0x4d
        LANE_3_STAT_FRAME_COUNTER = 0x51
        LANE_4_STAT_FRAME_COUNTER = 0x55
        LANE_5_STAT_FRAME_COUNTER = 0x59
        LANE_6_STAT_FRAME_COUNTER = 0x5d
        LANE_7_STAT_FRAME_COUNTER = 0x61
        LANE_8_STAT_FRAME_COUNTER = 0x65
        LANE_9_STAT_FRAME_COUNTER = 0x69
        LANE_10_STAT_FRAME_COUNTER = 0x6d
        LANE_11_STAT_FRAME_COUNTER = 0x71
        LANE_12_STAT_FRAME_COUNTER = 0x75
        LANE_13_STAT_FRAME_COUNTER = 0x79
        LANE_14_STAT_FRAME_COUNTER = 0x7d
        LANE_15_STAT_FRAME_COUNTER = 0x81
        LANE_16_STAT_FRAME_COUNTER = 0x85
        LANE_17_STAT_FRAME_COUNTER = 0x89
        LANE_18_STAT_FRAME_COUNTER = 0x8d
        LANE_19_STAT_FRAME_COUNTER = 0x91
        LANE_0_STAT_IDLE_COUNTER = 0x95
        LANE_1_STAT_IDLE_COUNTER = 0x99
        LANE_2_STAT_IDLE_COUNTER = 0x9d
        LANE_3_STAT_IDLE_COUNTER = 0xa1
        LANE_4_STAT_IDLE_COUNTER = 0xa5
        LANE_5_STAT_IDLE_COUNTER = 0xa9
        LANE_6_STAT_IDLE_COUNTER = 0xad
        LANE_7_STAT_IDLE_COUNTER = 0xb1
        LANE_8_STAT_IDLE_COUNTER = 0xb5
        LANE_9_STAT_IDLE_COUNTER = 0xb9
        LANE_10_STAT_IDLE_COUNTER = 0xbd
        LANE_11_STAT_IDLE_COUNTER = 0xc1
        LANE_12_STAT_IDLE_COUNTER = 0xc5
        LANE_13_STAT_IDLE_COUNTER = 0xc9
        LANE_14_STAT_IDLE_COUNTER = 0xcd
        LANE_15_STAT_IDLE_COUNTER = 0xd1
        LANE_16_STAT_IDLE_COUNTER = 0xd5
        LANE_17_STAT_IDLE_COUNTER = 0xd9
        LANE_18_STAT_IDLE_COUNTER = 0xdd
        LANE_19_STAT_IDLE_COUNTER = 0xe1
        LANE_0_MOSI = 0xe5
        LANE_0_MOSI_WRITE_SIZE = 0xe6
        LANE_1_MOSI = 0xea
        LANE_1_MOSI_WRITE_SIZE = 0xeb
        LANE_2_MOSI = 0xef
        LANE_2_MOSI_WRITE_SIZE = 0xf0
        LANE_3_MOSI = 0xf4
        LANE_3_MOSI_WRITE_SIZE = 0xf5
        LANE_4_MOSI = 0xf9
        LANE_4_MOSI_WRITE_SIZE = 0xfa
        LANE_5_MOSI = 0xfe
        LANE_5_MOSI_WRITE_SIZE = 0xff
        LANE_6_MOSI = 0x103
        LANE_6_MOSI_WRITE_SIZE = 0x104
        LANE_7_MOSI = 0x108
        LANE_7_MOSI_WRITE_SIZE = 0x109
        LANE_8_MOSI = 0x10d
        LANE_8_MOSI_WRITE_SIZE = 0x10e
        LANE_9_MOSI = 0x112
        LANE_9_MOSI_WRITE_SIZE = 0x113
        LANE_10_MOSI = 0x117
        LANE_10_MOSI_WRITE_SIZE = 0x118
        LANE_11_MOSI = 0x11c
        LANE_11_MOSI_WRITE_SIZE = 0x11d
        LANE_12_MOSI = 0x121
        LANE_12_MOSI_WRITE_SIZE = 0x122
        LANE_13_MOSI = 0x126
        LANE_13_MOSI_WRITE_SIZE = 0x127
        LANE_14_MOSI = 0x12b
        LANE_14_MOSI_WRITE_SIZE = 0x12c
        LANE_15_MOSI = 0x130
        LANE_15_MOSI_WRITE_SIZE = 0x131
        LANE_16_MOSI = 0x135
        LANE_16_MOSI_WRITE_SIZE = 0x136
        LANE_17_MOSI = 0x13a
        LANE_17_MOSI_WRITE_SIZE = 0x13b
        LANE_18_MOSI = 0x13f
        LANE_18_MOSI_WRITE_SIZE = 0x140
        LANE_19_MOSI = 0x144
        LANE_19_MOSI_WRITE_SIZE = 0x145
        LANE_0_LOOPBACK_MISO = 0x149
        LANE_0_LOOPBACK_MISO_WRITE_SIZE = 0x14a
        LANE_1_LOOPBACK_MISO = 0x14e
        LANE_1_LOOPBACK_MISO_WRITE_SIZE = 0x14f
        LANE_2_LOOPBACK_MISO = 0x153
        LANE_2_LOOPBACK_MISO_WRITE_SIZE = 0x154
        LANE_3_LOOPBACK_MISO = 0x158
        LANE_3_LOOPBACK_MISO_WRITE_SIZE = 0x159
        LANE_4_LOOPBACK_MISO = 0x15d
        LANE_4_LOOPBACK_MISO_WRITE_SIZE = 0x15e
        LANE_5_LOOPBACK_MISO = 0x162
        LANE_5_LOOPBACK_MISO_WRITE_SIZE = 0x163
        LANE_6_LOOPBACK_MISO = 0x167
        LANE_6_LOOPBACK_MISO_WRITE_SIZE = 0x168
        LANE_7_LOOPBACK_MISO = 0x16c
        LANE_7_LOOPBACK_MISO_WRITE_SIZE = 0x16d
        LANE_8_LOOPBACK_MISO = 0x171
        LANE_8_LOOPBACK_MISO_WRITE_SIZE = 0x172
        LANE_9_LOOPBACK_MISO = 0x176
        LANE_9_LOOPBACK_MISO_WRITE_SIZE = 0x177
        LANE_10_LOOPBACK_MISO = 0x17b
        LANE_10_LOOPBACK_MISO_WRITE_SIZE = 0x17c
        LANE_11_LOOPBACK_MISO = 0x180
        LANE_11_LOOPBACK_MISO_WRITE_SIZE = 0x181
        LANE_12_LOOPBACK_MISO = 0x185
        LANE_12_LOOPBACK_MISO_WRITE_SIZE = 0x186
        LANE_13_LOOPBACK_MISO = 0x18a
        LANE_13_LOOPBACK_MISO_WRITE_SIZE = 0x18b
        LANE_14_LOOPBACK_MISO = 0x18f
        LANE_14_LOOPBACK_MISO_WRITE_SIZE = 0x190
        LANE_15_LOOPBACK_MISO = 0x194
        LANE_15_LOOPBACK_MISO_WRITE_SIZE = 0x195
        LANE_16_LOOPBACK_MISO = 0x199
        LANE_16_LOOPBACK_MISO_WRITE_SIZE = 0x19a
        LANE_17_LOOPBACK_MISO = 0x19e
        LANE_17_LOOPBACK_MISO_WRITE_SIZE = 0x19f
        LANE_18_LOOPBACK_MISO = 0x1a3
        LANE_18_LOOPBACK_MISO_WRITE_SIZE = 0x1a4
        LANE_19_LOOPBACK_MISO = 0x1a8
        LANE_19_LOOPBACK_MISO_WRITE_SIZE = 0x1a9
        LANE_0_LOOPBACK_MOSI = 0x1ad
        LANE_0_LOOPBACK_MOSI_READ_SIZE = 0x1ae
        LANE_1_LOOPBACK_MOSI = 0x1b2
        LANE_1_LOOPBACK_MOSI_READ_SIZE = 0x1b3
        LANE_2_LOOPBACK_MOSI = 0x1b7
        LANE_2_LOOPBACK_MOSI_READ_SIZE = 0x1b8
        LANE_3_LOOPBACK_MOSI = 0x1bc
        LANE_3_LOOPBACK_MOSI_READ_SIZE = 0x1bd
        LANE_4_LOOPBACK_MOSI = 0x1c1
        LANE_4_LOOPBACK_MOSI_READ_SIZE = 0x1c2
        LANE_5_LOOPBACK_MOSI = 0x1c6
        LANE_5_LOOPBACK_MOSI_READ_SIZE = 0x1c7
        LANE_6_LOOPBACK_MOSI = 0x1cb
        LANE_6_LOOPBACK_MOSI_READ_SIZE = 0x1cc
        LANE_7_LOOPBACK_MOSI = 0x1d0
        LANE_7_LOOPBACK_MOSI_READ_SIZE = 0x1d1
        LANE_8_LOOPBACK_MOSI = 0x1d5
        LANE_8_LOOPBACK_MOSI_READ_SIZE = 0x1d6
        LANE_9_LOOPBACK_MOSI = 0x1da
        LANE_9_LOOPBACK_MOSI_READ_SIZE = 0x1db
        LANE_10_LOOPBACK_MOSI = 0x1df
        LANE_10_LOOPBACK_MOSI_READ_SIZE = 0x1e0
        LANE_11_LOOPBACK_MOSI = 0x1e4
        LANE_11_LOOPBACK_MOSI_READ_SIZE = 0x1e5
        LANE_12_LOOPBACK_MOSI = 0x1e9
        LANE_12_LOOPBACK_MOSI_READ_SIZE = 0x1ea
        LANE_13_LOOPBACK_MOSI = 0x1ee
        LANE_13_LOOPBACK_MOSI_READ_SIZE = 0x1ef
        LANE_14_LOOPBACK_MOSI = 0x1f3
        LANE_14_LOOPBACK_MOSI_READ_SIZE = 0x1f4
        LANE_15_LOOPBACK_MOSI = 0x1f8
        LANE_15_LOOPBACK_MOSI_READ_SIZE = 0x1f9
        LANE_16_LOOPBACK_MOSI = 0x1fd
        LANE_16_LOOPBACK_MOSI_READ_SIZE = 0x1fe
        LANE_17_LOOPBACK_MOSI = 0x202
        LANE_17_LOOPBACK_MOSI_READ_SIZE = 0x203
        LANE_18_LOOPBACK_MOSI = 0x207
        LANE_18_LOOPBACK_MOSI_READ_SIZE = 0x208
        LANE_19_LOOPBACK_MOSI = 0x20c
        LANE_19_LOOPBACK_MOSI_READ_SIZE = 0x20d
        LANES_CFG_FRAME_TAG_COUNTER_CTRL = 0x211
        LANES_CFG_FRAME_TAG_COUNTER_TRIGGER = 0x212
        LANES_CFG_FRAME_TAG_COUNTER = 0x216
        LANES_CFG_NODATA_CONTINUE = 0x21a
        LANES_SR_OUT = 0x21b
        LANES_SR_IN = 0x21c
        LANES_INJ_CTRL = 0x21d
        LANES_INJ_WADDR = 0x21e
        LANES_INJ_WDATA = 0x21f
        LANES_READOUT = 0x220
        LANES_READOUT_READ_SIZE = 0x221
        IO_CTRL = 0x225
        IO_LED = 0x226
        GECCO_SR_CTRL = 0x227
        HK_CONVERSION_TRIGGER_MATCH = 0x228
        LANES_CFG_FRAME_TAG_COUNTER_TRIGGER_MATCH = 0x22c
    
    
    
    def __init__(self):
        super().__init__()
    
    
    def hello(self):
        logger.info("Hello World")
    
    
    
    async def read_hk_firmware_id(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['HK_FIRMWARE_ID'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_hk_firmware_id_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['HK_FIRMWARE_ID'],count = count, increment = True)
        
    
    
    
    async def read_hk_firmware_version(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['HK_FIRMWARE_VERSION'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_hk_firmware_version_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['HK_FIRMWARE_VERSION'],count = count, increment = True)
        
    
    
    
    async def read_hk_xadc_temperature(self, count : int = 2 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['HK_XADC_TEMPERATURE'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_hk_xadc_temperature_raw(self, count : int = 2 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['HK_XADC_TEMPERATURE'],count = count, increment = True)
        
    
    
    
    async def read_hk_xadc_vccint(self, count : int = 2 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['HK_XADC_VCCINT'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_hk_xadc_vccint_raw(self, count : int = 2 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['HK_XADC_VCCINT'],count = count, increment = True)
        
    
    
    
    async def write_hk_conversion_trigger(self,value : int,flush = False):
        self.addWrite(register = self.Registers['HK_CONVERSION_TRIGGER'],value = value,increment = True,valueLength=4)
        if flush == True:
            await self.flush()
        
    
    async def read_hk_conversion_trigger(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['HK_CONVERSION_TRIGGER'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_hk_conversion_trigger_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['HK_CONVERSION_TRIGGER'],count = count, increment = True)
        
    
    
    
    async def read_hk_stat_conversions_counter(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['HK_STAT_CONVERSIONS_COUNTER'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_hk_stat_conversions_counter_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['HK_STAT_CONVERSIONS_COUNTER'],count = count, increment = True)
        
    
    
    
    async def write_hk_ctrl(self,value : int,flush = False):
        self.addWrite(register = self.Registers['HK_CTRL'],value = value,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    async def read_hk_ctrl(self, count : int = 1 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['HK_CTRL'],count = count, increment = False , targetQueue = targetQueue), 'little') 
        
    
    async def read_hk_ctrl_raw(self, count : int = 1 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['HK_CTRL'],count = count, increment = False)
        
    
    
    
    async def write_hk_adcdac_mosi_fifo(self,value : int,flush = False):
        self.addWrite(register = self.Registers['HK_ADCDAC_MOSI_FIFO'],value = value,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    async def write_hk_adcdac_mosi_fifo_bytes(self,values : bytearray,flush = False):
        for b in values:
            self.addWrite(register = self.Registers['HK_ADCDAC_MOSI_FIFO'],value = b,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    
    
    async def read_hk_adc_miso_fifo(self, count : int = 1 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['HK_ADC_MISO_FIFO'],count = count, increment = False , targetQueue = targetQueue), 'little') 
        
    
    async def read_hk_adc_miso_fifo_raw(self, count : int = 1 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['HK_ADC_MISO_FIFO'],count = count, increment = False)
        
    
    
    
    async def read_hk_adc_miso_fifo_read_size(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['HK_ADC_MISO_FIFO_READ_SIZE'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_hk_adc_miso_fifo_read_size_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['HK_ADC_MISO_FIFO_READ_SIZE'],count = count, increment = True)
        
    
    
    
    async def write_spi_lanes_ckdivider(self,value : int,flush = False):
        self.addWrite(register = self.Registers['SPI_LANES_CKDIVIDER'],value = value,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    async def read_spi_lanes_ckdivider(self, count : int = 1 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['SPI_LANES_CKDIVIDER'],count = count, increment = False , targetQueue = targetQueue), 'little') 
        
    
    async def read_spi_lanes_ckdivider_raw(self, count : int = 1 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['SPI_LANES_CKDIVIDER'],count = count, increment = False)
        
    
    
    
    async def write_spi_hk_ckdivider(self,value : int,flush = False):
        self.addWrite(register = self.Registers['SPI_HK_CKDIVIDER'],value = value,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    async def read_spi_hk_ckdivider(self, count : int = 1 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['SPI_HK_CKDIVIDER'],count = count, increment = False , targetQueue = targetQueue), 'little') 
        
    
    async def read_spi_hk_ckdivider_raw(self, count : int = 1 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['SPI_HK_CKDIVIDER'],count = count, increment = False)
        
    
    
    
    async def write_lane_0_cfg_ctrl(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LANE_0_CFG_CTRL'],value = value,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    async def read_lane_0_cfg_ctrl(self, count : int = 1 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LANE_0_CFG_CTRL'],count = count, increment = False , targetQueue = targetQueue), 'little') 
        
    
    async def read_lane_0_cfg_ctrl_raw(self, count : int = 1 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LANE_0_CFG_CTRL'],count = count, increment = False)
        
    
    
    
    async def write_lane_1_cfg_ctrl(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LANE_1_CFG_CTRL'],value = value,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    async def read_lane_1_cfg_ctrl(self, count : int = 1 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LANE_1_CFG_CTRL'],count = count, increment = False , targetQueue = targetQueue), 'little') 
        
    
    async def read_lane_1_cfg_ctrl_raw(self, count : int = 1 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LANE_1_CFG_CTRL'],count = count, increment = False)
        
    
    
    
    async def write_lane_2_cfg_ctrl(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LANE_2_CFG_CTRL'],value = value,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    async def read_lane_2_cfg_ctrl(self, count : int = 1 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LANE_2_CFG_CTRL'],count = count, increment = False , targetQueue = targetQueue), 'little') 
        
    
    async def read_lane_2_cfg_ctrl_raw(self, count : int = 1 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LANE_2_CFG_CTRL'],count = count, increment = False)
        
    
    
    
    async def write_lane_3_cfg_ctrl(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LANE_3_CFG_CTRL'],value = value,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    async def read_lane_3_cfg_ctrl(self, count : int = 1 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LANE_3_CFG_CTRL'],count = count, increment = False , targetQueue = targetQueue), 'little') 
        
    
    async def read_lane_3_cfg_ctrl_raw(self, count : int = 1 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LANE_3_CFG_CTRL'],count = count, increment = False)
        
    
    
    
    async def write_lane_4_cfg_ctrl(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LANE_4_CFG_CTRL'],value = value,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    async def read_lane_4_cfg_ctrl(self, count : int = 1 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LANE_4_CFG_CTRL'],count = count, increment = False , targetQueue = targetQueue), 'little') 
        
    
    async def read_lane_4_cfg_ctrl_raw(self, count : int = 1 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LANE_4_CFG_CTRL'],count = count, increment = False)
        
    
    
    
    async def write_lane_5_cfg_ctrl(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LANE_5_CFG_CTRL'],value = value,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    async def read_lane_5_cfg_ctrl(self, count : int = 1 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LANE_5_CFG_CTRL'],count = count, increment = False , targetQueue = targetQueue), 'little') 
        
    
    async def read_lane_5_cfg_ctrl_raw(self, count : int = 1 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LANE_5_CFG_CTRL'],count = count, increment = False)
        
    
    
    
    async def write_lane_6_cfg_ctrl(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LANE_6_CFG_CTRL'],value = value,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    async def read_lane_6_cfg_ctrl(self, count : int = 1 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LANE_6_CFG_CTRL'],count = count, increment = False , targetQueue = targetQueue), 'little') 
        
    
    async def read_lane_6_cfg_ctrl_raw(self, count : int = 1 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LANE_6_CFG_CTRL'],count = count, increment = False)
        
    
    
    
    async def write_lane_7_cfg_ctrl(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LANE_7_CFG_CTRL'],value = value,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    async def read_lane_7_cfg_ctrl(self, count : int = 1 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LANE_7_CFG_CTRL'],count = count, increment = False , targetQueue = targetQueue), 'little') 
        
    
    async def read_lane_7_cfg_ctrl_raw(self, count : int = 1 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LANE_7_CFG_CTRL'],count = count, increment = False)
        
    
    
    
    async def write_lane_8_cfg_ctrl(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LANE_8_CFG_CTRL'],value = value,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    async def read_lane_8_cfg_ctrl(self, count : int = 1 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LANE_8_CFG_CTRL'],count = count, increment = False , targetQueue = targetQueue), 'little') 
        
    
    async def read_lane_8_cfg_ctrl_raw(self, count : int = 1 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LANE_8_CFG_CTRL'],count = count, increment = False)
        
    
    
    
    async def write_lane_9_cfg_ctrl(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LANE_9_CFG_CTRL'],value = value,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    async def read_lane_9_cfg_ctrl(self, count : int = 1 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LANE_9_CFG_CTRL'],count = count, increment = False , targetQueue = targetQueue), 'little') 
        
    
    async def read_lane_9_cfg_ctrl_raw(self, count : int = 1 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LANE_9_CFG_CTRL'],count = count, increment = False)
        
    
    
    
    async def write_lane_10_cfg_ctrl(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LANE_10_CFG_CTRL'],value = value,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    async def read_lane_10_cfg_ctrl(self, count : int = 1 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LANE_10_CFG_CTRL'],count = count, increment = False , targetQueue = targetQueue), 'little') 
        
    
    async def read_lane_10_cfg_ctrl_raw(self, count : int = 1 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LANE_10_CFG_CTRL'],count = count, increment = False)
        
    
    
    
    async def write_lane_11_cfg_ctrl(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LANE_11_CFG_CTRL'],value = value,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    async def read_lane_11_cfg_ctrl(self, count : int = 1 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LANE_11_CFG_CTRL'],count = count, increment = False , targetQueue = targetQueue), 'little') 
        
    
    async def read_lane_11_cfg_ctrl_raw(self, count : int = 1 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LANE_11_CFG_CTRL'],count = count, increment = False)
        
    
    
    
    async def write_lane_12_cfg_ctrl(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LANE_12_CFG_CTRL'],value = value,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    async def read_lane_12_cfg_ctrl(self, count : int = 1 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LANE_12_CFG_CTRL'],count = count, increment = False , targetQueue = targetQueue), 'little') 
        
    
    async def read_lane_12_cfg_ctrl_raw(self, count : int = 1 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LANE_12_CFG_CTRL'],count = count, increment = False)
        
    
    
    
    async def write_lane_13_cfg_ctrl(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LANE_13_CFG_CTRL'],value = value,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    async def read_lane_13_cfg_ctrl(self, count : int = 1 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LANE_13_CFG_CTRL'],count = count, increment = False , targetQueue = targetQueue), 'little') 
        
    
    async def read_lane_13_cfg_ctrl_raw(self, count : int = 1 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LANE_13_CFG_CTRL'],count = count, increment = False)
        
    
    
    
    async def write_lane_14_cfg_ctrl(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LANE_14_CFG_CTRL'],value = value,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    async def read_lane_14_cfg_ctrl(self, count : int = 1 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LANE_14_CFG_CTRL'],count = count, increment = False , targetQueue = targetQueue), 'little') 
        
    
    async def read_lane_14_cfg_ctrl_raw(self, count : int = 1 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LANE_14_CFG_CTRL'],count = count, increment = False)
        
    
    
    
    async def write_lane_15_cfg_ctrl(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LANE_15_CFG_CTRL'],value = value,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    async def read_lane_15_cfg_ctrl(self, count : int = 1 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LANE_15_CFG_CTRL'],count = count, increment = False , targetQueue = targetQueue), 'little') 
        
    
    async def read_lane_15_cfg_ctrl_raw(self, count : int = 1 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LANE_15_CFG_CTRL'],count = count, increment = False)
        
    
    
    
    async def write_lane_16_cfg_ctrl(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LANE_16_CFG_CTRL'],value = value,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    async def read_lane_16_cfg_ctrl(self, count : int = 1 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LANE_16_CFG_CTRL'],count = count, increment = False , targetQueue = targetQueue), 'little') 
        
    
    async def read_lane_16_cfg_ctrl_raw(self, count : int = 1 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LANE_16_CFG_CTRL'],count = count, increment = False)
        
    
    
    
    async def write_lane_17_cfg_ctrl(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LANE_17_CFG_CTRL'],value = value,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    async def read_lane_17_cfg_ctrl(self, count : int = 1 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LANE_17_CFG_CTRL'],count = count, increment = False , targetQueue = targetQueue), 'little') 
        
    
    async def read_lane_17_cfg_ctrl_raw(self, count : int = 1 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LANE_17_CFG_CTRL'],count = count, increment = False)
        
    
    
    
    async def write_lane_18_cfg_ctrl(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LANE_18_CFG_CTRL'],value = value,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    async def read_lane_18_cfg_ctrl(self, count : int = 1 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LANE_18_CFG_CTRL'],count = count, increment = False , targetQueue = targetQueue), 'little') 
        
    
    async def read_lane_18_cfg_ctrl_raw(self, count : int = 1 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LANE_18_CFG_CTRL'],count = count, increment = False)
        
    
    
    
    async def write_lane_19_cfg_ctrl(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LANE_19_CFG_CTRL'],value = value,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    async def read_lane_19_cfg_ctrl(self, count : int = 1 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LANE_19_CFG_CTRL'],count = count, increment = False , targetQueue = targetQueue), 'little') 
        
    
    async def read_lane_19_cfg_ctrl_raw(self, count : int = 1 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LANE_19_CFG_CTRL'],count = count, increment = False)
        
    
    
    
    async def read_lane_0_status(self, count : int = 1 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LANE_0_STATUS'],count = count, increment = False , targetQueue = targetQueue), 'little') 
        
    
    async def read_lane_0_status_raw(self, count : int = 1 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LANE_0_STATUS'],count = count, increment = False)
        
    
    
    
    async def read_lane_1_status(self, count : int = 1 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LANE_1_STATUS'],count = count, increment = False , targetQueue = targetQueue), 'little') 
        
    
    async def read_lane_1_status_raw(self, count : int = 1 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LANE_1_STATUS'],count = count, increment = False)
        
    
    
    
    async def read_lane_2_status(self, count : int = 1 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LANE_2_STATUS'],count = count, increment = False , targetQueue = targetQueue), 'little') 
        
    
    async def read_lane_2_status_raw(self, count : int = 1 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LANE_2_STATUS'],count = count, increment = False)
        
    
    
    
    async def read_lane_3_status(self, count : int = 1 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LANE_3_STATUS'],count = count, increment = False , targetQueue = targetQueue), 'little') 
        
    
    async def read_lane_3_status_raw(self, count : int = 1 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LANE_3_STATUS'],count = count, increment = False)
        
    
    
    
    async def read_lane_4_status(self, count : int = 1 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LANE_4_STATUS'],count = count, increment = False , targetQueue = targetQueue), 'little') 
        
    
    async def read_lane_4_status_raw(self, count : int = 1 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LANE_4_STATUS'],count = count, increment = False)
        
    
    
    
    async def read_lane_5_status(self, count : int = 1 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LANE_5_STATUS'],count = count, increment = False , targetQueue = targetQueue), 'little') 
        
    
    async def read_lane_5_status_raw(self, count : int = 1 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LANE_5_STATUS'],count = count, increment = False)
        
    
    
    
    async def read_lane_6_status(self, count : int = 1 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LANE_6_STATUS'],count = count, increment = False , targetQueue = targetQueue), 'little') 
        
    
    async def read_lane_6_status_raw(self, count : int = 1 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LANE_6_STATUS'],count = count, increment = False)
        
    
    
    
    async def read_lane_7_status(self, count : int = 1 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LANE_7_STATUS'],count = count, increment = False , targetQueue = targetQueue), 'little') 
        
    
    async def read_lane_7_status_raw(self, count : int = 1 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LANE_7_STATUS'],count = count, increment = False)
        
    
    
    
    async def read_lane_8_status(self, count : int = 1 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LANE_8_STATUS'],count = count, increment = False , targetQueue = targetQueue), 'little') 
        
    
    async def read_lane_8_status_raw(self, count : int = 1 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LANE_8_STATUS'],count = count, increment = False)
        
    
    
    
    async def read_lane_9_status(self, count : int = 1 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LANE_9_STATUS'],count = count, increment = False , targetQueue = targetQueue), 'little') 
        
    
    async def read_lane_9_status_raw(self, count : int = 1 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LANE_9_STATUS'],count = count, increment = False)
        
    
    
    
    async def read_lane_10_status(self, count : int = 1 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LANE_10_STATUS'],count = count, increment = False , targetQueue = targetQueue), 'little') 
        
    
    async def read_lane_10_status_raw(self, count : int = 1 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LANE_10_STATUS'],count = count, increment = False)
        
    
    
    
    async def read_lane_11_status(self, count : int = 1 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LANE_11_STATUS'],count = count, increment = False , targetQueue = targetQueue), 'little') 
        
    
    async def read_lane_11_status_raw(self, count : int = 1 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LANE_11_STATUS'],count = count, increment = False)
        
    
    
    
    async def read_lane_12_status(self, count : int = 1 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LANE_12_STATUS'],count = count, increment = False , targetQueue = targetQueue), 'little') 
        
    
    async def read_lane_12_status_raw(self, count : int = 1 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LANE_12_STATUS'],count = count, increment = False)
        
    
    
    
    async def read_lane_13_status(self, count : int = 1 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LANE_13_STATUS'],count = count, increment = False , targetQueue = targetQueue), 'little') 
        
    
    async def read_lane_13_status_raw(self, count : int = 1 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LANE_13_STATUS'],count = count, increment = False)
        
    
    
    
    async def read_lane_14_status(self, count : int = 1 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LANE_14_STATUS'],count = count, increment = False , targetQueue = targetQueue), 'little') 
        
    
    async def read_lane_14_status_raw(self, count : int = 1 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LANE_14_STATUS'],count = count, increment = False)
        
    
    
    
    async def read_lane_15_status(self, count : int = 1 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LANE_15_STATUS'],count = count, increment = False , targetQueue = targetQueue), 'little') 
        
    
    async def read_lane_15_status_raw(self, count : int = 1 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LANE_15_STATUS'],count = count, increment = False)
        
    
    
    
    async def read_lane_16_status(self, count : int = 1 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LANE_16_STATUS'],count = count, increment = False , targetQueue = targetQueue), 'little') 
        
    
    async def read_lane_16_status_raw(self, count : int = 1 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LANE_16_STATUS'],count = count, increment = False)
        
    
    
    
    async def read_lane_17_status(self, count : int = 1 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LANE_17_STATUS'],count = count, increment = False , targetQueue = targetQueue), 'little') 
        
    
    async def read_lane_17_status_raw(self, count : int = 1 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LANE_17_STATUS'],count = count, increment = False)
        
    
    
    
    async def read_lane_18_status(self, count : int = 1 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LANE_18_STATUS'],count = count, increment = False , targetQueue = targetQueue), 'little') 
        
    
    async def read_lane_18_status_raw(self, count : int = 1 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LANE_18_STATUS'],count = count, increment = False)
        
    
    
    
    async def read_lane_19_status(self, count : int = 1 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LANE_19_STATUS'],count = count, increment = False , targetQueue = targetQueue), 'little') 
        
    
    async def read_lane_19_status_raw(self, count : int = 1 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LANE_19_STATUS'],count = count, increment = False)
        
    
    
    
    async def write_lane_0_stat_frame_counter(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LANE_0_STAT_FRAME_COUNTER'],value = value,increment = True,valueLength=4)
        if flush == True:
            await self.flush()
        
    
    async def read_lane_0_stat_frame_counter(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LANE_0_STAT_FRAME_COUNTER'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_lane_0_stat_frame_counter_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LANE_0_STAT_FRAME_COUNTER'],count = count, increment = True)
        
    
    
    
    async def write_lane_1_stat_frame_counter(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LANE_1_STAT_FRAME_COUNTER'],value = value,increment = True,valueLength=4)
        if flush == True:
            await self.flush()
        
    
    async def read_lane_1_stat_frame_counter(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LANE_1_STAT_FRAME_COUNTER'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_lane_1_stat_frame_counter_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LANE_1_STAT_FRAME_COUNTER'],count = count, increment = True)
        
    
    
    
    async def write_lane_2_stat_frame_counter(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LANE_2_STAT_FRAME_COUNTER'],value = value,increment = True,valueLength=4)
        if flush == True:
            await self.flush()
        
    
    async def read_lane_2_stat_frame_counter(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LANE_2_STAT_FRAME_COUNTER'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_lane_2_stat_frame_counter_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LANE_2_STAT_FRAME_COUNTER'],count = count, increment = True)
        
    
    
    
    async def write_lane_3_stat_frame_counter(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LANE_3_STAT_FRAME_COUNTER'],value = value,increment = True,valueLength=4)
        if flush == True:
            await self.flush()
        
    
    async def read_lane_3_stat_frame_counter(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LANE_3_STAT_FRAME_COUNTER'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_lane_3_stat_frame_counter_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LANE_3_STAT_FRAME_COUNTER'],count = count, increment = True)
        
    
    
    
    async def write_lane_4_stat_frame_counter(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LANE_4_STAT_FRAME_COUNTER'],value = value,increment = True,valueLength=4)
        if flush == True:
            await self.flush()
        
    
    async def read_lane_4_stat_frame_counter(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LANE_4_STAT_FRAME_COUNTER'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_lane_4_stat_frame_counter_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LANE_4_STAT_FRAME_COUNTER'],count = count, increment = True)
        
    
    
    
    async def write_lane_5_stat_frame_counter(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LANE_5_STAT_FRAME_COUNTER'],value = value,increment = True,valueLength=4)
        if flush == True:
            await self.flush()
        
    
    async def read_lane_5_stat_frame_counter(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LANE_5_STAT_FRAME_COUNTER'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_lane_5_stat_frame_counter_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LANE_5_STAT_FRAME_COUNTER'],count = count, increment = True)
        
    
    
    
    async def write_lane_6_stat_frame_counter(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LANE_6_STAT_FRAME_COUNTER'],value = value,increment = True,valueLength=4)
        if flush == True:
            await self.flush()
        
    
    async def read_lane_6_stat_frame_counter(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LANE_6_STAT_FRAME_COUNTER'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_lane_6_stat_frame_counter_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LANE_6_STAT_FRAME_COUNTER'],count = count, increment = True)
        
    
    
    
    async def write_lane_7_stat_frame_counter(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LANE_7_STAT_FRAME_COUNTER'],value = value,increment = True,valueLength=4)
        if flush == True:
            await self.flush()
        
    
    async def read_lane_7_stat_frame_counter(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LANE_7_STAT_FRAME_COUNTER'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_lane_7_stat_frame_counter_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LANE_7_STAT_FRAME_COUNTER'],count = count, increment = True)
        
    
    
    
    async def write_lane_8_stat_frame_counter(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LANE_8_STAT_FRAME_COUNTER'],value = value,increment = True,valueLength=4)
        if flush == True:
            await self.flush()
        
    
    async def read_lane_8_stat_frame_counter(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LANE_8_STAT_FRAME_COUNTER'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_lane_8_stat_frame_counter_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LANE_8_STAT_FRAME_COUNTER'],count = count, increment = True)
        
    
    
    
    async def write_lane_9_stat_frame_counter(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LANE_9_STAT_FRAME_COUNTER'],value = value,increment = True,valueLength=4)
        if flush == True:
            await self.flush()
        
    
    async def read_lane_9_stat_frame_counter(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LANE_9_STAT_FRAME_COUNTER'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_lane_9_stat_frame_counter_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LANE_9_STAT_FRAME_COUNTER'],count = count, increment = True)
        
    
    
    
    async def write_lane_10_stat_frame_counter(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LANE_10_STAT_FRAME_COUNTER'],value = value,increment = True,valueLength=4)
        if flush == True:
            await self.flush()
        
    
    async def read_lane_10_stat_frame_counter(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LANE_10_STAT_FRAME_COUNTER'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_lane_10_stat_frame_counter_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LANE_10_STAT_FRAME_COUNTER'],count = count, increment = True)
        
    
    
    
    async def write_lane_11_stat_frame_counter(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LANE_11_STAT_FRAME_COUNTER'],value = value,increment = True,valueLength=4)
        if flush == True:
            await self.flush()
        
    
    async def read_lane_11_stat_frame_counter(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LANE_11_STAT_FRAME_COUNTER'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_lane_11_stat_frame_counter_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LANE_11_STAT_FRAME_COUNTER'],count = count, increment = True)
        
    
    
    
    async def write_lane_12_stat_frame_counter(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LANE_12_STAT_FRAME_COUNTER'],value = value,increment = True,valueLength=4)
        if flush == True:
            await self.flush()
        
    
    async def read_lane_12_stat_frame_counter(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LANE_12_STAT_FRAME_COUNTER'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_lane_12_stat_frame_counter_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LANE_12_STAT_FRAME_COUNTER'],count = count, increment = True)
        
    
    
    
    async def write_lane_13_stat_frame_counter(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LANE_13_STAT_FRAME_COUNTER'],value = value,increment = True,valueLength=4)
        if flush == True:
            await self.flush()
        
    
    async def read_lane_13_stat_frame_counter(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LANE_13_STAT_FRAME_COUNTER'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_lane_13_stat_frame_counter_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LANE_13_STAT_FRAME_COUNTER'],count = count, increment = True)
        
    
    
    
    async def write_lane_14_stat_frame_counter(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LANE_14_STAT_FRAME_COUNTER'],value = value,increment = True,valueLength=4)
        if flush == True:
            await self.flush()
        
    
    async def read_lane_14_stat_frame_counter(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LANE_14_STAT_FRAME_COUNTER'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_lane_14_stat_frame_counter_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LANE_14_STAT_FRAME_COUNTER'],count = count, increment = True)
        
    
    
    
    async def write_lane_15_stat_frame_counter(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LANE_15_STAT_FRAME_COUNTER'],value = value,increment = True,valueLength=4)
        if flush == True:
            await self.flush()
        
    
    async def read_lane_15_stat_frame_counter(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LANE_15_STAT_FRAME_COUNTER'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_lane_15_stat_frame_counter_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LANE_15_STAT_FRAME_COUNTER'],count = count, increment = True)
        
    
    
    
    async def write_lane_16_stat_frame_counter(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LANE_16_STAT_FRAME_COUNTER'],value = value,increment = True,valueLength=4)
        if flush == True:
            await self.flush()
        
    
    async def read_lane_16_stat_frame_counter(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LANE_16_STAT_FRAME_COUNTER'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_lane_16_stat_frame_counter_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LANE_16_STAT_FRAME_COUNTER'],count = count, increment = True)
        
    
    
    
    async def write_lane_17_stat_frame_counter(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LANE_17_STAT_FRAME_COUNTER'],value = value,increment = True,valueLength=4)
        if flush == True:
            await self.flush()
        
    
    async def read_lane_17_stat_frame_counter(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LANE_17_STAT_FRAME_COUNTER'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_lane_17_stat_frame_counter_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LANE_17_STAT_FRAME_COUNTER'],count = count, increment = True)
        
    
    
    
    async def write_lane_18_stat_frame_counter(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LANE_18_STAT_FRAME_COUNTER'],value = value,increment = True,valueLength=4)
        if flush == True:
            await self.flush()
        
    
    async def read_lane_18_stat_frame_counter(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LANE_18_STAT_FRAME_COUNTER'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_lane_18_stat_frame_counter_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LANE_18_STAT_FRAME_COUNTER'],count = count, increment = True)
        
    
    
    
    async def write_lane_19_stat_frame_counter(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LANE_19_STAT_FRAME_COUNTER'],value = value,increment = True,valueLength=4)
        if flush == True:
            await self.flush()
        
    
    async def read_lane_19_stat_frame_counter(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LANE_19_STAT_FRAME_COUNTER'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_lane_19_stat_frame_counter_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LANE_19_STAT_FRAME_COUNTER'],count = count, increment = True)
        
    
    
    
    async def write_lane_0_stat_idle_counter(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LANE_0_STAT_IDLE_COUNTER'],value = value,increment = True,valueLength=4)
        if flush == True:
            await self.flush()
        
    
    async def read_lane_0_stat_idle_counter(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LANE_0_STAT_IDLE_COUNTER'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_lane_0_stat_idle_counter_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LANE_0_STAT_IDLE_COUNTER'],count = count, increment = True)
        
    
    
    
    async def write_lane_1_stat_idle_counter(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LANE_1_STAT_IDLE_COUNTER'],value = value,increment = True,valueLength=4)
        if flush == True:
            await self.flush()
        
    
    async def read_lane_1_stat_idle_counter(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LANE_1_STAT_IDLE_COUNTER'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_lane_1_stat_idle_counter_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LANE_1_STAT_IDLE_COUNTER'],count = count, increment = True)
        
    
    
    
    async def write_lane_2_stat_idle_counter(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LANE_2_STAT_IDLE_COUNTER'],value = value,increment = True,valueLength=4)
        if flush == True:
            await self.flush()
        
    
    async def read_lane_2_stat_idle_counter(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LANE_2_STAT_IDLE_COUNTER'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_lane_2_stat_idle_counter_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LANE_2_STAT_IDLE_COUNTER'],count = count, increment = True)
        
    
    
    
    async def write_lane_3_stat_idle_counter(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LANE_3_STAT_IDLE_COUNTER'],value = value,increment = True,valueLength=4)
        if flush == True:
            await self.flush()
        
    
    async def read_lane_3_stat_idle_counter(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LANE_3_STAT_IDLE_COUNTER'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_lane_3_stat_idle_counter_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LANE_3_STAT_IDLE_COUNTER'],count = count, increment = True)
        
    
    
    
    async def write_lane_4_stat_idle_counter(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LANE_4_STAT_IDLE_COUNTER'],value = value,increment = True,valueLength=4)
        if flush == True:
            await self.flush()
        
    
    async def read_lane_4_stat_idle_counter(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LANE_4_STAT_IDLE_COUNTER'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_lane_4_stat_idle_counter_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LANE_4_STAT_IDLE_COUNTER'],count = count, increment = True)
        
    
    
    
    async def write_lane_5_stat_idle_counter(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LANE_5_STAT_IDLE_COUNTER'],value = value,increment = True,valueLength=4)
        if flush == True:
            await self.flush()
        
    
    async def read_lane_5_stat_idle_counter(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LANE_5_STAT_IDLE_COUNTER'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_lane_5_stat_idle_counter_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LANE_5_STAT_IDLE_COUNTER'],count = count, increment = True)
        
    
    
    
    async def write_lane_6_stat_idle_counter(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LANE_6_STAT_IDLE_COUNTER'],value = value,increment = True,valueLength=4)
        if flush == True:
            await self.flush()
        
    
    async def read_lane_6_stat_idle_counter(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LANE_6_STAT_IDLE_COUNTER'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_lane_6_stat_idle_counter_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LANE_6_STAT_IDLE_COUNTER'],count = count, increment = True)
        
    
    
    
    async def write_lane_7_stat_idle_counter(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LANE_7_STAT_IDLE_COUNTER'],value = value,increment = True,valueLength=4)
        if flush == True:
            await self.flush()
        
    
    async def read_lane_7_stat_idle_counter(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LANE_7_STAT_IDLE_COUNTER'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_lane_7_stat_idle_counter_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LANE_7_STAT_IDLE_COUNTER'],count = count, increment = True)
        
    
    
    
    async def write_lane_8_stat_idle_counter(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LANE_8_STAT_IDLE_COUNTER'],value = value,increment = True,valueLength=4)
        if flush == True:
            await self.flush()
        
    
    async def read_lane_8_stat_idle_counter(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LANE_8_STAT_IDLE_COUNTER'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_lane_8_stat_idle_counter_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LANE_8_STAT_IDLE_COUNTER'],count = count, increment = True)
        
    
    
    
    async def write_lane_9_stat_idle_counter(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LANE_9_STAT_IDLE_COUNTER'],value = value,increment = True,valueLength=4)
        if flush == True:
            await self.flush()
        
    
    async def read_lane_9_stat_idle_counter(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LANE_9_STAT_IDLE_COUNTER'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_lane_9_stat_idle_counter_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LANE_9_STAT_IDLE_COUNTER'],count = count, increment = True)
        
    
    
    
    async def write_lane_10_stat_idle_counter(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LANE_10_STAT_IDLE_COUNTER'],value = value,increment = True,valueLength=4)
        if flush == True:
            await self.flush()
        
    
    async def read_lane_10_stat_idle_counter(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LANE_10_STAT_IDLE_COUNTER'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_lane_10_stat_idle_counter_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LANE_10_STAT_IDLE_COUNTER'],count = count, increment = True)
        
    
    
    
    async def write_lane_11_stat_idle_counter(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LANE_11_STAT_IDLE_COUNTER'],value = value,increment = True,valueLength=4)
        if flush == True:
            await self.flush()
        
    
    async def read_lane_11_stat_idle_counter(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LANE_11_STAT_IDLE_COUNTER'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_lane_11_stat_idle_counter_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LANE_11_STAT_IDLE_COUNTER'],count = count, increment = True)
        
    
    
    
    async def write_lane_12_stat_idle_counter(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LANE_12_STAT_IDLE_COUNTER'],value = value,increment = True,valueLength=4)
        if flush == True:
            await self.flush()
        
    
    async def read_lane_12_stat_idle_counter(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LANE_12_STAT_IDLE_COUNTER'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_lane_12_stat_idle_counter_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LANE_12_STAT_IDLE_COUNTER'],count = count, increment = True)
        
    
    
    
    async def write_lane_13_stat_idle_counter(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LANE_13_STAT_IDLE_COUNTER'],value = value,increment = True,valueLength=4)
        if flush == True:
            await self.flush()
        
    
    async def read_lane_13_stat_idle_counter(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LANE_13_STAT_IDLE_COUNTER'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_lane_13_stat_idle_counter_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LANE_13_STAT_IDLE_COUNTER'],count = count, increment = True)
        
    
    
    
    async def write_lane_14_stat_idle_counter(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LANE_14_STAT_IDLE_COUNTER'],value = value,increment = True,valueLength=4)
        if flush == True:
            await self.flush()
        
    
    async def read_lane_14_stat_idle_counter(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LANE_14_STAT_IDLE_COUNTER'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_lane_14_stat_idle_counter_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LANE_14_STAT_IDLE_COUNTER'],count = count, increment = True)
        
    
    
    
    async def write_lane_15_stat_idle_counter(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LANE_15_STAT_IDLE_COUNTER'],value = value,increment = True,valueLength=4)
        if flush == True:
            await self.flush()
        
    
    async def read_lane_15_stat_idle_counter(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LANE_15_STAT_IDLE_COUNTER'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_lane_15_stat_idle_counter_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LANE_15_STAT_IDLE_COUNTER'],count = count, increment = True)
        
    
    
    
    async def write_lane_16_stat_idle_counter(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LANE_16_STAT_IDLE_COUNTER'],value = value,increment = True,valueLength=4)
        if flush == True:
            await self.flush()
        
    
    async def read_lane_16_stat_idle_counter(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LANE_16_STAT_IDLE_COUNTER'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_lane_16_stat_idle_counter_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LANE_16_STAT_IDLE_COUNTER'],count = count, increment = True)
        
    
    
    
    async def write_lane_17_stat_idle_counter(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LANE_17_STAT_IDLE_COUNTER'],value = value,increment = True,valueLength=4)
        if flush == True:
            await self.flush()
        
    
    async def read_lane_17_stat_idle_counter(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LANE_17_STAT_IDLE_COUNTER'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_lane_17_stat_idle_counter_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LANE_17_STAT_IDLE_COUNTER'],count = count, increment = True)
        
    
    
    
    async def write_lane_18_stat_idle_counter(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LANE_18_STAT_IDLE_COUNTER'],value = value,increment = True,valueLength=4)
        if flush == True:
            await self.flush()
        
    
    async def read_lane_18_stat_idle_counter(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LANE_18_STAT_IDLE_COUNTER'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_lane_18_stat_idle_counter_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LANE_18_STAT_IDLE_COUNTER'],count = count, increment = True)
        
    
    
    
    async def write_lane_19_stat_idle_counter(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LANE_19_STAT_IDLE_COUNTER'],value = value,increment = True,valueLength=4)
        if flush == True:
            await self.flush()
        
    
    async def read_lane_19_stat_idle_counter(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LANE_19_STAT_IDLE_COUNTER'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_lane_19_stat_idle_counter_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LANE_19_STAT_IDLE_COUNTER'],count = count, increment = True)
        
    
    
    
    async def write_lane_0_mosi(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LANE_0_MOSI'],value = value,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    async def write_lane_0_mosi_bytes(self,values : bytearray,flush = False):
        for b in values:
            self.addWrite(register = self.Registers['LANE_0_MOSI'],value = b,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    
    
    async def read_lane_0_mosi_write_size(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LANE_0_MOSI_WRITE_SIZE'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_lane_0_mosi_write_size_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LANE_0_MOSI_WRITE_SIZE'],count = count, increment = True)
        
    
    
    
    async def write_lane_1_mosi(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LANE_1_MOSI'],value = value,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    async def write_lane_1_mosi_bytes(self,values : bytearray,flush = False):
        for b in values:
            self.addWrite(register = self.Registers['LANE_1_MOSI'],value = b,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    
    
    async def read_lane_1_mosi_write_size(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LANE_1_MOSI_WRITE_SIZE'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_lane_1_mosi_write_size_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LANE_1_MOSI_WRITE_SIZE'],count = count, increment = True)
        
    
    
    
    async def write_lane_2_mosi(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LANE_2_MOSI'],value = value,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    async def write_lane_2_mosi_bytes(self,values : bytearray,flush = False):
        for b in values:
            self.addWrite(register = self.Registers['LANE_2_MOSI'],value = b,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    
    
    async def read_lane_2_mosi_write_size(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LANE_2_MOSI_WRITE_SIZE'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_lane_2_mosi_write_size_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LANE_2_MOSI_WRITE_SIZE'],count = count, increment = True)
        
    
    
    
    async def write_lane_3_mosi(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LANE_3_MOSI'],value = value,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    async def write_lane_3_mosi_bytes(self,values : bytearray,flush = False):
        for b in values:
            self.addWrite(register = self.Registers['LANE_3_MOSI'],value = b,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    
    
    async def read_lane_3_mosi_write_size(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LANE_3_MOSI_WRITE_SIZE'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_lane_3_mosi_write_size_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LANE_3_MOSI_WRITE_SIZE'],count = count, increment = True)
        
    
    
    
    async def write_lane_4_mosi(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LANE_4_MOSI'],value = value,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    async def write_lane_4_mosi_bytes(self,values : bytearray,flush = False):
        for b in values:
            self.addWrite(register = self.Registers['LANE_4_MOSI'],value = b,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    
    
    async def read_lane_4_mosi_write_size(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LANE_4_MOSI_WRITE_SIZE'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_lane_4_mosi_write_size_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LANE_4_MOSI_WRITE_SIZE'],count = count, increment = True)
        
    
    
    
    async def write_lane_5_mosi(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LANE_5_MOSI'],value = value,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    async def write_lane_5_mosi_bytes(self,values : bytearray,flush = False):
        for b in values:
            self.addWrite(register = self.Registers['LANE_5_MOSI'],value = b,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    
    
    async def read_lane_5_mosi_write_size(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LANE_5_MOSI_WRITE_SIZE'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_lane_5_mosi_write_size_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LANE_5_MOSI_WRITE_SIZE'],count = count, increment = True)
        
    
    
    
    async def write_lane_6_mosi(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LANE_6_MOSI'],value = value,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    async def write_lane_6_mosi_bytes(self,values : bytearray,flush = False):
        for b in values:
            self.addWrite(register = self.Registers['LANE_6_MOSI'],value = b,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    
    
    async def read_lane_6_mosi_write_size(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LANE_6_MOSI_WRITE_SIZE'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_lane_6_mosi_write_size_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LANE_6_MOSI_WRITE_SIZE'],count = count, increment = True)
        
    
    
    
    async def write_lane_7_mosi(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LANE_7_MOSI'],value = value,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    async def write_lane_7_mosi_bytes(self,values : bytearray,flush = False):
        for b in values:
            self.addWrite(register = self.Registers['LANE_7_MOSI'],value = b,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    
    
    async def read_lane_7_mosi_write_size(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LANE_7_MOSI_WRITE_SIZE'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_lane_7_mosi_write_size_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LANE_7_MOSI_WRITE_SIZE'],count = count, increment = True)
        
    
    
    
    async def write_lane_8_mosi(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LANE_8_MOSI'],value = value,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    async def write_lane_8_mosi_bytes(self,values : bytearray,flush = False):
        for b in values:
            self.addWrite(register = self.Registers['LANE_8_MOSI'],value = b,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    
    
    async def read_lane_8_mosi_write_size(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LANE_8_MOSI_WRITE_SIZE'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_lane_8_mosi_write_size_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LANE_8_MOSI_WRITE_SIZE'],count = count, increment = True)
        
    
    
    
    async def write_lane_9_mosi(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LANE_9_MOSI'],value = value,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    async def write_lane_9_mosi_bytes(self,values : bytearray,flush = False):
        for b in values:
            self.addWrite(register = self.Registers['LANE_9_MOSI'],value = b,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    
    
    async def read_lane_9_mosi_write_size(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LANE_9_MOSI_WRITE_SIZE'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_lane_9_mosi_write_size_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LANE_9_MOSI_WRITE_SIZE'],count = count, increment = True)
        
    
    
    
    async def write_lane_10_mosi(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LANE_10_MOSI'],value = value,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    async def write_lane_10_mosi_bytes(self,values : bytearray,flush = False):
        for b in values:
            self.addWrite(register = self.Registers['LANE_10_MOSI'],value = b,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    
    
    async def read_lane_10_mosi_write_size(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LANE_10_MOSI_WRITE_SIZE'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_lane_10_mosi_write_size_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LANE_10_MOSI_WRITE_SIZE'],count = count, increment = True)
        
    
    
    
    async def write_lane_11_mosi(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LANE_11_MOSI'],value = value,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    async def write_lane_11_mosi_bytes(self,values : bytearray,flush = False):
        for b in values:
            self.addWrite(register = self.Registers['LANE_11_MOSI'],value = b,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    
    
    async def read_lane_11_mosi_write_size(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LANE_11_MOSI_WRITE_SIZE'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_lane_11_mosi_write_size_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LANE_11_MOSI_WRITE_SIZE'],count = count, increment = True)
        
    
    
    
    async def write_lane_12_mosi(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LANE_12_MOSI'],value = value,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    async def write_lane_12_mosi_bytes(self,values : bytearray,flush = False):
        for b in values:
            self.addWrite(register = self.Registers['LANE_12_MOSI'],value = b,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    
    
    async def read_lane_12_mosi_write_size(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LANE_12_MOSI_WRITE_SIZE'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_lane_12_mosi_write_size_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LANE_12_MOSI_WRITE_SIZE'],count = count, increment = True)
        
    
    
    
    async def write_lane_13_mosi(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LANE_13_MOSI'],value = value,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    async def write_lane_13_mosi_bytes(self,values : bytearray,flush = False):
        for b in values:
            self.addWrite(register = self.Registers['LANE_13_MOSI'],value = b,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    
    
    async def read_lane_13_mosi_write_size(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LANE_13_MOSI_WRITE_SIZE'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_lane_13_mosi_write_size_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LANE_13_MOSI_WRITE_SIZE'],count = count, increment = True)
        
    
    
    
    async def write_lane_14_mosi(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LANE_14_MOSI'],value = value,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    async def write_lane_14_mosi_bytes(self,values : bytearray,flush = False):
        for b in values:
            self.addWrite(register = self.Registers['LANE_14_MOSI'],value = b,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    
    
    async def read_lane_14_mosi_write_size(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LANE_14_MOSI_WRITE_SIZE'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_lane_14_mosi_write_size_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LANE_14_MOSI_WRITE_SIZE'],count = count, increment = True)
        
    
    
    
    async def write_lane_15_mosi(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LANE_15_MOSI'],value = value,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    async def write_lane_15_mosi_bytes(self,values : bytearray,flush = False):
        for b in values:
            self.addWrite(register = self.Registers['LANE_15_MOSI'],value = b,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    
    
    async def read_lane_15_mosi_write_size(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LANE_15_MOSI_WRITE_SIZE'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_lane_15_mosi_write_size_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LANE_15_MOSI_WRITE_SIZE'],count = count, increment = True)
        
    
    
    
    async def write_lane_16_mosi(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LANE_16_MOSI'],value = value,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    async def write_lane_16_mosi_bytes(self,values : bytearray,flush = False):
        for b in values:
            self.addWrite(register = self.Registers['LANE_16_MOSI'],value = b,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    
    
    async def read_lane_16_mosi_write_size(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LANE_16_MOSI_WRITE_SIZE'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_lane_16_mosi_write_size_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LANE_16_MOSI_WRITE_SIZE'],count = count, increment = True)
        
    
    
    
    async def write_lane_17_mosi(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LANE_17_MOSI'],value = value,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    async def write_lane_17_mosi_bytes(self,values : bytearray,flush = False):
        for b in values:
            self.addWrite(register = self.Registers['LANE_17_MOSI'],value = b,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    
    
    async def read_lane_17_mosi_write_size(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LANE_17_MOSI_WRITE_SIZE'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_lane_17_mosi_write_size_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LANE_17_MOSI_WRITE_SIZE'],count = count, increment = True)
        
    
    
    
    async def write_lane_18_mosi(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LANE_18_MOSI'],value = value,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    async def write_lane_18_mosi_bytes(self,values : bytearray,flush = False):
        for b in values:
            self.addWrite(register = self.Registers['LANE_18_MOSI'],value = b,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    
    
    async def read_lane_18_mosi_write_size(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LANE_18_MOSI_WRITE_SIZE'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_lane_18_mosi_write_size_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LANE_18_MOSI_WRITE_SIZE'],count = count, increment = True)
        
    
    
    
    async def write_lane_19_mosi(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LANE_19_MOSI'],value = value,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    async def write_lane_19_mosi_bytes(self,values : bytearray,flush = False):
        for b in values:
            self.addWrite(register = self.Registers['LANE_19_MOSI'],value = b,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    
    
    async def read_lane_19_mosi_write_size(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LANE_19_MOSI_WRITE_SIZE'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_lane_19_mosi_write_size_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LANE_19_MOSI_WRITE_SIZE'],count = count, increment = True)
        
    
    
    
    async def write_lane_0_loopback_miso(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LANE_0_LOOPBACK_MISO'],value = value,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    async def write_lane_0_loopback_miso_bytes(self,values : bytearray,flush = False):
        for b in values:
            self.addWrite(register = self.Registers['LANE_0_LOOPBACK_MISO'],value = b,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    
    
    async def read_lane_0_loopback_miso_write_size(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LANE_0_LOOPBACK_MISO_WRITE_SIZE'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_lane_0_loopback_miso_write_size_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LANE_0_LOOPBACK_MISO_WRITE_SIZE'],count = count, increment = True)
        
    
    
    
    async def write_lane_1_loopback_miso(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LANE_1_LOOPBACK_MISO'],value = value,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    async def write_lane_1_loopback_miso_bytes(self,values : bytearray,flush = False):
        for b in values:
            self.addWrite(register = self.Registers['LANE_1_LOOPBACK_MISO'],value = b,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    
    
    async def read_lane_1_loopback_miso_write_size(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LANE_1_LOOPBACK_MISO_WRITE_SIZE'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_lane_1_loopback_miso_write_size_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LANE_1_LOOPBACK_MISO_WRITE_SIZE'],count = count, increment = True)
        
    
    
    
    async def write_lane_2_loopback_miso(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LANE_2_LOOPBACK_MISO'],value = value,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    async def write_lane_2_loopback_miso_bytes(self,values : bytearray,flush = False):
        for b in values:
            self.addWrite(register = self.Registers['LANE_2_LOOPBACK_MISO'],value = b,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    
    
    async def read_lane_2_loopback_miso_write_size(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LANE_2_LOOPBACK_MISO_WRITE_SIZE'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_lane_2_loopback_miso_write_size_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LANE_2_LOOPBACK_MISO_WRITE_SIZE'],count = count, increment = True)
        
    
    
    
    async def write_lane_3_loopback_miso(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LANE_3_LOOPBACK_MISO'],value = value,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    async def write_lane_3_loopback_miso_bytes(self,values : bytearray,flush = False):
        for b in values:
            self.addWrite(register = self.Registers['LANE_3_LOOPBACK_MISO'],value = b,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    
    
    async def read_lane_3_loopback_miso_write_size(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LANE_3_LOOPBACK_MISO_WRITE_SIZE'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_lane_3_loopback_miso_write_size_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LANE_3_LOOPBACK_MISO_WRITE_SIZE'],count = count, increment = True)
        
    
    
    
    async def write_lane_4_loopback_miso(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LANE_4_LOOPBACK_MISO'],value = value,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    async def write_lane_4_loopback_miso_bytes(self,values : bytearray,flush = False):
        for b in values:
            self.addWrite(register = self.Registers['LANE_4_LOOPBACK_MISO'],value = b,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    
    
    async def read_lane_4_loopback_miso_write_size(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LANE_4_LOOPBACK_MISO_WRITE_SIZE'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_lane_4_loopback_miso_write_size_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LANE_4_LOOPBACK_MISO_WRITE_SIZE'],count = count, increment = True)
        
    
    
    
    async def write_lane_5_loopback_miso(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LANE_5_LOOPBACK_MISO'],value = value,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    async def write_lane_5_loopback_miso_bytes(self,values : bytearray,flush = False):
        for b in values:
            self.addWrite(register = self.Registers['LANE_5_LOOPBACK_MISO'],value = b,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    
    
    async def read_lane_5_loopback_miso_write_size(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LANE_5_LOOPBACK_MISO_WRITE_SIZE'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_lane_5_loopback_miso_write_size_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LANE_5_LOOPBACK_MISO_WRITE_SIZE'],count = count, increment = True)
        
    
    
    
    async def write_lane_6_loopback_miso(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LANE_6_LOOPBACK_MISO'],value = value,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    async def write_lane_6_loopback_miso_bytes(self,values : bytearray,flush = False):
        for b in values:
            self.addWrite(register = self.Registers['LANE_6_LOOPBACK_MISO'],value = b,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    
    
    async def read_lane_6_loopback_miso_write_size(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LANE_6_LOOPBACK_MISO_WRITE_SIZE'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_lane_6_loopback_miso_write_size_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LANE_6_LOOPBACK_MISO_WRITE_SIZE'],count = count, increment = True)
        
    
    
    
    async def write_lane_7_loopback_miso(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LANE_7_LOOPBACK_MISO'],value = value,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    async def write_lane_7_loopback_miso_bytes(self,values : bytearray,flush = False):
        for b in values:
            self.addWrite(register = self.Registers['LANE_7_LOOPBACK_MISO'],value = b,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    
    
    async def read_lane_7_loopback_miso_write_size(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LANE_7_LOOPBACK_MISO_WRITE_SIZE'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_lane_7_loopback_miso_write_size_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LANE_7_LOOPBACK_MISO_WRITE_SIZE'],count = count, increment = True)
        
    
    
    
    async def write_lane_8_loopback_miso(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LANE_8_LOOPBACK_MISO'],value = value,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    async def write_lane_8_loopback_miso_bytes(self,values : bytearray,flush = False):
        for b in values:
            self.addWrite(register = self.Registers['LANE_8_LOOPBACK_MISO'],value = b,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    
    
    async def read_lane_8_loopback_miso_write_size(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LANE_8_LOOPBACK_MISO_WRITE_SIZE'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_lane_8_loopback_miso_write_size_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LANE_8_LOOPBACK_MISO_WRITE_SIZE'],count = count, increment = True)
        
    
    
    
    async def write_lane_9_loopback_miso(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LANE_9_LOOPBACK_MISO'],value = value,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    async def write_lane_9_loopback_miso_bytes(self,values : bytearray,flush = False):
        for b in values:
            self.addWrite(register = self.Registers['LANE_9_LOOPBACK_MISO'],value = b,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    
    
    async def read_lane_9_loopback_miso_write_size(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LANE_9_LOOPBACK_MISO_WRITE_SIZE'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_lane_9_loopback_miso_write_size_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LANE_9_LOOPBACK_MISO_WRITE_SIZE'],count = count, increment = True)
        
    
    
    
    async def write_lane_10_loopback_miso(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LANE_10_LOOPBACK_MISO'],value = value,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    async def write_lane_10_loopback_miso_bytes(self,values : bytearray,flush = False):
        for b in values:
            self.addWrite(register = self.Registers['LANE_10_LOOPBACK_MISO'],value = b,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    
    
    async def read_lane_10_loopback_miso_write_size(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LANE_10_LOOPBACK_MISO_WRITE_SIZE'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_lane_10_loopback_miso_write_size_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LANE_10_LOOPBACK_MISO_WRITE_SIZE'],count = count, increment = True)
        
    
    
    
    async def write_lane_11_loopback_miso(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LANE_11_LOOPBACK_MISO'],value = value,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    async def write_lane_11_loopback_miso_bytes(self,values : bytearray,flush = False):
        for b in values:
            self.addWrite(register = self.Registers['LANE_11_LOOPBACK_MISO'],value = b,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    
    
    async def read_lane_11_loopback_miso_write_size(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LANE_11_LOOPBACK_MISO_WRITE_SIZE'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_lane_11_loopback_miso_write_size_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LANE_11_LOOPBACK_MISO_WRITE_SIZE'],count = count, increment = True)
        
    
    
    
    async def write_lane_12_loopback_miso(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LANE_12_LOOPBACK_MISO'],value = value,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    async def write_lane_12_loopback_miso_bytes(self,values : bytearray,flush = False):
        for b in values:
            self.addWrite(register = self.Registers['LANE_12_LOOPBACK_MISO'],value = b,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    
    
    async def read_lane_12_loopback_miso_write_size(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LANE_12_LOOPBACK_MISO_WRITE_SIZE'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_lane_12_loopback_miso_write_size_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LANE_12_LOOPBACK_MISO_WRITE_SIZE'],count = count, increment = True)
        
    
    
    
    async def write_lane_13_loopback_miso(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LANE_13_LOOPBACK_MISO'],value = value,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    async def write_lane_13_loopback_miso_bytes(self,values : bytearray,flush = False):
        for b in values:
            self.addWrite(register = self.Registers['LANE_13_LOOPBACK_MISO'],value = b,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    
    
    async def read_lane_13_loopback_miso_write_size(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LANE_13_LOOPBACK_MISO_WRITE_SIZE'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_lane_13_loopback_miso_write_size_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LANE_13_LOOPBACK_MISO_WRITE_SIZE'],count = count, increment = True)
        
    
    
    
    async def write_lane_14_loopback_miso(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LANE_14_LOOPBACK_MISO'],value = value,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    async def write_lane_14_loopback_miso_bytes(self,values : bytearray,flush = False):
        for b in values:
            self.addWrite(register = self.Registers['LANE_14_LOOPBACK_MISO'],value = b,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    
    
    async def read_lane_14_loopback_miso_write_size(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LANE_14_LOOPBACK_MISO_WRITE_SIZE'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_lane_14_loopback_miso_write_size_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LANE_14_LOOPBACK_MISO_WRITE_SIZE'],count = count, increment = True)
        
    
    
    
    async def write_lane_15_loopback_miso(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LANE_15_LOOPBACK_MISO'],value = value,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    async def write_lane_15_loopback_miso_bytes(self,values : bytearray,flush = False):
        for b in values:
            self.addWrite(register = self.Registers['LANE_15_LOOPBACK_MISO'],value = b,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    
    
    async def read_lane_15_loopback_miso_write_size(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LANE_15_LOOPBACK_MISO_WRITE_SIZE'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_lane_15_loopback_miso_write_size_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LANE_15_LOOPBACK_MISO_WRITE_SIZE'],count = count, increment = True)
        
    
    
    
    async def write_lane_16_loopback_miso(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LANE_16_LOOPBACK_MISO'],value = value,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    async def write_lane_16_loopback_miso_bytes(self,values : bytearray,flush = False):
        for b in values:
            self.addWrite(register = self.Registers['LANE_16_LOOPBACK_MISO'],value = b,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    
    
    async def read_lane_16_loopback_miso_write_size(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LANE_16_LOOPBACK_MISO_WRITE_SIZE'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_lane_16_loopback_miso_write_size_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LANE_16_LOOPBACK_MISO_WRITE_SIZE'],count = count, increment = True)
        
    
    
    
    async def write_lane_17_loopback_miso(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LANE_17_LOOPBACK_MISO'],value = value,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    async def write_lane_17_loopback_miso_bytes(self,values : bytearray,flush = False):
        for b in values:
            self.addWrite(register = self.Registers['LANE_17_LOOPBACK_MISO'],value = b,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    
    
    async def read_lane_17_loopback_miso_write_size(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LANE_17_LOOPBACK_MISO_WRITE_SIZE'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_lane_17_loopback_miso_write_size_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LANE_17_LOOPBACK_MISO_WRITE_SIZE'],count = count, increment = True)
        
    
    
    
    async def write_lane_18_loopback_miso(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LANE_18_LOOPBACK_MISO'],value = value,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    async def write_lane_18_loopback_miso_bytes(self,values : bytearray,flush = False):
        for b in values:
            self.addWrite(register = self.Registers['LANE_18_LOOPBACK_MISO'],value = b,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    
    
    async def read_lane_18_loopback_miso_write_size(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LANE_18_LOOPBACK_MISO_WRITE_SIZE'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_lane_18_loopback_miso_write_size_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LANE_18_LOOPBACK_MISO_WRITE_SIZE'],count = count, increment = True)
        
    
    
    
    async def write_lane_19_loopback_miso(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LANE_19_LOOPBACK_MISO'],value = value,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    async def write_lane_19_loopback_miso_bytes(self,values : bytearray,flush = False):
        for b in values:
            self.addWrite(register = self.Registers['LANE_19_LOOPBACK_MISO'],value = b,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    
    
    async def read_lane_19_loopback_miso_write_size(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LANE_19_LOOPBACK_MISO_WRITE_SIZE'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_lane_19_loopback_miso_write_size_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LANE_19_LOOPBACK_MISO_WRITE_SIZE'],count = count, increment = True)
        
    
    
    
    async def read_lane_0_loopback_mosi(self, count : int = 1 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LANE_0_LOOPBACK_MOSI'],count = count, increment = False , targetQueue = targetQueue), 'little') 
        
    
    async def read_lane_0_loopback_mosi_raw(self, count : int = 1 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LANE_0_LOOPBACK_MOSI'],count = count, increment = False)
        
    
    
    
    async def read_lane_0_loopback_mosi_read_size(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LANE_0_LOOPBACK_MOSI_READ_SIZE'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_lane_0_loopback_mosi_read_size_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LANE_0_LOOPBACK_MOSI_READ_SIZE'],count = count, increment = True)
        
    
    
    
    async def read_lane_1_loopback_mosi(self, count : int = 1 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LANE_1_LOOPBACK_MOSI'],count = count, increment = False , targetQueue = targetQueue), 'little') 
        
    
    async def read_lane_1_loopback_mosi_raw(self, count : int = 1 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LANE_1_LOOPBACK_MOSI'],count = count, increment = False)
        
    
    
    
    async def read_lane_1_loopback_mosi_read_size(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LANE_1_LOOPBACK_MOSI_READ_SIZE'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_lane_1_loopback_mosi_read_size_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LANE_1_LOOPBACK_MOSI_READ_SIZE'],count = count, increment = True)
        
    
    
    
    async def read_lane_2_loopback_mosi(self, count : int = 1 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LANE_2_LOOPBACK_MOSI'],count = count, increment = False , targetQueue = targetQueue), 'little') 
        
    
    async def read_lane_2_loopback_mosi_raw(self, count : int = 1 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LANE_2_LOOPBACK_MOSI'],count = count, increment = False)
        
    
    
    
    async def read_lane_2_loopback_mosi_read_size(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LANE_2_LOOPBACK_MOSI_READ_SIZE'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_lane_2_loopback_mosi_read_size_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LANE_2_LOOPBACK_MOSI_READ_SIZE'],count = count, increment = True)
        
    
    
    
    async def read_lane_3_loopback_mosi(self, count : int = 1 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LANE_3_LOOPBACK_MOSI'],count = count, increment = False , targetQueue = targetQueue), 'little') 
        
    
    async def read_lane_3_loopback_mosi_raw(self, count : int = 1 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LANE_3_LOOPBACK_MOSI'],count = count, increment = False)
        
    
    
    
    async def read_lane_3_loopback_mosi_read_size(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LANE_3_LOOPBACK_MOSI_READ_SIZE'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_lane_3_loopback_mosi_read_size_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LANE_3_LOOPBACK_MOSI_READ_SIZE'],count = count, increment = True)
        
    
    
    
    async def read_lane_4_loopback_mosi(self, count : int = 1 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LANE_4_LOOPBACK_MOSI'],count = count, increment = False , targetQueue = targetQueue), 'little') 
        
    
    async def read_lane_4_loopback_mosi_raw(self, count : int = 1 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LANE_4_LOOPBACK_MOSI'],count = count, increment = False)
        
    
    
    
    async def read_lane_4_loopback_mosi_read_size(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LANE_4_LOOPBACK_MOSI_READ_SIZE'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_lane_4_loopback_mosi_read_size_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LANE_4_LOOPBACK_MOSI_READ_SIZE'],count = count, increment = True)
        
    
    
    
    async def read_lane_5_loopback_mosi(self, count : int = 1 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LANE_5_LOOPBACK_MOSI'],count = count, increment = False , targetQueue = targetQueue), 'little') 
        
    
    async def read_lane_5_loopback_mosi_raw(self, count : int = 1 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LANE_5_LOOPBACK_MOSI'],count = count, increment = False)
        
    
    
    
    async def read_lane_5_loopback_mosi_read_size(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LANE_5_LOOPBACK_MOSI_READ_SIZE'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_lane_5_loopback_mosi_read_size_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LANE_5_LOOPBACK_MOSI_READ_SIZE'],count = count, increment = True)
        
    
    
    
    async def read_lane_6_loopback_mosi(self, count : int = 1 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LANE_6_LOOPBACK_MOSI'],count = count, increment = False , targetQueue = targetQueue), 'little') 
        
    
    async def read_lane_6_loopback_mosi_raw(self, count : int = 1 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LANE_6_LOOPBACK_MOSI'],count = count, increment = False)
        
    
    
    
    async def read_lane_6_loopback_mosi_read_size(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LANE_6_LOOPBACK_MOSI_READ_SIZE'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_lane_6_loopback_mosi_read_size_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LANE_6_LOOPBACK_MOSI_READ_SIZE'],count = count, increment = True)
        
    
    
    
    async def read_lane_7_loopback_mosi(self, count : int = 1 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LANE_7_LOOPBACK_MOSI'],count = count, increment = False , targetQueue = targetQueue), 'little') 
        
    
    async def read_lane_7_loopback_mosi_raw(self, count : int = 1 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LANE_7_LOOPBACK_MOSI'],count = count, increment = False)
        
    
    
    
    async def read_lane_7_loopback_mosi_read_size(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LANE_7_LOOPBACK_MOSI_READ_SIZE'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_lane_7_loopback_mosi_read_size_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LANE_7_LOOPBACK_MOSI_READ_SIZE'],count = count, increment = True)
        
    
    
    
    async def read_lane_8_loopback_mosi(self, count : int = 1 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LANE_8_LOOPBACK_MOSI'],count = count, increment = False , targetQueue = targetQueue), 'little') 
        
    
    async def read_lane_8_loopback_mosi_raw(self, count : int = 1 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LANE_8_LOOPBACK_MOSI'],count = count, increment = False)
        
    
    
    
    async def read_lane_8_loopback_mosi_read_size(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LANE_8_LOOPBACK_MOSI_READ_SIZE'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_lane_8_loopback_mosi_read_size_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LANE_8_LOOPBACK_MOSI_READ_SIZE'],count = count, increment = True)
        
    
    
    
    async def read_lane_9_loopback_mosi(self, count : int = 1 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LANE_9_LOOPBACK_MOSI'],count = count, increment = False , targetQueue = targetQueue), 'little') 
        
    
    async def read_lane_9_loopback_mosi_raw(self, count : int = 1 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LANE_9_LOOPBACK_MOSI'],count = count, increment = False)
        
    
    
    
    async def read_lane_9_loopback_mosi_read_size(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LANE_9_LOOPBACK_MOSI_READ_SIZE'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_lane_9_loopback_mosi_read_size_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LANE_9_LOOPBACK_MOSI_READ_SIZE'],count = count, increment = True)
        
    
    
    
    async def read_lane_10_loopback_mosi(self, count : int = 1 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LANE_10_LOOPBACK_MOSI'],count = count, increment = False , targetQueue = targetQueue), 'little') 
        
    
    async def read_lane_10_loopback_mosi_raw(self, count : int = 1 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LANE_10_LOOPBACK_MOSI'],count = count, increment = False)
        
    
    
    
    async def read_lane_10_loopback_mosi_read_size(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LANE_10_LOOPBACK_MOSI_READ_SIZE'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_lane_10_loopback_mosi_read_size_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LANE_10_LOOPBACK_MOSI_READ_SIZE'],count = count, increment = True)
        
    
    
    
    async def read_lane_11_loopback_mosi(self, count : int = 1 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LANE_11_LOOPBACK_MOSI'],count = count, increment = False , targetQueue = targetQueue), 'little') 
        
    
    async def read_lane_11_loopback_mosi_raw(self, count : int = 1 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LANE_11_LOOPBACK_MOSI'],count = count, increment = False)
        
    
    
    
    async def read_lane_11_loopback_mosi_read_size(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LANE_11_LOOPBACK_MOSI_READ_SIZE'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_lane_11_loopback_mosi_read_size_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LANE_11_LOOPBACK_MOSI_READ_SIZE'],count = count, increment = True)
        
    
    
    
    async def read_lane_12_loopback_mosi(self, count : int = 1 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LANE_12_LOOPBACK_MOSI'],count = count, increment = False , targetQueue = targetQueue), 'little') 
        
    
    async def read_lane_12_loopback_mosi_raw(self, count : int = 1 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LANE_12_LOOPBACK_MOSI'],count = count, increment = False)
        
    
    
    
    async def read_lane_12_loopback_mosi_read_size(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LANE_12_LOOPBACK_MOSI_READ_SIZE'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_lane_12_loopback_mosi_read_size_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LANE_12_LOOPBACK_MOSI_READ_SIZE'],count = count, increment = True)
        
    
    
    
    async def read_lane_13_loopback_mosi(self, count : int = 1 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LANE_13_LOOPBACK_MOSI'],count = count, increment = False , targetQueue = targetQueue), 'little') 
        
    
    async def read_lane_13_loopback_mosi_raw(self, count : int = 1 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LANE_13_LOOPBACK_MOSI'],count = count, increment = False)
        
    
    
    
    async def read_lane_13_loopback_mosi_read_size(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LANE_13_LOOPBACK_MOSI_READ_SIZE'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_lane_13_loopback_mosi_read_size_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LANE_13_LOOPBACK_MOSI_READ_SIZE'],count = count, increment = True)
        
    
    
    
    async def read_lane_14_loopback_mosi(self, count : int = 1 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LANE_14_LOOPBACK_MOSI'],count = count, increment = False , targetQueue = targetQueue), 'little') 
        
    
    async def read_lane_14_loopback_mosi_raw(self, count : int = 1 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LANE_14_LOOPBACK_MOSI'],count = count, increment = False)
        
    
    
    
    async def read_lane_14_loopback_mosi_read_size(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LANE_14_LOOPBACK_MOSI_READ_SIZE'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_lane_14_loopback_mosi_read_size_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LANE_14_LOOPBACK_MOSI_READ_SIZE'],count = count, increment = True)
        
    
    
    
    async def read_lane_15_loopback_mosi(self, count : int = 1 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LANE_15_LOOPBACK_MOSI'],count = count, increment = False , targetQueue = targetQueue), 'little') 
        
    
    async def read_lane_15_loopback_mosi_raw(self, count : int = 1 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LANE_15_LOOPBACK_MOSI'],count = count, increment = False)
        
    
    
    
    async def read_lane_15_loopback_mosi_read_size(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LANE_15_LOOPBACK_MOSI_READ_SIZE'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_lane_15_loopback_mosi_read_size_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LANE_15_LOOPBACK_MOSI_READ_SIZE'],count = count, increment = True)
        
    
    
    
    async def read_lane_16_loopback_mosi(self, count : int = 1 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LANE_16_LOOPBACK_MOSI'],count = count, increment = False , targetQueue = targetQueue), 'little') 
        
    
    async def read_lane_16_loopback_mosi_raw(self, count : int = 1 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LANE_16_LOOPBACK_MOSI'],count = count, increment = False)
        
    
    
    
    async def read_lane_16_loopback_mosi_read_size(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LANE_16_LOOPBACK_MOSI_READ_SIZE'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_lane_16_loopback_mosi_read_size_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LANE_16_LOOPBACK_MOSI_READ_SIZE'],count = count, increment = True)
        
    
    
    
    async def read_lane_17_loopback_mosi(self, count : int = 1 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LANE_17_LOOPBACK_MOSI'],count = count, increment = False , targetQueue = targetQueue), 'little') 
        
    
    async def read_lane_17_loopback_mosi_raw(self, count : int = 1 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LANE_17_LOOPBACK_MOSI'],count = count, increment = False)
        
    
    
    
    async def read_lane_17_loopback_mosi_read_size(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LANE_17_LOOPBACK_MOSI_READ_SIZE'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_lane_17_loopback_mosi_read_size_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LANE_17_LOOPBACK_MOSI_READ_SIZE'],count = count, increment = True)
        
    
    
    
    async def read_lane_18_loopback_mosi(self, count : int = 1 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LANE_18_LOOPBACK_MOSI'],count = count, increment = False , targetQueue = targetQueue), 'little') 
        
    
    async def read_lane_18_loopback_mosi_raw(self, count : int = 1 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LANE_18_LOOPBACK_MOSI'],count = count, increment = False)
        
    
    
    
    async def read_lane_18_loopback_mosi_read_size(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LANE_18_LOOPBACK_MOSI_READ_SIZE'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_lane_18_loopback_mosi_read_size_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LANE_18_LOOPBACK_MOSI_READ_SIZE'],count = count, increment = True)
        
    
    
    
    async def read_lane_19_loopback_mosi(self, count : int = 1 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LANE_19_LOOPBACK_MOSI'],count = count, increment = False , targetQueue = targetQueue), 'little') 
        
    
    async def read_lane_19_loopback_mosi_raw(self, count : int = 1 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LANE_19_LOOPBACK_MOSI'],count = count, increment = False)
        
    
    
    
    async def read_lane_19_loopback_mosi_read_size(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LANE_19_LOOPBACK_MOSI_READ_SIZE'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_lane_19_loopback_mosi_read_size_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LANE_19_LOOPBACK_MOSI_READ_SIZE'],count = count, increment = True)
        
    
    
    
    async def write_lanes_cfg_frame_tag_counter_ctrl(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LANES_CFG_FRAME_TAG_COUNTER_CTRL'],value = value,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    async def read_lanes_cfg_frame_tag_counter_ctrl(self, count : int = 1 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LANES_CFG_FRAME_TAG_COUNTER_CTRL'],count = count, increment = False , targetQueue = targetQueue), 'little') 
        
    
    async def read_lanes_cfg_frame_tag_counter_ctrl_raw(self, count : int = 1 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LANES_CFG_FRAME_TAG_COUNTER_CTRL'],count = count, increment = False)
        
    
    
    
    async def write_lanes_cfg_frame_tag_counter_trigger(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LANES_CFG_FRAME_TAG_COUNTER_TRIGGER'],value = value,increment = True,valueLength=4)
        if flush == True:
            await self.flush()
        
    
    async def read_lanes_cfg_frame_tag_counter_trigger(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LANES_CFG_FRAME_TAG_COUNTER_TRIGGER'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_lanes_cfg_frame_tag_counter_trigger_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LANES_CFG_FRAME_TAG_COUNTER_TRIGGER'],count = count, increment = True)
        
    
    
    
    async def write_lanes_cfg_frame_tag_counter(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LANES_CFG_FRAME_TAG_COUNTER'],value = value,increment = True,valueLength=4)
        if flush == True:
            await self.flush()
        
    
    async def read_lanes_cfg_frame_tag_counter(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LANES_CFG_FRAME_TAG_COUNTER'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_lanes_cfg_frame_tag_counter_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LANES_CFG_FRAME_TAG_COUNTER'],count = count, increment = True)
        
    
    
    
    async def write_lanes_cfg_nodata_continue(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LANES_CFG_NODATA_CONTINUE'],value = value,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    async def read_lanes_cfg_nodata_continue(self, count : int = 1 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LANES_CFG_NODATA_CONTINUE'],count = count, increment = False , targetQueue = targetQueue), 'little') 
        
    
    async def read_lanes_cfg_nodata_continue_raw(self, count : int = 1 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LANES_CFG_NODATA_CONTINUE'],count = count, increment = False)
        
    
    
    
    async def write_lanes_sr_out(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LANES_SR_OUT'],value = value,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    async def read_lanes_sr_out(self, count : int = 1 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LANES_SR_OUT'],count = count, increment = False , targetQueue = targetQueue), 'little') 
        
    
    async def read_lanes_sr_out_raw(self, count : int = 1 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LANES_SR_OUT'],count = count, increment = False)
        
    
    
    
    async def write_lanes_sr_in(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LANES_SR_IN'],value = value,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    async def read_lanes_sr_in(self, count : int = 1 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LANES_SR_IN'],count = count, increment = False , targetQueue = targetQueue), 'little') 
        
    
    async def read_lanes_sr_in_raw(self, count : int = 1 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LANES_SR_IN'],count = count, increment = False)
        
    
    
    
    async def write_lanes_inj_ctrl(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LANES_INJ_CTRL'],value = value,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    async def read_lanes_inj_ctrl(self, count : int = 1 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LANES_INJ_CTRL'],count = count, increment = False , targetQueue = targetQueue), 'little') 
        
    
    async def read_lanes_inj_ctrl_raw(self, count : int = 1 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LANES_INJ_CTRL'],count = count, increment = False)
        
    
    
    
    async def write_lanes_inj_waddr(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LANES_INJ_WADDR'],value = value,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    async def read_lanes_inj_waddr(self, count : int = 0 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LANES_INJ_WADDR'],count = count, increment = False , targetQueue = targetQueue), 'little') 
        
    
    async def read_lanes_inj_waddr_raw(self, count : int = 0 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LANES_INJ_WADDR'],count = count, increment = False)
        
    
    
    
    async def write_lanes_inj_wdata(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LANES_INJ_WDATA'],value = value,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    async def read_lanes_inj_wdata(self, count : int = 1 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LANES_INJ_WDATA'],count = count, increment = False , targetQueue = targetQueue), 'little') 
        
    
    async def read_lanes_inj_wdata_raw(self, count : int = 1 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LANES_INJ_WDATA'],count = count, increment = False)
        
    
    
    
    async def read_lanes_readout(self, count : int = 1 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LANES_READOUT'],count = count, increment = False , targetQueue = targetQueue), 'little') 
        
    
    async def read_lanes_readout_raw(self, count : int = 1 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LANES_READOUT'],count = count, increment = False)
        
    
    
    
    async def read_lanes_readout_read_size(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LANES_READOUT_READ_SIZE'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_lanes_readout_read_size_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LANES_READOUT_READ_SIZE'],count = count, increment = True)
        
    
    
    
    async def write_io_ctrl(self,value : int,flush = False):
        self.addWrite(register = self.Registers['IO_CTRL'],value = value,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    async def read_io_ctrl(self, count : int = 1 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['IO_CTRL'],count = count, increment = False , targetQueue = targetQueue), 'little') 
        
    
    async def read_io_ctrl_raw(self, count : int = 1 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['IO_CTRL'],count = count, increment = False)
        
    
    
    
    async def write_io_led(self,value : int,flush = False):
        self.addWrite(register = self.Registers['IO_LED'],value = value,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    async def read_io_led(self, count : int = 1 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['IO_LED'],count = count, increment = False , targetQueue = targetQueue), 'little') 
        
    
    async def read_io_led_raw(self, count : int = 1 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['IO_LED'],count = count, increment = False)
        
    
    
    
    async def write_gecco_sr_ctrl(self,value : int,flush = False):
        self.addWrite(register = self.Registers['GECCO_SR_CTRL'],value = value,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    async def read_gecco_sr_ctrl(self, count : int = 1 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['GECCO_SR_CTRL'],count = count, increment = False , targetQueue = targetQueue), 'little') 
        
    
    async def read_gecco_sr_ctrl_raw(self, count : int = 1 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['GECCO_SR_CTRL'],count = count, increment = False)
        
    
    
    
    async def write_hk_conversion_trigger_match(self,value : int,flush = False):
        self.addWrite(register = self.Registers['HK_CONVERSION_TRIGGER_MATCH'],value = value,increment = True,valueLength=4)
        if flush == True:
            await self.flush()
        
    
    async def read_hk_conversion_trigger_match(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['HK_CONVERSION_TRIGGER_MATCH'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_hk_conversion_trigger_match_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['HK_CONVERSION_TRIGGER_MATCH'],count = count, increment = True)
        
    
    
    
    async def write_lanes_cfg_frame_tag_counter_trigger_match(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LANES_CFG_FRAME_TAG_COUNTER_TRIGGER_MATCH'],value = value,increment = True,valueLength=4)
        if flush == True:
            await self.flush()
        
    
    async def read_lanes_cfg_frame_tag_counter_trigger_match(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LANES_CFG_FRAME_TAG_COUNTER_TRIGGER_MATCH'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_lanes_cfg_frame_tag_counter_trigger_match_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LANES_CFG_FRAME_TAG_COUNTER_TRIGGER_MATCH'],count = count, increment = True)
        
    
