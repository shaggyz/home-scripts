#!/usr/bin/env bash

#set -x

VIM_SOURCE_DIR=$(dirname "$0")

VIM_CONFIG_BACKUP="$HOME/.vim.backup"
VIM_CONFIG_DIR="$HOME/.vim"
VIM_CONFIG_FILE="$HOME/.vimrc"

VIM_COLORS="$VIM_CONFIG_DIR/colors"
VIM_BUNDLE="$VIM_CONFIG_DIR/bundle"
VIM_AUTOLOAD="$VIM_CONFIG_DIR/autoload"

GREEN=$(tput setaf 2)
NORMAL=$(tput sgr0)

#-------------------------------------------------------------------------------
# This section is used to update the repository with the current configuration
#-------------------------------------------------------------------------------

if [ "$1" = "--repository" ]; then
    echo "Updating home-scripts vimrc with your current .vimrc configuration..."
    rm "$VIM_SOURCE_DIR/vimrc"
    cp $VIM_CONFIG_FILE "$VIM_SOURCE_DIR/vimrc"
    git add $VIM_SOURCE_DIR
    git commit
    git push origin master
    echo "Configuration updated in github!"
    exit
fi

#-------------------------------------------------------------------------------
# Backup configuration, and copy new config files from repository
#-------------------------------------------------------------------------------

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
cp "$VIM_SOURCE_DIR/vimrc" "$VIM_CONFIG_FILE"

#-------------------------------------------------------------------------------
# Install plugins
#-------------------------------------------------------------------------------

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

# Ctrl-P bundle (Search files with CTRL+P)
git clone --dept=1 "https://github.com/kien/ctrlp.vim" "$VIM_BUNDLE/ctrlp.vim"

# NERDTree (Display file tree)
git clone --dept=1 "https://github.com/scrooloose/nerdtree" "$VIM_BUNDLE/nertdree"

# Syntastic
# git clone --dept=1 "https://github.com/vim-syntastic/syntastic" "$VIM_BUNDLE/syntastic"

# Vim Airline (Status bar for vim)
git clone --dept=1 "https://github.com/vim-airline/vim-airline" "$VIM_BUNDLE/vim-airline"

# Instant markdown (Converts markdown to html)
git clone --dept=1 "https://github.com/suan/vim-instant-markdown" "$VIM_BUNDLE/vim-instant-markdown"

# Emmet (HTML, CSS, web development tool)
# git clone --dept=1 "https://github.com/mattn/emmet-vim.git" "$VIM_BUNDLE/emmet-vim"

# Git fugitive (Utilities for git, not used, but required by git gutter)
git clone --dept=1 "https://github.com/tpope/vim-fugitive.git" "$VIM_BUNDLE/vim-fugitive"

# Git gutter (Display git changes on vim)
git clone --dept=1 "http://github.com/airblade/vim-gitgutter.git" "$VIM_BUNDLE/vim-gitgutter"

# Auto pair
# git clone --dept=1 "https://github.com/jiangmiao/auto-pairs" "$VIM_BUNDLE/auto-pairs"

# Vim table mode
git clone --dept=1 "https://github.com/dhruvasagar/vim-table-mode" "$VIM_BUNDLE/vim-table-mode"

# Vim REST client
# git clone --dept=1 "https://github.com/diepm/vim-rest-console" "$VIM_BUNDLE/vim-rest-console"

printf "\n${GREEN}Vim plugins and confguration updated${NORMAL}\n\n"

