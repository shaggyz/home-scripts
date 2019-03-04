#!/usr/bin/env bash

# Detect the main network interface
MAIN_IFACE=$(ip addr show | awk '/inet.*brd/{print $NF; exit}')

# Get the LAN ip address
IP=$(ip addr | grep "bal $MAIN_IFACE" | cut -d' ' -f6 | cut -d'/' -f1) 

# Button actions
case $BLOCK_BUTTON in
	# Right click: Copy the IP address to X clipboard
    3) echo "$IP" | xclip ;;
	# Display the IP address by default
    *) echo "$IP" ;;
esac

