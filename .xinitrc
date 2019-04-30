#!/usr/bin/env bash
xrdb -merge ~/.Xresources

# Gnome keyring
eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
export SSH_AUTH_SOCK

