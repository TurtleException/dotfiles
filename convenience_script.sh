#!/bin/bash

# Asks a Yes/No question and prompts the user (defaults to yes if not input is supplied)
function ask() {
  read -p "$1 (Y/n): " response < /dev/tty
  test -z "$response" \
    || [ "$response" = "y" ] \
    || [ "$response" = "Y" ] \
    || [ "$response" = "yes" ] \
    || [ "$response" = "Yes" ] \
    || [ "$response" = "YES" ]
}

function main() {
	if ! command -v git &>/dev/null; then
		echo "Git is not installed!"

		# Attempt to install via APT
		if command -v apt &>/dev/null; then
			if ask "  Attempt to install via APT?"; then
				sudo apt install git
			else
				exit 1
			fi
		elif command -v dnf &>/dev/null; then
			if ask "  Attempt to install via DNF?"; then
				sudo dnf install git
			else
				exit 1
			fi
		elif command -v yum &>/dev/null; then
			if ask "  Attempt to install via YUM?"; then
				sudo yum install git
			else
				exit 1
			fi
		elif command -v brew &>/dev/null; then
			if ask "  Attempt to install via Homebrew?"; then
				brew install git
			else
				exit 1
			fi
		else
			echo "  Failed at attempting auto-installation"
			exit 2
		fi
	fi

	git clone https://github.com/TurtleException/dotfiles ~/.dotfiles && bash ~/.dotfiles/install.sh
}

# Only invoke at the end to prevent partial transmission of this script
main
