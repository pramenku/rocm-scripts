#!/usr/bin/env bash
# Copyright 2017 The TensorFlow Authors. All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# ==============================================================================

set -e
set -x
#install_bootstrap_deb_packages.sh
apt-get -y update
apt-get install -y --no-install-recommends pciutils \
    apt-transport-https ca-certificates software-properties-common
apt-get clean
rm -rf /var/lib/apt/lists/*

#install_pip_packages.sh
apt-get install pciutils -y
apt autoremove -y python-numpy python3-numpy
mkdir -p /install && cd ~/tensorflow && cp tensorflow/tools/ci_build/install/*.sh /install/
sh /install/install_bootstrap_deb_packages.sh
add-apt-repository -y ppa:openjdk-r/ppa && add-apt-repository -y ppa:george-edison55/cmake-3.x
sh /install/install_deb_packages.sh
pip uninstall setuptools -y
pip install setuptools==20.7.0
pip install --upgrade pip
pip3 install numpy
sh /install/install_pip_packages.sh
#sh /install/install_golang.sh


N_JOBS=$(grep -c ^processor /proc/cpuinfo)
N_GPUS=$(lspci|grep 'controller'|grep 'AMD/ATI'|wc -l)

echo ""
echo "Bazel will use ${N_JOBS} concurrent build job(s) and ${N_GPUS} concurrent test job(s)."
echo ""

cd ~/tensorflow && bazel clean --expunge && bash tensorflow/tools/ci_build/linux/rocm/run_py3_core.sh |& tee tensorflow-ut-logs.txt
