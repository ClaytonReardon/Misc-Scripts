#!/bin/bash

set -euo pipefail

GRN='\033[1;32m'
RED='\033[1;31m'
RST='\033[0m'

if ! [[ $USER == "paul" ]]; then
    echo -e "${RED}This script is intended for the user 'paul'. Please run it as 'paul'.${RST}"
    exit 1
fi

if ! [[ -d "/home/paul/anaconda3" ]]; then
    echo -e "${RED}Anaconda3 not found. Please install Anaconda3 first. Use the following command:${RST}"
    echo "wget https://repo.anaconda.com/archive/Anaconda3-2024.10-1-Linux-x86_64.sh \ 
    chmod +x Anaconda3-2024.10-1-Linux-x86_64.sh \ 
    ./Anaconda3-2024.10-1-Linux-x86_64.sh \ 
    exec zsh"
    exit 1
fi

# Install Sleap.ai
echo
echo -e "${GRN}Installing Sleap.ai${RST}"
conda create -y -n sleap -c conda-forge -c nvidia -c sleap/label/dev -c sleap -c anaconda sleap=1.4.1
echo "Sleap.ai install completed."

# Install DeepLabCut
echo
echo -e "${GRN}Installing DeepLabCut${RST}"
wget https://github.com/DeepLabCut/DeepLabCut/raw/refs/heads/main/conda-environments/DEEPLABCUT.yaml
conda env create -f DEEPLABCUT.yaml
echo "DeepLabCut install completed."

# Install Phy2
# Install dependencies
echo
echo -e "${GRN}Installing Phy2${RST}"
sudo nala install build-essential python3-dev git
wget https://github.com/cortex-lab/phy/raw/refs/heads/master/environment.yml -O phy-env.yml
conda env create -f phy-env.yml
conda activate phy2
pip install klusta klustakwik2
conda deactivate
echo "Phy2 install completed."

# Install Kilosort
echo
echo -e "${GRN}Installing Kilosort${RST}"
conda create --name kilosort python=3.9
conda activate kilosort
python -m pip install kilosort[gui]
# Next 2 lines only needed for VM
# sudo apt install mesa-utils libgl1-mesa-dri qt6-base-dev libqt6opengl6 libqt6openglwidgets6 libxcb-cursor0 -y
# export QT_QPA_PLATFORM=xcb
conda deactivate
echo "Kilosort install completed."

echo
echo "Cleaning up..."
cd ..
rm -rf $install_dir

echo "To test installations:

Sleap:
conda activate sleap
sleap-label
(Opens GUI)

DeepLabCut:
conda activate deeplabcut
python -m deeplabcut
(Opens GUI)

Phy2:
conda activate phy2
phy --help

Kilosort:
conda activate kilosort
python -m kilosort
(Should start with 'Binary path is none'
If this doesn't work, it's likely a 
graphics driver issue. Verify Nvidia drivers
are up to date and running.)" > "$installation_test_file"

echo -e "${GRN}Installation test instructions saved to "$installation_test_file"${RST}