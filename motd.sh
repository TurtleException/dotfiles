#!/bin/bash

# Displays an ASCII turtle with the hostname of the system as a banner
# This is intended to be used as an motd

dotfiles_dir=$(dirname "$0")

hostname=$(hostnamectl hostname --pretty)
if [ "$hostname" == "" ]; then
	hostname=$(hostnamectl hostname)
fi

paste <(cat "$dotfiles_dir"/res/turtle) <(figlet "$hostname")
