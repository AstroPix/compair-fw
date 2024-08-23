
## 125Mhz Clocks
create_clock -period 8 -name clk_125 [get_ports sysclk_125]


## SPI Clocks
create_clock -period 20 -name spi_clk [get_ports spi_clk]

## Resets and Falsepath inputs
set_false_path -from [get_ports rstn]
set_false_path -from [get_ports spi_csn]

