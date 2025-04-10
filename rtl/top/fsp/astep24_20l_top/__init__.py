

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
SPI_LAYERS_CKDIVIDER = 0x1b
SPI_HK_CKDIVIDER = 0x1c
LAYER_0_CFG_CTRL = 0x1d
LAYER_1_CFG_CTRL = 0x1e
LAYER_2_CFG_CTRL = 0x1f
LAYER_3_CFG_CTRL = 0x20
LAYER_4_CFG_CTRL = 0x21
LAYER_5_CFG_CTRL = 0x22
LAYER_6_CFG_CTRL = 0x23
LAYER_7_CFG_CTRL = 0x24
LAYER_8_CFG_CTRL = 0x25
LAYER_9_CFG_CTRL = 0x26
LAYER_10_CFG_CTRL = 0x27
LAYER_11_CFG_CTRL = 0x28
LAYER_12_CFG_CTRL = 0x29
LAYER_13_CFG_CTRL = 0x2a
LAYER_14_CFG_CTRL = 0x2b
LAYER_15_CFG_CTRL = 0x2c
LAYER_16_CFG_CTRL = 0x2d
LAYER_17_CFG_CTRL = 0x2e
LAYER_18_CFG_CTRL = 0x2f
LAYER_19_CFG_CTRL = 0x30
LAYER_0_STATUS = 0x31
LAYER_1_STATUS = 0x32
LAYER_2_STATUS = 0x33
LAYER_3_STATUS = 0x34
LAYER_4_STATUS = 0x35
LAYER_5_STATUS = 0x36
LAYER_6_STATUS = 0x37
LAYER_7_STATUS = 0x38
LAYER_8_STATUS = 0x39
LAYER_9_STATUS = 0x3a
LAYER_10_STATUS = 0x3b
LAYER_11_STATUS = 0x3c
LAYER_12_STATUS = 0x3d
LAYER_13_STATUS = 0x3e
LAYER_14_STATUS = 0x3f
LAYER_15_STATUS = 0x40
LAYER_16_STATUS = 0x41
LAYER_17_STATUS = 0x42
LAYER_18_STATUS = 0x43
LAYER_19_STATUS = 0x44
LAYER_0_STAT_FRAME_COUNTER = 0x45
LAYER_1_STAT_FRAME_COUNTER = 0x49
LAYER_2_STAT_FRAME_COUNTER = 0x4d
LAYER_3_STAT_FRAME_COUNTER = 0x51
LAYER_4_STAT_FRAME_COUNTER = 0x55
LAYER_5_STAT_FRAME_COUNTER = 0x59
LAYER_6_STAT_FRAME_COUNTER = 0x5d
LAYER_7_STAT_FRAME_COUNTER = 0x61
LAYER_8_STAT_FRAME_COUNTER = 0x65
LAYER_9_STAT_FRAME_COUNTER = 0x69
LAYER_10_STAT_FRAME_COUNTER = 0x6d
LAYER_11_STAT_FRAME_COUNTER = 0x71
LAYER_12_STAT_FRAME_COUNTER = 0x75
LAYER_13_STAT_FRAME_COUNTER = 0x79
LAYER_14_STAT_FRAME_COUNTER = 0x7d
LAYER_15_STAT_FRAME_COUNTER = 0x81
LAYER_16_STAT_FRAME_COUNTER = 0x85
LAYER_17_STAT_FRAME_COUNTER = 0x89
LAYER_18_STAT_FRAME_COUNTER = 0x8d
LAYER_19_STAT_FRAME_COUNTER = 0x91
LAYER_0_STAT_IDLE_COUNTER = 0x95
LAYER_1_STAT_IDLE_COUNTER = 0x99
LAYER_2_STAT_IDLE_COUNTER = 0x9d
LAYER_3_STAT_IDLE_COUNTER = 0xa1
LAYER_4_STAT_IDLE_COUNTER = 0xa5
LAYER_5_STAT_IDLE_COUNTER = 0xa9
LAYER_6_STAT_IDLE_COUNTER = 0xad
LAYER_7_STAT_IDLE_COUNTER = 0xb1
LAYER_8_STAT_IDLE_COUNTER = 0xb5
LAYER_9_STAT_IDLE_COUNTER = 0xb9
LAYER_10_STAT_IDLE_COUNTER = 0xbd
LAYER_11_STAT_IDLE_COUNTER = 0xc1
LAYER_12_STAT_IDLE_COUNTER = 0xc5
LAYER_13_STAT_IDLE_COUNTER = 0xc9
LAYER_14_STAT_IDLE_COUNTER = 0xcd
LAYER_15_STAT_IDLE_COUNTER = 0xd1
LAYER_16_STAT_IDLE_COUNTER = 0xd5
LAYER_17_STAT_IDLE_COUNTER = 0xd9
LAYER_18_STAT_IDLE_COUNTER = 0xdd
LAYER_19_STAT_IDLE_COUNTER = 0xe1
LAYER_0_MOSI = 0xe5
LAYER_0_MOSI_WRITE_SIZE = 0xe6
LAYER_1_MOSI = 0xea
LAYER_1_MOSI_WRITE_SIZE = 0xeb
LAYER_2_MOSI = 0xef
LAYER_2_MOSI_WRITE_SIZE = 0xf0
LAYER_3_MOSI = 0xf4
LAYER_3_MOSI_WRITE_SIZE = 0xf5
LAYER_4_MOSI = 0xf9
LAYER_4_MOSI_WRITE_SIZE = 0xfa
LAYER_5_MOSI = 0xfe
LAYER_5_MOSI_WRITE_SIZE = 0xff
LAYER_6_MOSI = 0x103
LAYER_6_MOSI_WRITE_SIZE = 0x104
LAYER_7_MOSI = 0x108
LAYER_7_MOSI_WRITE_SIZE = 0x109
LAYER_8_MOSI = 0x10d
LAYER_8_MOSI_WRITE_SIZE = 0x10e
LAYER_9_MOSI = 0x112
LAYER_9_MOSI_WRITE_SIZE = 0x113
LAYER_10_MOSI = 0x117
LAYER_10_MOSI_WRITE_SIZE = 0x118
LAYER_11_MOSI = 0x11c
LAYER_11_MOSI_WRITE_SIZE = 0x11d
LAYER_12_MOSI = 0x121
LAYER_12_MOSI_WRITE_SIZE = 0x122
LAYER_13_MOSI = 0x126
LAYER_13_MOSI_WRITE_SIZE = 0x127
LAYER_14_MOSI = 0x12b
LAYER_14_MOSI_WRITE_SIZE = 0x12c
LAYER_15_MOSI = 0x130
LAYER_15_MOSI_WRITE_SIZE = 0x131
LAYER_16_MOSI = 0x135
LAYER_16_MOSI_WRITE_SIZE = 0x136
LAYER_17_MOSI = 0x13a
LAYER_17_MOSI_WRITE_SIZE = 0x13b
LAYER_18_MOSI = 0x13f
LAYER_18_MOSI_WRITE_SIZE = 0x140
LAYER_19_MOSI = 0x144
LAYER_19_MOSI_WRITE_SIZE = 0x145
LAYER_0_LOOPBACK_MISO = 0x149
LAYER_0_LOOPBACK_MISO_WRITE_SIZE = 0x14a
LAYER_1_LOOPBACK_MISO = 0x14e
LAYER_1_LOOPBACK_MISO_WRITE_SIZE = 0x14f
LAYER_2_LOOPBACK_MISO = 0x153
LAYER_2_LOOPBACK_MISO_WRITE_SIZE = 0x154
LAYER_3_LOOPBACK_MISO = 0x158
LAYER_3_LOOPBACK_MISO_WRITE_SIZE = 0x159
LAYER_4_LOOPBACK_MISO = 0x15d
LAYER_4_LOOPBACK_MISO_WRITE_SIZE = 0x15e
LAYER_5_LOOPBACK_MISO = 0x162
LAYER_5_LOOPBACK_MISO_WRITE_SIZE = 0x163
LAYER_6_LOOPBACK_MISO = 0x167
LAYER_6_LOOPBACK_MISO_WRITE_SIZE = 0x168
LAYER_7_LOOPBACK_MISO = 0x16c
LAYER_7_LOOPBACK_MISO_WRITE_SIZE = 0x16d
LAYER_8_LOOPBACK_MISO = 0x171
LAYER_8_LOOPBACK_MISO_WRITE_SIZE = 0x172
LAYER_9_LOOPBACK_MISO = 0x176
LAYER_9_LOOPBACK_MISO_WRITE_SIZE = 0x177
LAYER_10_LOOPBACK_MISO = 0x17b
LAYER_10_LOOPBACK_MISO_WRITE_SIZE = 0x17c
LAYER_11_LOOPBACK_MISO = 0x180
LAYER_11_LOOPBACK_MISO_WRITE_SIZE = 0x181
LAYER_12_LOOPBACK_MISO = 0x185
LAYER_12_LOOPBACK_MISO_WRITE_SIZE = 0x186
LAYER_13_LOOPBACK_MISO = 0x18a
LAYER_13_LOOPBACK_MISO_WRITE_SIZE = 0x18b
LAYER_14_LOOPBACK_MISO = 0x18f
LAYER_14_LOOPBACK_MISO_WRITE_SIZE = 0x190
LAYER_15_LOOPBACK_MISO = 0x194
LAYER_15_LOOPBACK_MISO_WRITE_SIZE = 0x195
LAYER_16_LOOPBACK_MISO = 0x199
LAYER_16_LOOPBACK_MISO_WRITE_SIZE = 0x19a
LAYER_17_LOOPBACK_MISO = 0x19e
LAYER_17_LOOPBACK_MISO_WRITE_SIZE = 0x19f
LAYER_18_LOOPBACK_MISO = 0x1a3
LAYER_18_LOOPBACK_MISO_WRITE_SIZE = 0x1a4
LAYER_19_LOOPBACK_MISO = 0x1a8
LAYER_19_LOOPBACK_MISO_WRITE_SIZE = 0x1a9
LAYER_0_LOOPBACK_MOSI = 0x1ad
LAYER_0_LOOPBACK_MOSI_READ_SIZE = 0x1ae
LAYER_1_LOOPBACK_MOSI = 0x1b2
LAYER_1_LOOPBACK_MOSI_READ_SIZE = 0x1b3
LAYER_2_LOOPBACK_MOSI = 0x1b7
LAYER_2_LOOPBACK_MOSI_READ_SIZE = 0x1b8
LAYER_3_LOOPBACK_MOSI = 0x1bc
LAYER_3_LOOPBACK_MOSI_READ_SIZE = 0x1bd
LAYER_4_LOOPBACK_MOSI = 0x1c1
LAYER_4_LOOPBACK_MOSI_READ_SIZE = 0x1c2
LAYER_5_LOOPBACK_MOSI = 0x1c6
LAYER_5_LOOPBACK_MOSI_READ_SIZE = 0x1c7
LAYER_6_LOOPBACK_MOSI = 0x1cb
LAYER_6_LOOPBACK_MOSI_READ_SIZE = 0x1cc
LAYER_7_LOOPBACK_MOSI = 0x1d0
LAYER_7_LOOPBACK_MOSI_READ_SIZE = 0x1d1
LAYER_8_LOOPBACK_MOSI = 0x1d5
LAYER_8_LOOPBACK_MOSI_READ_SIZE = 0x1d6
LAYER_9_LOOPBACK_MOSI = 0x1da
LAYER_9_LOOPBACK_MOSI_READ_SIZE = 0x1db
LAYER_10_LOOPBACK_MOSI = 0x1df
LAYER_10_LOOPBACK_MOSI_READ_SIZE = 0x1e0
LAYER_11_LOOPBACK_MOSI = 0x1e4
LAYER_11_LOOPBACK_MOSI_READ_SIZE = 0x1e5
LAYER_12_LOOPBACK_MOSI = 0x1e9
LAYER_12_LOOPBACK_MOSI_READ_SIZE = 0x1ea
LAYER_13_LOOPBACK_MOSI = 0x1ee
LAYER_13_LOOPBACK_MOSI_READ_SIZE = 0x1ef
LAYER_14_LOOPBACK_MOSI = 0x1f3
LAYER_14_LOOPBACK_MOSI_READ_SIZE = 0x1f4
LAYER_15_LOOPBACK_MOSI = 0x1f8
LAYER_15_LOOPBACK_MOSI_READ_SIZE = 0x1f9
LAYER_16_LOOPBACK_MOSI = 0x1fd
LAYER_16_LOOPBACK_MOSI_READ_SIZE = 0x1fe
LAYER_17_LOOPBACK_MOSI = 0x202
LAYER_17_LOOPBACK_MOSI_READ_SIZE = 0x203
LAYER_18_LOOPBACK_MOSI = 0x207
LAYER_18_LOOPBACK_MOSI_READ_SIZE = 0x208
LAYER_19_LOOPBACK_MOSI = 0x20c
LAYER_19_LOOPBACK_MOSI_READ_SIZE = 0x20d
LAYERS_CFG_FRAME_TAG_COUNTER_CTRL = 0x211
LAYERS_CFG_FRAME_TAG_COUNTER_TRIGGER = 0x212
LAYERS_CFG_FRAME_TAG_COUNTER = 0x216
LAYERS_CFG_NODATA_CONTINUE = 0x21a
LAYERS_SR_OUT = 0x21b
LAYERS_SR_IN = 0x21c
LAYERS_INJ_CTRL = 0x21d
LAYERS_INJ_WADDR = 0x21e
LAYERS_INJ_WDATA = 0x21f
LAYERS_READOUT = 0x220
LAYERS_READOUT_READ_SIZE = 0x221
IO_CTRL = 0x225
IO_LED = 0x226
GECCO_SR_CTRL = 0x227
HK_CONVERSION_TRIGGER_MATCH = 0x228
LAYERS_CFG_FRAME_TAG_COUNTER_TRIGGER_MATCH = 0x22c




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
        SPI_LAYERS_CKDIVIDER = 0x1b
        SPI_HK_CKDIVIDER = 0x1c
        LAYER_0_CFG_CTRL = 0x1d
        LAYER_1_CFG_CTRL = 0x1e
        LAYER_2_CFG_CTRL = 0x1f
        LAYER_3_CFG_CTRL = 0x20
        LAYER_4_CFG_CTRL = 0x21
        LAYER_5_CFG_CTRL = 0x22
        LAYER_6_CFG_CTRL = 0x23
        LAYER_7_CFG_CTRL = 0x24
        LAYER_8_CFG_CTRL = 0x25
        LAYER_9_CFG_CTRL = 0x26
        LAYER_10_CFG_CTRL = 0x27
        LAYER_11_CFG_CTRL = 0x28
        LAYER_12_CFG_CTRL = 0x29
        LAYER_13_CFG_CTRL = 0x2a
        LAYER_14_CFG_CTRL = 0x2b
        LAYER_15_CFG_CTRL = 0x2c
        LAYER_16_CFG_CTRL = 0x2d
        LAYER_17_CFG_CTRL = 0x2e
        LAYER_18_CFG_CTRL = 0x2f
        LAYER_19_CFG_CTRL = 0x30
        LAYER_0_STATUS = 0x31
        LAYER_1_STATUS = 0x32
        LAYER_2_STATUS = 0x33
        LAYER_3_STATUS = 0x34
        LAYER_4_STATUS = 0x35
        LAYER_5_STATUS = 0x36
        LAYER_6_STATUS = 0x37
        LAYER_7_STATUS = 0x38
        LAYER_8_STATUS = 0x39
        LAYER_9_STATUS = 0x3a
        LAYER_10_STATUS = 0x3b
        LAYER_11_STATUS = 0x3c
        LAYER_12_STATUS = 0x3d
        LAYER_13_STATUS = 0x3e
        LAYER_14_STATUS = 0x3f
        LAYER_15_STATUS = 0x40
        LAYER_16_STATUS = 0x41
        LAYER_17_STATUS = 0x42
        LAYER_18_STATUS = 0x43
        LAYER_19_STATUS = 0x44
        LAYER_0_STAT_FRAME_COUNTER = 0x45
        LAYER_1_STAT_FRAME_COUNTER = 0x49
        LAYER_2_STAT_FRAME_COUNTER = 0x4d
        LAYER_3_STAT_FRAME_COUNTER = 0x51
        LAYER_4_STAT_FRAME_COUNTER = 0x55
        LAYER_5_STAT_FRAME_COUNTER = 0x59
        LAYER_6_STAT_FRAME_COUNTER = 0x5d
        LAYER_7_STAT_FRAME_COUNTER = 0x61
        LAYER_8_STAT_FRAME_COUNTER = 0x65
        LAYER_9_STAT_FRAME_COUNTER = 0x69
        LAYER_10_STAT_FRAME_COUNTER = 0x6d
        LAYER_11_STAT_FRAME_COUNTER = 0x71
        LAYER_12_STAT_FRAME_COUNTER = 0x75
        LAYER_13_STAT_FRAME_COUNTER = 0x79
        LAYER_14_STAT_FRAME_COUNTER = 0x7d
        LAYER_15_STAT_FRAME_COUNTER = 0x81
        LAYER_16_STAT_FRAME_COUNTER = 0x85
        LAYER_17_STAT_FRAME_COUNTER = 0x89
        LAYER_18_STAT_FRAME_COUNTER = 0x8d
        LAYER_19_STAT_FRAME_COUNTER = 0x91
        LAYER_0_STAT_IDLE_COUNTER = 0x95
        LAYER_1_STAT_IDLE_COUNTER = 0x99
        LAYER_2_STAT_IDLE_COUNTER = 0x9d
        LAYER_3_STAT_IDLE_COUNTER = 0xa1
        LAYER_4_STAT_IDLE_COUNTER = 0xa5
        LAYER_5_STAT_IDLE_COUNTER = 0xa9
        LAYER_6_STAT_IDLE_COUNTER = 0xad
        LAYER_7_STAT_IDLE_COUNTER = 0xb1
        LAYER_8_STAT_IDLE_COUNTER = 0xb5
        LAYER_9_STAT_IDLE_COUNTER = 0xb9
        LAYER_10_STAT_IDLE_COUNTER = 0xbd
        LAYER_11_STAT_IDLE_COUNTER = 0xc1
        LAYER_12_STAT_IDLE_COUNTER = 0xc5
        LAYER_13_STAT_IDLE_COUNTER = 0xc9
        LAYER_14_STAT_IDLE_COUNTER = 0xcd
        LAYER_15_STAT_IDLE_COUNTER = 0xd1
        LAYER_16_STAT_IDLE_COUNTER = 0xd5
        LAYER_17_STAT_IDLE_COUNTER = 0xd9
        LAYER_18_STAT_IDLE_COUNTER = 0xdd
        LAYER_19_STAT_IDLE_COUNTER = 0xe1
        LAYER_0_MOSI = 0xe5
        LAYER_0_MOSI_WRITE_SIZE = 0xe6
        LAYER_1_MOSI = 0xea
        LAYER_1_MOSI_WRITE_SIZE = 0xeb
        LAYER_2_MOSI = 0xef
        LAYER_2_MOSI_WRITE_SIZE = 0xf0
        LAYER_3_MOSI = 0xf4
        LAYER_3_MOSI_WRITE_SIZE = 0xf5
        LAYER_4_MOSI = 0xf9
        LAYER_4_MOSI_WRITE_SIZE = 0xfa
        LAYER_5_MOSI = 0xfe
        LAYER_5_MOSI_WRITE_SIZE = 0xff
        LAYER_6_MOSI = 0x103
        LAYER_6_MOSI_WRITE_SIZE = 0x104
        LAYER_7_MOSI = 0x108
        LAYER_7_MOSI_WRITE_SIZE = 0x109
        LAYER_8_MOSI = 0x10d
        LAYER_8_MOSI_WRITE_SIZE = 0x10e
        LAYER_9_MOSI = 0x112
        LAYER_9_MOSI_WRITE_SIZE = 0x113
        LAYER_10_MOSI = 0x117
        LAYER_10_MOSI_WRITE_SIZE = 0x118
        LAYER_11_MOSI = 0x11c
        LAYER_11_MOSI_WRITE_SIZE = 0x11d
        LAYER_12_MOSI = 0x121
        LAYER_12_MOSI_WRITE_SIZE = 0x122
        LAYER_13_MOSI = 0x126
        LAYER_13_MOSI_WRITE_SIZE = 0x127
        LAYER_14_MOSI = 0x12b
        LAYER_14_MOSI_WRITE_SIZE = 0x12c
        LAYER_15_MOSI = 0x130
        LAYER_15_MOSI_WRITE_SIZE = 0x131
        LAYER_16_MOSI = 0x135
        LAYER_16_MOSI_WRITE_SIZE = 0x136
        LAYER_17_MOSI = 0x13a
        LAYER_17_MOSI_WRITE_SIZE = 0x13b
        LAYER_18_MOSI = 0x13f
        LAYER_18_MOSI_WRITE_SIZE = 0x140
        LAYER_19_MOSI = 0x144
        LAYER_19_MOSI_WRITE_SIZE = 0x145
        LAYER_0_LOOPBACK_MISO = 0x149
        LAYER_0_LOOPBACK_MISO_WRITE_SIZE = 0x14a
        LAYER_1_LOOPBACK_MISO = 0x14e
        LAYER_1_LOOPBACK_MISO_WRITE_SIZE = 0x14f
        LAYER_2_LOOPBACK_MISO = 0x153
        LAYER_2_LOOPBACK_MISO_WRITE_SIZE = 0x154
        LAYER_3_LOOPBACK_MISO = 0x158
        LAYER_3_LOOPBACK_MISO_WRITE_SIZE = 0x159
        LAYER_4_LOOPBACK_MISO = 0x15d
        LAYER_4_LOOPBACK_MISO_WRITE_SIZE = 0x15e
        LAYER_5_LOOPBACK_MISO = 0x162
        LAYER_5_LOOPBACK_MISO_WRITE_SIZE = 0x163
        LAYER_6_LOOPBACK_MISO = 0x167
        LAYER_6_LOOPBACK_MISO_WRITE_SIZE = 0x168
        LAYER_7_LOOPBACK_MISO = 0x16c
        LAYER_7_LOOPBACK_MISO_WRITE_SIZE = 0x16d
        LAYER_8_LOOPBACK_MISO = 0x171
        LAYER_8_LOOPBACK_MISO_WRITE_SIZE = 0x172
        LAYER_9_LOOPBACK_MISO = 0x176
        LAYER_9_LOOPBACK_MISO_WRITE_SIZE = 0x177
        LAYER_10_LOOPBACK_MISO = 0x17b
        LAYER_10_LOOPBACK_MISO_WRITE_SIZE = 0x17c
        LAYER_11_LOOPBACK_MISO = 0x180
        LAYER_11_LOOPBACK_MISO_WRITE_SIZE = 0x181
        LAYER_12_LOOPBACK_MISO = 0x185
        LAYER_12_LOOPBACK_MISO_WRITE_SIZE = 0x186
        LAYER_13_LOOPBACK_MISO = 0x18a
        LAYER_13_LOOPBACK_MISO_WRITE_SIZE = 0x18b
        LAYER_14_LOOPBACK_MISO = 0x18f
        LAYER_14_LOOPBACK_MISO_WRITE_SIZE = 0x190
        LAYER_15_LOOPBACK_MISO = 0x194
        LAYER_15_LOOPBACK_MISO_WRITE_SIZE = 0x195
        LAYER_16_LOOPBACK_MISO = 0x199
        LAYER_16_LOOPBACK_MISO_WRITE_SIZE = 0x19a
        LAYER_17_LOOPBACK_MISO = 0x19e
        LAYER_17_LOOPBACK_MISO_WRITE_SIZE = 0x19f
        LAYER_18_LOOPBACK_MISO = 0x1a3
        LAYER_18_LOOPBACK_MISO_WRITE_SIZE = 0x1a4
        LAYER_19_LOOPBACK_MISO = 0x1a8
        LAYER_19_LOOPBACK_MISO_WRITE_SIZE = 0x1a9
        LAYER_0_LOOPBACK_MOSI = 0x1ad
        LAYER_0_LOOPBACK_MOSI_READ_SIZE = 0x1ae
        LAYER_1_LOOPBACK_MOSI = 0x1b2
        LAYER_1_LOOPBACK_MOSI_READ_SIZE = 0x1b3
        LAYER_2_LOOPBACK_MOSI = 0x1b7
        LAYER_2_LOOPBACK_MOSI_READ_SIZE = 0x1b8
        LAYER_3_LOOPBACK_MOSI = 0x1bc
        LAYER_3_LOOPBACK_MOSI_READ_SIZE = 0x1bd
        LAYER_4_LOOPBACK_MOSI = 0x1c1
        LAYER_4_LOOPBACK_MOSI_READ_SIZE = 0x1c2
        LAYER_5_LOOPBACK_MOSI = 0x1c6
        LAYER_5_LOOPBACK_MOSI_READ_SIZE = 0x1c7
        LAYER_6_LOOPBACK_MOSI = 0x1cb
        LAYER_6_LOOPBACK_MOSI_READ_SIZE = 0x1cc
        LAYER_7_LOOPBACK_MOSI = 0x1d0
        LAYER_7_LOOPBACK_MOSI_READ_SIZE = 0x1d1
        LAYER_8_LOOPBACK_MOSI = 0x1d5
        LAYER_8_LOOPBACK_MOSI_READ_SIZE = 0x1d6
        LAYER_9_LOOPBACK_MOSI = 0x1da
        LAYER_9_LOOPBACK_MOSI_READ_SIZE = 0x1db
        LAYER_10_LOOPBACK_MOSI = 0x1df
        LAYER_10_LOOPBACK_MOSI_READ_SIZE = 0x1e0
        LAYER_11_LOOPBACK_MOSI = 0x1e4
        LAYER_11_LOOPBACK_MOSI_READ_SIZE = 0x1e5
        LAYER_12_LOOPBACK_MOSI = 0x1e9
        LAYER_12_LOOPBACK_MOSI_READ_SIZE = 0x1ea
        LAYER_13_LOOPBACK_MOSI = 0x1ee
        LAYER_13_LOOPBACK_MOSI_READ_SIZE = 0x1ef
        LAYER_14_LOOPBACK_MOSI = 0x1f3
        LAYER_14_LOOPBACK_MOSI_READ_SIZE = 0x1f4
        LAYER_15_LOOPBACK_MOSI = 0x1f8
        LAYER_15_LOOPBACK_MOSI_READ_SIZE = 0x1f9
        LAYER_16_LOOPBACK_MOSI = 0x1fd
        LAYER_16_LOOPBACK_MOSI_READ_SIZE = 0x1fe
        LAYER_17_LOOPBACK_MOSI = 0x202
        LAYER_17_LOOPBACK_MOSI_READ_SIZE = 0x203
        LAYER_18_LOOPBACK_MOSI = 0x207
        LAYER_18_LOOPBACK_MOSI_READ_SIZE = 0x208
        LAYER_19_LOOPBACK_MOSI = 0x20c
        LAYER_19_LOOPBACK_MOSI_READ_SIZE = 0x20d
        LAYERS_CFG_FRAME_TAG_COUNTER_CTRL = 0x211
        LAYERS_CFG_FRAME_TAG_COUNTER_TRIGGER = 0x212
        LAYERS_CFG_FRAME_TAG_COUNTER = 0x216
        LAYERS_CFG_NODATA_CONTINUE = 0x21a
        LAYERS_SR_OUT = 0x21b
        LAYERS_SR_IN = 0x21c
        LAYERS_INJ_CTRL = 0x21d
        LAYERS_INJ_WADDR = 0x21e
        LAYERS_INJ_WDATA = 0x21f
        LAYERS_READOUT = 0x220
        LAYERS_READOUT_READ_SIZE = 0x221
        IO_CTRL = 0x225
        IO_LED = 0x226
        GECCO_SR_CTRL = 0x227
        HK_CONVERSION_TRIGGER_MATCH = 0x228
        LAYERS_CFG_FRAME_TAG_COUNTER_TRIGGER_MATCH = 0x22c
    
    
    
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
        
    
    
    
    async def write_spi_layers_ckdivider(self,value : int,flush = False):
        self.addWrite(register = self.Registers['SPI_LAYERS_CKDIVIDER'],value = value,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    async def read_spi_layers_ckdivider(self, count : int = 1 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['SPI_LAYERS_CKDIVIDER'],count = count, increment = False , targetQueue = targetQueue), 'little') 
        
    
    async def read_spi_layers_ckdivider_raw(self, count : int = 1 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['SPI_LAYERS_CKDIVIDER'],count = count, increment = False)
        
    
    
    
    async def write_spi_hk_ckdivider(self,value : int,flush = False):
        self.addWrite(register = self.Registers['SPI_HK_CKDIVIDER'],value = value,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    async def read_spi_hk_ckdivider(self, count : int = 1 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['SPI_HK_CKDIVIDER'],count = count, increment = False , targetQueue = targetQueue), 'little') 
        
    
    async def read_spi_hk_ckdivider_raw(self, count : int = 1 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['SPI_HK_CKDIVIDER'],count = count, increment = False)
        
    
    
    
    async def write_layer_0_cfg_ctrl(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LAYER_0_CFG_CTRL'],value = value,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    async def read_layer_0_cfg_ctrl(self, count : int = 1 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LAYER_0_CFG_CTRL'],count = count, increment = False , targetQueue = targetQueue), 'little') 
        
    
    async def read_layer_0_cfg_ctrl_raw(self, count : int = 1 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LAYER_0_CFG_CTRL'],count = count, increment = False)
        
    
    
    
    async def write_layer_1_cfg_ctrl(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LAYER_1_CFG_CTRL'],value = value,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    async def read_layer_1_cfg_ctrl(self, count : int = 1 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LAYER_1_CFG_CTRL'],count = count, increment = False , targetQueue = targetQueue), 'little') 
        
    
    async def read_layer_1_cfg_ctrl_raw(self, count : int = 1 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LAYER_1_CFG_CTRL'],count = count, increment = False)
        
    
    
    
    async def write_layer_2_cfg_ctrl(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LAYER_2_CFG_CTRL'],value = value,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    async def read_layer_2_cfg_ctrl(self, count : int = 1 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LAYER_2_CFG_CTRL'],count = count, increment = False , targetQueue = targetQueue), 'little') 
        
    
    async def read_layer_2_cfg_ctrl_raw(self, count : int = 1 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LAYER_2_CFG_CTRL'],count = count, increment = False)
        
    
    
    
    async def write_layer_3_cfg_ctrl(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LAYER_3_CFG_CTRL'],value = value,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    async def read_layer_3_cfg_ctrl(self, count : int = 1 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LAYER_3_CFG_CTRL'],count = count, increment = False , targetQueue = targetQueue), 'little') 
        
    
    async def read_layer_3_cfg_ctrl_raw(self, count : int = 1 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LAYER_3_CFG_CTRL'],count = count, increment = False)
        
    
    
    
    async def write_layer_4_cfg_ctrl(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LAYER_4_CFG_CTRL'],value = value,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    async def read_layer_4_cfg_ctrl(self, count : int = 1 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LAYER_4_CFG_CTRL'],count = count, increment = False , targetQueue = targetQueue), 'little') 
        
    
    async def read_layer_4_cfg_ctrl_raw(self, count : int = 1 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LAYER_4_CFG_CTRL'],count = count, increment = False)
        
    
    
    
    async def write_layer_5_cfg_ctrl(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LAYER_5_CFG_CTRL'],value = value,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    async def read_layer_5_cfg_ctrl(self, count : int = 1 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LAYER_5_CFG_CTRL'],count = count, increment = False , targetQueue = targetQueue), 'little') 
        
    
    async def read_layer_5_cfg_ctrl_raw(self, count : int = 1 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LAYER_5_CFG_CTRL'],count = count, increment = False)
        
    
    
    
    async def write_layer_6_cfg_ctrl(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LAYER_6_CFG_CTRL'],value = value,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    async def read_layer_6_cfg_ctrl(self, count : int = 1 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LAYER_6_CFG_CTRL'],count = count, increment = False , targetQueue = targetQueue), 'little') 
        
    
    async def read_layer_6_cfg_ctrl_raw(self, count : int = 1 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LAYER_6_CFG_CTRL'],count = count, increment = False)
        
    
    
    
    async def write_layer_7_cfg_ctrl(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LAYER_7_CFG_CTRL'],value = value,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    async def read_layer_7_cfg_ctrl(self, count : int = 1 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LAYER_7_CFG_CTRL'],count = count, increment = False , targetQueue = targetQueue), 'little') 
        
    
    async def read_layer_7_cfg_ctrl_raw(self, count : int = 1 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LAYER_7_CFG_CTRL'],count = count, increment = False)
        
    
    
    
    async def write_layer_8_cfg_ctrl(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LAYER_8_CFG_CTRL'],value = value,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    async def read_layer_8_cfg_ctrl(self, count : int = 1 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LAYER_8_CFG_CTRL'],count = count, increment = False , targetQueue = targetQueue), 'little') 
        
    
    async def read_layer_8_cfg_ctrl_raw(self, count : int = 1 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LAYER_8_CFG_CTRL'],count = count, increment = False)
        
    
    
    
    async def write_layer_9_cfg_ctrl(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LAYER_9_CFG_CTRL'],value = value,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    async def read_layer_9_cfg_ctrl(self, count : int = 1 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LAYER_9_CFG_CTRL'],count = count, increment = False , targetQueue = targetQueue), 'little') 
        
    
    async def read_layer_9_cfg_ctrl_raw(self, count : int = 1 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LAYER_9_CFG_CTRL'],count = count, increment = False)
        
    
    
    
    async def write_layer_10_cfg_ctrl(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LAYER_10_CFG_CTRL'],value = value,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    async def read_layer_10_cfg_ctrl(self, count : int = 1 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LAYER_10_CFG_CTRL'],count = count, increment = False , targetQueue = targetQueue), 'little') 
        
    
    async def read_layer_10_cfg_ctrl_raw(self, count : int = 1 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LAYER_10_CFG_CTRL'],count = count, increment = False)
        
    
    
    
    async def write_layer_11_cfg_ctrl(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LAYER_11_CFG_CTRL'],value = value,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    async def read_layer_11_cfg_ctrl(self, count : int = 1 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LAYER_11_CFG_CTRL'],count = count, increment = False , targetQueue = targetQueue), 'little') 
        
    
    async def read_layer_11_cfg_ctrl_raw(self, count : int = 1 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LAYER_11_CFG_CTRL'],count = count, increment = False)
        
    
    
    
    async def write_layer_12_cfg_ctrl(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LAYER_12_CFG_CTRL'],value = value,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    async def read_layer_12_cfg_ctrl(self, count : int = 1 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LAYER_12_CFG_CTRL'],count = count, increment = False , targetQueue = targetQueue), 'little') 
        
    
    async def read_layer_12_cfg_ctrl_raw(self, count : int = 1 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LAYER_12_CFG_CTRL'],count = count, increment = False)
        
    
    
    
    async def write_layer_13_cfg_ctrl(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LAYER_13_CFG_CTRL'],value = value,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    async def read_layer_13_cfg_ctrl(self, count : int = 1 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LAYER_13_CFG_CTRL'],count = count, increment = False , targetQueue = targetQueue), 'little') 
        
    
    async def read_layer_13_cfg_ctrl_raw(self, count : int = 1 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LAYER_13_CFG_CTRL'],count = count, increment = False)
        
    
    
    
    async def write_layer_14_cfg_ctrl(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LAYER_14_CFG_CTRL'],value = value,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    async def read_layer_14_cfg_ctrl(self, count : int = 1 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LAYER_14_CFG_CTRL'],count = count, increment = False , targetQueue = targetQueue), 'little') 
        
    
    async def read_layer_14_cfg_ctrl_raw(self, count : int = 1 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LAYER_14_CFG_CTRL'],count = count, increment = False)
        
    
    
    
    async def write_layer_15_cfg_ctrl(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LAYER_15_CFG_CTRL'],value = value,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    async def read_layer_15_cfg_ctrl(self, count : int = 1 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LAYER_15_CFG_CTRL'],count = count, increment = False , targetQueue = targetQueue), 'little') 
        
    
    async def read_layer_15_cfg_ctrl_raw(self, count : int = 1 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LAYER_15_CFG_CTRL'],count = count, increment = False)
        
    
    
    
    async def write_layer_16_cfg_ctrl(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LAYER_16_CFG_CTRL'],value = value,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    async def read_layer_16_cfg_ctrl(self, count : int = 1 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LAYER_16_CFG_CTRL'],count = count, increment = False , targetQueue = targetQueue), 'little') 
        
    
    async def read_layer_16_cfg_ctrl_raw(self, count : int = 1 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LAYER_16_CFG_CTRL'],count = count, increment = False)
        
    
    
    
    async def write_layer_17_cfg_ctrl(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LAYER_17_CFG_CTRL'],value = value,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    async def read_layer_17_cfg_ctrl(self, count : int = 1 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LAYER_17_CFG_CTRL'],count = count, increment = False , targetQueue = targetQueue), 'little') 
        
    
    async def read_layer_17_cfg_ctrl_raw(self, count : int = 1 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LAYER_17_CFG_CTRL'],count = count, increment = False)
        
    
    
    
    async def write_layer_18_cfg_ctrl(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LAYER_18_CFG_CTRL'],value = value,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    async def read_layer_18_cfg_ctrl(self, count : int = 1 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LAYER_18_CFG_CTRL'],count = count, increment = False , targetQueue = targetQueue), 'little') 
        
    
    async def read_layer_18_cfg_ctrl_raw(self, count : int = 1 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LAYER_18_CFG_CTRL'],count = count, increment = False)
        
    
    
    
    async def write_layer_19_cfg_ctrl(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LAYER_19_CFG_CTRL'],value = value,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    async def read_layer_19_cfg_ctrl(self, count : int = 1 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LAYER_19_CFG_CTRL'],count = count, increment = False , targetQueue = targetQueue), 'little') 
        
    
    async def read_layer_19_cfg_ctrl_raw(self, count : int = 1 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LAYER_19_CFG_CTRL'],count = count, increment = False)
        
    
    
    
    async def read_layer_0_status(self, count : int = 1 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LAYER_0_STATUS'],count = count, increment = False , targetQueue = targetQueue), 'little') 
        
    
    async def read_layer_0_status_raw(self, count : int = 1 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LAYER_0_STATUS'],count = count, increment = False)
        
    
    
    
    async def read_layer_1_status(self, count : int = 1 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LAYER_1_STATUS'],count = count, increment = False , targetQueue = targetQueue), 'little') 
        
    
    async def read_layer_1_status_raw(self, count : int = 1 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LAYER_1_STATUS'],count = count, increment = False)
        
    
    
    
    async def read_layer_2_status(self, count : int = 1 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LAYER_2_STATUS'],count = count, increment = False , targetQueue = targetQueue), 'little') 
        
    
    async def read_layer_2_status_raw(self, count : int = 1 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LAYER_2_STATUS'],count = count, increment = False)
        
    
    
    
    async def read_layer_3_status(self, count : int = 1 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LAYER_3_STATUS'],count = count, increment = False , targetQueue = targetQueue), 'little') 
        
    
    async def read_layer_3_status_raw(self, count : int = 1 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LAYER_3_STATUS'],count = count, increment = False)
        
    
    
    
    async def read_layer_4_status(self, count : int = 1 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LAYER_4_STATUS'],count = count, increment = False , targetQueue = targetQueue), 'little') 
        
    
    async def read_layer_4_status_raw(self, count : int = 1 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LAYER_4_STATUS'],count = count, increment = False)
        
    
    
    
    async def read_layer_5_status(self, count : int = 1 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LAYER_5_STATUS'],count = count, increment = False , targetQueue = targetQueue), 'little') 
        
    
    async def read_layer_5_status_raw(self, count : int = 1 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LAYER_5_STATUS'],count = count, increment = False)
        
    
    
    
    async def read_layer_6_status(self, count : int = 1 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LAYER_6_STATUS'],count = count, increment = False , targetQueue = targetQueue), 'little') 
        
    
    async def read_layer_6_status_raw(self, count : int = 1 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LAYER_6_STATUS'],count = count, increment = False)
        
    
    
    
    async def read_layer_7_status(self, count : int = 1 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LAYER_7_STATUS'],count = count, increment = False , targetQueue = targetQueue), 'little') 
        
    
    async def read_layer_7_status_raw(self, count : int = 1 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LAYER_7_STATUS'],count = count, increment = False)
        
    
    
    
    async def read_layer_8_status(self, count : int = 1 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LAYER_8_STATUS'],count = count, increment = False , targetQueue = targetQueue), 'little') 
        
    
    async def read_layer_8_status_raw(self, count : int = 1 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LAYER_8_STATUS'],count = count, increment = False)
        
    
    
    
    async def read_layer_9_status(self, count : int = 1 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LAYER_9_STATUS'],count = count, increment = False , targetQueue = targetQueue), 'little') 
        
    
    async def read_layer_9_status_raw(self, count : int = 1 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LAYER_9_STATUS'],count = count, increment = False)
        
    
    
    
    async def read_layer_10_status(self, count : int = 1 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LAYER_10_STATUS'],count = count, increment = False , targetQueue = targetQueue), 'little') 
        
    
    async def read_layer_10_status_raw(self, count : int = 1 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LAYER_10_STATUS'],count = count, increment = False)
        
    
    
    
    async def read_layer_11_status(self, count : int = 1 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LAYER_11_STATUS'],count = count, increment = False , targetQueue = targetQueue), 'little') 
        
    
    async def read_layer_11_status_raw(self, count : int = 1 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LAYER_11_STATUS'],count = count, increment = False)
        
    
    
    
    async def read_layer_12_status(self, count : int = 1 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LAYER_12_STATUS'],count = count, increment = False , targetQueue = targetQueue), 'little') 
        
    
    async def read_layer_12_status_raw(self, count : int = 1 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LAYER_12_STATUS'],count = count, increment = False)
        
    
    
    
    async def read_layer_13_status(self, count : int = 1 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LAYER_13_STATUS'],count = count, increment = False , targetQueue = targetQueue), 'little') 
        
    
    async def read_layer_13_status_raw(self, count : int = 1 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LAYER_13_STATUS'],count = count, increment = False)
        
    
    
    
    async def read_layer_14_status(self, count : int = 1 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LAYER_14_STATUS'],count = count, increment = False , targetQueue = targetQueue), 'little') 
        
    
    async def read_layer_14_status_raw(self, count : int = 1 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LAYER_14_STATUS'],count = count, increment = False)
        
    
    
    
    async def read_layer_15_status(self, count : int = 1 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LAYER_15_STATUS'],count = count, increment = False , targetQueue = targetQueue), 'little') 
        
    
    async def read_layer_15_status_raw(self, count : int = 1 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LAYER_15_STATUS'],count = count, increment = False)
        
    
    
    
    async def read_layer_16_status(self, count : int = 1 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LAYER_16_STATUS'],count = count, increment = False , targetQueue = targetQueue), 'little') 
        
    
    async def read_layer_16_status_raw(self, count : int = 1 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LAYER_16_STATUS'],count = count, increment = False)
        
    
    
    
    async def read_layer_17_status(self, count : int = 1 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LAYER_17_STATUS'],count = count, increment = False , targetQueue = targetQueue), 'little') 
        
    
    async def read_layer_17_status_raw(self, count : int = 1 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LAYER_17_STATUS'],count = count, increment = False)
        
    
    
    
    async def read_layer_18_status(self, count : int = 1 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LAYER_18_STATUS'],count = count, increment = False , targetQueue = targetQueue), 'little') 
        
    
    async def read_layer_18_status_raw(self, count : int = 1 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LAYER_18_STATUS'],count = count, increment = False)
        
    
    
    
    async def read_layer_19_status(self, count : int = 1 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LAYER_19_STATUS'],count = count, increment = False , targetQueue = targetQueue), 'little') 
        
    
    async def read_layer_19_status_raw(self, count : int = 1 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LAYER_19_STATUS'],count = count, increment = False)
        
    
    
    
    async def write_layer_0_stat_frame_counter(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LAYER_0_STAT_FRAME_COUNTER'],value = value,increment = True,valueLength=4)
        if flush == True:
            await self.flush()
        
    
    async def read_layer_0_stat_frame_counter(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LAYER_0_STAT_FRAME_COUNTER'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_layer_0_stat_frame_counter_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LAYER_0_STAT_FRAME_COUNTER'],count = count, increment = True)
        
    
    
    
    async def write_layer_1_stat_frame_counter(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LAYER_1_STAT_FRAME_COUNTER'],value = value,increment = True,valueLength=4)
        if flush == True:
            await self.flush()
        
    
    async def read_layer_1_stat_frame_counter(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LAYER_1_STAT_FRAME_COUNTER'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_layer_1_stat_frame_counter_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LAYER_1_STAT_FRAME_COUNTER'],count = count, increment = True)
        
    
    
    
    async def write_layer_2_stat_frame_counter(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LAYER_2_STAT_FRAME_COUNTER'],value = value,increment = True,valueLength=4)
        if flush == True:
            await self.flush()
        
    
    async def read_layer_2_stat_frame_counter(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LAYER_2_STAT_FRAME_COUNTER'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_layer_2_stat_frame_counter_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LAYER_2_STAT_FRAME_COUNTER'],count = count, increment = True)
        
    
    
    
    async def write_layer_3_stat_frame_counter(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LAYER_3_STAT_FRAME_COUNTER'],value = value,increment = True,valueLength=4)
        if flush == True:
            await self.flush()
        
    
    async def read_layer_3_stat_frame_counter(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LAYER_3_STAT_FRAME_COUNTER'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_layer_3_stat_frame_counter_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LAYER_3_STAT_FRAME_COUNTER'],count = count, increment = True)
        
    
    
    
    async def write_layer_4_stat_frame_counter(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LAYER_4_STAT_FRAME_COUNTER'],value = value,increment = True,valueLength=4)
        if flush == True:
            await self.flush()
        
    
    async def read_layer_4_stat_frame_counter(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LAYER_4_STAT_FRAME_COUNTER'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_layer_4_stat_frame_counter_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LAYER_4_STAT_FRAME_COUNTER'],count = count, increment = True)
        
    
    
    
    async def write_layer_5_stat_frame_counter(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LAYER_5_STAT_FRAME_COUNTER'],value = value,increment = True,valueLength=4)
        if flush == True:
            await self.flush()
        
    
    async def read_layer_5_stat_frame_counter(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LAYER_5_STAT_FRAME_COUNTER'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_layer_5_stat_frame_counter_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LAYER_5_STAT_FRAME_COUNTER'],count = count, increment = True)
        
    
    
    
    async def write_layer_6_stat_frame_counter(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LAYER_6_STAT_FRAME_COUNTER'],value = value,increment = True,valueLength=4)
        if flush == True:
            await self.flush()
        
    
    async def read_layer_6_stat_frame_counter(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LAYER_6_STAT_FRAME_COUNTER'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_layer_6_stat_frame_counter_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LAYER_6_STAT_FRAME_COUNTER'],count = count, increment = True)
        
    
    
    
    async def write_layer_7_stat_frame_counter(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LAYER_7_STAT_FRAME_COUNTER'],value = value,increment = True,valueLength=4)
        if flush == True:
            await self.flush()
        
    
    async def read_layer_7_stat_frame_counter(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LAYER_7_STAT_FRAME_COUNTER'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_layer_7_stat_frame_counter_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LAYER_7_STAT_FRAME_COUNTER'],count = count, increment = True)
        
    
    
    
    async def write_layer_8_stat_frame_counter(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LAYER_8_STAT_FRAME_COUNTER'],value = value,increment = True,valueLength=4)
        if flush == True:
            await self.flush()
        
    
    async def read_layer_8_stat_frame_counter(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LAYER_8_STAT_FRAME_COUNTER'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_layer_8_stat_frame_counter_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LAYER_8_STAT_FRAME_COUNTER'],count = count, increment = True)
        
    
    
    
    async def write_layer_9_stat_frame_counter(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LAYER_9_STAT_FRAME_COUNTER'],value = value,increment = True,valueLength=4)
        if flush == True:
            await self.flush()
        
    
    async def read_layer_9_stat_frame_counter(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LAYER_9_STAT_FRAME_COUNTER'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_layer_9_stat_frame_counter_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LAYER_9_STAT_FRAME_COUNTER'],count = count, increment = True)
        
    
    
    
    async def write_layer_10_stat_frame_counter(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LAYER_10_STAT_FRAME_COUNTER'],value = value,increment = True,valueLength=4)
        if flush == True:
            await self.flush()
        
    
    async def read_layer_10_stat_frame_counter(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LAYER_10_STAT_FRAME_COUNTER'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_layer_10_stat_frame_counter_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LAYER_10_STAT_FRAME_COUNTER'],count = count, increment = True)
        
    
    
    
    async def write_layer_11_stat_frame_counter(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LAYER_11_STAT_FRAME_COUNTER'],value = value,increment = True,valueLength=4)
        if flush == True:
            await self.flush()
        
    
    async def read_layer_11_stat_frame_counter(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LAYER_11_STAT_FRAME_COUNTER'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_layer_11_stat_frame_counter_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LAYER_11_STAT_FRAME_COUNTER'],count = count, increment = True)
        
    
    
    
    async def write_layer_12_stat_frame_counter(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LAYER_12_STAT_FRAME_COUNTER'],value = value,increment = True,valueLength=4)
        if flush == True:
            await self.flush()
        
    
    async def read_layer_12_stat_frame_counter(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LAYER_12_STAT_FRAME_COUNTER'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_layer_12_stat_frame_counter_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LAYER_12_STAT_FRAME_COUNTER'],count = count, increment = True)
        
    
    
    
    async def write_layer_13_stat_frame_counter(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LAYER_13_STAT_FRAME_COUNTER'],value = value,increment = True,valueLength=4)
        if flush == True:
            await self.flush()
        
    
    async def read_layer_13_stat_frame_counter(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LAYER_13_STAT_FRAME_COUNTER'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_layer_13_stat_frame_counter_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LAYER_13_STAT_FRAME_COUNTER'],count = count, increment = True)
        
    
    
    
    async def write_layer_14_stat_frame_counter(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LAYER_14_STAT_FRAME_COUNTER'],value = value,increment = True,valueLength=4)
        if flush == True:
            await self.flush()
        
    
    async def read_layer_14_stat_frame_counter(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LAYER_14_STAT_FRAME_COUNTER'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_layer_14_stat_frame_counter_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LAYER_14_STAT_FRAME_COUNTER'],count = count, increment = True)
        
    
    
    
    async def write_layer_15_stat_frame_counter(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LAYER_15_STAT_FRAME_COUNTER'],value = value,increment = True,valueLength=4)
        if flush == True:
            await self.flush()
        
    
    async def read_layer_15_stat_frame_counter(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LAYER_15_STAT_FRAME_COUNTER'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_layer_15_stat_frame_counter_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LAYER_15_STAT_FRAME_COUNTER'],count = count, increment = True)
        
    
    
    
    async def write_layer_16_stat_frame_counter(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LAYER_16_STAT_FRAME_COUNTER'],value = value,increment = True,valueLength=4)
        if flush == True:
            await self.flush()
        
    
    async def read_layer_16_stat_frame_counter(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LAYER_16_STAT_FRAME_COUNTER'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_layer_16_stat_frame_counter_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LAYER_16_STAT_FRAME_COUNTER'],count = count, increment = True)
        
    
    
    
    async def write_layer_17_stat_frame_counter(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LAYER_17_STAT_FRAME_COUNTER'],value = value,increment = True,valueLength=4)
        if flush == True:
            await self.flush()
        
    
    async def read_layer_17_stat_frame_counter(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LAYER_17_STAT_FRAME_COUNTER'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_layer_17_stat_frame_counter_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LAYER_17_STAT_FRAME_COUNTER'],count = count, increment = True)
        
    
    
    
    async def write_layer_18_stat_frame_counter(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LAYER_18_STAT_FRAME_COUNTER'],value = value,increment = True,valueLength=4)
        if flush == True:
            await self.flush()
        
    
    async def read_layer_18_stat_frame_counter(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LAYER_18_STAT_FRAME_COUNTER'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_layer_18_stat_frame_counter_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LAYER_18_STAT_FRAME_COUNTER'],count = count, increment = True)
        
    
    
    
    async def write_layer_19_stat_frame_counter(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LAYER_19_STAT_FRAME_COUNTER'],value = value,increment = True,valueLength=4)
        if flush == True:
            await self.flush()
        
    
    async def read_layer_19_stat_frame_counter(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LAYER_19_STAT_FRAME_COUNTER'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_layer_19_stat_frame_counter_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LAYER_19_STAT_FRAME_COUNTER'],count = count, increment = True)
        
    
    
    
    async def write_layer_0_stat_idle_counter(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LAYER_0_STAT_IDLE_COUNTER'],value = value,increment = True,valueLength=4)
        if flush == True:
            await self.flush()
        
    
    async def read_layer_0_stat_idle_counter(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LAYER_0_STAT_IDLE_COUNTER'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_layer_0_stat_idle_counter_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LAYER_0_STAT_IDLE_COUNTER'],count = count, increment = True)
        
    
    
    
    async def write_layer_1_stat_idle_counter(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LAYER_1_STAT_IDLE_COUNTER'],value = value,increment = True,valueLength=4)
        if flush == True:
            await self.flush()
        
    
    async def read_layer_1_stat_idle_counter(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LAYER_1_STAT_IDLE_COUNTER'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_layer_1_stat_idle_counter_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LAYER_1_STAT_IDLE_COUNTER'],count = count, increment = True)
        
    
    
    
    async def write_layer_2_stat_idle_counter(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LAYER_2_STAT_IDLE_COUNTER'],value = value,increment = True,valueLength=4)
        if flush == True:
            await self.flush()
        
    
    async def read_layer_2_stat_idle_counter(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LAYER_2_STAT_IDLE_COUNTER'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_layer_2_stat_idle_counter_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LAYER_2_STAT_IDLE_COUNTER'],count = count, increment = True)
        
    
    
    
    async def write_layer_3_stat_idle_counter(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LAYER_3_STAT_IDLE_COUNTER'],value = value,increment = True,valueLength=4)
        if flush == True:
            await self.flush()
        
    
    async def read_layer_3_stat_idle_counter(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LAYER_3_STAT_IDLE_COUNTER'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_layer_3_stat_idle_counter_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LAYER_3_STAT_IDLE_COUNTER'],count = count, increment = True)
        
    
    
    
    async def write_layer_4_stat_idle_counter(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LAYER_4_STAT_IDLE_COUNTER'],value = value,increment = True,valueLength=4)
        if flush == True:
            await self.flush()
        
    
    async def read_layer_4_stat_idle_counter(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LAYER_4_STAT_IDLE_COUNTER'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_layer_4_stat_idle_counter_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LAYER_4_STAT_IDLE_COUNTER'],count = count, increment = True)
        
    
    
    
    async def write_layer_5_stat_idle_counter(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LAYER_5_STAT_IDLE_COUNTER'],value = value,increment = True,valueLength=4)
        if flush == True:
            await self.flush()
        
    
    async def read_layer_5_stat_idle_counter(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LAYER_5_STAT_IDLE_COUNTER'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_layer_5_stat_idle_counter_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LAYER_5_STAT_IDLE_COUNTER'],count = count, increment = True)
        
    
    
    
    async def write_layer_6_stat_idle_counter(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LAYER_6_STAT_IDLE_COUNTER'],value = value,increment = True,valueLength=4)
        if flush == True:
            await self.flush()
        
    
    async def read_layer_6_stat_idle_counter(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LAYER_6_STAT_IDLE_COUNTER'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_layer_6_stat_idle_counter_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LAYER_6_STAT_IDLE_COUNTER'],count = count, increment = True)
        
    
    
    
    async def write_layer_7_stat_idle_counter(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LAYER_7_STAT_IDLE_COUNTER'],value = value,increment = True,valueLength=4)
        if flush == True:
            await self.flush()
        
    
    async def read_layer_7_stat_idle_counter(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LAYER_7_STAT_IDLE_COUNTER'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_layer_7_stat_idle_counter_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LAYER_7_STAT_IDLE_COUNTER'],count = count, increment = True)
        
    
    
    
    async def write_layer_8_stat_idle_counter(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LAYER_8_STAT_IDLE_COUNTER'],value = value,increment = True,valueLength=4)
        if flush == True:
            await self.flush()
        
    
    async def read_layer_8_stat_idle_counter(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LAYER_8_STAT_IDLE_COUNTER'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_layer_8_stat_idle_counter_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LAYER_8_STAT_IDLE_COUNTER'],count = count, increment = True)
        
    
    
    
    async def write_layer_9_stat_idle_counter(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LAYER_9_STAT_IDLE_COUNTER'],value = value,increment = True,valueLength=4)
        if flush == True:
            await self.flush()
        
    
    async def read_layer_9_stat_idle_counter(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LAYER_9_STAT_IDLE_COUNTER'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_layer_9_stat_idle_counter_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LAYER_9_STAT_IDLE_COUNTER'],count = count, increment = True)
        
    
    
    
    async def write_layer_10_stat_idle_counter(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LAYER_10_STAT_IDLE_COUNTER'],value = value,increment = True,valueLength=4)
        if flush == True:
            await self.flush()
        
    
    async def read_layer_10_stat_idle_counter(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LAYER_10_STAT_IDLE_COUNTER'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_layer_10_stat_idle_counter_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LAYER_10_STAT_IDLE_COUNTER'],count = count, increment = True)
        
    
    
    
    async def write_layer_11_stat_idle_counter(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LAYER_11_STAT_IDLE_COUNTER'],value = value,increment = True,valueLength=4)
        if flush == True:
            await self.flush()
        
    
    async def read_layer_11_stat_idle_counter(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LAYER_11_STAT_IDLE_COUNTER'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_layer_11_stat_idle_counter_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LAYER_11_STAT_IDLE_COUNTER'],count = count, increment = True)
        
    
    
    
    async def write_layer_12_stat_idle_counter(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LAYER_12_STAT_IDLE_COUNTER'],value = value,increment = True,valueLength=4)
        if flush == True:
            await self.flush()
        
    
    async def read_layer_12_stat_idle_counter(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LAYER_12_STAT_IDLE_COUNTER'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_layer_12_stat_idle_counter_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LAYER_12_STAT_IDLE_COUNTER'],count = count, increment = True)
        
    
    
    
    async def write_layer_13_stat_idle_counter(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LAYER_13_STAT_IDLE_COUNTER'],value = value,increment = True,valueLength=4)
        if flush == True:
            await self.flush()
        
    
    async def read_layer_13_stat_idle_counter(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LAYER_13_STAT_IDLE_COUNTER'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_layer_13_stat_idle_counter_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LAYER_13_STAT_IDLE_COUNTER'],count = count, increment = True)
        
    
    
    
    async def write_layer_14_stat_idle_counter(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LAYER_14_STAT_IDLE_COUNTER'],value = value,increment = True,valueLength=4)
        if flush == True:
            await self.flush()
        
    
    async def read_layer_14_stat_idle_counter(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LAYER_14_STAT_IDLE_COUNTER'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_layer_14_stat_idle_counter_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LAYER_14_STAT_IDLE_COUNTER'],count = count, increment = True)
        
    
    
    
    async def write_layer_15_stat_idle_counter(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LAYER_15_STAT_IDLE_COUNTER'],value = value,increment = True,valueLength=4)
        if flush == True:
            await self.flush()
        
    
    async def read_layer_15_stat_idle_counter(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LAYER_15_STAT_IDLE_COUNTER'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_layer_15_stat_idle_counter_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LAYER_15_STAT_IDLE_COUNTER'],count = count, increment = True)
        
    
    
    
    async def write_layer_16_stat_idle_counter(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LAYER_16_STAT_IDLE_COUNTER'],value = value,increment = True,valueLength=4)
        if flush == True:
            await self.flush()
        
    
    async def read_layer_16_stat_idle_counter(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LAYER_16_STAT_IDLE_COUNTER'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_layer_16_stat_idle_counter_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LAYER_16_STAT_IDLE_COUNTER'],count = count, increment = True)
        
    
    
    
    async def write_layer_17_stat_idle_counter(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LAYER_17_STAT_IDLE_COUNTER'],value = value,increment = True,valueLength=4)
        if flush == True:
            await self.flush()
        
    
    async def read_layer_17_stat_idle_counter(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LAYER_17_STAT_IDLE_COUNTER'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_layer_17_stat_idle_counter_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LAYER_17_STAT_IDLE_COUNTER'],count = count, increment = True)
        
    
    
    
    async def write_layer_18_stat_idle_counter(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LAYER_18_STAT_IDLE_COUNTER'],value = value,increment = True,valueLength=4)
        if flush == True:
            await self.flush()
        
    
    async def read_layer_18_stat_idle_counter(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LAYER_18_STAT_IDLE_COUNTER'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_layer_18_stat_idle_counter_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LAYER_18_STAT_IDLE_COUNTER'],count = count, increment = True)
        
    
    
    
    async def write_layer_19_stat_idle_counter(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LAYER_19_STAT_IDLE_COUNTER'],value = value,increment = True,valueLength=4)
        if flush == True:
            await self.flush()
        
    
    async def read_layer_19_stat_idle_counter(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LAYER_19_STAT_IDLE_COUNTER'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_layer_19_stat_idle_counter_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LAYER_19_STAT_IDLE_COUNTER'],count = count, increment = True)
        
    
    
    
    async def write_layer_0_mosi(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LAYER_0_MOSI'],value = value,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    async def write_layer_0_mosi_bytes(self,values : bytearray,flush = False):
        for b in values:
            self.addWrite(register = self.Registers['LAYER_0_MOSI'],value = b,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    
    
    async def read_layer_0_mosi_write_size(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LAYER_0_MOSI_WRITE_SIZE'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_layer_0_mosi_write_size_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LAYER_0_MOSI_WRITE_SIZE'],count = count, increment = True)
        
    
    
    
    async def write_layer_1_mosi(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LAYER_1_MOSI'],value = value,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    async def write_layer_1_mosi_bytes(self,values : bytearray,flush = False):
        for b in values:
            self.addWrite(register = self.Registers['LAYER_1_MOSI'],value = b,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    
    
    async def read_layer_1_mosi_write_size(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LAYER_1_MOSI_WRITE_SIZE'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_layer_1_mosi_write_size_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LAYER_1_MOSI_WRITE_SIZE'],count = count, increment = True)
        
    
    
    
    async def write_layer_2_mosi(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LAYER_2_MOSI'],value = value,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    async def write_layer_2_mosi_bytes(self,values : bytearray,flush = False):
        for b in values:
            self.addWrite(register = self.Registers['LAYER_2_MOSI'],value = b,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    
    
    async def read_layer_2_mosi_write_size(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LAYER_2_MOSI_WRITE_SIZE'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_layer_2_mosi_write_size_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LAYER_2_MOSI_WRITE_SIZE'],count = count, increment = True)
        
    
    
    
    async def write_layer_3_mosi(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LAYER_3_MOSI'],value = value,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    async def write_layer_3_mosi_bytes(self,values : bytearray,flush = False):
        for b in values:
            self.addWrite(register = self.Registers['LAYER_3_MOSI'],value = b,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    
    
    async def read_layer_3_mosi_write_size(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LAYER_3_MOSI_WRITE_SIZE'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_layer_3_mosi_write_size_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LAYER_3_MOSI_WRITE_SIZE'],count = count, increment = True)
        
    
    
    
    async def write_layer_4_mosi(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LAYER_4_MOSI'],value = value,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    async def write_layer_4_mosi_bytes(self,values : bytearray,flush = False):
        for b in values:
            self.addWrite(register = self.Registers['LAYER_4_MOSI'],value = b,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    
    
    async def read_layer_4_mosi_write_size(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LAYER_4_MOSI_WRITE_SIZE'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_layer_4_mosi_write_size_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LAYER_4_MOSI_WRITE_SIZE'],count = count, increment = True)
        
    
    
    
    async def write_layer_5_mosi(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LAYER_5_MOSI'],value = value,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    async def write_layer_5_mosi_bytes(self,values : bytearray,flush = False):
        for b in values:
            self.addWrite(register = self.Registers['LAYER_5_MOSI'],value = b,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    
    
    async def read_layer_5_mosi_write_size(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LAYER_5_MOSI_WRITE_SIZE'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_layer_5_mosi_write_size_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LAYER_5_MOSI_WRITE_SIZE'],count = count, increment = True)
        
    
    
    
    async def write_layer_6_mosi(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LAYER_6_MOSI'],value = value,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    async def write_layer_6_mosi_bytes(self,values : bytearray,flush = False):
        for b in values:
            self.addWrite(register = self.Registers['LAYER_6_MOSI'],value = b,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    
    
    async def read_layer_6_mosi_write_size(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LAYER_6_MOSI_WRITE_SIZE'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_layer_6_mosi_write_size_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LAYER_6_MOSI_WRITE_SIZE'],count = count, increment = True)
        
    
    
    
    async def write_layer_7_mosi(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LAYER_7_MOSI'],value = value,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    async def write_layer_7_mosi_bytes(self,values : bytearray,flush = False):
        for b in values:
            self.addWrite(register = self.Registers['LAYER_7_MOSI'],value = b,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    
    
    async def read_layer_7_mosi_write_size(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LAYER_7_MOSI_WRITE_SIZE'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_layer_7_mosi_write_size_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LAYER_7_MOSI_WRITE_SIZE'],count = count, increment = True)
        
    
    
    
    async def write_layer_8_mosi(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LAYER_8_MOSI'],value = value,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    async def write_layer_8_mosi_bytes(self,values : bytearray,flush = False):
        for b in values:
            self.addWrite(register = self.Registers['LAYER_8_MOSI'],value = b,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    
    
    async def read_layer_8_mosi_write_size(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LAYER_8_MOSI_WRITE_SIZE'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_layer_8_mosi_write_size_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LAYER_8_MOSI_WRITE_SIZE'],count = count, increment = True)
        
    
    
    
    async def write_layer_9_mosi(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LAYER_9_MOSI'],value = value,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    async def write_layer_9_mosi_bytes(self,values : bytearray,flush = False):
        for b in values:
            self.addWrite(register = self.Registers['LAYER_9_MOSI'],value = b,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    
    
    async def read_layer_9_mosi_write_size(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LAYER_9_MOSI_WRITE_SIZE'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_layer_9_mosi_write_size_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LAYER_9_MOSI_WRITE_SIZE'],count = count, increment = True)
        
    
    
    
    async def write_layer_10_mosi(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LAYER_10_MOSI'],value = value,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    async def write_layer_10_mosi_bytes(self,values : bytearray,flush = False):
        for b in values:
            self.addWrite(register = self.Registers['LAYER_10_MOSI'],value = b,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    
    
    async def read_layer_10_mosi_write_size(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LAYER_10_MOSI_WRITE_SIZE'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_layer_10_mosi_write_size_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LAYER_10_MOSI_WRITE_SIZE'],count = count, increment = True)
        
    
    
    
    async def write_layer_11_mosi(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LAYER_11_MOSI'],value = value,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    async def write_layer_11_mosi_bytes(self,values : bytearray,flush = False):
        for b in values:
            self.addWrite(register = self.Registers['LAYER_11_MOSI'],value = b,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    
    
    async def read_layer_11_mosi_write_size(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LAYER_11_MOSI_WRITE_SIZE'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_layer_11_mosi_write_size_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LAYER_11_MOSI_WRITE_SIZE'],count = count, increment = True)
        
    
    
    
    async def write_layer_12_mosi(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LAYER_12_MOSI'],value = value,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    async def write_layer_12_mosi_bytes(self,values : bytearray,flush = False):
        for b in values:
            self.addWrite(register = self.Registers['LAYER_12_MOSI'],value = b,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    
    
    async def read_layer_12_mosi_write_size(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LAYER_12_MOSI_WRITE_SIZE'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_layer_12_mosi_write_size_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LAYER_12_MOSI_WRITE_SIZE'],count = count, increment = True)
        
    
    
    
    async def write_layer_13_mosi(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LAYER_13_MOSI'],value = value,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    async def write_layer_13_mosi_bytes(self,values : bytearray,flush = False):
        for b in values:
            self.addWrite(register = self.Registers['LAYER_13_MOSI'],value = b,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    
    
    async def read_layer_13_mosi_write_size(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LAYER_13_MOSI_WRITE_SIZE'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_layer_13_mosi_write_size_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LAYER_13_MOSI_WRITE_SIZE'],count = count, increment = True)
        
    
    
    
    async def write_layer_14_mosi(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LAYER_14_MOSI'],value = value,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    async def write_layer_14_mosi_bytes(self,values : bytearray,flush = False):
        for b in values:
            self.addWrite(register = self.Registers['LAYER_14_MOSI'],value = b,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    
    
    async def read_layer_14_mosi_write_size(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LAYER_14_MOSI_WRITE_SIZE'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_layer_14_mosi_write_size_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LAYER_14_MOSI_WRITE_SIZE'],count = count, increment = True)
        
    
    
    
    async def write_layer_15_mosi(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LAYER_15_MOSI'],value = value,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    async def write_layer_15_mosi_bytes(self,values : bytearray,flush = False):
        for b in values:
            self.addWrite(register = self.Registers['LAYER_15_MOSI'],value = b,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    
    
    async def read_layer_15_mosi_write_size(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LAYER_15_MOSI_WRITE_SIZE'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_layer_15_mosi_write_size_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LAYER_15_MOSI_WRITE_SIZE'],count = count, increment = True)
        
    
    
    
    async def write_layer_16_mosi(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LAYER_16_MOSI'],value = value,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    async def write_layer_16_mosi_bytes(self,values : bytearray,flush = False):
        for b in values:
            self.addWrite(register = self.Registers['LAYER_16_MOSI'],value = b,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    
    
    async def read_layer_16_mosi_write_size(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LAYER_16_MOSI_WRITE_SIZE'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_layer_16_mosi_write_size_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LAYER_16_MOSI_WRITE_SIZE'],count = count, increment = True)
        
    
    
    
    async def write_layer_17_mosi(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LAYER_17_MOSI'],value = value,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    async def write_layer_17_mosi_bytes(self,values : bytearray,flush = False):
        for b in values:
            self.addWrite(register = self.Registers['LAYER_17_MOSI'],value = b,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    
    
    async def read_layer_17_mosi_write_size(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LAYER_17_MOSI_WRITE_SIZE'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_layer_17_mosi_write_size_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LAYER_17_MOSI_WRITE_SIZE'],count = count, increment = True)
        
    
    
    
    async def write_layer_18_mosi(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LAYER_18_MOSI'],value = value,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    async def write_layer_18_mosi_bytes(self,values : bytearray,flush = False):
        for b in values:
            self.addWrite(register = self.Registers['LAYER_18_MOSI'],value = b,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    
    
    async def read_layer_18_mosi_write_size(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LAYER_18_MOSI_WRITE_SIZE'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_layer_18_mosi_write_size_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LAYER_18_MOSI_WRITE_SIZE'],count = count, increment = True)
        
    
    
    
    async def write_layer_19_mosi(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LAYER_19_MOSI'],value = value,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    async def write_layer_19_mosi_bytes(self,values : bytearray,flush = False):
        for b in values:
            self.addWrite(register = self.Registers['LAYER_19_MOSI'],value = b,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    
    
    async def read_layer_19_mosi_write_size(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LAYER_19_MOSI_WRITE_SIZE'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_layer_19_mosi_write_size_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LAYER_19_MOSI_WRITE_SIZE'],count = count, increment = True)
        
    
    
    
    async def write_layer_0_loopback_miso(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LAYER_0_LOOPBACK_MISO'],value = value,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    async def write_layer_0_loopback_miso_bytes(self,values : bytearray,flush = False):
        for b in values:
            self.addWrite(register = self.Registers['LAYER_0_LOOPBACK_MISO'],value = b,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    
    
    async def read_layer_0_loopback_miso_write_size(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LAYER_0_LOOPBACK_MISO_WRITE_SIZE'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_layer_0_loopback_miso_write_size_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LAYER_0_LOOPBACK_MISO_WRITE_SIZE'],count = count, increment = True)
        
    
    
    
    async def write_layer_1_loopback_miso(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LAYER_1_LOOPBACK_MISO'],value = value,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    async def write_layer_1_loopback_miso_bytes(self,values : bytearray,flush = False):
        for b in values:
            self.addWrite(register = self.Registers['LAYER_1_LOOPBACK_MISO'],value = b,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    
    
    async def read_layer_1_loopback_miso_write_size(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LAYER_1_LOOPBACK_MISO_WRITE_SIZE'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_layer_1_loopback_miso_write_size_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LAYER_1_LOOPBACK_MISO_WRITE_SIZE'],count = count, increment = True)
        
    
    
    
    async def write_layer_2_loopback_miso(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LAYER_2_LOOPBACK_MISO'],value = value,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    async def write_layer_2_loopback_miso_bytes(self,values : bytearray,flush = False):
        for b in values:
            self.addWrite(register = self.Registers['LAYER_2_LOOPBACK_MISO'],value = b,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    
    
    async def read_layer_2_loopback_miso_write_size(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LAYER_2_LOOPBACK_MISO_WRITE_SIZE'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_layer_2_loopback_miso_write_size_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LAYER_2_LOOPBACK_MISO_WRITE_SIZE'],count = count, increment = True)
        
    
    
    
    async def write_layer_3_loopback_miso(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LAYER_3_LOOPBACK_MISO'],value = value,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    async def write_layer_3_loopback_miso_bytes(self,values : bytearray,flush = False):
        for b in values:
            self.addWrite(register = self.Registers['LAYER_3_LOOPBACK_MISO'],value = b,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    
    
    async def read_layer_3_loopback_miso_write_size(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LAYER_3_LOOPBACK_MISO_WRITE_SIZE'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_layer_3_loopback_miso_write_size_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LAYER_3_LOOPBACK_MISO_WRITE_SIZE'],count = count, increment = True)
        
    
    
    
    async def write_layer_4_loopback_miso(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LAYER_4_LOOPBACK_MISO'],value = value,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    async def write_layer_4_loopback_miso_bytes(self,values : bytearray,flush = False):
        for b in values:
            self.addWrite(register = self.Registers['LAYER_4_LOOPBACK_MISO'],value = b,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    
    
    async def read_layer_4_loopback_miso_write_size(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LAYER_4_LOOPBACK_MISO_WRITE_SIZE'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_layer_4_loopback_miso_write_size_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LAYER_4_LOOPBACK_MISO_WRITE_SIZE'],count = count, increment = True)
        
    
    
    
    async def write_layer_5_loopback_miso(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LAYER_5_LOOPBACK_MISO'],value = value,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    async def write_layer_5_loopback_miso_bytes(self,values : bytearray,flush = False):
        for b in values:
            self.addWrite(register = self.Registers['LAYER_5_LOOPBACK_MISO'],value = b,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    
    
    async def read_layer_5_loopback_miso_write_size(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LAYER_5_LOOPBACK_MISO_WRITE_SIZE'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_layer_5_loopback_miso_write_size_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LAYER_5_LOOPBACK_MISO_WRITE_SIZE'],count = count, increment = True)
        
    
    
    
    async def write_layer_6_loopback_miso(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LAYER_6_LOOPBACK_MISO'],value = value,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    async def write_layer_6_loopback_miso_bytes(self,values : bytearray,flush = False):
        for b in values:
            self.addWrite(register = self.Registers['LAYER_6_LOOPBACK_MISO'],value = b,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    
    
    async def read_layer_6_loopback_miso_write_size(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LAYER_6_LOOPBACK_MISO_WRITE_SIZE'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_layer_6_loopback_miso_write_size_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LAYER_6_LOOPBACK_MISO_WRITE_SIZE'],count = count, increment = True)
        
    
    
    
    async def write_layer_7_loopback_miso(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LAYER_7_LOOPBACK_MISO'],value = value,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    async def write_layer_7_loopback_miso_bytes(self,values : bytearray,flush = False):
        for b in values:
            self.addWrite(register = self.Registers['LAYER_7_LOOPBACK_MISO'],value = b,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    
    
    async def read_layer_7_loopback_miso_write_size(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LAYER_7_LOOPBACK_MISO_WRITE_SIZE'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_layer_7_loopback_miso_write_size_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LAYER_7_LOOPBACK_MISO_WRITE_SIZE'],count = count, increment = True)
        
    
    
    
    async def write_layer_8_loopback_miso(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LAYER_8_LOOPBACK_MISO'],value = value,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    async def write_layer_8_loopback_miso_bytes(self,values : bytearray,flush = False):
        for b in values:
            self.addWrite(register = self.Registers['LAYER_8_LOOPBACK_MISO'],value = b,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    
    
    async def read_layer_8_loopback_miso_write_size(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LAYER_8_LOOPBACK_MISO_WRITE_SIZE'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_layer_8_loopback_miso_write_size_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LAYER_8_LOOPBACK_MISO_WRITE_SIZE'],count = count, increment = True)
        
    
    
    
    async def write_layer_9_loopback_miso(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LAYER_9_LOOPBACK_MISO'],value = value,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    async def write_layer_9_loopback_miso_bytes(self,values : bytearray,flush = False):
        for b in values:
            self.addWrite(register = self.Registers['LAYER_9_LOOPBACK_MISO'],value = b,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    
    
    async def read_layer_9_loopback_miso_write_size(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LAYER_9_LOOPBACK_MISO_WRITE_SIZE'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_layer_9_loopback_miso_write_size_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LAYER_9_LOOPBACK_MISO_WRITE_SIZE'],count = count, increment = True)
        
    
    
    
    async def write_layer_10_loopback_miso(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LAYER_10_LOOPBACK_MISO'],value = value,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    async def write_layer_10_loopback_miso_bytes(self,values : bytearray,flush = False):
        for b in values:
            self.addWrite(register = self.Registers['LAYER_10_LOOPBACK_MISO'],value = b,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    
    
    async def read_layer_10_loopback_miso_write_size(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LAYER_10_LOOPBACK_MISO_WRITE_SIZE'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_layer_10_loopback_miso_write_size_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LAYER_10_LOOPBACK_MISO_WRITE_SIZE'],count = count, increment = True)
        
    
    
    
    async def write_layer_11_loopback_miso(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LAYER_11_LOOPBACK_MISO'],value = value,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    async def write_layer_11_loopback_miso_bytes(self,values : bytearray,flush = False):
        for b in values:
            self.addWrite(register = self.Registers['LAYER_11_LOOPBACK_MISO'],value = b,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    
    
    async def read_layer_11_loopback_miso_write_size(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LAYER_11_LOOPBACK_MISO_WRITE_SIZE'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_layer_11_loopback_miso_write_size_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LAYER_11_LOOPBACK_MISO_WRITE_SIZE'],count = count, increment = True)
        
    
    
    
    async def write_layer_12_loopback_miso(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LAYER_12_LOOPBACK_MISO'],value = value,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    async def write_layer_12_loopback_miso_bytes(self,values : bytearray,flush = False):
        for b in values:
            self.addWrite(register = self.Registers['LAYER_12_LOOPBACK_MISO'],value = b,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    
    
    async def read_layer_12_loopback_miso_write_size(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LAYER_12_LOOPBACK_MISO_WRITE_SIZE'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_layer_12_loopback_miso_write_size_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LAYER_12_LOOPBACK_MISO_WRITE_SIZE'],count = count, increment = True)
        
    
    
    
    async def write_layer_13_loopback_miso(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LAYER_13_LOOPBACK_MISO'],value = value,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    async def write_layer_13_loopback_miso_bytes(self,values : bytearray,flush = False):
        for b in values:
            self.addWrite(register = self.Registers['LAYER_13_LOOPBACK_MISO'],value = b,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    
    
    async def read_layer_13_loopback_miso_write_size(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LAYER_13_LOOPBACK_MISO_WRITE_SIZE'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_layer_13_loopback_miso_write_size_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LAYER_13_LOOPBACK_MISO_WRITE_SIZE'],count = count, increment = True)
        
    
    
    
    async def write_layer_14_loopback_miso(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LAYER_14_LOOPBACK_MISO'],value = value,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    async def write_layer_14_loopback_miso_bytes(self,values : bytearray,flush = False):
        for b in values:
            self.addWrite(register = self.Registers['LAYER_14_LOOPBACK_MISO'],value = b,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    
    
    async def read_layer_14_loopback_miso_write_size(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LAYER_14_LOOPBACK_MISO_WRITE_SIZE'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_layer_14_loopback_miso_write_size_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LAYER_14_LOOPBACK_MISO_WRITE_SIZE'],count = count, increment = True)
        
    
    
    
    async def write_layer_15_loopback_miso(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LAYER_15_LOOPBACK_MISO'],value = value,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    async def write_layer_15_loopback_miso_bytes(self,values : bytearray,flush = False):
        for b in values:
            self.addWrite(register = self.Registers['LAYER_15_LOOPBACK_MISO'],value = b,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    
    
    async def read_layer_15_loopback_miso_write_size(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LAYER_15_LOOPBACK_MISO_WRITE_SIZE'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_layer_15_loopback_miso_write_size_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LAYER_15_LOOPBACK_MISO_WRITE_SIZE'],count = count, increment = True)
        
    
    
    
    async def write_layer_16_loopback_miso(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LAYER_16_LOOPBACK_MISO'],value = value,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    async def write_layer_16_loopback_miso_bytes(self,values : bytearray,flush = False):
        for b in values:
            self.addWrite(register = self.Registers['LAYER_16_LOOPBACK_MISO'],value = b,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    
    
    async def read_layer_16_loopback_miso_write_size(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LAYER_16_LOOPBACK_MISO_WRITE_SIZE'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_layer_16_loopback_miso_write_size_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LAYER_16_LOOPBACK_MISO_WRITE_SIZE'],count = count, increment = True)
        
    
    
    
    async def write_layer_17_loopback_miso(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LAYER_17_LOOPBACK_MISO'],value = value,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    async def write_layer_17_loopback_miso_bytes(self,values : bytearray,flush = False):
        for b in values:
            self.addWrite(register = self.Registers['LAYER_17_LOOPBACK_MISO'],value = b,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    
    
    async def read_layer_17_loopback_miso_write_size(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LAYER_17_LOOPBACK_MISO_WRITE_SIZE'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_layer_17_loopback_miso_write_size_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LAYER_17_LOOPBACK_MISO_WRITE_SIZE'],count = count, increment = True)
        
    
    
    
    async def write_layer_18_loopback_miso(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LAYER_18_LOOPBACK_MISO'],value = value,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    async def write_layer_18_loopback_miso_bytes(self,values : bytearray,flush = False):
        for b in values:
            self.addWrite(register = self.Registers['LAYER_18_LOOPBACK_MISO'],value = b,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    
    
    async def read_layer_18_loopback_miso_write_size(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LAYER_18_LOOPBACK_MISO_WRITE_SIZE'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_layer_18_loopback_miso_write_size_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LAYER_18_LOOPBACK_MISO_WRITE_SIZE'],count = count, increment = True)
        
    
    
    
    async def write_layer_19_loopback_miso(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LAYER_19_LOOPBACK_MISO'],value = value,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    async def write_layer_19_loopback_miso_bytes(self,values : bytearray,flush = False):
        for b in values:
            self.addWrite(register = self.Registers['LAYER_19_LOOPBACK_MISO'],value = b,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    
    
    async def read_layer_19_loopback_miso_write_size(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LAYER_19_LOOPBACK_MISO_WRITE_SIZE'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_layer_19_loopback_miso_write_size_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LAYER_19_LOOPBACK_MISO_WRITE_SIZE'],count = count, increment = True)
        
    
    
    
    async def read_layer_0_loopback_mosi(self, count : int = 1 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LAYER_0_LOOPBACK_MOSI'],count = count, increment = False , targetQueue = targetQueue), 'little') 
        
    
    async def read_layer_0_loopback_mosi_raw(self, count : int = 1 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LAYER_0_LOOPBACK_MOSI'],count = count, increment = False)
        
    
    
    
    async def read_layer_0_loopback_mosi_read_size(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LAYER_0_LOOPBACK_MOSI_READ_SIZE'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_layer_0_loopback_mosi_read_size_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LAYER_0_LOOPBACK_MOSI_READ_SIZE'],count = count, increment = True)
        
    
    
    
    async def read_layer_1_loopback_mosi(self, count : int = 1 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LAYER_1_LOOPBACK_MOSI'],count = count, increment = False , targetQueue = targetQueue), 'little') 
        
    
    async def read_layer_1_loopback_mosi_raw(self, count : int = 1 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LAYER_1_LOOPBACK_MOSI'],count = count, increment = False)
        
    
    
    
    async def read_layer_1_loopback_mosi_read_size(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LAYER_1_LOOPBACK_MOSI_READ_SIZE'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_layer_1_loopback_mosi_read_size_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LAYER_1_LOOPBACK_MOSI_READ_SIZE'],count = count, increment = True)
        
    
    
    
    async def read_layer_2_loopback_mosi(self, count : int = 1 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LAYER_2_LOOPBACK_MOSI'],count = count, increment = False , targetQueue = targetQueue), 'little') 
        
    
    async def read_layer_2_loopback_mosi_raw(self, count : int = 1 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LAYER_2_LOOPBACK_MOSI'],count = count, increment = False)
        
    
    
    
    async def read_layer_2_loopback_mosi_read_size(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LAYER_2_LOOPBACK_MOSI_READ_SIZE'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_layer_2_loopback_mosi_read_size_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LAYER_2_LOOPBACK_MOSI_READ_SIZE'],count = count, increment = True)
        
    
    
    
    async def read_layer_3_loopback_mosi(self, count : int = 1 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LAYER_3_LOOPBACK_MOSI'],count = count, increment = False , targetQueue = targetQueue), 'little') 
        
    
    async def read_layer_3_loopback_mosi_raw(self, count : int = 1 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LAYER_3_LOOPBACK_MOSI'],count = count, increment = False)
        
    
    
    
    async def read_layer_3_loopback_mosi_read_size(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LAYER_3_LOOPBACK_MOSI_READ_SIZE'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_layer_3_loopback_mosi_read_size_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LAYER_3_LOOPBACK_MOSI_READ_SIZE'],count = count, increment = True)
        
    
    
    
    async def read_layer_4_loopback_mosi(self, count : int = 1 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LAYER_4_LOOPBACK_MOSI'],count = count, increment = False , targetQueue = targetQueue), 'little') 
        
    
    async def read_layer_4_loopback_mosi_raw(self, count : int = 1 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LAYER_4_LOOPBACK_MOSI'],count = count, increment = False)
        
    
    
    
    async def read_layer_4_loopback_mosi_read_size(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LAYER_4_LOOPBACK_MOSI_READ_SIZE'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_layer_4_loopback_mosi_read_size_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LAYER_4_LOOPBACK_MOSI_READ_SIZE'],count = count, increment = True)
        
    
    
    
    async def read_layer_5_loopback_mosi(self, count : int = 1 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LAYER_5_LOOPBACK_MOSI'],count = count, increment = False , targetQueue = targetQueue), 'little') 
        
    
    async def read_layer_5_loopback_mosi_raw(self, count : int = 1 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LAYER_5_LOOPBACK_MOSI'],count = count, increment = False)
        
    
    
    
    async def read_layer_5_loopback_mosi_read_size(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LAYER_5_LOOPBACK_MOSI_READ_SIZE'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_layer_5_loopback_mosi_read_size_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LAYER_5_LOOPBACK_MOSI_READ_SIZE'],count = count, increment = True)
        
    
    
    
    async def read_layer_6_loopback_mosi(self, count : int = 1 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LAYER_6_LOOPBACK_MOSI'],count = count, increment = False , targetQueue = targetQueue), 'little') 
        
    
    async def read_layer_6_loopback_mosi_raw(self, count : int = 1 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LAYER_6_LOOPBACK_MOSI'],count = count, increment = False)
        
    
    
    
    async def read_layer_6_loopback_mosi_read_size(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LAYER_6_LOOPBACK_MOSI_READ_SIZE'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_layer_6_loopback_mosi_read_size_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LAYER_6_LOOPBACK_MOSI_READ_SIZE'],count = count, increment = True)
        
    
    
    
    async def read_layer_7_loopback_mosi(self, count : int = 1 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LAYER_7_LOOPBACK_MOSI'],count = count, increment = False , targetQueue = targetQueue), 'little') 
        
    
    async def read_layer_7_loopback_mosi_raw(self, count : int = 1 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LAYER_7_LOOPBACK_MOSI'],count = count, increment = False)
        
    
    
    
    async def read_layer_7_loopback_mosi_read_size(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LAYER_7_LOOPBACK_MOSI_READ_SIZE'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_layer_7_loopback_mosi_read_size_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LAYER_7_LOOPBACK_MOSI_READ_SIZE'],count = count, increment = True)
        
    
    
    
    async def read_layer_8_loopback_mosi(self, count : int = 1 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LAYER_8_LOOPBACK_MOSI'],count = count, increment = False , targetQueue = targetQueue), 'little') 
        
    
    async def read_layer_8_loopback_mosi_raw(self, count : int = 1 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LAYER_8_LOOPBACK_MOSI'],count = count, increment = False)
        
    
    
    
    async def read_layer_8_loopback_mosi_read_size(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LAYER_8_LOOPBACK_MOSI_READ_SIZE'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_layer_8_loopback_mosi_read_size_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LAYER_8_LOOPBACK_MOSI_READ_SIZE'],count = count, increment = True)
        
    
    
    
    async def read_layer_9_loopback_mosi(self, count : int = 1 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LAYER_9_LOOPBACK_MOSI'],count = count, increment = False , targetQueue = targetQueue), 'little') 
        
    
    async def read_layer_9_loopback_mosi_raw(self, count : int = 1 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LAYER_9_LOOPBACK_MOSI'],count = count, increment = False)
        
    
    
    
    async def read_layer_9_loopback_mosi_read_size(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LAYER_9_LOOPBACK_MOSI_READ_SIZE'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_layer_9_loopback_mosi_read_size_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LAYER_9_LOOPBACK_MOSI_READ_SIZE'],count = count, increment = True)
        
    
    
    
    async def read_layer_10_loopback_mosi(self, count : int = 1 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LAYER_10_LOOPBACK_MOSI'],count = count, increment = False , targetQueue = targetQueue), 'little') 
        
    
    async def read_layer_10_loopback_mosi_raw(self, count : int = 1 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LAYER_10_LOOPBACK_MOSI'],count = count, increment = False)
        
    
    
    
    async def read_layer_10_loopback_mosi_read_size(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LAYER_10_LOOPBACK_MOSI_READ_SIZE'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_layer_10_loopback_mosi_read_size_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LAYER_10_LOOPBACK_MOSI_READ_SIZE'],count = count, increment = True)
        
    
    
    
    async def read_layer_11_loopback_mosi(self, count : int = 1 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LAYER_11_LOOPBACK_MOSI'],count = count, increment = False , targetQueue = targetQueue), 'little') 
        
    
    async def read_layer_11_loopback_mosi_raw(self, count : int = 1 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LAYER_11_LOOPBACK_MOSI'],count = count, increment = False)
        
    
    
    
    async def read_layer_11_loopback_mosi_read_size(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LAYER_11_LOOPBACK_MOSI_READ_SIZE'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_layer_11_loopback_mosi_read_size_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LAYER_11_LOOPBACK_MOSI_READ_SIZE'],count = count, increment = True)
        
    
    
    
    async def read_layer_12_loopback_mosi(self, count : int = 1 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LAYER_12_LOOPBACK_MOSI'],count = count, increment = False , targetQueue = targetQueue), 'little') 
        
    
    async def read_layer_12_loopback_mosi_raw(self, count : int = 1 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LAYER_12_LOOPBACK_MOSI'],count = count, increment = False)
        
    
    
    
    async def read_layer_12_loopback_mosi_read_size(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LAYER_12_LOOPBACK_MOSI_READ_SIZE'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_layer_12_loopback_mosi_read_size_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LAYER_12_LOOPBACK_MOSI_READ_SIZE'],count = count, increment = True)
        
    
    
    
    async def read_layer_13_loopback_mosi(self, count : int = 1 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LAYER_13_LOOPBACK_MOSI'],count = count, increment = False , targetQueue = targetQueue), 'little') 
        
    
    async def read_layer_13_loopback_mosi_raw(self, count : int = 1 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LAYER_13_LOOPBACK_MOSI'],count = count, increment = False)
        
    
    
    
    async def read_layer_13_loopback_mosi_read_size(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LAYER_13_LOOPBACK_MOSI_READ_SIZE'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_layer_13_loopback_mosi_read_size_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LAYER_13_LOOPBACK_MOSI_READ_SIZE'],count = count, increment = True)
        
    
    
    
    async def read_layer_14_loopback_mosi(self, count : int = 1 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LAYER_14_LOOPBACK_MOSI'],count = count, increment = False , targetQueue = targetQueue), 'little') 
        
    
    async def read_layer_14_loopback_mosi_raw(self, count : int = 1 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LAYER_14_LOOPBACK_MOSI'],count = count, increment = False)
        
    
    
    
    async def read_layer_14_loopback_mosi_read_size(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LAYER_14_LOOPBACK_MOSI_READ_SIZE'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_layer_14_loopback_mosi_read_size_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LAYER_14_LOOPBACK_MOSI_READ_SIZE'],count = count, increment = True)
        
    
    
    
    async def read_layer_15_loopback_mosi(self, count : int = 1 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LAYER_15_LOOPBACK_MOSI'],count = count, increment = False , targetQueue = targetQueue), 'little') 
        
    
    async def read_layer_15_loopback_mosi_raw(self, count : int = 1 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LAYER_15_LOOPBACK_MOSI'],count = count, increment = False)
        
    
    
    
    async def read_layer_15_loopback_mosi_read_size(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LAYER_15_LOOPBACK_MOSI_READ_SIZE'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_layer_15_loopback_mosi_read_size_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LAYER_15_LOOPBACK_MOSI_READ_SIZE'],count = count, increment = True)
        
    
    
    
    async def read_layer_16_loopback_mosi(self, count : int = 1 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LAYER_16_LOOPBACK_MOSI'],count = count, increment = False , targetQueue = targetQueue), 'little') 
        
    
    async def read_layer_16_loopback_mosi_raw(self, count : int = 1 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LAYER_16_LOOPBACK_MOSI'],count = count, increment = False)
        
    
    
    
    async def read_layer_16_loopback_mosi_read_size(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LAYER_16_LOOPBACK_MOSI_READ_SIZE'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_layer_16_loopback_mosi_read_size_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LAYER_16_LOOPBACK_MOSI_READ_SIZE'],count = count, increment = True)
        
    
    
    
    async def read_layer_17_loopback_mosi(self, count : int = 1 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LAYER_17_LOOPBACK_MOSI'],count = count, increment = False , targetQueue = targetQueue), 'little') 
        
    
    async def read_layer_17_loopback_mosi_raw(self, count : int = 1 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LAYER_17_LOOPBACK_MOSI'],count = count, increment = False)
        
    
    
    
    async def read_layer_17_loopback_mosi_read_size(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LAYER_17_LOOPBACK_MOSI_READ_SIZE'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_layer_17_loopback_mosi_read_size_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LAYER_17_LOOPBACK_MOSI_READ_SIZE'],count = count, increment = True)
        
    
    
    
    async def read_layer_18_loopback_mosi(self, count : int = 1 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LAYER_18_LOOPBACK_MOSI'],count = count, increment = False , targetQueue = targetQueue), 'little') 
        
    
    async def read_layer_18_loopback_mosi_raw(self, count : int = 1 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LAYER_18_LOOPBACK_MOSI'],count = count, increment = False)
        
    
    
    
    async def read_layer_18_loopback_mosi_read_size(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LAYER_18_LOOPBACK_MOSI_READ_SIZE'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_layer_18_loopback_mosi_read_size_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LAYER_18_LOOPBACK_MOSI_READ_SIZE'],count = count, increment = True)
        
    
    
    
    async def read_layer_19_loopback_mosi(self, count : int = 1 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LAYER_19_LOOPBACK_MOSI'],count = count, increment = False , targetQueue = targetQueue), 'little') 
        
    
    async def read_layer_19_loopback_mosi_raw(self, count : int = 1 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LAYER_19_LOOPBACK_MOSI'],count = count, increment = False)
        
    
    
    
    async def read_layer_19_loopback_mosi_read_size(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LAYER_19_LOOPBACK_MOSI_READ_SIZE'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_layer_19_loopback_mosi_read_size_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LAYER_19_LOOPBACK_MOSI_READ_SIZE'],count = count, increment = True)
        
    
    
    
    async def write_layers_cfg_frame_tag_counter_ctrl(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LAYERS_CFG_FRAME_TAG_COUNTER_CTRL'],value = value,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    async def read_layers_cfg_frame_tag_counter_ctrl(self, count : int = 1 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LAYERS_CFG_FRAME_TAG_COUNTER_CTRL'],count = count, increment = False , targetQueue = targetQueue), 'little') 
        
    
    async def read_layers_cfg_frame_tag_counter_ctrl_raw(self, count : int = 1 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LAYERS_CFG_FRAME_TAG_COUNTER_CTRL'],count = count, increment = False)
        
    
    
    
    async def write_layers_cfg_frame_tag_counter_trigger(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LAYERS_CFG_FRAME_TAG_COUNTER_TRIGGER'],value = value,increment = True,valueLength=4)
        if flush == True:
            await self.flush()
        
    
    async def read_layers_cfg_frame_tag_counter_trigger(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LAYERS_CFG_FRAME_TAG_COUNTER_TRIGGER'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_layers_cfg_frame_tag_counter_trigger_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LAYERS_CFG_FRAME_TAG_COUNTER_TRIGGER'],count = count, increment = True)
        
    
    
    
    async def write_layers_cfg_frame_tag_counter(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LAYERS_CFG_FRAME_TAG_COUNTER'],value = value,increment = True,valueLength=4)
        if flush == True:
            await self.flush()
        
    
    async def read_layers_cfg_frame_tag_counter(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LAYERS_CFG_FRAME_TAG_COUNTER'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_layers_cfg_frame_tag_counter_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LAYERS_CFG_FRAME_TAG_COUNTER'],count = count, increment = True)
        
    
    
    
    async def write_layers_cfg_nodata_continue(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LAYERS_CFG_NODATA_CONTINUE'],value = value,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    async def read_layers_cfg_nodata_continue(self, count : int = 1 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LAYERS_CFG_NODATA_CONTINUE'],count = count, increment = False , targetQueue = targetQueue), 'little') 
        
    
    async def read_layers_cfg_nodata_continue_raw(self, count : int = 1 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LAYERS_CFG_NODATA_CONTINUE'],count = count, increment = False)
        
    
    
    
    async def write_layers_sr_out(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LAYERS_SR_OUT'],value = value,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    async def read_layers_sr_out(self, count : int = 1 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LAYERS_SR_OUT'],count = count, increment = False , targetQueue = targetQueue), 'little') 
        
    
    async def read_layers_sr_out_raw(self, count : int = 1 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LAYERS_SR_OUT'],count = count, increment = False)
        
    
    
    
    async def write_layers_sr_in(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LAYERS_SR_IN'],value = value,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    async def read_layers_sr_in(self, count : int = 1 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LAYERS_SR_IN'],count = count, increment = False , targetQueue = targetQueue), 'little') 
        
    
    async def read_layers_sr_in_raw(self, count : int = 1 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LAYERS_SR_IN'],count = count, increment = False)
        
    
    
    
    async def write_layers_inj_ctrl(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LAYERS_INJ_CTRL'],value = value,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    async def read_layers_inj_ctrl(self, count : int = 1 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LAYERS_INJ_CTRL'],count = count, increment = False , targetQueue = targetQueue), 'little') 
        
    
    async def read_layers_inj_ctrl_raw(self, count : int = 1 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LAYERS_INJ_CTRL'],count = count, increment = False)
        
    
    
    
    async def write_layers_inj_waddr(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LAYERS_INJ_WADDR'],value = value,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    async def read_layers_inj_waddr(self, count : int = 0 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LAYERS_INJ_WADDR'],count = count, increment = False , targetQueue = targetQueue), 'little') 
        
    
    async def read_layers_inj_waddr_raw(self, count : int = 0 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LAYERS_INJ_WADDR'],count = count, increment = False)
        
    
    
    
    async def write_layers_inj_wdata(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LAYERS_INJ_WDATA'],value = value,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    async def read_layers_inj_wdata(self, count : int = 1 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LAYERS_INJ_WDATA'],count = count, increment = False , targetQueue = targetQueue), 'little') 
        
    
    async def read_layers_inj_wdata_raw(self, count : int = 1 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LAYERS_INJ_WDATA'],count = count, increment = False)
        
    
    
    
    async def read_layers_readout(self, count : int = 1 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LAYERS_READOUT'],count = count, increment = False , targetQueue = targetQueue), 'little') 
        
    
    async def read_layers_readout_raw(self, count : int = 1 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LAYERS_READOUT'],count = count, increment = False)
        
    
    
    
    async def read_layers_readout_read_size(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LAYERS_READOUT_READ_SIZE'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_layers_readout_read_size_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LAYERS_READOUT_READ_SIZE'],count = count, increment = True)
        
    
    
    
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
        
    
    
    
    async def write_layers_cfg_frame_tag_counter_trigger_match(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LAYERS_CFG_FRAME_TAG_COUNTER_TRIGGER_MATCH'],value = value,increment = True,valueLength=4)
        if flush == True:
            await self.flush()
        
    
    async def read_layers_cfg_frame_tag_counter_trigger_match(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LAYERS_CFG_FRAME_TAG_COUNTER_TRIGGER_MATCH'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_layers_cfg_frame_tag_counter_trigger_match_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LAYERS_CFG_FRAME_TAG_COUNTER_TRIGGER_MATCH'],count = count, increment = True)
        
    
