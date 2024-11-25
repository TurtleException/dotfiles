#!/bin/bash

# Installs brave browser


KEY_URL="https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg"


# Prompt for sudo password once
sudo -v || { echo "This script requires sudo privileges."; exit 1; }

echo "Installing brave-browser"

echo "  Downloading keyring"
sudo curl -fsSL "$KEY_URL" -o "/usr/share/keyrings/brave-browser-archive-keyring.gpg" &> /dev/null
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main" \
	| sudo tee /etc/apt/sources.list.d/brave-browser.list &> /dev/null

echo "  Running apt update"
sudo apt update &> /dev/null

echo "  Installing"
sudo apt install brave-browser -y &> /dev/null
