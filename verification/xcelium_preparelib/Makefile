
compile:
	@tclsh $(bindir)/../../cae_library/simulation/scripts/cmpl_libs.tcl -sim_path /eda/cadence/2024-25/RHELx86/XCELIUM_24.03.004/tools/bin -sim_vendor cadence -device lfcpnx -target_path lattice_compiled

questa:
	@tclsh $(bindir)/../../cae_library/simulation/scripts/cmpl_libs.tcl -sim_path /eda/Siemens/2023-24/RHELx86/QUESTA-CORE-PRIME_2023.4/questasim/bin/ -sim_vendor mentor -device lfcpnx -target_path lattice_compiled_questa


#@xrun -sv -compile -64 -define LFCPNX -define LFCPNX_100 -define jd5d00 -f xcelium_lib.f
#fpga_ip_files.f:
#@tclsh make_filelist.tcl