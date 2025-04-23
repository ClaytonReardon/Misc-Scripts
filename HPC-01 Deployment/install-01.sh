#!/usr/bin/env bash
# Make sure failures in piped commands aren't hidden by successful final command
set -euo pipefail

GRN='\033[1;32m'
RST='\033[0m'

echo -e "${GRN}Updating system and installing basic dependencies...${RST}"
sudo apt update && sudo apt upgrade -y
sudo apt install git curl nala -y

echo
echo -e "${GRN}Installing desktop environment...${RST}"
sudo apt install ubuntu-desktop -y
sudo systemctl set-default graphical.target
echo
echo -e "${GRN}System will reboot to GUI in 5s...${RST}"
sleep 5
sudo reboot