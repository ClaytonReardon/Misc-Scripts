#!/usr/bin/env bash
# Make sure failures in piped commands aren't hidden by successful final command
set -euo pipefail

GRN='\033[1;32m'
RST='\033[0m'

echo -e "${GRN}\nUpdating system and installing basic dependencies...\n${RST}"
sudo apt update && sudo apt upgrade -y
sudo apt install git curl open-vm-tools open-vm-tools-desktop -y

echo -e "${GRN}\nInstalling desktop environment...\n${RST}"
sudo apt install ubuntu-desktop -y
sudo systemctl set-default graphical.target
echo
echo -e "${GRN}\nSystem will reboot to GUI in 5s...\n${RST}"
sleep 5
sudo reboot -h now