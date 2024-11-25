#!/bin/bash

# Installs skype for linux


DEB_URL="https://go.skype.com/skypeforlinux-64.deb"
tmpfile="/tmp/skypeforlinux-64.deb"


# Prompt for sudo password once
sudo -v || { echo "This script requires sudo privileges."; exit 1; }

echo "Installing skypeforlinux"

echo "  Downloading"
curl -fsSL "$DEB_URL" -o "$tmpfile" &> /dev/null

echo "  Installing"
apt install "$tmpfile" -y &> /dev/null

echo "  Cleaning up"
rm "$tmpfile"
