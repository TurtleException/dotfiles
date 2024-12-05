#!/bin/bash

# Displays an ASCII turtle with the hostname of the system as a banner
# This is intended to be used as an motd

dotfiles_dir=$(dirname "$0")

hostname=""

hctl_version=$(hostnamectl --version | grep -o -P '(?<=systemd )\d+')
if [ "$hctl_version" -ge 249 ]; then
	hostname=$(hostnamectl hostname --pretty)

	if [ "$hostname" == "" ]; then
		hostname=$(hostnamectl hostname)
	fi
fi

if [ -z "$hostname" ]; then
	hostname=$(hostname)
fi

paste <(cat "$dotfiles_dir"/res/turtle) <(figlet "$hostname")
