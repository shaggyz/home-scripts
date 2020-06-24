#!/usr/bin/env bash
xrdb -merge ~/.Xresources

# Gnome keyring
eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
export SSH_AUTH_SOCK

# Disable the fucking terminal bell
xset b off

# Wallpaper, pick a random one
# Rotation can be added to crontab:
# */15 * * * * DISPLAY=:0 feh --bg-scale --randomize ~/Pictures/Wallpapers/Active/*
feh --bg-scale --randomize ~/Pictures/Wallpapers/Active/*

# Keyboard
setxkbmap en_US

# Enable composition
compton &

# Network manager applet
nm-applet &

# Bluetooth *blueman manager
blueman-applet &

# Netcloud desktop client
nextcloud &

# Pulse audio applet
pasystray &
