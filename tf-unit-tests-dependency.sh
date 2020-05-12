#!/bin/bash

set -x
#install_bootstrap_deb_packages.sh
apt-get -y update
apt-get install -y --no-install-recommends pciutils \
    apt-transport-https ca-certificates software-properties-common
apt-get clean
rm -rf /var/lib/apt/lists/*

apt-get -y update
apt autoremove -y python3-numpy
pip3 install portpicker

#cd ~/tensorflow/tensorflow/tools/ci_build/install

#./install_deb_packages.sh

#./install_pip_packages.sh

