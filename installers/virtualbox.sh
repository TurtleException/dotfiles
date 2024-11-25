#!/bin/bash

# Installs virtualbox


KEY_URL="https://www.virtualbox.org/download/oracle_vbox_2016.asc"
keyfile="/usr/share/keyrings/oracle-virtualbox-2016.gpg"


# Prompt for sudo password once
sudo -v || { echo "This script requires sudo privileges."; exit 1; }

echo "Installing VirtualBox"

echo "  Downloading keyring"
curl -fsSL "$KEY_URL" | sudo gpg --yes --output "$keyfile" --dearmor &> /dev/null
echo "deb [arch=$(dpkg --print-architecture)  signed-by=$keyfile] https://download.virtualbox.org/virtualbox/debian $(. /etc/os-release && echo "$VERSION_CODENAME") contrib" \
	| sudo tee /etc/apt/sources.list.d/virtualbox.list &> /dev/null

echo "  Running apt update"
sudo apt update &> /dev/null

echo "  Installing virtualbox-7.1"
sudo apt install virtualbox-7.1 -y &>/dev/null
