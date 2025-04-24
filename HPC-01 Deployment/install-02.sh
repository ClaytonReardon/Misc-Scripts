#!/usr/bin/env bash
# Make sure failures in piped commands aren't hidden by successful final command
set -euo pipefail

GRN='\033[1;32m'
RST='\033[0m'
installation_test_file="~/installation_test.txt"
install_dir=$(pwd)

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
  libc6-dev-i386
  g++-multilib
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

echo -e "${GRN}\nCreating user 'paul'\n${RST}"
sudo adduser --shell /bin/zsh paul
sudo chage -d 0 paul # Require password change on first login
sudo usermod -aG sudo paul # add to sudo group
sudo cp "$install_dir/zshrc" /home/paul/.zshrc
sudo mkdir -p /home/paul/.config
sudo cp "$install_dir/starship.toml" /home/paul/.config/starship.toml
sudo cp "$install_dir/install-alfred.sh" /home/paul

echo -e "${GRN}\nCreating user 'dermatology'\n${RST}"
sudo adduser --shell /bin/zsh dermatology
sudo chage -d 0 dermatology # Require password change on first login
sudo usermod -aG sudo dermatology # add to sudo group
sudo cp "$install_dir/zshrc" /home/dermatology/.zshrc
sudo mkdir -p /home/dermatology/.config
sudo cp "$install_dir/starship.toml" /home/dermatology/.config/starship.toml
sudo cp "$install_dir/install-alfred.sh" /home/dermatology