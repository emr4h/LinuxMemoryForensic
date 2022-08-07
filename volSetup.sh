#!/bin/bash
# Volatility Download
# -------------------

sudo apt install -y python2.7
sudo apt install -y python-setuptools -y
sudo apt install python2.7-dev -y
sudo apt install curl -y
curl https://bootstrap.pypa.io/pip/2.7/get-pip.py --output get-pip.py
sudo python2.7 get-pip.py
sudo python2.7 -m pip install -U setuptools wheel
python2.7 -m pip install distorm3==3.4.4
python2.7 -m pip install pycrypto
sudo apt install yara -y
rm get-pip.py
cd /opt
git clone https://github.com/volatilityfoundation/volatility.git
chmod +x volatility/vol.py
cd volatility
python2.7 setup.py build
python2.7 setup.py install
echo "your volatility path: /opt/volatility "
