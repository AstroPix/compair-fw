
set simSourceDir [file normalize $::env(bindir)/../../cae_library/simulation/verilog/lfcpnx]
set uaplatformSourceDir [file normalize $::env(bindir)/../../cae_library/simulation/verilog/uaplatform/]


# LFCPNX
set out [open fpga_ip_files.f w+]
puts $out "+incdir+$simSourceDir"
puts $out "-makelib lattice_sim"
puts $out -parallel
foreach srcFile [glob -type f $simSourceDir/*.v] {
    if {![string match *defines* [file tail $srcFile]] && [file tail $srcFile]!="define.v"} {
        puts $out [file normalize $srcFile]
    }
    
}
#puts $out "-endlib"

# UAPLATFORM
#puts $out "-makelib lattice"
foreach srcFile [glob -type f $uaplatformSourceDir/*.v] {
    if {![string match *defines* [file tail $srcFile]] && [file tail $srcFile]!="define.v"} {
        puts $out [file normalize $srcFile]
    }
    
}
puts $out "-endlib"



close $out