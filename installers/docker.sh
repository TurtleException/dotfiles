#!/bin/bash

# Installs docker engine


KEY_URL="https://download.docker.com/linux/debian/gpg"

function ask() {
	read -p "$1 (Y/n): " response < /dev/tty
	test -z "$response" \
		|| [ "$response" = "y" ] \
		|| [ "$response" = "Y" ] \
		|| [ "$response" = "yes" ] \
		|| [ "$response" = "Yes" ] \
		|| [ "$response" = "YES" ]
}


# Prompt for sudo password once
sudo -v || { echo "This script requires sudo privileges."; exit 1; }

echo "Installing docker"

echo "  Downloading keyring"
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL "$KEY_URL" -o "/etc/apt/keyrings/docker.asc" &> /dev/null
echo "deb [arch=$(dpkg --print-architecture)  signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian $(. /etc/os-release && echo "$VERSION_CODENAME") stable" \
	| sudo tee /etc/apt/sources.list.d/docker.list &> /dev/null
sudo chmod a+r /etc/apt/keyrings/docker.asc

echo "  Running apt update"
sudo apt update &> /dev/null

echo "  Installing docker-ce"
sudo apt install docker-ce -y &>/dev/null
echo "  Installing docker-ce-cli"
sudo apt install docker-ce-cli -y &>/dev/null
echo "  Installing containerd.io"
sudo apt install containerd.io -y &>/dev/null
echo "  Installing docker-buildx-plugin"
sudo apt install docker-buildx-plugin -y &>/dev/null
echo "  Installing docker-compose-plugin"
sudo apt install docker-compose-plugin -y &>/dev/null

calling_user=$(id -un)
if ask "Would you like $calling_user to be added to the docker group?"; then
	sudo usermod -aG docker "$calling_user" &> /dev/null
	echo "  OK!"
fi
