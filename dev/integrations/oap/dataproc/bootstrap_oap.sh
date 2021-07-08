#!/bin/bash

oap_install_dir=/opt/benchmark-tools/oap
sudo mkdir -p $oap_install_dir
conda_install_dir=/opt/benchmark-tools/conda
sudo yum -y install wget

## Step 1: install conda
sudo wget -c https://repo.continuum.io/miniconda/Miniconda2-latest-Linux-x86_64.sh -P /tmp
sudo chmod +x /tmp/Miniconda2-latest-Linux-x86_64.sh
sudo bash /tmp/Miniconda2-latest-Linux-x86_64.sh -b -p ${conda_install_dir}
${conda_install_dir}/bin/conda init
source ~/.bashrc
sudo chown $(whoami):$(whoami) ${oap_install_dir}

## Step 2: install oap

conda create -p ${oap_install_dir}  -c conda-forge -c intel-beaver -c intel -c intel-bigdata -y oap=1.2.0

