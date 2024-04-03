puts "Test IDA"
ida_probe -log -wave -wave_probe_args="${::env(TOPLEVEL)} -all -depth all -memories"TOPLEVEL
run