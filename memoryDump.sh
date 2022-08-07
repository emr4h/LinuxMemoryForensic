#!/bin/bash
# Memory Dump
# -----------

sudo apt install git -y
sudo apt install build-essential -y
sudo apt install linux-image-$(uname -r)
sudo apt install linux-headers-$(uname -r) -y
cd /opt
git clone https://github.com/504ensicsLabs/LiME.git
cd LiME/src
make
sudo /sbin/insmod lime-$(uname -r).ko "path=/opt/memory.lime format=lime"
cd /opt
echo " "
echo "Memory Checking"
echo " "
echo "your memory path: /opt/memory.lime "
ls -alh memory.lime
