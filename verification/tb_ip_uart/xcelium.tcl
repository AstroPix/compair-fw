
puts "DDS Setup script"

# Setup Wave database to save signals
database -open -default waves
probe -create -name all $::env(TOPLEVEL) -depth all -tasks -functions -uvm -database waves -packed 9280

# Run simulation
run

# Dump Coverage
catch {coverage -dump top}