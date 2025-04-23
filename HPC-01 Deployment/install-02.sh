#!/usr/bin/env bash
# Make sure failures in piped commands aren't hidden by successful final command
set -euo pipefail

GRN='\033[1;32m'
RST='\033[0m'

# Create and enter installation directory
mkdir -p ~/install_dir
install_dir=~/install_dir
installation_test_file="$install_dir/installation_test.txt"
cd "$install_dir"

command_exists() {
  command -v "$1" >/dev/null 2>&1
}
# Check if Nala is installed
echo -e "\n${GRN}Checking if Nala is installed...${RST}\n"
if ! command_exists nala; then
    echo -e "${GRN}Nala is not installed. Installing...\n${RST}"
    sudo apt install nala -y;
fi

# Update package list
echo -e "${GRN}\nUpdating nala…\n${RST}"
sudo nala update

# Packages to install
packages=(
  zsh
  neofetch
  terminator
  mercurial
  axel
  lftp
  unar
  parallel
  encfs
  datamash
  samtools
  p7zip-full
  ftp

  # Python packages
  python3-pip
  python3-numpy
  python3-scipy
  python3-matplotlib
  python3-pandas
  jupyter-notebook
  python3-sympy
  python3-nose
  python3-biopython

  # Libraries
  build-essential
  libncurses-dev
  zlib1g-dev
  libbz2-dev
  libssl-dev
  libsqlite3-dev
  libatlas-base-dev
  liblapack-dev
  libblas-dev
  libjpeg-turbo8-dev
  libcurl4-openssl-dev
  libxml2-dev
  libxml2-utils
  libreadline-dev
  xfonts-base
  xorg-dev
  libx11-dev
  libxt-dev
  libgflags-dev
  libgoogle-glog-dev
  libleveldb-dev
  libsnappy-dev
  libopencv-dev
  libboost-dev
  libhdf5-dev
  libprotobuf-dev
  libgmp-dev
  libmpfr-dev
  libmpc-dev
  libc6-dev-i386    # glibc-devel.i686
  g++-multilib      # libstdc++-devel.i686
)

# Install in one shot
echo -e "\n${GRN}Installing ${#packages[@]} packages...\n${RST}"
sudo nala install -y "${packages[@]}"
echo -e "${GRN}Installation of packages completed.\n${RST}"

# Install R
# Add R key & repo
echo -e "\n${GRN}Installing R\n${RST}"
wget -qO- https://cloud.r-project.org/bin/linux/ubuntu/marutter_pubkey.asc \
    | sudo tee -a /etc/apt/trusted.gpg.d/cran_ubuntu_key.asc
echo "deb https://cloud.r-project.org/bin/linux/ubuntu $(lsb_release -cs)-cran40/" \
    | sudo tee -a /etc/apt/sources.list
sudo nala update
sudo nala install r-base r-base-dev -y
echo "R installation completed."

echo -e "${GRN}\nCreating Users 'paul' and 'dermatology'...\n${RST}"
sudo adduser --shell /bin/zsh paul
sudo chage -d 0 paul # Require password change on first login
sudo usermod -aG sudo paul # add to sudo group
sudo wget https://github.com/ClaytonReardon/LinUtil/raw/refs/heads/main/zshrc -O /home/paul/.zshrc

sudo adduser --shell /bin/zsh dermatology
sudo chage -d 0 dermatology # Require password change on first login
sudo usermod -aG sudo dermatology # add to sudo group
sudo wget https://github.com/ClaytonReardon/LinUtil/raw/refs/heads/main/zshrc -O /home/dermatology/.zshrc

# echo
# echo -e "${GRN}Beginning python package installation...${RST}"

# Python packages for paul, and alfred, separated into 2 scripts by user

# # Install Anaconda
# echo
# echo -e "${GRN}Installing Anaconda${RST}"
# wget https://repo.anaconda.com/archive/Anaconda3-2024.10-1-Linux-x86_64.sh 
# chmod +x Anaconda3-2024.10-1-Linux-x86_64.sh
# ./Anaconda3-2024.10-1-Linux-x86_64.sh
# echo "Anaconda install completed."

# # Install Sleap.ai
# echo
# echo -e "${GRN}Installing Sleap.ai${RST}"
# conda create -y -n sleap -c conda-forge -c nvidia -c sleap/label/dev -c sleap -c anaconda sleap=1.4.1
# echo "Sleap.ai install completed."

