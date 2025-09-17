
# create_generated_clock -name {clk_core} -source [get_ports sysclk_100] -divide_by 25 -multiply_by 15 [get_pins -hierarchical astep24_20l_top_I/clocking_reset_I/clk_core]
# create_generated_clock -name {clk_uart} -source [get_ports sysclk_100] -divide_by 50 -multiply_by 15 [get_pins -hierarchical astep24_20l_top_I/clocking_reset_I/clk_uart]
# create_generated_clock -name {layers_spi_divided} -source [get_clocks clk_core] -divide_by 2 [get_pins -hierarchical */spi_layers_ckdivider_divided_clk*]
# create_generated_clock -name {hk_spi_divided} -source [get_clocks clk_core] -divide_by 4 [get_pins -hierarchical */spi_hk_ckdivider_divided_clk*]
# set numberOfLayerClocks 20
# for {set i 0} {$i < $numberOfLayerClocks} {incr i} {
#     create_generated_clock -name spi_layer${i}_clock_out -source [get_pins -hierarchical */spi_layers_ckdivider_divided_clk*] -divide_by 1 [get_ports row${i}_spi_clk]
# }

## SPI Clocks
# create_clock -name {ext_spi_clk} -period 166 [get_ports ext_spi_clk]

# create_generated_clock -name {clk_core} -source [get_nets -hierarchical astep24_20l_top_I/clocking_reset_I/top_clocking_core_io_uart/clki_i] -divide_by 25 -multiply_by 15 [get_pins -hierarchical astep24_20l_top_I/clocking_reset_I/clk_core]
# create_generated_clock -name {clk_uart} -source [get_ports sysclk_100] -divide_by 50 -multiply_by 15 [get_pins -hierarchical astep24_20l_top_I/clocking_reset_I/clk_uart]
# create_generated_clock -name {layers_spi_divided} -source [get_pins -hierarchical */spi_layers_ckdivider_source_clk] -divide_by 2 [get_pins -hierarchical */spi_layers_ckdivider_divided_clk*]
# create_generated_clock -name {hk_spi_divided} -source [get_pins -hierarchical */spi_hk_ckdivider_source_clk*] -divide_by 4 [get_pins -hierarchical */spi_hk_ckdivider_divided_clk*]
# set numberOfLayerClocks 20
# for {set i 0} {$i < $numberOfLayerClocks} {incr i} {
#     create_generated_clock -name spi_layer${i}_clock_out -source [get_pins -hierarchical */spi_layers_ckdivider_divided_clk*] -divide_by 1 [get_ports row${i}_spi_clk]
# }



## ADC
# create_clock -name {ext_spi_clk} -period 166 [get_ports ext_spi_clk]




#set_false_path -from [get_ports row*]
#set_false_path -to [get_ports row*]



# ## 100Mhz Clocks
# create_clock -name {sysclk_100} -period 10 [get_ports sysclk_100]


# ## SPI Clocks
# create_clock -name {ext_spi_clk} -period 166 [get_ports ext_spi_clk]

# create_generated_clock -name {clk_core} -source [get_ports sysclk_100] -divide_by 25 -multiply_by 15 [get_pins -hierarchical astep24_20l_top_I/clocking_reset_I/clk_core]
# create_generated_clock -name {clk_uart} -source [get_ports sysclk_100] -divide_by 50 -multiply_by 15 [get_pins -hierarchical astep24_20l_top_I/clocking_reset_I/clk_uart]
# create_generated_clock -name {layers_spi_divided} -source [get_clocks clk_core] -divide_by 2 [get_pins -hierarchical */spi_layers_ckdivider_divided_clk*]
# create_generated_clock -name {hk_spi_divided} -source [get_pins -hierarchical */spi_hk_ckdivider_source_clk*] -divide_by 4 [get_pins -hierarchical */spi_hk_ckdivider_divided_clk*]
# set numberOfLayerClocks 20
# for {set i 0} {$i < $numberOfLayerClocks} {incr i} {
#     create_generated_clock -name spi_layer${i}_clock_out -source [get_pins -hierarchical */spi_layers_ckdivider_divided_clk*] -divide_by 1 [get_ports row${i}_spi_clk]
# }



#### Layer SPI delays, assume maximum 20 Mhz (50ns) - reserve 75% of period
# set layer_spi_min_period 50
# set layer_spi_io_delay [expr $layer_spi_min_period * 0.5 + 4]


# ## Layers SPI Constraints
# for {set i 0} {$i < $numberOfLayerClocks} {incr i} {


        
#         #set_false_path -through [get_ports [list layer_${i}_inj layer_${i}_resn] ]
 
#         set_output_delay $layer_spi_io_delay -max -clock spi_layer${i}_clock_out     [get_ports row${i}_spi_mosi ]
#         set_output_delay 2 -min -clock spi_layer${i}_clock_out                      [get_ports row${i}_spi_mosi ]
       
#         set_input_delay  2 -max -clock spi_layer${i}_clock_out                      [get_ports row${i}_spi_miso* ] -clock_fall
#         set_input_delay  -1 -min -clock spi_layer${i}_clock_out                     [get_ports row${i}_spi_miso* ] -clock_fall



# }


# ## ADC
# create_clock -name {ext_spi_clk} -period 166 [get_ports ext_spi_clk]
# set adc_spi_min_period 166
# set adc_spi_io_delay [expr $adc_spi_min_period * 0.5 + 4]
# set_output_delay $adc_spi_io_delay -max -clock [get_clocks ext_spi_clk]   [get_ports ext_spi_mosi]
# set_output_delay 2 -min -clock [get_clocks ext_spi_clk]  [get_ports ext_spi_mosi]
# set_input_delay 2 -max -clock [get_clocks ext_spi_clk]   [get_ports ext_spi_adc_miso] -clock_fall
# set_input_delay -1 -min -clock [get_clocks ext_spi_clk] [get_ports ext_spi_adc_miso] -clock_fall
# set_false_path -to [get_ports {ext_spi_adc_csn[2] ext_spi_adc_csn[1] ext_spi_adc_csn[0]}]



#set_clock_uncertainty 0.225 [get_clocks] -to [get_clocks]
#set_clock_uncertainty -setup 0.125 sysclk_100
## Resets and Falsepath inputs
# set_false_path -from [get_ports rstn]
# set_false_path -to [get_ports {ext_spi_adc_csn[2] ext_spi_adc_csn[1] ext_spi_adc_csn[0]}]
# set_false_path -from [get_ports row*]
# set_false_path -to [get_ports row*]
# set_output_delay -clock [get_clocks ext_spi_clk] -min 15 [get_ports ext_spi_mosi]
# set_output_delay -clock [get_clocks ext_spi_clk] -max 15 [get_ports ext_spi_mosi]
# set_input_delay -clock [get_clocks ext_spi_clk] -clock_fall -min 15 [get_ports ext_spi_adc_miso]
# set_input_delay -clock [get_clocks ext_spi_clk] -clock_fall -max 15 [get_ports ext_spi_adc_miso]
#set_clock_uncertainty -setup 0.125 [get_clocks sysclk_100]




## SPI Clocks
create_clock -name {ext_spi_clk} -period 166 [get_ports ext_spi_clk]
#SPI 
## Common csn - remove timing, signal is sw driven
set_false_path -to [get_ports row*_spi_cs]
## 100Mhz Clocks
create_clock -name {sysclk_100} -period 10 [get_ports sysclk_100]
set_clock_uncertainty -setup 0.125 [get_clocks sysclk_100]
