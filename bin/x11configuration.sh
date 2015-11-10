#!/usr/bin/env bash

if [ ! -f "$HOME/.Xdefaults" ]; then
    touch "$HOME/.Xdefaults"
fi

if [ ! -f "$HOME/.xsession" ]; then
    touch "$HOME/.xsession"
fi

# 256 color term for X11
echo "*customization: -color" >> "$HOME/.Xdefaults"
echo "XTerm*termName:  xterm-256color" >> "$HOME/.Xdefaults"

# Read .Xdefaults on every user X11 session
echo 'if [ -f $HOME/.Xdefaults ]; then' >> "$HOME/.xsession"
echo '  xrdb -merge $HOME/.Xdefaults' >> "$HOME/.xsession"
echo 'fi' >> "$HOME/.xsession"


