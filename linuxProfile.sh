#!/bin/bash
# Profile Creator
# ---------------

#example usage : ./linuxProfile.sh /opt/memory.lime

echo "catching kernel information from the memory image.."
echo "Please wait ..."
memoryDump=$1
kernelInfo=$(sudo strings $memoryDump | grep "Linux version 4.*\|Linux version 5.*" | head -n 1 | cut -d ' ' -f 3)
sudo apt install linux-image-${kernelInfo}
sudo apt install linux-headers-${kernelInfo} -y
sudo apt install dwarfdump -y 
sudo apt install zip -y
cd /opt/volatility/tools/linux
echo 'MODULE_LICENSE("GPL");' >> module.c
sudo make -C /lib/modules/${kernelInfo}/build CONFIG_DEBUG_INFO=y M=$PWD modules
dwarfdump -di ./module.o > module.dwarf
sudo zip $(lsb_release -i -s)_${kernelInfo}_profile.zip module.dwarf /boot/System.map-${kernelInfo}
mv $(lsb_release -i -s)_${kernelInfo}_profile.zip ../../volatility/plugins/overlays/linux/
cd /opt/volatility
echo " "
echo "Profile Checking"
echo " "
python2.7 vol.py --info | grep -i ${kernelInfo}
