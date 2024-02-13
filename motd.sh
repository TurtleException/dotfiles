#!/bin/bash

# Displays an ASCII turtle with the hostname of the system as a banner
# This is intended to be used as an motd

paste <(cat res/turtle) <(figlet hostname)