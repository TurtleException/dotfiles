#!/bin/bash

# Installer script for dotfiles

INSTALL_DIR="$HOME"

# Asks a Yes/No question and prompts the user (defaults to yes if not input is supplied)
function ask() {
  read -p "$1 (Y/n): " response
  test -z "$response" \
    || [ "$response" = "y" ] \
    || [ "$response" = "Y" ] \
    || [ "$response" = "yes" ] \
    || [ "$response" = "Yes" ] \
    || [ "$response" = "YES" ]
}

# Asks whether something should be installed (i.e. sources by .bashrc)
function askSource() {
  if ask "$1"; then
    echo "source $INSTALL_DIR/.dotfiles/$2" >> "$INSTALL_DIR/.bashrc"
  fi
}

cd "$INSTALL_DIR/.dotfiles" || exit 1

askSource "Add bash aliases?" ".bash_aliases"
askSource "Use color prompt?" ".bash_color"

# TODO: is there no better way to do this?
if ask "Install motd?"; then
  echo "./.dotfiles/motd.sh" >> "$INSTALL_DIR/.bashrc"
fi