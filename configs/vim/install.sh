#!/usr/bin/env bash

VIM_COLORS=$HOME/.vim/colors
VIM_BUNDLES=$HOME/.vim/bundle

mkdir -p $VIM_COLORS $VIM_BUNDLES

TMPDIR=$(mktemp -d)

cd $TMPDIR

# Molokai color theme (requires 256 term colors)
git clone https://github.com/tomasr/molokai.git
mv molokai/colors/molokai.vim $VIM_COLORS

# Ctrl-P bundle
#curl -O https://raw.githubusercontent.com/ctrlpvim/ctrlp.vim/master/plugin/ctrlp.vim
#git clone https://github.com/ctrlpvim/ctrlp.vim.git $VIM_BUNDLES/ctrlp.vim

rm -Rf $TMPDIR