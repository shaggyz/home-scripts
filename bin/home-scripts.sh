#!/usr/bin/env bash

# Internal usage directory
mkdir $HOME/.home-scripts

# Basic stuff installation
read -p "Install basic linux (debian) stuff? " -n 1 -r
echo 

if [[ $REPLY =~ ^[Yy]$ ]]; then
    ./install-basic-stuff.sh
fi

# Vim configuration
read -p "Configure vim? " -n 1 -r
echo

if [[ $REPLY =~ ^[Yy]$ ]]; then
    cp -R vim/.vim* $HOME/
fi

# Bash configuration
read -p "Configure bash? " -n 1 -r

if [[ $REPLY =~ ^[Yy]$ ]]; then
   if [ -f "../bash/$USER-bashrc" ]; then
       cat "../bash/$USER-bashrc" >> $HOME/.bashrc
   else 
       cat "../bash/general-bashrc" >> $HOME/.bashrc
   fi
fi

