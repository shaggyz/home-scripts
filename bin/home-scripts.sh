#!/usr/bin/env bash

# Internal usage directory
mkdir $HOME/.home-scripts

# Basic stuff installation
read -p "Install basic linux (debian) stuff? " -n 1 -r
echo 

if [[ $REPLY =~ ^[Yy]$ ]]; then
    ./install-basic-stuff.sh
fi

# X11 configuration
read -p "Configure X11? " -n 1 -r
echo 

if [[ $REPLY =~ ^[Yy]$ ]]; then
    ./x11configuration.sh
fi

# Linux headers
read -p "Install linux headers? " -n 1 -r
echo 

if [[ $REPLY =~ ^[Yy]$ ]]; then
    apt-get install -y linux-headers-`uname -r`
fi

# Vim configuration
read -p "Configure vim? " -n 1 -r
echo

if [[ $REPLY =~ ^[Yy]$ ]]; then
    cp -R ../vim/.vim* $HOME/
fi

# Bash configuration
read -p "Configure bash? " -n 1 -r
echo

sed -i s/#force_color_prompt/force_color_prompt/ $HOME/.bashrc

if [[ $REPLY =~ ^[Yy]$ ]]; then
   if [ -f "../bash/$USER-bashrc" ]; then
       cat "../bash/$USER-bashrc" >> $HOME/.bashrc
   else 
       cat "../bash/general-bashrc" >> $HOME/.bashrc
   fi
fi

echo
echo "Environment configured. Bye!"
echo
