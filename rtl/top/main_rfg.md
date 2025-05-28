

# Register File Reference
| Address | Name | Size | Features | Description |
|---------|------|------|-------|-------------|
|0x0 | [hk_firmware_id](#hk_firmware_id) | 32 |  | ID to identify the Firmware|
|0x4 | [hk_firmware_version](#hk_firmware_version) | 32 |  | Date based Build version: YEARMONTHDAYCOUNT|
|0x8 | [hk_xadc_temperature](#hk_xadc_temperature) | 16 |  | XADC FPGA temperature (automatically updated by firmware)|
|0xa | [hk_xadc_vccint](#hk_xadc_vccint) | 16 |  | XADC FPGA VCCINT (automatically updated by firmware)|
|0xc | [hk_conversion_trigger](#hk_conversion_trigger) | 32 | Counter w/ Interrupt | This register is a counter that generates regular interrupts to fetch new XADC values|
|0x10 | [hk_stat_conversions_counter](#hk_stat_conversions_counter) | 32 | Counter w/o Interrupt | Counter increased after each XADC conversion (for information) |
|0x14 | [hk_ctrl](#hk_ctrl) | 8 |  | Controls for HK modules|
|0x15 | [hk_adcdac_mosi_fifo](#hk_adcdac_mosi_fifo) | 8 | AXIS FIFO Master (write) | FIFO to send bytes to ADC or DAC|
|0x16 | [hk_adc_miso_fifo](#hk_adc_miso_fifo) | 8 | AXIS FIFO Slave (read) | FIFO with read bytes from ADC|
|0x17 | [hk_adc_miso_fifo_read_size](#hk_adc_miso_fifo_read_size) | 32 |  | Number of entries in hk_adc_miso_fifo fifo|
|0x1b | [spi_layers_ckdivider](#spi_layers_ckdivider) | 8 |  | This clock divider provides the clock for the Layer SPI interfaces|
|0x1c | [spi_hk_ckdivider](#spi_hk_ckdivider) | 8 |  | This clock divider provides the clock for the Housekeeping ADC/DAC SPI interfaces|
|0x1d | [layer_0_cfg_ctrl](#layer_0_cfg_ctrl) | 8 |  | Layer 0 control bits|
|0x1e | [layer_1_cfg_ctrl](#layer_1_cfg_ctrl) | 8 |  | Layer 1 control bits|
|0x1f | [layer_2_cfg_ctrl](#layer_2_cfg_ctrl) | 8 |  | Layer 2 control bits|
|0x20 | [layer_3_cfg_ctrl](#layer_3_cfg_ctrl) | 8 |  | Layer 3 control bits|
|0x21 | [layer_4_cfg_ctrl](#layer_4_cfg_ctrl) | 8 |  | Layer 4 control bits|
|0x22 | [layer_5_cfg_ctrl](#layer_5_cfg_ctrl) | 8 |  | Layer 5 control bits|
|0x23 | [layer_6_cfg_ctrl](#layer_6_cfg_ctrl) | 8 |  | Layer 6 control bits|
|0x24 | [layer_7_cfg_ctrl](#layer_7_cfg_ctrl) | 8 |  | Layer 7 control bits|
|0x25 | [layer_8_cfg_ctrl](#layer_8_cfg_ctrl) | 8 |  | Layer 8 control bits|
|0x26 | [layer_9_cfg_ctrl](#layer_9_cfg_ctrl) | 8 |  | Layer 9 control bits|
|0x27 | [layer_10_cfg_ctrl](#layer_10_cfg_ctrl) | 8 |  | Layer 10 control bits|
|0x28 | [layer_11_cfg_ctrl](#layer_11_cfg_ctrl) | 8 |  | Layer 11 control bits|
|0x29 | [layer_12_cfg_ctrl](#layer_12_cfg_ctrl) | 8 |  | Layer 12 control bits|
|0x2a | [layer_13_cfg_ctrl](#layer_13_cfg_ctrl) | 8 |  | Layer 13 control bits|
|0x2b | [layer_14_cfg_ctrl](#layer_14_cfg_ctrl) | 8 |  | Layer 14 control bits|
|0x2c | [layer_15_cfg_ctrl](#layer_15_cfg_ctrl) | 8 |  | Layer 15 control bits|
|0x2d | [layer_16_cfg_ctrl](#layer_16_cfg_ctrl) | 8 |  | Layer 16 control bits|
|0x2e | [layer_17_cfg_ctrl](#layer_17_cfg_ctrl) | 8 |  | Layer 17 control bits|
|0x2f | [layer_18_cfg_ctrl](#layer_18_cfg_ctrl) | 8 |  | Layer 18 control bits|
|0x30 | [layer_19_cfg_ctrl](#layer_19_cfg_ctrl) | 8 |  | Layer 19 control bits|
|0x31 | [layer_0_status](#layer_0_status) | 8 |  | Layer 0 status bits|
|0x32 | [layer_1_status](#layer_1_status) | 8 |  | Layer 1 status bits|
|0x33 | [layer_2_status](#layer_2_status) | 8 |  | Layer 2 status bits|
|0x34 | [layer_3_status](#layer_3_status) | 8 |  | Layer 3 status bits|
|0x35 | [layer_4_status](#layer_4_status) | 8 |  | Layer 4 status bits|
|0x36 | [layer_5_status](#layer_5_status) | 8 |  | Layer 5 status bits|
|0x37 | [layer_6_status](#layer_6_status) | 8 |  | Layer 6 status bits|
|0x38 | [layer_7_status](#layer_7_status) | 8 |  | Layer 7 status bits|
|0x39 | [layer_8_status](#layer_8_status) | 8 |  | Layer 8 status bits|
|0x3a | [layer_9_status](#layer_9_status) | 8 |  | Layer 9 status bits|
|0x3b | [layer_10_status](#layer_10_status) | 8 |  | Layer 10 status bits|
|0x3c | [layer_11_status](#layer_11_status) | 8 |  | Layer 11 status bits|
|0x3d | [layer_12_status](#layer_12_status) | 8 |  | Layer 12 status bits|
|0x3e | [layer_13_status](#layer_13_status) | 8 |  | Layer 13 status bits|
|0x3f | [layer_14_status](#layer_14_status) | 8 |  | Layer 14 status bits|
|0x40 | [layer_15_status](#layer_15_status) | 8 |  | Layer 15 status bits|
|0x41 | [layer_16_status](#layer_16_status) | 8 |  | Layer 16 status bits|
|0x42 | [layer_17_status](#layer_17_status) | 8 |  | Layer 17 status bits|
|0x43 | [layer_18_status](#layer_18_status) | 8 |  | Layer 18 status bits|
|0x44 | [layer_19_status](#layer_19_status) | 8 |  | Layer 19 status bits|
|0x45 | [layer_0_stat_frame_counter](#layer_0_stat_frame_counter) | 32 | Counter w/o Interrupt | Counts the number of data frames|
|0x49 | [layer_1_stat_frame_counter](#layer_1_stat_frame_counter) | 32 | Counter w/o Interrupt | Counts the number of data frames|
|0x4d | [layer_2_stat_frame_counter](#layer_2_stat_frame_counter) | 32 | Counter w/o Interrupt | Counts the number of data frames|
|0x51 | [layer_3_stat_frame_counter](#layer_3_stat_frame_counter) | 32 | Counter w/o Interrupt | Counts the number of data frames|
|0x55 | [layer_4_stat_frame_counter](#layer_4_stat_frame_counter) | 32 | Counter w/o Interrupt | Counts the number of data frames|
|0x59 | [layer_5_stat_frame_counter](#layer_5_stat_frame_counter) | 32 | Counter w/o Interrupt | Counts the number of data frames|
|0x5d | [layer_6_stat_frame_counter](#layer_6_stat_frame_counter) | 32 | Counter w/o Interrupt | Counts the number of data frames|
|0x61 | [layer_7_stat_frame_counter](#layer_7_stat_frame_counter) | 32 | Counter w/o Interrupt | Counts the number of data frames|
|0x65 | [layer_8_stat_frame_counter](#layer_8_stat_frame_counter) | 32 | Counter w/o Interrupt | Counts the number of data frames|
|0x69 | [layer_9_stat_frame_counter](#layer_9_stat_frame_counter) | 32 | Counter w/o Interrupt | Counts the number of data frames|
|0x6d | [layer_10_stat_frame_counter](#layer_10_stat_frame_counter) | 32 | Counter w/o Interrupt | Counts the number of data frames|
|0x71 | [layer_11_stat_frame_counter](#layer_11_stat_frame_counter) | 32 | Counter w/o Interrupt | Counts the number of data frames|
|0x75 | [layer_12_stat_frame_counter](#layer_12_stat_frame_counter) | 32 | Counter w/o Interrupt | Counts the number of data frames|
|0x79 | [layer_13_stat_frame_counter](#layer_13_stat_frame_counter) | 32 | Counter w/o Interrupt | Counts the number of data frames|
|0x7d | [layer_14_stat_frame_counter](#layer_14_stat_frame_counter) | 32 | Counter w/o Interrupt | Counts the number of data frames|
|0x81 | [layer_15_stat_frame_counter](#layer_15_stat_frame_counter) | 32 | Counter w/o Interrupt | Counts the number of data frames|
|0x85 | [layer_16_stat_frame_counter](#layer_16_stat_frame_counter) | 32 | Counter w/o Interrupt | Counts the number of data frames|
|0x89 | [layer_17_stat_frame_counter](#layer_17_stat_frame_counter) | 32 | Counter w/o Interrupt | Counts the number of data frames|
|0x8d | [layer_18_stat_frame_counter](#layer_18_stat_frame_counter) | 32 | Counter w/o Interrupt | Counts the number of data frames|
|0x91 | [layer_19_stat_frame_counter](#layer_19_stat_frame_counter) | 32 | Counter w/o Interrupt | Counts the number of data frames|
|0x95 | [layer_0_stat_idle_counter](#layer_0_stat_idle_counter) | 32 | Counter w/o Interrupt | Counts the number of Idle bytes|
|0x99 | [layer_1_stat_idle_counter](#layer_1_stat_idle_counter) | 32 | Counter w/o Interrupt | Counts the number of Idle bytes|
|0x9d | [layer_2_stat_idle_counter](#layer_2_stat_idle_counter) | 32 | Counter w/o Interrupt | Counts the number of Idle bytes|
|0xa1 | [layer_3_stat_idle_counter](#layer_3_stat_idle_counter) | 32 | Counter w/o Interrupt | Counts the number of Idle bytes|
|0xa5 | [layer_4_stat_idle_counter](#layer_4_stat_idle_counter) | 32 | Counter w/o Interrupt | Counts the number of Idle bytes|
|0xa9 | [layer_5_stat_idle_counter](#layer_5_stat_idle_counter) | 32 | Counter w/o Interrupt | Counts the number of Idle bytes|
|0xad | [layer_6_stat_idle_counter](#layer_6_stat_idle_counter) | 32 | Counter w/o Interrupt | Counts the number of Idle bytes|
|0xb1 | [layer_7_stat_idle_counter](#layer_7_stat_idle_counter) | 32 | Counter w/o Interrupt | Counts the number of Idle bytes|
|0xb5 | [layer_8_stat_idle_counter](#layer_8_stat_idle_counter) | 32 | Counter w/o Interrupt | Counts the number of Idle bytes|
|0xb9 | [layer_9_stat_idle_counter](#layer_9_stat_idle_counter) | 32 | Counter w/o Interrupt | Counts the number of Idle bytes|
|0xbd | [layer_10_stat_idle_counter](#layer_10_stat_idle_counter) | 32 | Counter w/o Interrupt | Counts the number of Idle bytes|
|0xc1 | [layer_11_stat_idle_counter](#layer_11_stat_idle_counter) | 32 | Counter w/o Interrupt | Counts the number of Idle bytes|
|0xc5 | [layer_12_stat_idle_counter](#layer_12_stat_idle_counter) | 32 | Counter w/o Interrupt | Counts the number of Idle bytes|
|0xc9 | [layer_13_stat_idle_counter](#layer_13_stat_idle_counter) | 32 | Counter w/o Interrupt | Counts the number of Idle bytes|
|0xcd | [layer_14_stat_idle_counter](#layer_14_stat_idle_counter) | 32 | Counter w/o Interrupt | Counts the number of Idle bytes|
|0xd1 | [layer_15_stat_idle_counter](#layer_15_stat_idle_counter) | 32 | Counter w/o Interrupt | Counts the number of Idle bytes|
|0xd5 | [layer_16_stat_idle_counter](#layer_16_stat_idle_counter) | 32 | Counter w/o Interrupt | Counts the number of Idle bytes|
|0xd9 | [layer_17_stat_idle_counter](#layer_17_stat_idle_counter) | 32 | Counter w/o Interrupt | Counts the number of Idle bytes|
|0xdd | [layer_18_stat_idle_counter](#layer_18_stat_idle_counter) | 32 | Counter w/o Interrupt | Counts the number of Idle bytes|
|0xe1 | [layer_19_stat_idle_counter](#layer_19_stat_idle_counter) | 32 | Counter w/o Interrupt | Counts the number of Idle bytes|
|0xe5 | [layer_0_mosi](#layer_0_mosi) | 8 | AXIS FIFO Master (write) | FIFO to send bytes to Layer 0 Astropix|
|0xe6 | [layer_0_mosi_write_size](#layer_0_mosi_write_size) | 32 |  | Number of entries in layer_0_mosi fifo|
|0xea | [layer_1_mosi](#layer_1_mosi) | 8 | AXIS FIFO Master (write) | FIFO to send bytes to Layer 1 Astropix|
|0xeb | [layer_1_mosi_write_size](#layer_1_mosi_write_size) | 32 |  | Number of entries in layer_1_mosi fifo|
|0xef | [layer_2_mosi](#layer_2_mosi) | 8 | AXIS FIFO Master (write) | FIFO to send bytes to Layer 2 Astropix|
|0xf0 | [layer_2_mosi_write_size](#layer_2_mosi_write_size) | 32 |  | Number of entries in layer_2_mosi fifo|
|0xf4 | [layer_3_mosi](#layer_3_mosi) | 8 | AXIS FIFO Master (write) | FIFO to send bytes to Layer 3 Astropix|
|0xf5 | [layer_3_mosi_write_size](#layer_3_mosi_write_size) | 32 |  | Number of entries in layer_3_mosi fifo|
|0xf9 | [layer_4_mosi](#layer_4_mosi) | 8 | AXIS FIFO Master (write) | FIFO to send bytes to Layer 4 Astropix|
|0xfa | [layer_4_mosi_write_size](#layer_4_mosi_write_size) | 32 |  | Number of entries in layer_4_mosi fifo|
|0xfe | [layer_5_mosi](#layer_5_mosi) | 8 | AXIS FIFO Master (write) | FIFO to send bytes to Layer 5 Astropix|
|0xff | [layer_5_mosi_write_size](#layer_5_mosi_write_size) | 32 |  | Number of entries in layer_5_mosi fifo|
|0x103 | [layer_6_mosi](#layer_6_mosi) | 8 | AXIS FIFO Master (write) | FIFO to send bytes to Layer 6 Astropix|
|0x104 | [layer_6_mosi_write_size](#layer_6_mosi_write_size) | 32 |  | Number of entries in layer_6_mosi fifo|
|0x108 | [layer_7_mosi](#layer_7_mosi) | 8 | AXIS FIFO Master (write) | FIFO to send bytes to Layer 7 Astropix|
|0x109 | [layer_7_mosi_write_size](#layer_7_mosi_write_size) | 32 |  | Number of entries in layer_7_mosi fifo|
|0x10d | [layer_8_mosi](#layer_8_mosi) | 8 | AXIS FIFO Master (write) | FIFO to send bytes to Layer 8 Astropix|
|0x10e | [layer_8_mosi_write_size](#layer_8_mosi_write_size) | 32 |  | Number of entries in layer_8_mosi fifo|
|0x112 | [layer_9_mosi](#layer_9_mosi) | 8 | AXIS FIFO Master (write) | FIFO to send bytes to Layer 9 Astropix|
|0x113 | [layer_9_mosi_write_size](#layer_9_mosi_write_size) | 32 |  | Number of entries in layer_9_mosi fifo|
|0x117 | [layer_10_mosi](#layer_10_mosi) | 8 | AXIS FIFO Master (write) | FIFO to send bytes to Layer 10 Astropix|
|0x118 | [layer_10_mosi_write_size](#layer_10_mosi_write_size) | 32 |  | Number of entries in layer_10_mosi fifo|
|0x11c | [layer_11_mosi](#layer_11_mosi) | 8 | AXIS FIFO Master (write) | FIFO to send bytes to Layer 11 Astropix|
|0x11d | [layer_11_mosi_write_size](#layer_11_mosi_write_size) | 32 |  | Number of entries in layer_11_mosi fifo|
|0x121 | [layer_12_mosi](#layer_12_mosi) | 8 | AXIS FIFO Master (write) | FIFO to send bytes to Layer 12 Astropix|
|0x122 | [layer_12_mosi_write_size](#layer_12_mosi_write_size) | 32 |  | Number of entries in layer_12_mosi fifo|
|0x126 | [layer_13_mosi](#layer_13_mosi) | 8 | AXIS FIFO Master (write) | FIFO to send bytes to Layer 13 Astropix|
|0x127 | [layer_13_mosi_write_size](#layer_13_mosi_write_size) | 32 |  | Number of entries in layer_13_mosi fifo|
|0x12b | [layer_14_mosi](#layer_14_mosi) | 8 | AXIS FIFO Master (write) | FIFO to send bytes to Layer 14 Astropix|
|0x12c | [layer_14_mosi_write_size](#layer_14_mosi_write_size) | 32 |  | Number of entries in layer_14_mosi fifo|
|0x130 | [layer_15_mosi](#layer_15_mosi) | 8 | AXIS FIFO Master (write) | FIFO to send bytes to Layer 15 Astropix|
|0x131 | [layer_15_mosi_write_size](#layer_15_mosi_write_size) | 32 |  | Number of entries in layer_15_mosi fifo|
|0x135 | [layer_16_mosi](#layer_16_mosi) | 8 | AXIS FIFO Master (write) | FIFO to send bytes to Layer 16 Astropix|
|0x136 | [layer_16_mosi_write_size](#layer_16_mosi_write_size) | 32 |  | Number of entries in layer_16_mosi fifo|
|0x13a | [layer_17_mosi](#layer_17_mosi) | 8 | AXIS FIFO Master (write) | FIFO to send bytes to Layer 17 Astropix|
|0x13b | [layer_17_mosi_write_size](#layer_17_mosi_write_size) | 32 |  | Number of entries in layer_17_mosi fifo|
|0x13f | [layer_18_mosi](#layer_18_mosi) | 8 | AXIS FIFO Master (write) | FIFO to send bytes to Layer 18 Astropix|
|0x140 | [layer_18_mosi_write_size](#layer_18_mosi_write_size) | 32 |  | Number of entries in layer_18_mosi fifo|
|0x144 | [layer_19_mosi](#layer_19_mosi) | 8 | AXIS FIFO Master (write) | FIFO to send bytes to Layer 19 Astropix|
|0x145 | [layer_19_mosi_write_size](#layer_19_mosi_write_size) | 32 |  | Number of entries in layer_19_mosi fifo|
|0x149 | [layer_0_loopback_miso](#layer_0_loopback_miso) | 8 | AXIS FIFO Master (write) | FIFO to send bytes to Layer 0 Astropix throug internal slave loopback|
|0x14a | [layer_0_loopback_miso_write_size](#layer_0_loopback_miso_write_size) | 32 |  | Number of entries in layer_0_loopback_miso fifo|
|0x14e | [layer_1_loopback_miso](#layer_1_loopback_miso) | 8 | AXIS FIFO Master (write) | FIFO to send bytes to Layer 1 Astropix throug internal slave loopback|
|0x14f | [layer_1_loopback_miso_write_size](#layer_1_loopback_miso_write_size) | 32 |  | Number of entries in layer_1_loopback_miso fifo|
|0x153 | [layer_2_loopback_miso](#layer_2_loopback_miso) | 8 | AXIS FIFO Master (write) | FIFO to send bytes to Layer 2 Astropix throug internal slave loopback|
|0x154 | [layer_2_loopback_miso_write_size](#layer_2_loopback_miso_write_size) | 32 |  | Number of entries in layer_2_loopback_miso fifo|
|0x158 | [layer_3_loopback_miso](#layer_3_loopback_miso) | 8 | AXIS FIFO Master (write) | FIFO to send bytes to Layer 3 Astropix throug internal slave loopback|
|0x159 | [layer_3_loopback_miso_write_size](#layer_3_loopback_miso_write_size) | 32 |  | Number of entries in layer_3_loopback_miso fifo|
|0x15d | [layer_4_loopback_miso](#layer_4_loopback_miso) | 8 | AXIS FIFO Master (write) | FIFO to send bytes to Layer 4 Astropix throug internal slave loopback|
|0x15e | [layer_4_loopback_miso_write_size](#layer_4_loopback_miso_write_size) | 32 |  | Number of entries in layer_4_loopback_miso fifo|
|0x162 | [layer_5_loopback_miso](#layer_5_loopback_miso) | 8 | AXIS FIFO Master (write) | FIFO to send bytes to Layer 5 Astropix throug internal slave loopback|
|0x163 | [layer_5_loopback_miso_write_size](#layer_5_loopback_miso_write_size) | 32 |  | Number of entries in layer_5_loopback_miso fifo|
|0x167 | [layer_6_loopback_miso](#layer_6_loopback_miso) | 8 | AXIS FIFO Master (write) | FIFO to send bytes to Layer 6 Astropix throug internal slave loopback|
|0x168 | [layer_6_loopback_miso_write_size](#layer_6_loopback_miso_write_size) | 32 |  | Number of entries in layer_6_loopback_miso fifo|
|0x16c | [layer_7_loopback_miso](#layer_7_loopback_miso) | 8 | AXIS FIFO Master (write) | FIFO to send bytes to Layer 7 Astropix throug internal slave loopback|
|0x16d | [layer_7_loopback_miso_write_size](#layer_7_loopback_miso_write_size) | 32 |  | Number of entries in layer_7_loopback_miso fifo|
|0x171 | [layer_8_loopback_miso](#layer_8_loopback_miso) | 8 | AXIS FIFO Master (write) | FIFO to send bytes to Layer 8 Astropix throug internal slave loopback|
|0x172 | [layer_8_loopback_miso_write_size](#layer_8_loopback_miso_write_size) | 32 |  | Number of entries in layer_8_loopback_miso fifo|
|0x176 | [layer_9_loopback_miso](#layer_9_loopback_miso) | 8 | AXIS FIFO Master (write) | FIFO to send bytes to Layer 9 Astropix throug internal slave loopback|
|0x177 | [layer_9_loopback_miso_write_size](#layer_9_loopback_miso_write_size) | 32 |  | Number of entries in layer_9_loopback_miso fifo|
|0x17b | [layer_10_loopback_miso](#layer_10_loopback_miso) | 8 | AXIS FIFO Master (write) | FIFO to send bytes to Layer 10 Astropix throug internal slave loopback|
|0x17c | [layer_10_loopback_miso_write_size](#layer_10_loopback_miso_write_size) | 32 |  | Number of entries in layer_10_loopback_miso fifo|
|0x180 | [layer_11_loopback_miso](#layer_11_loopback_miso) | 8 | AXIS FIFO Master (write) | FIFO to send bytes to Layer 11 Astropix throug internal slave loopback|
|0x181 | [layer_11_loopback_miso_write_size](#layer_11_loopback_miso_write_size) | 32 |  | Number of entries in layer_11_loopback_miso fifo|
|0x185 | [layer_12_loopback_miso](#layer_12_loopback_miso) | 8 | AXIS FIFO Master (write) | FIFO to send bytes to Layer 12 Astropix throug internal slave loopback|
|0x186 | [layer_12_loopback_miso_write_size](#layer_12_loopback_miso_write_size) | 32 |  | Number of entries in layer_12_loopback_miso fifo|
|0x18a | [layer_13_loopback_miso](#layer_13_loopback_miso) | 8 | AXIS FIFO Master (write) | FIFO to send bytes to Layer 13 Astropix throug internal slave loopback|
|0x18b | [layer_13_loopback_miso_write_size](#layer_13_loopback_miso_write_size) | 32 |  | Number of entries in layer_13_loopback_miso fifo|
|0x18f | [layer_14_loopback_miso](#layer_14_loopback_miso) | 8 | AXIS FIFO Master (write) | FIFO to send bytes to Layer 14 Astropix throug internal slave loopback|
|0x190 | [layer_14_loopback_miso_write_size](#layer_14_loopback_miso_write_size) | 32 |  | Number of entries in layer_14_loopback_miso fifo|
|0x194 | [layer_15_loopback_miso](#layer_15_loopback_miso) | 8 | AXIS FIFO Master (write) | FIFO to send bytes to Layer 15 Astropix throug internal slave loopback|
|0x195 | [layer_15_loopback_miso_write_size](#layer_15_loopback_miso_write_size) | 32 |  | Number of entries in layer_15_loopback_miso fifo|
|0x199 | [layer_16_loopback_miso](#layer_16_loopback_miso) | 8 | AXIS FIFO Master (write) | FIFO to send bytes to Layer 16 Astropix throug internal slave loopback|
|0x19a | [layer_16_loopback_miso_write_size](#layer_16_loopback_miso_write_size) | 32 |  | Number of entries in layer_16_loopback_miso fifo|
|0x19e | [layer_17_loopback_miso](#layer_17_loopback_miso) | 8 | AXIS FIFO Master (write) | FIFO to send bytes to Layer 17 Astropix throug internal slave loopback|
|0x19f | [layer_17_loopback_miso_write_size](#layer_17_loopback_miso_write_size) | 32 |  | Number of entries in layer_17_loopback_miso fifo|
|0x1a3 | [layer_18_loopback_miso](#layer_18_loopback_miso) | 8 | AXIS FIFO Master (write) | FIFO to send bytes to Layer 18 Astropix throug internal slave loopback|
|0x1a4 | [layer_18_loopback_miso_write_size](#layer_18_loopback_miso_write_size) | 32 |  | Number of entries in layer_18_loopback_miso fifo|
|0x1a8 | [layer_19_loopback_miso](#layer_19_loopback_miso) | 8 | AXIS FIFO Master (write) | FIFO to send bytes to Layer 19 Astropix throug internal slave loopback|
|0x1a9 | [layer_19_loopback_miso_write_size](#layer_19_loopback_miso_write_size) | 32 |  | Number of entries in layer_19_loopback_miso fifo|
|0x1ad | [layer_0_loopback_mosi](#layer_0_loopback_mosi) | 8 | AXIS FIFO Slave (read) | FIFO to read bytes received by internal slave loopback|
|0x1ae | [layer_0_loopback_mosi_read_size](#layer_0_loopback_mosi_read_size) | 32 |  | Number of entries in layer_0_loopback_mosi fifo|
|0x1b2 | [layer_1_loopback_mosi](#layer_1_loopback_mosi) | 8 | AXIS FIFO Slave (read) | FIFO to read bytes received by internal slave loopback|
|0x1b3 | [layer_1_loopback_mosi_read_size](#layer_1_loopback_mosi_read_size) | 32 |  | Number of entries in layer_1_loopback_mosi fifo|
|0x1b7 | [layer_2_loopback_mosi](#layer_2_loopback_mosi) | 8 | AXIS FIFO Slave (read) | FIFO to read bytes received by internal slave loopback|
|0x1b8 | [layer_2_loopback_mosi_read_size](#layer_2_loopback_mosi_read_size) | 32 |  | Number of entries in layer_2_loopback_mosi fifo|
|0x1bc | [layer_3_loopback_mosi](#layer_3_loopback_mosi) | 8 | AXIS FIFO Slave (read) | FIFO to read bytes received by internal slave loopback|
|0x1bd | [layer_3_loopback_mosi_read_size](#layer_3_loopback_mosi_read_size) | 32 |  | Number of entries in layer_3_loopback_mosi fifo|
|0x1c1 | [layer_4_loopback_mosi](#layer_4_loopback_mosi) | 8 | AXIS FIFO Slave (read) | FIFO to read bytes received by internal slave loopback|
|0x1c2 | [layer_4_loopback_mosi_read_size](#layer_4_loopback_mosi_read_size) | 32 |  | Number of entries in layer_4_loopback_mosi fifo|
|0x1c6 | [layer_5_loopback_mosi](#layer_5_loopback_mosi) | 8 | AXIS FIFO Slave (read) | FIFO to read bytes received by internal slave loopback|
|0x1c7 | [layer_5_loopback_mosi_read_size](#layer_5_loopback_mosi_read_size) | 32 |  | Number of entries in layer_5_loopback_mosi fifo|
|0x1cb | [layer_6_loopback_mosi](#layer_6_loopback_mosi) | 8 | AXIS FIFO Slave (read) | FIFO to read bytes received by internal slave loopback|
|0x1cc | [layer_6_loopback_mosi_read_size](#layer_6_loopback_mosi_read_size) | 32 |  | Number of entries in layer_6_loopback_mosi fifo|
|0x1d0 | [layer_7_loopback_mosi](#layer_7_loopback_mosi) | 8 | AXIS FIFO Slave (read) | FIFO to read bytes received by internal slave loopback|
|0x1d1 | [layer_7_loopback_mosi_read_size](#layer_7_loopback_mosi_read_size) | 32 |  | Number of entries in layer_7_loopback_mosi fifo|
|0x1d5 | [layer_8_loopback_mosi](#layer_8_loopback_mosi) | 8 | AXIS FIFO Slave (read) | FIFO to read bytes received by internal slave loopback|
|0x1d6 | [layer_8_loopback_mosi_read_size](#layer_8_loopback_mosi_read_size) | 32 |  | Number of entries in layer_8_loopback_mosi fifo|
|0x1da | [layer_9_loopback_mosi](#layer_9_loopback_mosi) | 8 | AXIS FIFO Slave (read) | FIFO to read bytes received by internal slave loopback|
|0x1db | [layer_9_loopback_mosi_read_size](#layer_9_loopback_mosi_read_size) | 32 |  | Number of entries in layer_9_loopback_mosi fifo|
|0x1df | [layer_10_loopback_mosi](#layer_10_loopback_mosi) | 8 | AXIS FIFO Slave (read) | FIFO to read bytes received by internal slave loopback|
|0x1e0 | [layer_10_loopback_mosi_read_size](#layer_10_loopback_mosi_read_size) | 32 |  | Number of entries in layer_10_loopback_mosi fifo|
|0x1e4 | [layer_11_loopback_mosi](#layer_11_loopback_mosi) | 8 | AXIS FIFO Slave (read) | FIFO to read bytes received by internal slave loopback|
|0x1e5 | [layer_11_loopback_mosi_read_size](#layer_11_loopback_mosi_read_size) | 32 |  | Number of entries in layer_11_loopback_mosi fifo|
|0x1e9 | [layer_12_loopback_mosi](#layer_12_loopback_mosi) | 8 | AXIS FIFO Slave (read) | FIFO to read bytes received by internal slave loopback|
|0x1ea | [layer_12_loopback_mosi_read_size](#layer_12_loopback_mosi_read_size) | 32 |  | Number of entries in layer_12_loopback_mosi fifo|
|0x1ee | [layer_13_loopback_mosi](#layer_13_loopback_mosi) | 8 | AXIS FIFO Slave (read) | FIFO to read bytes received by internal slave loopback|
|0x1ef | [layer_13_loopback_mosi_read_size](#layer_13_loopback_mosi_read_size) | 32 |  | Number of entries in layer_13_loopback_mosi fifo|
|0x1f3 | [layer_14_loopback_mosi](#layer_14_loopback_mosi) | 8 | AXIS FIFO Slave (read) | FIFO to read bytes received by internal slave loopback|
|0x1f4 | [layer_14_loopback_mosi_read_size](#layer_14_loopback_mosi_read_size) | 32 |  | Number of entries in layer_14_loopback_mosi fifo|
|0x1f8 | [layer_15_loopback_mosi](#layer_15_loopback_mosi) | 8 | AXIS FIFO Slave (read) | FIFO to read bytes received by internal slave loopback|
|0x1f9 | [layer_15_loopback_mosi_read_size](#layer_15_loopback_mosi_read_size) | 32 |  | Number of entries in layer_15_loopback_mosi fifo|
|0x1fd | [layer_16_loopback_mosi](#layer_16_loopback_mosi) | 8 | AXIS FIFO Slave (read) | FIFO to read bytes received by internal slave loopback|
|0x1fe | [layer_16_loopback_mosi_read_size](#layer_16_loopback_mosi_read_size) | 32 |  | Number of entries in layer_16_loopback_mosi fifo|
|0x202 | [layer_17_loopback_mosi](#layer_17_loopback_mosi) | 8 | AXIS FIFO Slave (read) | FIFO to read bytes received by internal slave loopback|
|0x203 | [layer_17_loopback_mosi_read_size](#layer_17_loopback_mosi_read_size) | 32 |  | Number of entries in layer_17_loopback_mosi fifo|
|0x207 | [layer_18_loopback_mosi](#layer_18_loopback_mosi) | 8 | AXIS FIFO Slave (read) | FIFO to read bytes received by internal slave loopback|
|0x208 | [layer_18_loopback_mosi_read_size](#layer_18_loopback_mosi_read_size) | 32 |  | Number of entries in layer_18_loopback_mosi fifo|
|0x20c | [layer_19_loopback_mosi](#layer_19_loopback_mosi) | 8 | AXIS FIFO Slave (read) | FIFO to read bytes received by internal slave loopback|
|0x20d | [layer_19_loopback_mosi_read_size](#layer_19_loopback_mosi_read_size) | 32 |  | Number of entries in layer_19_loopback_mosi fifo|
|0x211 | [layers_cfg_frame_tag_counter_ctrl](#layers_cfg_frame_tag_counter_ctrl) | 8 |  | A few bits to control the Frame Tagging Counter|
|0x212 | [layers_cfg_frame_tag_counter_trigger](#layers_cfg_frame_tag_counter_trigger) | 32 | Counter w/ Interrupt | This Interrupt Counter provides the enable signal for the frame tag counter|
|0x216 | [layers_cfg_frame_tag_counter](#layers_cfg_frame_tag_counter) | 32 | Counter w/o Interrupt | Counter to tag frames upon detection (Counter value added to frame output)|
|0x21a | [layers_cfg_nodata_continue](#layers_cfg_nodata_continue) | 8 |  | Number of IDLE Bytes until stopping readout|
|0x21b | [layers_sr_out](#layers_sr_out) | 8 |  | Shift Register Configuration I/O Control register|
|0x21c | [layers_sr_in](#layers_sr_in) | 8 |  | Shift Register Configuration Input control (Readback enable and layers inputs)|
|0x21d | [layers_inj_ctrl](#layers_inj_ctrl) | 8 |  | Control bits for the Injection Pattern Generator|
|0x21e | [layers_inj_waddr](#layers_inj_waddr) | 4 |  | Address for register to write in Injection Pattern Generator|
|0x21f | [layers_inj_wdata](#layers_inj_wdata) | 8 |  | Data for register to write in Injection Pattern Generator|
|0x220 | [layers_readout](#layers_readout) | 8 | AXIS FIFO Slave (read) | Reads from the readout data fifo|
|0x221 | [layers_readout_read_size](#layers_readout_read_size) | 32 |  | Number of entries in layers_readout fifo|
|0x225 | [io_ctrl](#io_ctrl) | 8 |  | Configuration register for I/O multiplexers and gating.|
|0x226 | [io_led](#io_led) | 8 |  | This register is connected to the Board's LED. See target documentation for detailed connection information.|
|0x227 | [gecco_sr_ctrl](#gecco_sr_ctrl) | 8 |  | Shift Register Control for Gecco Cards|
|0x228 | [hk_conversion_trigger_match](#hk_conversion_trigger_match) | 32 |  | |
|0x22c | [layers_cfg_frame_tag_counter_trigger_match](#layers_cfg_frame_tag_counter_trigger_match) | 32 |  | |


## <a id='hk_firmware_id'></a>hk_firmware_id


> ID to identify the Firmware


**Address**: 0x0


**Reset Value**: 32'h0000ff00




## <a id='hk_firmware_version'></a>hk_firmware_version


> Date based Build version: YEARMONTHDAYCOUNT


**Address**: 0x4


**Reset Value**: 32'd2024112001




## <a id='hk_xadc_temperature'></a>hk_xadc_temperature


> XADC FPGA temperature (automatically updated by firmware)


**Address**: 0x8






## <a id='hk_xadc_vccint'></a>hk_xadc_vccint


> XADC FPGA VCCINT (automatically updated by firmware)


**Address**: 0xa






## <a id='hk_conversion_trigger'></a>hk_conversion_trigger


> This register is a counter that generates regular interrupts to fetch new XADC values


**Address**: 0xc






## <a id='hk_stat_conversions_counter'></a>hk_stat_conversions_counter


> Counter increased after each XADC conversion (for information) 


**Address**: 0x10






## <a id='hk_ctrl'></a>hk_ctrl


> Controls for HK modules


**Address**: 0x14




|[7:3] |2 |1 |0 |
|--|-- |-- |-- |
|RSVD |select_adc2|select_adc1|select_adc0|

- select_adc0: Selects ADC 0
- select_adc1: Selects ADC 1
- select_adc2: Selects ADC 2


## <a id='hk_adcdac_mosi_fifo'></a>hk_adcdac_mosi_fifo


> FIFO to send bytes to ADC or DAC


**Address**: 0x15






## <a id='hk_adc_miso_fifo'></a>hk_adc_miso_fifo


> FIFO with read bytes from ADC


**Address**: 0x16






## <a id='hk_adc_miso_fifo_read_size'></a>hk_adc_miso_fifo_read_size


> Number of entries in hk_adc_miso_fifo fifo


**Address**: 0x17






## <a id='spi_layers_ckdivider'></a>spi_layers_ckdivider


> This clock divider provides the clock for the Layer SPI interfaces


**Address**: 0x1b


**Reset Value**: 8'h4




## <a id='spi_hk_ckdivider'></a>spi_hk_ckdivider


> This clock divider provides the clock for the Housekeeping ADC/DAC SPI interfaces


**Address**: 0x1c


**Reset Value**: 8'h4




## <a id='layer_0_cfg_ctrl'></a>layer_0_cfg_ctrl


> Layer 0 control bits


**Address**: 0x1d


**Reset Value**: 8'b00000111


|[7:6] |5 |4 |3 |2 |1 |0 |
|--|-- |-- |-- |-- |-- |-- |
|RSVD |loopback|disable_miso|cs|disable_autoread|reset|hold|

- hold: Hold Layer
- reset: Active High Layer Reset (Inverted before output to Sensor)
- disable_autoread: 1: Layer doesn't read frames if the interrupt is low, 0: Layer reads frames upon interrupt trigger
- cs: Chip Select, active high (inverted in firmware) - Set to 1 to force chip select low - if autoread is active, chip select is automatically 1
- disable_miso: If 1, the SPI interface won't read bytes from MOSI
- loopback: If 1, the Layer SPI Master is connected to the matching internal SPI Slave


## <a id='layer_1_cfg_ctrl'></a>layer_1_cfg_ctrl


> Layer 1 control bits


**Address**: 0x1e


**Reset Value**: 8'b00000111


|[7:6] |5 |4 |3 |2 |1 |0 |
|--|-- |-- |-- |-- |-- |-- |
|RSVD |loopback|disable_miso|cs|disable_autoread|reset|hold|

- hold: Hold Layer
- reset: Active High Layer Reset (Inverted before output to Sensor)
- disable_autoread: 1: Layer doesn't read frames if the interrupt is low, 0: Layer reads frames upon interrupt trigger
- cs: Chip Select, active high (inverted in firmware) - Set to 1 to force chip select low - if autoread is active, chip select is automatically 1
- disable_miso: If 1, the SPI interface won't read bytes from MOSI
- loopback: If 1, the Layer SPI Master is connected to the matching internal SPI Slave


## <a id='layer_2_cfg_ctrl'></a>layer_2_cfg_ctrl


> Layer 2 control bits


**Address**: 0x1f


**Reset Value**: 8'b00000111


|[7:6] |5 |4 |3 |2 |1 |0 |
|--|-- |-- |-- |-- |-- |-- |
|RSVD |loopback|disable_miso|cs|disable_autoread|reset|hold|

- hold: Hold Layer
- reset: Active High Layer Reset (Inverted before output to Sensor)
- disable_autoread: 1: Layer doesn't read frames if the interrupt is low, 0: Layer reads frames upon interrupt trigger
- cs: Chip Select, active high (inverted in firmware) - Set to 1 to force chip select low - if autoread is active, chip select is automatically 1
- disable_miso: If 1, the SPI interface won't read bytes from MOSI
- loopback: If 1, the Layer SPI Master is connected to the matching internal SPI Slave


## <a id='layer_3_cfg_ctrl'></a>layer_3_cfg_ctrl


> Layer 3 control bits


**Address**: 0x20


**Reset Value**: 8'b00000111


|[7:6] |5 |4 |3 |2 |1 |0 |
|--|-- |-- |-- |-- |-- |-- |
|RSVD |loopback|disable_miso|cs|disable_autoread|reset|hold|

- hold: Hold Layer
- reset: Active High Layer Reset (Inverted before output to Sensor)
- disable_autoread: 1: Layer doesn't read frames if the interrupt is low, 0: Layer reads frames upon interrupt trigger
- cs: Chip Select, active high (inverted in firmware) - Set to 1 to force chip select low - if autoread is active, chip select is automatically 1
- disable_miso: If 1, the SPI interface won't read bytes from MOSI
- loopback: If 1, the Layer SPI Master is connected to the matching internal SPI Slave


## <a id='layer_4_cfg_ctrl'></a>layer_4_cfg_ctrl


> Layer 4 control bits


**Address**: 0x21


**Reset Value**: 8'b00000111


|[7:6] |5 |4 |3 |2 |1 |0 |
|--|-- |-- |-- |-- |-- |-- |
|RSVD |loopback|disable_miso|cs|disable_autoread|reset|hold|

- hold: Hold Layer
- reset: Active High Layer Reset (Inverted before output to Sensor)
- disable_autoread: 1: Layer doesn't read frames if the interrupt is low, 0: Layer reads frames upon interrupt trigger
- cs: Chip Select, active high (inverted in firmware) - Set to 1 to force chip select low - if autoread is active, chip select is automatically 1
- disable_miso: If 1, the SPI interface won't read bytes from MOSI
- loopback: If 1, the Layer SPI Master is connected to the matching internal SPI Slave


## <a id='layer_5_cfg_ctrl'></a>layer_5_cfg_ctrl


> Layer 5 control bits


**Address**: 0x22


**Reset Value**: 8'b00000111


|[7:6] |5 |4 |3 |2 |1 |0 |
|--|-- |-- |-- |-- |-- |-- |
|RSVD |loopback|disable_miso|cs|disable_autoread|reset|hold|

- hold: Hold Layer
- reset: Active High Layer Reset (Inverted before output to Sensor)
- disable_autoread: 1: Layer doesn't read frames if the interrupt is low, 0: Layer reads frames upon interrupt trigger
- cs: Chip Select, active high (inverted in firmware) - Set to 1 to force chip select low - if autoread is active, chip select is automatically 1
- disable_miso: If 1, the SPI interface won't read bytes from MOSI
- loopback: If 1, the Layer SPI Master is connected to the matching internal SPI Slave


## <a id='layer_6_cfg_ctrl'></a>layer_6_cfg_ctrl


> Layer 6 control bits


**Address**: 0x23


**Reset Value**: 8'b00000111


|[7:6] |5 |4 |3 |2 |1 |0 |
|--|-- |-- |-- |-- |-- |-- |
|RSVD |loopback|disable_miso|cs|disable_autoread|reset|hold|

- hold: Hold Layer
- reset: Active High Layer Reset (Inverted before output to Sensor)
- disable_autoread: 1: Layer doesn't read frames if the interrupt is low, 0: Layer reads frames upon interrupt trigger
- cs: Chip Select, active high (inverted in firmware) - Set to 1 to force chip select low - if autoread is active, chip select is automatically 1
- disable_miso: If 1, the SPI interface won't read bytes from MOSI
- loopback: If 1, the Layer SPI Master is connected to the matching internal SPI Slave


## <a id='layer_7_cfg_ctrl'></a>layer_7_cfg_ctrl


> Layer 7 control bits


**Address**: 0x24


**Reset Value**: 8'b00000111


|[7:6] |5 |4 |3 |2 |1 |0 |
|--|-- |-- |-- |-- |-- |-- |
|RSVD |loopback|disable_miso|cs|disable_autoread|reset|hold|

- hold: Hold Layer
- reset: Active High Layer Reset (Inverted before output to Sensor)
- disable_autoread: 1: Layer doesn't read frames if the interrupt is low, 0: Layer reads frames upon interrupt trigger
- cs: Chip Select, active high (inverted in firmware) - Set to 1 to force chip select low - if autoread is active, chip select is automatically 1
- disable_miso: If 1, the SPI interface won't read bytes from MOSI
- loopback: If 1, the Layer SPI Master is connected to the matching internal SPI Slave


## <a id='layer_8_cfg_ctrl'></a>layer_8_cfg_ctrl


> Layer 8 control bits


**Address**: 0x25


**Reset Value**: 8'b00000111


|[7:6] |5 |4 |3 |2 |1 |0 |
|--|-- |-- |-- |-- |-- |-- |
|RSVD |loopback|disable_miso|cs|disable_autoread|reset|hold|

- hold: Hold Layer
- reset: Active High Layer Reset (Inverted before output to Sensor)
- disable_autoread: 1: Layer doesn't read frames if the interrupt is low, 0: Layer reads frames upon interrupt trigger
- cs: Chip Select, active high (inverted in firmware) - Set to 1 to force chip select low - if autoread is active, chip select is automatically 1
- disable_miso: If 1, the SPI interface won't read bytes from MOSI
- loopback: If 1, the Layer SPI Master is connected to the matching internal SPI Slave


## <a id='layer_9_cfg_ctrl'></a>layer_9_cfg_ctrl


> Layer 9 control bits


**Address**: 0x26


**Reset Value**: 8'b00000111


|[7:6] |5 |4 |3 |2 |1 |0 |
|--|-- |-- |-- |-- |-- |-- |
|RSVD |loopback|disable_miso|cs|disable_autoread|reset|hold|

- hold: Hold Layer
- reset: Active High Layer Reset (Inverted before output to Sensor)
- disable_autoread: 1: Layer doesn't read frames if the interrupt is low, 0: Layer reads frames upon interrupt trigger
- cs: Chip Select, active high (inverted in firmware) - Set to 1 to force chip select low - if autoread is active, chip select is automatically 1
- disable_miso: If 1, the SPI interface won't read bytes from MOSI
- loopback: If 1, the Layer SPI Master is connected to the matching internal SPI Slave


## <a id='layer_10_cfg_ctrl'></a>layer_10_cfg_ctrl


> Layer 10 control bits


**Address**: 0x27


**Reset Value**: 8'b00000111


|[7:6] |5 |4 |3 |2 |1 |0 |
|--|-- |-- |-- |-- |-- |-- |
|RSVD |loopback|disable_miso|cs|disable_autoread|reset|hold|

- hold: Hold Layer
- reset: Active High Layer Reset (Inverted before output to Sensor)
- disable_autoread: 1: Layer doesn't read frames if the interrupt is low, 0: Layer reads frames upon interrupt trigger
- cs: Chip Select, active high (inverted in firmware) - Set to 1 to force chip select low - if autoread is active, chip select is automatically 1
- disable_miso: If 1, the SPI interface won't read bytes from MOSI
- loopback: If 1, the Layer SPI Master is connected to the matching internal SPI Slave


## <a id='layer_11_cfg_ctrl'></a>layer_11_cfg_ctrl


> Layer 11 control bits


**Address**: 0x28


**Reset Value**: 8'b00000111


|[7:6] |5 |4 |3 |2 |1 |0 |
|--|-- |-- |-- |-- |-- |-- |
|RSVD |loopback|disable_miso|cs|disable_autoread|reset|hold|

- hold: Hold Layer
- reset: Active High Layer Reset (Inverted before output to Sensor)
- disable_autoread: 1: Layer doesn't read frames if the interrupt is low, 0: Layer reads frames upon interrupt trigger
- cs: Chip Select, active high (inverted in firmware) - Set to 1 to force chip select low - if autoread is active, chip select is automatically 1
- disable_miso: If 1, the SPI interface won't read bytes from MOSI
- loopback: If 1, the Layer SPI Master is connected to the matching internal SPI Slave


## <a id='layer_12_cfg_ctrl'></a>layer_12_cfg_ctrl


> Layer 12 control bits


**Address**: 0x29


**Reset Value**: 8'b00000111


|[7:6] |5 |4 |3 |2 |1 |0 |
|--|-- |-- |-- |-- |-- |-- |
|RSVD |loopback|disable_miso|cs|disable_autoread|reset|hold|

- hold: Hold Layer
- reset: Active High Layer Reset (Inverted before output to Sensor)
- disable_autoread: 1: Layer doesn't read frames if the interrupt is low, 0: Layer reads frames upon interrupt trigger
- cs: Chip Select, active high (inverted in firmware) - Set to 1 to force chip select low - if autoread is active, chip select is automatically 1
- disable_miso: If 1, the SPI interface won't read bytes from MOSI
- loopback: If 1, the Layer SPI Master is connected to the matching internal SPI Slave


## <a id='layer_13_cfg_ctrl'></a>layer_13_cfg_ctrl


> Layer 13 control bits


**Address**: 0x2a


**Reset Value**: 8'b00000111


|[7:6] |5 |4 |3 |2 |1 |0 |
|--|-- |-- |-- |-- |-- |-- |
|RSVD |loopback|disable_miso|cs|disable_autoread|reset|hold|

- hold: Hold Layer
- reset: Active High Layer Reset (Inverted before output to Sensor)
- disable_autoread: 1: Layer doesn't read frames if the interrupt is low, 0: Layer reads frames upon interrupt trigger
- cs: Chip Select, active high (inverted in firmware) - Set to 1 to force chip select low - if autoread is active, chip select is automatically 1
- disable_miso: If 1, the SPI interface won't read bytes from MOSI
- loopback: If 1, the Layer SPI Master is connected to the matching internal SPI Slave


## <a id='layer_14_cfg_ctrl'></a>layer_14_cfg_ctrl


> Layer 14 control bits


**Address**: 0x2b


**Reset Value**: 8'b00000111


|[7:6] |5 |4 |3 |2 |1 |0 |
|--|-- |-- |-- |-- |-- |-- |
|RSVD |loopback|disable_miso|cs|disable_autoread|reset|hold|

- hold: Hold Layer
- reset: Active High Layer Reset (Inverted before output to Sensor)
- disable_autoread: 1: Layer doesn't read frames if the interrupt is low, 0: Layer reads frames upon interrupt trigger
- cs: Chip Select, active high (inverted in firmware) - Set to 1 to force chip select low - if autoread is active, chip select is automatically 1
- disable_miso: If 1, the SPI interface won't read bytes from MOSI
- loopback: If 1, the Layer SPI Master is connected to the matching internal SPI Slave


## <a id='layer_15_cfg_ctrl'></a>layer_15_cfg_ctrl


> Layer 15 control bits


**Address**: 0x2c


**Reset Value**: 8'b00000111


|[7:6] |5 |4 |3 |2 |1 |0 |
|--|-- |-- |-- |-- |-- |-- |
|RSVD |loopback|disable_miso|cs|disable_autoread|reset|hold|

- hold: Hold Layer
- reset: Active High Layer Reset (Inverted before output to Sensor)
- disable_autoread: 1: Layer doesn't read frames if the interrupt is low, 0: Layer reads frames upon interrupt trigger
- cs: Chip Select, active high (inverted in firmware) - Set to 1 to force chip select low - if autoread is active, chip select is automatically 1
- disable_miso: If 1, the SPI interface won't read bytes from MOSI
- loopback: If 1, the Layer SPI Master is connected to the matching internal SPI Slave


## <a id='layer_16_cfg_ctrl'></a>layer_16_cfg_ctrl


> Layer 16 control bits


**Address**: 0x2d


**Reset Value**: 8'b00000111


|[7:6] |5 |4 |3 |2 |1 |0 |
|--|-- |-- |-- |-- |-- |-- |
|RSVD |loopback|disable_miso|cs|disable_autoread|reset|hold|

- hold: Hold Layer
- reset: Active High Layer Reset (Inverted before output to Sensor)
- disable_autoread: 1: Layer doesn't read frames if the interrupt is low, 0: Layer reads frames upon interrupt trigger
- cs: Chip Select, active high (inverted in firmware) - Set to 1 to force chip select low - if autoread is active, chip select is automatically 1
- disable_miso: If 1, the SPI interface won't read bytes from MOSI
- loopback: If 1, the Layer SPI Master is connected to the matching internal SPI Slave


## <a id='layer_17_cfg_ctrl'></a>layer_17_cfg_ctrl


> Layer 17 control bits


**Address**: 0x2e


**Reset Value**: 8'b00000111


|[7:6] |5 |4 |3 |2 |1 |0 |
|--|-- |-- |-- |-- |-- |-- |
|RSVD |loopback|disable_miso|cs|disable_autoread|reset|hold|

- hold: Hold Layer
- reset: Active High Layer Reset (Inverted before output to Sensor)
- disable_autoread: 1: Layer doesn't read frames if the interrupt is low, 0: Layer reads frames upon interrupt trigger
- cs: Chip Select, active high (inverted in firmware) - Set to 1 to force chip select low - if autoread is active, chip select is automatically 1
- disable_miso: If 1, the SPI interface won't read bytes from MOSI
- loopback: If 1, the Layer SPI Master is connected to the matching internal SPI Slave


## <a id='layer_18_cfg_ctrl'></a>layer_18_cfg_ctrl


> Layer 18 control bits


**Address**: 0x2f


**Reset Value**: 8'b00000111


|[7:6] |5 |4 |3 |2 |1 |0 |
|--|-- |-- |-- |-- |-- |-- |
|RSVD |loopback|disable_miso|cs|disable_autoread|reset|hold|

- hold: Hold Layer
- reset: Active High Layer Reset (Inverted before output to Sensor)
- disable_autoread: 1: Layer doesn't read frames if the interrupt is low, 0: Layer reads frames upon interrupt trigger
- cs: Chip Select, active high (inverted in firmware) - Set to 1 to force chip select low - if autoread is active, chip select is automatically 1
- disable_miso: If 1, the SPI interface won't read bytes from MOSI
- loopback: If 1, the Layer SPI Master is connected to the matching internal SPI Slave


## <a id='layer_19_cfg_ctrl'></a>layer_19_cfg_ctrl


> Layer 19 control bits


**Address**: 0x30


**Reset Value**: 8'b00000111


|[7:6] |5 |4 |3 |2 |1 |0 |
|--|-- |-- |-- |-- |-- |-- |
|RSVD |loopback|disable_miso|cs|disable_autoread|reset|hold|

- hold: Hold Layer
- reset: Active High Layer Reset (Inverted before output to Sensor)
- disable_autoread: 1: Layer doesn't read frames if the interrupt is low, 0: Layer reads frames upon interrupt trigger
- cs: Chip Select, active high (inverted in firmware) - Set to 1 to force chip select low - if autoread is active, chip select is automatically 1
- disable_miso: If 1, the SPI interface won't read bytes from MOSI
- loopback: If 1, the Layer SPI Master is connected to the matching internal SPI Slave


## <a id='layer_0_status'></a>layer_0_status


> Layer 0 status bits


**Address**: 0x31




|[7:2] |1 |0 |
|--|-- |-- |
|RSVD |frame_decoding|interruptn|

- interruptn: -
- frame_decoding: -


## <a id='layer_1_status'></a>layer_1_status


> Layer 1 status bits


**Address**: 0x32




|[7:2] |1 |0 |
|--|-- |-- |
|RSVD |frame_decoding|interruptn|

- interruptn: -
- frame_decoding: -


## <a id='layer_2_status'></a>layer_2_status


> Layer 2 status bits


**Address**: 0x33




|[7:2] |1 |0 |
|--|-- |-- |
|RSVD |frame_decoding|interruptn|

- interruptn: -
- frame_decoding: -


## <a id='layer_3_status'></a>layer_3_status


> Layer 3 status bits


**Address**: 0x34




|[7:2] |1 |0 |
|--|-- |-- |
|RSVD |frame_decoding|interruptn|

- interruptn: -
- frame_decoding: -


## <a id='layer_4_status'></a>layer_4_status


> Layer 4 status bits


**Address**: 0x35




|[7:2] |1 |0 |
|--|-- |-- |
|RSVD |frame_decoding|interruptn|

- interruptn: -
- frame_decoding: -


## <a id='layer_5_status'></a>layer_5_status


> Layer 5 status bits


**Address**: 0x36




|[7:2] |1 |0 |
|--|-- |-- |
|RSVD |frame_decoding|interruptn|

- interruptn: -
- frame_decoding: -


## <a id='layer_6_status'></a>layer_6_status


> Layer 6 status bits


**Address**: 0x37




|[7:2] |1 |0 |
|--|-- |-- |
|RSVD |frame_decoding|interruptn|

- interruptn: -
- frame_decoding: -


## <a id='layer_7_status'></a>layer_7_status


> Layer 7 status bits


**Address**: 0x38




|[7:2] |1 |0 |
|--|-- |-- |
|RSVD |frame_decoding|interruptn|

- interruptn: -
- frame_decoding: -


## <a id='layer_8_status'></a>layer_8_status


> Layer 8 status bits


**Address**: 0x39




|[7:2] |1 |0 |
|--|-- |-- |
|RSVD |frame_decoding|interruptn|

- interruptn: -
- frame_decoding: -


## <a id='layer_9_status'></a>layer_9_status


> Layer 9 status bits


**Address**: 0x3a




|[7:2] |1 |0 |
|--|-- |-- |
|RSVD |frame_decoding|interruptn|

- interruptn: -
- frame_decoding: -


## <a id='layer_10_status'></a>layer_10_status


> Layer 10 status bits


**Address**: 0x3b




|[7:2] |1 |0 |
|--|-- |-- |
|RSVD |frame_decoding|interruptn|

- interruptn: -
- frame_decoding: -


## <a id='layer_11_status'></a>layer_11_status


> Layer 11 status bits


**Address**: 0x3c




|[7:2] |1 |0 |
|--|-- |-- |
|RSVD |frame_decoding|interruptn|

- interruptn: -
- frame_decoding: -


## <a id='layer_12_status'></a>layer_12_status


> Layer 12 status bits


**Address**: 0x3d




|[7:2] |1 |0 |
|--|-- |-- |
|RSVD |frame_decoding|interruptn|

- interruptn: -
- frame_decoding: -


## <a id='layer_13_status'></a>layer_13_status


> Layer 13 status bits


**Address**: 0x3e




|[7:2] |1 |0 |
|--|-- |-- |
|RSVD |frame_decoding|interruptn|

- interruptn: -
- frame_decoding: -


## <a id='layer_14_status'></a>layer_14_status


> Layer 14 status bits


**Address**: 0x3f




|[7:2] |1 |0 |
|--|-- |-- |
|RSVD |frame_decoding|interruptn|

- interruptn: -
- frame_decoding: -


## <a id='layer_15_status'></a>layer_15_status


> Layer 15 status bits


**Address**: 0x40




|[7:2] |1 |0 |
|--|-- |-- |
|RSVD |frame_decoding|interruptn|

- interruptn: -
- frame_decoding: -


## <a id='layer_16_status'></a>layer_16_status


> Layer 16 status bits


**Address**: 0x41




|[7:2] |1 |0 |
|--|-- |-- |
|RSVD |frame_decoding|interruptn|

- interruptn: -
- frame_decoding: -


## <a id='layer_17_status'></a>layer_17_status


> Layer 17 status bits


**Address**: 0x42




|[7:2] |1 |0 |
|--|-- |-- |
|RSVD |frame_decoding|interruptn|

- interruptn: -
- frame_decoding: -


## <a id='layer_18_status'></a>layer_18_status


> Layer 18 status bits


**Address**: 0x43




|[7:2] |1 |0 |
|--|-- |-- |
|RSVD |frame_decoding|interruptn|

- interruptn: -
- frame_decoding: -


## <a id='layer_19_status'></a>layer_19_status


> Layer 19 status bits


**Address**: 0x44




|[7:2] |1 |0 |
|--|-- |-- |
|RSVD |frame_decoding|interruptn|

- interruptn: -
- frame_decoding: -


## <a id='layer_0_stat_frame_counter'></a>layer_0_stat_frame_counter


> Counts the number of data frames


**Address**: 0x45






## <a id='layer_1_stat_frame_counter'></a>layer_1_stat_frame_counter


> Counts the number of data frames


**Address**: 0x49






## <a id='layer_2_stat_frame_counter'></a>layer_2_stat_frame_counter


> Counts the number of data frames


**Address**: 0x4d






## <a id='layer_3_stat_frame_counter'></a>layer_3_stat_frame_counter


> Counts the number of data frames


**Address**: 0x51






## <a id='layer_4_stat_frame_counter'></a>layer_4_stat_frame_counter


> Counts the number of data frames


**Address**: 0x55






## <a id='layer_5_stat_frame_counter'></a>layer_5_stat_frame_counter


> Counts the number of data frames


**Address**: 0x59






## <a id='layer_6_stat_frame_counter'></a>layer_6_stat_frame_counter


> Counts the number of data frames


**Address**: 0x5d






## <a id='layer_7_stat_frame_counter'></a>layer_7_stat_frame_counter


> Counts the number of data frames


**Address**: 0x61






## <a id='layer_8_stat_frame_counter'></a>layer_8_stat_frame_counter


> Counts the number of data frames


**Address**: 0x65






## <a id='layer_9_stat_frame_counter'></a>layer_9_stat_frame_counter


> Counts the number of data frames


**Address**: 0x69






## <a id='layer_10_stat_frame_counter'></a>layer_10_stat_frame_counter


> Counts the number of data frames


**Address**: 0x6d






## <a id='layer_11_stat_frame_counter'></a>layer_11_stat_frame_counter


> Counts the number of data frames


**Address**: 0x71






## <a id='layer_12_stat_frame_counter'></a>layer_12_stat_frame_counter


> Counts the number of data frames


**Address**: 0x75






## <a id='layer_13_stat_frame_counter'></a>layer_13_stat_frame_counter


> Counts the number of data frames


**Address**: 0x79






## <a id='layer_14_stat_frame_counter'></a>layer_14_stat_frame_counter


> Counts the number of data frames


**Address**: 0x7d






## <a id='layer_15_stat_frame_counter'></a>layer_15_stat_frame_counter


> Counts the number of data frames


**Address**: 0x81






## <a id='layer_16_stat_frame_counter'></a>layer_16_stat_frame_counter


> Counts the number of data frames


**Address**: 0x85






## <a id='layer_17_stat_frame_counter'></a>layer_17_stat_frame_counter


> Counts the number of data frames


**Address**: 0x89






## <a id='layer_18_stat_frame_counter'></a>layer_18_stat_frame_counter


> Counts the number of data frames


**Address**: 0x8d






## <a id='layer_19_stat_frame_counter'></a>layer_19_stat_frame_counter


> Counts the number of data frames


**Address**: 0x91






## <a id='layer_0_stat_idle_counter'></a>layer_0_stat_idle_counter


> Counts the number of Idle bytes


**Address**: 0x95






## <a id='layer_1_stat_idle_counter'></a>layer_1_stat_idle_counter


> Counts the number of Idle bytes


**Address**: 0x99






## <a id='layer_2_stat_idle_counter'></a>layer_2_stat_idle_counter


> Counts the number of Idle bytes


**Address**: 0x9d






## <a id='layer_3_stat_idle_counter'></a>layer_3_stat_idle_counter


> Counts the number of Idle bytes


**Address**: 0xa1






## <a id='layer_4_stat_idle_counter'></a>layer_4_stat_idle_counter


> Counts the number of Idle bytes


**Address**: 0xa5






## <a id='layer_5_stat_idle_counter'></a>layer_5_stat_idle_counter


> Counts the number of Idle bytes


**Address**: 0xa9






## <a id='layer_6_stat_idle_counter'></a>layer_6_stat_idle_counter


> Counts the number of Idle bytes


**Address**: 0xad






## <a id='layer_7_stat_idle_counter'></a>layer_7_stat_idle_counter


> Counts the number of Idle bytes


**Address**: 0xb1






## <a id='layer_8_stat_idle_counter'></a>layer_8_stat_idle_counter


> Counts the number of Idle bytes


**Address**: 0xb5






## <a id='layer_9_stat_idle_counter'></a>layer_9_stat_idle_counter


> Counts the number of Idle bytes


**Address**: 0xb9






## <a id='layer_10_stat_idle_counter'></a>layer_10_stat_idle_counter


> Counts the number of Idle bytes


**Address**: 0xbd






## <a id='layer_11_stat_idle_counter'></a>layer_11_stat_idle_counter


> Counts the number of Idle bytes


**Address**: 0xc1






## <a id='layer_12_stat_idle_counter'></a>layer_12_stat_idle_counter


> Counts the number of Idle bytes


**Address**: 0xc5






## <a id='layer_13_stat_idle_counter'></a>layer_13_stat_idle_counter


> Counts the number of Idle bytes


**Address**: 0xc9






## <a id='layer_14_stat_idle_counter'></a>layer_14_stat_idle_counter


> Counts the number of Idle bytes


**Address**: 0xcd






## <a id='layer_15_stat_idle_counter'></a>layer_15_stat_idle_counter


> Counts the number of Idle bytes


**Address**: 0xd1






## <a id='layer_16_stat_idle_counter'></a>layer_16_stat_idle_counter


> Counts the number of Idle bytes


**Address**: 0xd5






## <a id='layer_17_stat_idle_counter'></a>layer_17_stat_idle_counter


> Counts the number of Idle bytes


**Address**: 0xd9






## <a id='layer_18_stat_idle_counter'></a>layer_18_stat_idle_counter


> Counts the number of Idle bytes


**Address**: 0xdd






## <a id='layer_19_stat_idle_counter'></a>layer_19_stat_idle_counter


> Counts the number of Idle bytes


**Address**: 0xe1






## <a id='layer_0_mosi'></a>layer_0_mosi


> FIFO to send bytes to Layer 0 Astropix


**Address**: 0xe5






## <a id='layer_0_mosi_write_size'></a>layer_0_mosi_write_size


> Number of entries in layer_0_mosi fifo


**Address**: 0xe6






## <a id='layer_1_mosi'></a>layer_1_mosi


> FIFO to send bytes to Layer 1 Astropix


**Address**: 0xea






## <a id='layer_1_mosi_write_size'></a>layer_1_mosi_write_size


> Number of entries in layer_1_mosi fifo


**Address**: 0xeb






## <a id='layer_2_mosi'></a>layer_2_mosi


> FIFO to send bytes to Layer 2 Astropix


**Address**: 0xef






## <a id='layer_2_mosi_write_size'></a>layer_2_mosi_write_size


> Number of entries in layer_2_mosi fifo


**Address**: 0xf0






## <a id='layer_3_mosi'></a>layer_3_mosi


> FIFO to send bytes to Layer 3 Astropix


**Address**: 0xf4






## <a id='layer_3_mosi_write_size'></a>layer_3_mosi_write_size


> Number of entries in layer_3_mosi fifo


**Address**: 0xf5






## <a id='layer_4_mosi'></a>layer_4_mosi


> FIFO to send bytes to Layer 4 Astropix


**Address**: 0xf9






## <a id='layer_4_mosi_write_size'></a>layer_4_mosi_write_size


> Number of entries in layer_4_mosi fifo


**Address**: 0xfa






## <a id='layer_5_mosi'></a>layer_5_mosi


> FIFO to send bytes to Layer 5 Astropix


**Address**: 0xfe






## <a id='layer_5_mosi_write_size'></a>layer_5_mosi_write_size


> Number of entries in layer_5_mosi fifo


**Address**: 0xff






## <a id='layer_6_mosi'></a>layer_6_mosi


> FIFO to send bytes to Layer 6 Astropix


**Address**: 0x103






## <a id='layer_6_mosi_write_size'></a>layer_6_mosi_write_size


> Number of entries in layer_6_mosi fifo


**Address**: 0x104






## <a id='layer_7_mosi'></a>layer_7_mosi


> FIFO to send bytes to Layer 7 Astropix


**Address**: 0x108






## <a id='layer_7_mosi_write_size'></a>layer_7_mosi_write_size


> Number of entries in layer_7_mosi fifo


**Address**: 0x109






## <a id='layer_8_mosi'></a>layer_8_mosi


> FIFO to send bytes to Layer 8 Astropix


**Address**: 0x10d






## <a id='layer_8_mosi_write_size'></a>layer_8_mosi_write_size


> Number of entries in layer_8_mosi fifo


**Address**: 0x10e






## <a id='layer_9_mosi'></a>layer_9_mosi


> FIFO to send bytes to Layer 9 Astropix


**Address**: 0x112






## <a id='layer_9_mosi_write_size'></a>layer_9_mosi_write_size


> Number of entries in layer_9_mosi fifo


**Address**: 0x113






## <a id='layer_10_mosi'></a>layer_10_mosi


> FIFO to send bytes to Layer 10 Astropix


**Address**: 0x117






## <a id='layer_10_mosi_write_size'></a>layer_10_mosi_write_size


> Number of entries in layer_10_mosi fifo


**Address**: 0x118






## <a id='layer_11_mosi'></a>layer_11_mosi


> FIFO to send bytes to Layer 11 Astropix


**Address**: 0x11c






## <a id='layer_11_mosi_write_size'></a>layer_11_mosi_write_size


> Number of entries in layer_11_mosi fifo


**Address**: 0x11d






## <a id='layer_12_mosi'></a>layer_12_mosi


> FIFO to send bytes to Layer 12 Astropix


**Address**: 0x121






## <a id='layer_12_mosi_write_size'></a>layer_12_mosi_write_size


> Number of entries in layer_12_mosi fifo


**Address**: 0x122






## <a id='layer_13_mosi'></a>layer_13_mosi


> FIFO to send bytes to Layer 13 Astropix


**Address**: 0x126






## <a id='layer_13_mosi_write_size'></a>layer_13_mosi_write_size


> Number of entries in layer_13_mosi fifo


**Address**: 0x127






## <a id='layer_14_mosi'></a>layer_14_mosi


> FIFO to send bytes to Layer 14 Astropix


**Address**: 0x12b






## <a id='layer_14_mosi_write_size'></a>layer_14_mosi_write_size


> Number of entries in layer_14_mosi fifo


**Address**: 0x12c






## <a id='layer_15_mosi'></a>layer_15_mosi


> FIFO to send bytes to Layer 15 Astropix


**Address**: 0x130






## <a id='layer_15_mosi_write_size'></a>layer_15_mosi_write_size


> Number of entries in layer_15_mosi fifo


**Address**: 0x131






## <a id='layer_16_mosi'></a>layer_16_mosi


> FIFO to send bytes to Layer 16 Astropix


**Address**: 0x135






## <a id='layer_16_mosi_write_size'></a>layer_16_mosi_write_size


> Number of entries in layer_16_mosi fifo


**Address**: 0x136






## <a id='layer_17_mosi'></a>layer_17_mosi


> FIFO to send bytes to Layer 17 Astropix


**Address**: 0x13a






## <a id='layer_17_mosi_write_size'></a>layer_17_mosi_write_size


> Number of entries in layer_17_mosi fifo


**Address**: 0x13b






## <a id='layer_18_mosi'></a>layer_18_mosi


> FIFO to send bytes to Layer 18 Astropix


**Address**: 0x13f






## <a id='layer_18_mosi_write_size'></a>layer_18_mosi_write_size


> Number of entries in layer_18_mosi fifo


**Address**: 0x140






## <a id='layer_19_mosi'></a>layer_19_mosi


> FIFO to send bytes to Layer 19 Astropix


**Address**: 0x144






## <a id='layer_19_mosi_write_size'></a>layer_19_mosi_write_size


> Number of entries in layer_19_mosi fifo


**Address**: 0x145






## <a id='layer_0_loopback_miso'></a>layer_0_loopback_miso


> FIFO to send bytes to Layer 0 Astropix throug internal slave loopback


**Address**: 0x149






## <a id='layer_0_loopback_miso_write_size'></a>layer_0_loopback_miso_write_size


> Number of entries in layer_0_loopback_miso fifo


**Address**: 0x14a






## <a id='layer_1_loopback_miso'></a>layer_1_loopback_miso


> FIFO to send bytes to Layer 1 Astropix throug internal slave loopback


**Address**: 0x14e






## <a id='layer_1_loopback_miso_write_size'></a>layer_1_loopback_miso_write_size


> Number of entries in layer_1_loopback_miso fifo


**Address**: 0x14f






## <a id='layer_2_loopback_miso'></a>layer_2_loopback_miso


> FIFO to send bytes to Layer 2 Astropix throug internal slave loopback


**Address**: 0x153






## <a id='layer_2_loopback_miso_write_size'></a>layer_2_loopback_miso_write_size


> Number of entries in layer_2_loopback_miso fifo


**Address**: 0x154






## <a id='layer_3_loopback_miso'></a>layer_3_loopback_miso


> FIFO to send bytes to Layer 3 Astropix throug internal slave loopback


**Address**: 0x158






## <a id='layer_3_loopback_miso_write_size'></a>layer_3_loopback_miso_write_size


> Number of entries in layer_3_loopback_miso fifo


**Address**: 0x159






## <a id='layer_4_loopback_miso'></a>layer_4_loopback_miso


> FIFO to send bytes to Layer 4 Astropix throug internal slave loopback


**Address**: 0x15d






## <a id='layer_4_loopback_miso_write_size'></a>layer_4_loopback_miso_write_size


> Number of entries in layer_4_loopback_miso fifo


**Address**: 0x15e






## <a id='layer_5_loopback_miso'></a>layer_5_loopback_miso


> FIFO to send bytes to Layer 5 Astropix throug internal slave loopback


**Address**: 0x162






## <a id='layer_5_loopback_miso_write_size'></a>layer_5_loopback_miso_write_size


> Number of entries in layer_5_loopback_miso fifo


**Address**: 0x163






## <a id='layer_6_loopback_miso'></a>layer_6_loopback_miso


> FIFO to send bytes to Layer 6 Astropix throug internal slave loopback


**Address**: 0x167






## <a id='layer_6_loopback_miso_write_size'></a>layer_6_loopback_miso_write_size


> Number of entries in layer_6_loopback_miso fifo


**Address**: 0x168






## <a id='layer_7_loopback_miso'></a>layer_7_loopback_miso


> FIFO to send bytes to Layer 7 Astropix throug internal slave loopback


**Address**: 0x16c






## <a id='layer_7_loopback_miso_write_size'></a>layer_7_loopback_miso_write_size


> Number of entries in layer_7_loopback_miso fifo


**Address**: 0x16d






## <a id='layer_8_loopback_miso'></a>layer_8_loopback_miso


> FIFO to send bytes to Layer 8 Astropix throug internal slave loopback


**Address**: 0x171






## <a id='layer_8_loopback_miso_write_size'></a>layer_8_loopback_miso_write_size


> Number of entries in layer_8_loopback_miso fifo


**Address**: 0x172






## <a id='layer_9_loopback_miso'></a>layer_9_loopback_miso


> FIFO to send bytes to Layer 9 Astropix throug internal slave loopback


**Address**: 0x176






## <a id='layer_9_loopback_miso_write_size'></a>layer_9_loopback_miso_write_size


> Number of entries in layer_9_loopback_miso fifo


**Address**: 0x177






## <a id='layer_10_loopback_miso'></a>layer_10_loopback_miso


> FIFO to send bytes to Layer 10 Astropix throug internal slave loopback


**Address**: 0x17b






## <a id='layer_10_loopback_miso_write_size'></a>layer_10_loopback_miso_write_size


> Number of entries in layer_10_loopback_miso fifo


**Address**: 0x17c






## <a id='layer_11_loopback_miso'></a>layer_11_loopback_miso


> FIFO to send bytes to Layer 11 Astropix throug internal slave loopback


**Address**: 0x180






## <a id='layer_11_loopback_miso_write_size'></a>layer_11_loopback_miso_write_size


> Number of entries in layer_11_loopback_miso fifo


**Address**: 0x181






## <a id='layer_12_loopback_miso'></a>layer_12_loopback_miso


> FIFO to send bytes to Layer 12 Astropix throug internal slave loopback


**Address**: 0x185






## <a id='layer_12_loopback_miso_write_size'></a>layer_12_loopback_miso_write_size


> Number of entries in layer_12_loopback_miso fifo


**Address**: 0x186






## <a id='layer_13_loopback_miso'></a>layer_13_loopback_miso


> FIFO to send bytes to Layer 13 Astropix throug internal slave loopback


**Address**: 0x18a






## <a id='layer_13_loopback_miso_write_size'></a>layer_13_loopback_miso_write_size


> Number of entries in layer_13_loopback_miso fifo


**Address**: 0x18b






## <a id='layer_14_loopback_miso'></a>layer_14_loopback_miso


> FIFO to send bytes to Layer 14 Astropix throug internal slave loopback


**Address**: 0x18f






## <a id='layer_14_loopback_miso_write_size'></a>layer_14_loopback_miso_write_size


> Number of entries in layer_14_loopback_miso fifo


**Address**: 0x190






## <a id='layer_15_loopback_miso'></a>layer_15_loopback_miso


> FIFO to send bytes to Layer 15 Astropix throug internal slave loopback


**Address**: 0x194






## <a id='layer_15_loopback_miso_write_size'></a>layer_15_loopback_miso_write_size


> Number of entries in layer_15_loopback_miso fifo


**Address**: 0x195






## <a id='layer_16_loopback_miso'></a>layer_16_loopback_miso


> FIFO to send bytes to Layer 16 Astropix throug internal slave loopback


**Address**: 0x199






## <a id='layer_16_loopback_miso_write_size'></a>layer_16_loopback_miso_write_size


> Number of entries in layer_16_loopback_miso fifo


**Address**: 0x19a






## <a id='layer_17_loopback_miso'></a>layer_17_loopback_miso


> FIFO to send bytes to Layer 17 Astropix throug internal slave loopback


**Address**: 0x19e






## <a id='layer_17_loopback_miso_write_size'></a>layer_17_loopback_miso_write_size


> Number of entries in layer_17_loopback_miso fifo


**Address**: 0x19f






## <a id='layer_18_loopback_miso'></a>layer_18_loopback_miso


> FIFO to send bytes to Layer 18 Astropix throug internal slave loopback


**Address**: 0x1a3






## <a id='layer_18_loopback_miso_write_size'></a>layer_18_loopback_miso_write_size


> Number of entries in layer_18_loopback_miso fifo


**Address**: 0x1a4






## <a id='layer_19_loopback_miso'></a>layer_19_loopback_miso


> FIFO to send bytes to Layer 19 Astropix throug internal slave loopback


**Address**: 0x1a8






## <a id='layer_19_loopback_miso_write_size'></a>layer_19_loopback_miso_write_size


> Number of entries in layer_19_loopback_miso fifo


**Address**: 0x1a9






## <a id='layer_0_loopback_mosi'></a>layer_0_loopback_mosi


> FIFO to read bytes received by internal slave loopback


**Address**: 0x1ad






## <a id='layer_0_loopback_mosi_read_size'></a>layer_0_loopback_mosi_read_size


> Number of entries in layer_0_loopback_mosi fifo


**Address**: 0x1ae






## <a id='layer_1_loopback_mosi'></a>layer_1_loopback_mosi


> FIFO to read bytes received by internal slave loopback


**Address**: 0x1b2






## <a id='layer_1_loopback_mosi_read_size'></a>layer_1_loopback_mosi_read_size


> Number of entries in layer_1_loopback_mosi fifo


**Address**: 0x1b3






## <a id='layer_2_loopback_mosi'></a>layer_2_loopback_mosi


> FIFO to read bytes received by internal slave loopback


**Address**: 0x1b7






## <a id='layer_2_loopback_mosi_read_size'></a>layer_2_loopback_mosi_read_size


> Number of entries in layer_2_loopback_mosi fifo


**Address**: 0x1b8






## <a id='layer_3_loopback_mosi'></a>layer_3_loopback_mosi


> FIFO to read bytes received by internal slave loopback


**Address**: 0x1bc






## <a id='layer_3_loopback_mosi_read_size'></a>layer_3_loopback_mosi_read_size


> Number of entries in layer_3_loopback_mosi fifo


**Address**: 0x1bd






## <a id='layer_4_loopback_mosi'></a>layer_4_loopback_mosi


> FIFO to read bytes received by internal slave loopback


**Address**: 0x1c1






## <a id='layer_4_loopback_mosi_read_size'></a>layer_4_loopback_mosi_read_size


> Number of entries in layer_4_loopback_mosi fifo


**Address**: 0x1c2






## <a id='layer_5_loopback_mosi'></a>layer_5_loopback_mosi


> FIFO to read bytes received by internal slave loopback


**Address**: 0x1c6






## <a id='layer_5_loopback_mosi_read_size'></a>layer_5_loopback_mosi_read_size


> Number of entries in layer_5_loopback_mosi fifo


**Address**: 0x1c7






## <a id='layer_6_loopback_mosi'></a>layer_6_loopback_mosi


> FIFO to read bytes received by internal slave loopback


**Address**: 0x1cb






## <a id='layer_6_loopback_mosi_read_size'></a>layer_6_loopback_mosi_read_size


> Number of entries in layer_6_loopback_mosi fifo


**Address**: 0x1cc






## <a id='layer_7_loopback_mosi'></a>layer_7_loopback_mosi


> FIFO to read bytes received by internal slave loopback


**Address**: 0x1d0






## <a id='layer_7_loopback_mosi_read_size'></a>layer_7_loopback_mosi_read_size


> Number of entries in layer_7_loopback_mosi fifo


**Address**: 0x1d1






## <a id='layer_8_loopback_mosi'></a>layer_8_loopback_mosi


> FIFO to read bytes received by internal slave loopback


**Address**: 0x1d5






## <a id='layer_8_loopback_mosi_read_size'></a>layer_8_loopback_mosi_read_size


> Number of entries in layer_8_loopback_mosi fifo


**Address**: 0x1d6






## <a id='layer_9_loopback_mosi'></a>layer_9_loopback_mosi


> FIFO to read bytes received by internal slave loopback


**Address**: 0x1da






## <a id='layer_9_loopback_mosi_read_size'></a>layer_9_loopback_mosi_read_size


> Number of entries in layer_9_loopback_mosi fifo


**Address**: 0x1db






## <a id='layer_10_loopback_mosi'></a>layer_10_loopback_mosi


> FIFO to read bytes received by internal slave loopback


**Address**: 0x1df






## <a id='layer_10_loopback_mosi_read_size'></a>layer_10_loopback_mosi_read_size


> Number of entries in layer_10_loopback_mosi fifo


**Address**: 0x1e0






## <a id='layer_11_loopback_mosi'></a>layer_11_loopback_mosi


> FIFO to read bytes received by internal slave loopback


**Address**: 0x1e4






## <a id='layer_11_loopback_mosi_read_size'></a>layer_11_loopback_mosi_read_size


> Number of entries in layer_11_loopback_mosi fifo


**Address**: 0x1e5






## <a id='layer_12_loopback_mosi'></a>layer_12_loopback_mosi


> FIFO to read bytes received by internal slave loopback


**Address**: 0x1e9






## <a id='layer_12_loopback_mosi_read_size'></a>layer_12_loopback_mosi_read_size


> Number of entries in layer_12_loopback_mosi fifo


**Address**: 0x1ea






## <a id='layer_13_loopback_mosi'></a>layer_13_loopback_mosi


> FIFO to read bytes received by internal slave loopback


**Address**: 0x1ee






## <a id='layer_13_loopback_mosi_read_size'></a>layer_13_loopback_mosi_read_size


> Number of entries in layer_13_loopback_mosi fifo


**Address**: 0x1ef






## <a id='layer_14_loopback_mosi'></a>layer_14_loopback_mosi


> FIFO to read bytes received by internal slave loopback


**Address**: 0x1f3






## <a id='layer_14_loopback_mosi_read_size'></a>layer_14_loopback_mosi_read_size


> Number of entries in layer_14_loopback_mosi fifo


**Address**: 0x1f4






## <a id='layer_15_loopback_mosi'></a>layer_15_loopback_mosi


> FIFO to read bytes received by internal slave loopback


**Address**: 0x1f8






## <a id='layer_15_loopback_mosi_read_size'></a>layer_15_loopback_mosi_read_size


> Number of entries in layer_15_loopback_mosi fifo


**Address**: 0x1f9






## <a id='layer_16_loopback_mosi'></a>layer_16_loopback_mosi


> FIFO to read bytes received by internal slave loopback


**Address**: 0x1fd






## <a id='layer_16_loopback_mosi_read_size'></a>layer_16_loopback_mosi_read_size


> Number of entries in layer_16_loopback_mosi fifo


**Address**: 0x1fe






## <a id='layer_17_loopback_mosi'></a>layer_17_loopback_mosi


> FIFO to read bytes received by internal slave loopback


**Address**: 0x202






## <a id='layer_17_loopback_mosi_read_size'></a>layer_17_loopback_mosi_read_size


> Number of entries in layer_17_loopback_mosi fifo


**Address**: 0x203






## <a id='layer_18_loopback_mosi'></a>layer_18_loopback_mosi


> FIFO to read bytes received by internal slave loopback


**Address**: 0x207






## <a id='layer_18_loopback_mosi_read_size'></a>layer_18_loopback_mosi_read_size


> Number of entries in layer_18_loopback_mosi fifo


**Address**: 0x208






## <a id='layer_19_loopback_mosi'></a>layer_19_loopback_mosi


> FIFO to read bytes received by internal slave loopback


**Address**: 0x20c






## <a id='layer_19_loopback_mosi_read_size'></a>layer_19_loopback_mosi_read_size


> Number of entries in layer_19_loopback_mosi fifo


**Address**: 0x20d






## <a id='layers_cfg_frame_tag_counter_ctrl'></a>layers_cfg_frame_tag_counter_ctrl


> A few bits to control the Frame Tagging Counter


**Address**: 0x211


**Reset Value**: 8'h1


|[7:2] |1 |0 |
|--|-- |-- |
|RSVD |force_count|enable|

- enable: If 1, the counter will increment after the trigger counter reached its match value
- force_count: If 1, the counter will increment at each core clock cycle. If you flush a write with this value 1 then 0 in two data words, you can increment by 1 manually


## <a id='layers_cfg_frame_tag_counter_trigger'></a>layers_cfg_frame_tag_counter_trigger


> This Interrupt Counter provides the enable signal for the frame tag counter


**Address**: 0x212






## <a id='layers_cfg_frame_tag_counter'></a>layers_cfg_frame_tag_counter


> Counter to tag frames upon detection (Counter value added to frame output)


**Address**: 0x216






## <a id='layers_cfg_nodata_continue'></a>layers_cfg_nodata_continue


> Number of IDLE Bytes until stopping readout


**Address**: 0x21a


**Reset Value**: 8'd5




## <a id='layers_sr_out'></a>layers_sr_out


> Shift Register Configuration I/O Control register


**Address**: 0x21b




|[7:6] |5 |4 |3 |2 |1 |0 |
|--|-- |-- |-- |-- |-- |-- |
|RSVD |ld2|ld1|ld0|sin|ck2|ck1|

- ck1: CK1 I/O for Shift Register Configuration
- ck2: CK2 I/O for Shift Register Configuration
- sin: SIN I/O for Shift Register Configuration
- ld0: Load signal for Layer 0
- ld1: Load signal for Layer 1
- ld2: Load signal for Layer 2


## <a id='layers_sr_in'></a>layers_sr_in


> Shift Register Configuration Input control (Readback enable and layers inputs)


**Address**: 0x21c




|[7:4] |3 |2 |1 |0 |
|--|-- |-- |-- |-- |
|RSVD |sout2|sout1|sout0|rb|

- rb: Set to 1 to activate Shift Register Read back from layers
- sout0: -
- sout1: -
- sout2: -


## <a id='layers_inj_ctrl'></a>layers_inj_ctrl


> Control bits for the Injection Pattern Generator


**Address**: 0x21d


**Reset Value**: 8'b00000110


|[7:7] |6 |5 |4 |3 |2 |1 |0 |
|--|-- |-- |-- |-- |-- |-- |-- |
|RSVD |running|done|write|trigger|synced|suspend|reset|

- reset: Reset for Pattern Generator - must be set to 1 after writing registers for config to be read
- suspend: Suspend module from running
- synced: -
- trigger: -
- write: Write Register value at address set by WADDR/WDATA registers
- done: Pattern generator finished configured sequence
- running: Pattern generator is running generating injection pulses


## <a id='layers_inj_waddr'></a>layers_inj_waddr


> Address for register to write in Injection Pattern Generator


**Address**: 0x21e






## <a id='layers_inj_wdata'></a>layers_inj_wdata


> Data for register to write in Injection Pattern Generator


**Address**: 0x21f






## <a id='layers_readout'></a>layers_readout


> Reads from the readout data fifo


**Address**: 0x220






## <a id='layers_readout_read_size'></a>layers_readout_read_size


> Number of entries in layers_readout fifo


**Address**: 0x221






## <a id='io_ctrl'></a>io_ctrl


> Configuration register for I/O multiplexers and gating.


**Address**: 0x225


**Reset Value**: 8'b00001000


|[7:4] |3 |2 |1 |0 |
|--|-- |-- |-- |-- |
|RSVD |gecco_inj_enable|gecco_sample_clock_se|timestamp_clock_enable|sample_clock_enable|

- sample_clock_enable: Sample clock output enable. Sample clock output is 0 if this bit is set to 0
- timestamp_clock_enable: Timestamp clock output enable. Timestamp clock output is 0 if this bit is set to 0
- gecco_sample_clock_se: Selects the Single Ended output for the sample clock on Gecco.
- gecco_inj_enable: Selects the Gecco Injection to Injection Card output for the injection patterns. Set to 0 to route the injection pattern directly to the chip carrier


## <a id='io_led'></a>io_led


> This register is connected to the Board's LED. See target documentation for detailed connection information.


**Address**: 0x226






## <a id='gecco_sr_ctrl'></a>gecco_sr_ctrl


> Shift Register Control for Gecco Cards


**Address**: 0x227




|[7:3] |2 |1 |0 |
|--|-- |-- |-- |
|RSVD |ld|sin|ck|

- ck: -
- sin: -
- ld: -


## <a id='hk_conversion_trigger_match'></a>hk_conversion_trigger_match


> 


**Address**: 0x228


**Reset Value**: 32'd10




## <a id='layers_cfg_frame_tag_counter_trigger_match'></a>layers_cfg_frame_tag_counter_trigger_match


> 


**Address**: 0x22c


**Reset Value**: 32'd4