# # Install DeepLabCut
# echo
# echo -e "${GRN}Installing DeepLabCut${RST}"
# wget https://github.com/DeepLabCut/DeepLabCut/raw/refs/heads/main/conda-environments/DEEPLABCUT.yaml
# conda env create -f DEEPLABCUT.yaml
# echo "DeepLabCut install completed."

# # Install Phy2
# # Install dependencies
# echo
# echo -e "${GRN}Installing Phy2${RST}"
# sudo nala install build-essential python3-dev git
# wget https://github.com/cortex-lab/phy/raw/refs/heads/master/environment.yml -O phy-env.yml
# conda env create -f phy-env.yml
# conda activate phy2
# pip install klusta klustakwik2
# conda deactivate
# echo "Phy2 install completed."

# # Install R in Anaconda
# echo
# echo -e "${GRN}Installing R in Anaconda${RST}"
# conda create --name r_env r-essentials r-base
# echo "R in Anaconda install completed."

# # Install Fastp
# echo
# echo -e "${GRN}Installing Fastp${RST}"
# conda create –name fastp
# conda activate fastp
# conda install -c bioconda fastpconda install
# conda deactivate
# echo "Fastp install completed."

# # Install Biobakery
# echo
# echo -e "${GRN}Installing Biobakery${RST}"
# conda config --add channels defaults
# conda config --add channels bioconda
# conda config --add channels conda-forge
# conda config --add channels biobakery
# conda create --name biobakery3 python=3.7
# echo "Biobakery install completed."

# # Install Humann and Metaphlan
# echo
# echo -e "${GRN}Installing Humann and Metaphlan${RST}"
# conda activate biobakery3
# conda install -c biobakery humann
# conda deactivate
# echo "Humann and Metaphlan install completed."

# # Install Bracken
# echo
# echo -e "${GRN}Installing Bracken${RST}"
# conda create -n bracken
# conda activate bracken
# conda install bioconda::bracken
# conda deactivate
# echo "Bracken install completed."

# # Install Kraken2
# echo
# echo -e "${GRN}Installing Kraken2${RST}"
# conda create -n kraken2
# conda activate kraken2
# conda install bioconda::kraken2
# conda deactivate
# echo "Kraken2 install completed."

# # Install MPA
# echo
# echo -e "${GRN}Installing MPA${RST}"
# conda create -n mpa 
# conda activate mpa
# conda install mpa-portable -c bioconda
# conda deactivate
# echo "MPA install completed."

# # Install Picrust1
# echo
# echo -e "${GRN}Installing Picrust1${RST}"
# conda create -n picrust1
# conda activate picrust1
# conda install sjanssen2::picrust1
# conda deactivate
# echo "Picrust1 install completed."

# # Install Picrust2
# echo
# echo -e "${GRN}Installing Picrust2${RST}"
# conda create -n picrust2
# conda activate picrust2
# conda install bioconda::picrust2

# # Install Kilosort
# echo
# echo -e "${GRN}Installing Kilosort${RST}"
# conda create --name kilosort python=3.9
# conda activate kilosort
# python -m pip install kilosort[gui]
# conda deactivate
# echo "Kilosort install completed."

echo
echo "Cleaning up..."
cd ..
rm -rf $install_dir

# echo
# echo "To test installations:

# Sleap:
# conda activate sleap
# sleap-label
# (Opens GUI)

# DeepLabCut:
# conda activate deeplabcut
# python -m deeplabcut
# (Opens GUI)

# Phy2:
# conda activate phy2
# phy --help

# Biobakery/Humann/Metaphlan:
# conda activate biobakery3
# humann --help
# metaphlan --help

# Fastp:
# conda activate fastp
# fastp --help

# Bracken:
# conda activate bracken
# bracken --help

# Kraken2:
# conda activate kraken2
# kraken2 --help

# MPA:
# conda activate mpa
# mpa-portable 
# (should start with "--exec-dir=PATH")

# Picrust1:
# conda activate picrust1
# evalutate_test_datasets.py --help

# Picrust2:
# conda activate picrust2
# picrust2_pipeline.py --help

# Kilosort:
# conda activate kilosort
# python -m kilosort
# (Should start with 'Binary path is none'
# If this doesn't work, it's likely a 
# graphics driver issue. Verify Nvidia drivers
# are up to date and running.)" > "$installation_test_file"

# echo -e "${GRN}Installation test instructions saved to "$installation_test_file"${RST}
