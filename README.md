# compair-fw
ComPair Firmware Repository

Porting to lattice based compair-fw from xilinx based astep-fw

Actual folders structure: 

- rtl -> RTL sources are here, building blocks and generic top level 
- target-xxx -> FPGA implementation target folders, should contain radiant project for the target board, if we would have multiple targets
- verification -> All cocotb verification testbenches are here
- vendor -> if needed some extra libraries. Contains KIT icflow lib that provides simulation utilities and RFG tool required for registerfile generation

## WSL environment
These instructions are developed in May 2025, on Windows 11 Version 23H2 (OS Build 22631.5335), using WSL 2, and specific to WSL Ubuntu-22.04

### For a fresh install if image already exists, backup existing image

    mkdir c:\wsl
    cd c:\wsl
    wsl --export Ubuntu-22.04 Ubuntu-22.04_backup.tar
    wsl --import Ubuntu-22.04_backup Ubuntu-22.04_backup Ubuntu-22.04_backup.tar`

### Install Ubuntu 22.04 WSL 
(assuming default wsl version already 2)

    wsl --install Ubuntu-22.04

Note: use auid for username to make network licensing easier.

### Set Ubuntu-22.04 as default distribution

    wsl -s Ubuntu-22.04

### Install Radiant
1. Download radiant zip files from https://www.latticesemi.com/latticeradiant
2. 

    sudo apt-get update
    sudo apt-get upgrade
    sudo update-locale LC_ALL="C.UTF-8"

    sudo apt-get install unzip libopengl0 libgl1-mesa-glx build-essential libjpeg-dev libieee1284-3 libusb-0.1.4 lsb-core libice6 libsm6 libsm6 libxt6 libsm6 libxt6 libxft2 -f libxss1 pulseaudio -y libxcb-xinput0 libxcb-image0 libxcb-keysyms1 libxcb-render-util0 libxcb-xkb1 libxcb-xinerama0 libxkbcommon-x11-0 libxcb-icccm4 libxkbfile1 libxcb-shape0 libxcb-cursor0 libxv1 libxslt1-dev


    cd ~
    cp /mnt/c/users/<AUID>/Downloads/2024.2.0.3.4_Radiant_lin.zip ~
    unzip 2024.2.0.3.4_Radiant_lin.zip
    ./2024.2.0.3.4_Radiant_lin.run --console --prefix ~/lscc/radiant/2024.2
    rm 2024.2.0.3.4_Radiant_lin.*
    
    cp /mnt/c/users/<AUID>/Downloads/2024.2.1.330.0_Radiant_update_lin.zip ~
    unzip 2024.2.1.330.0_Radiant_update_lin.zip
    chmod +x 2024.2.1.330.0_Radiant_update.run
    ./2024.2.1.330.0_Radiant_update.run --console --prefix ~/lscc/radiant/2024.2


./lscc/radiant/2024.2/bin/lin64/check_systemlibrary_radiant.bash
cat ./check_systemlibrary.log

### Set up license
1. get the eth0 mac address using `ip addr`
2. Use it, removing symbols, to generate a license selecting all ip at https://www.latticesemi.com/Support/Licensing/DiamondAndiCEcube2SoftwareLicensing/Radiant
3. Download licesnse.dat emailed to you
4. Copy license to local install directory `cp /mnt/c/Users/<AUID>/Downloads/license.dat ~/lscc/radiant/2024.2/license/`
5. If using a network license run or add to .bashrc: `export LATTICE_LICENSE_FILE=27542@gs500s-license`

### Running Radiant
./lscc/radiant/2024.2/bin/lin64/radiant &

