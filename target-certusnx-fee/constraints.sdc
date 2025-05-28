
## 100Mhz Clocks
create_clock -period 10 -name sysclk_100 [get_ports sysclk_100]


## SPI Clocks
create_clock -period 20 -name ext_spi_clk [get_ports ext_spi_clk]

## Resets and Falsepath inputs
set_false_path -from [get_ports rstn]
set_false_path -from [get_ports ext_spi_csn]

