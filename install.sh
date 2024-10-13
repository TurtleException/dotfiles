#!/bin/bash

# Installer script for dotfiles

INSTALL_DIR="$HOME"

# Asks a Yes/No question and prompts the user (defaults to yes if no input is supplied)
function ask() {
  read -p "$1 (Y/n): " response
  test -z "$response" \
    || [ "$response" = "y" ] \
    || [ "$response" = "Y" ] \
    || [ "$response" = "yes" ] \
    || [ "$response" = "Yes" ] \
    || [ "$response" = "YES" ]
}

# Asks whether something should be sourced by .bashrc
function askSource() {
  if ask "$1"; then
    echo "source $INSTALL_DIR/.dotfiles/$2" >> "$INSTALL_DIR/.bashrc"
  fi
}

cd "$INSTALL_DIR/.dotfiles" || exit 1

echo "" >> "$INSTALL_DIR/.bashrc"
echo "# dotfiles repo config" >> "$INSTALL_DIR/.bashrc"

askSource "Add bash aliases?" ".bash_aliases"
askSource "Use color prompt?" ".bash_color"

if ask "Install motd?"; then
  install_motd=true

  # Check whether figlet is already installed
  if ! command -v figlet &>/dev/null; then
    # Check whether figlet can be installed via apt (Debian & Ubuntu)
    if command -v apt &>/dev/null; then
      if ask "  Figlet could not be found. Should it be installed?"; then
        sudo apt install figlet
      fi
    # Check whether figlet can be installed via dnf (Fedora)
    elif command -v dnf &>/dev/null; then
      if ask "  Figlet could not be found. Should it be installed?"; then
        sudo dnf install figlet
      fi
    # Check whether figlet can be installed via yum (CentOS & RHEL)
    elif command -v yum &>/dev/null; then
      if ask "  Figlet could not be found. Should it be installed?"; then
        sudo yum install figlet
      fi
    else
      if ! ask "  Figlet could not be found. Proceed anyway?"; then
        install_motd=false
      fi
    fi
  fi

  if $install_motd; then
    echo "./.dotfiles/motd.sh" >> "$INSTALL_DIR/.bashrc"
  else
    echo "  Skipping installation of motd"
  fi
fi
