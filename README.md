# compair-fw
ComPair Firmware Repository

## Status 03/04/2024

This repository contains base sources copied from ASTEP project, it is not ported and prepared for lattice environment, don't expect anything to be working.

Actual folders structure: 

- rtl -> RTL sources are here, building blocks and generic top level 
- target-xxx -> FPGA implementation target folders, should contain radiant project for the target board, if we would have multiple targets
- verification -> All cocotb verification testbenches are here
- vendor -> if needed some extra libraries. Contains KIT icflow lib that provides simulation utilities and RFG tool required for registerfile generation