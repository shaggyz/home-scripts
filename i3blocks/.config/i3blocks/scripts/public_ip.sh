#!/usr/bin/env bash

IP=$(curl ifconfig.me/ip)

wget -q --tries=10 --timeout=20 -O - http://google.com > /dev/null

if [ $? -ne 0 ]; then
    echo 'Offline'
    exit 0
fi

# Button actions
case $BLOCK_BUTTON in
	# Right click: Copy the IP address to X clipboard
    3) echo "$IP" | xclip ;;
	# Display the IP address by default
    *) echo "$IP" ;;
esac
