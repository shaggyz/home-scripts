#!/usr/bin/env bash

#set -x

VIM_CONFIG_BACKUP="$HOME/.vim.backup"
VIM_CONFIG_DIR="$HOME/.vim"
VIM_CONFIG_FILE="$HOME/.vimrc"

VIM_COLORS="$VIM_CONFIG_DIR/colors"
VIM_BUNDLE="$VIM_CONFIG_DIR/bundle"
VIM_AUTOLOAD="$VIM_CONFIG_DIR/autoload"

GREEN=$(tput setaf 2)
NORMAL=$(tput sgr0)

# Check existent backup

if [ ! -d $VIM_CONFIG_BACKUP ]; then
    mkdir -p $VIM_CONFIG_BACKUP
fi

# Backup the current configuration
BACKUP_FILE="$VIM_CONFIG_BACKUP/vim-config-`date +%Y-%m-%d.%H_%M_%S`.tar.gz"

printf "\n${GREEN}Creating backup with current configuration at: $BACKUP_FILE ${NORMAL}\n\n"

tar -zvcf $BACKUP_FILE -C $HOME .vim .vimrc 
rm -Rf $VIM_CONFIG_DIR $VIM_CONFIG_FILE

# Create the directory structure

mkdir -p $VIM_CONFIG_DIR $VIM_COLORS $VIM_BUNDLE $VIM_AUTOLOAD
mkdir -p "$VIM_AUTOLOAD/airline/themes"
cp vimrc "$VIM_CONFIG_FILE"

# Install plugins

printf "\n${GREEN}Installing plugins and themes${NORMAL}\n\n"
GITHUB="https://raw.githubusercontent.com"

# Pathogen plugin
echo "$GITHUB/tpope/vim-pathogen/master/autoload/pathogen.vim"
curl -Lo "$VIM_AUTOLOAD/pathogen.vim" "$GITHUB/tpope/vim-pathogen/master/autoload/pathogen.vim"

# Molokai color theme (requires 256 term colors)
curl -Lo "$VIM_COLORS/molokai.vim" "$GITHUB/tomasr/molokai/master/colors/molokai.vim"

# Afterflow theme
curl -Lo "$VIM_COLORS/afterglow.vim" "$GITHUB/danilo-augusto/vim-afterglow/master/colors/afterglow.vim"
curl -Lo "$VIM_AUTOLOAD/airline/afterglow.vim" "$GITHUB/danilo-augusto/vim-afterglow/master/autoload/airline/themes/afterglow.vim"

# Ctrl-P bundle
git clone --dept=1 "https://github.com/kien/ctrlp.vim" "$VIM_BUNDLE/ctrlp.vim"

# NERDTree
git clone --dept=1 "https://github.com/scrooloose/nerdtree" "$VIM_BUNDLE/nertdree"

# Syntastic
git clone --dept=1 "https://github.com/vim-syntastic/syntastic" "$VIM_BUNDLE/syntastic"

# Vim Airline
git clone --dept=1 "https://github.com/vim-airline/vim-airline" "$VIM_BUNDLE/vim-airline"

# Instant markdown
git clone --dept=1 "https://github.com/suan/vim-instant-markdown" "$VIM_BUNDLE/vim-instant-markdown"

printf "\n${GREEN}Vim plugins and confguration updated${NORMAL}\n\n"

