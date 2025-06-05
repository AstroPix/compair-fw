## 100Mhz Clocks
create_clock -name {sysclk_100} -period 10 [get_ports sysclk_100]
## SPI Clocks
create_clock -name {ext_spi_clk} -period 166 [get_ports ext_spi_clk]
#set_clock_uncertainty 0.225 [get_clocks] -to [get_clocks]
#set_clock_uncertainty -setup 0.125 sysclk_100
## Resets and Falsepath inputs
set_false_path -from [get_ports rstn]
set_false_path -to [get_ports {ext_spi_adc_csn[2] ext_spi_adc_csn[1] ext_spi_adc_csn[0]}]
set_false_path -from [get_ports row*]
set_false_path -to [get_ports row*]
set_output_delay -clock [get_clocks ext_spi_clk] -max 29 [get_ports ext_spi_mosi]
set_output_delay -clock [get_clocks ext_spi_clk] -min 2 [get_ports ext_spi_mosi]
set_input_delay -clock [get_clocks ext_spi_clk] -clock_fall -max 2 [get_ports ext_spi_adc_miso]
set_clock_uncertainty -setup 0.125 [get_clocks sysclk_100]
