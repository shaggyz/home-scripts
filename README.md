# Dotfiles

> This repository contains my dotfiles for Unix (ATM only macOS and GNU/Linux).


## Requirements

The program [GNU/Stow](https://www.gnu.org/software/stow/) is used to synchronise the local files with the home folder. 

Also, `GNU make` is an optional dependency just for convenience.

```bash
# Install stow in Debian
sudo apt install stow

# Install stow in macOS with home-brew
brew install stow
```


## Usage

The `stow` usage is quite simple, but here are the most used commands:

```bash
# Synchronizes a single "package"
stow -t $HOME -v bash

# De-Synchronizes (unlink) a single package:
stow -t $HOME -D -v bash

# Dry run:
stow -t $HOME --no -v bash
```

There is also a Makefile used to install the packages bundled by OS/context, make targets can be checked by running `make` or `make help`:

```
Shaggyz dotfiles - make targets:

help: -> Show this help
unix: -> Links unix-generic dotfiles
development: unix -> Links development-related dotfiles
linux: unix -> Links dotfiles only related to GNU/Linux
macos: unix -> Links macOS dotfiles
windows: -> Some WSL dotfiles
```
