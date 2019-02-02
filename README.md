# My unix home configuration files

Configuration files for programs that I use in a daily basis. Used to keep the configuration synchronised between different environments. Configurations included:

- GNU screen
- tmux
- vim
- bash
- X11
- i3
- i3blocks

## Usage

If you want to install all the configurations `make update`. Otherwise you can update specific programs, for example: `make tmux`, `make screen`.

## Vim 

In order to install vim configuration you can use `make vim`. 
It will backup your current vim configuration in `$HOME/.vim.backup` before to make any change. The same with other files, for example: `~/.tmux.conf` -> `~/.tmux.conf.bkp`

### Vim key mappings

The default `<leader>` key in vim is `\`

- Move to previous buffer: `<Shift+h>`
- Move to next buffer: `<Shift+l>`
- Close unmodified buffer: `<Shift+w>`
- Toggle NerdTREE: `<Ctrl+n>`
- Markdown preview: `<leader>mp`
- JSON format: `<leader>jsf`
- Clear highlighted selections: `<C-c><C-c>`
- Open the current file in NerdTREE: `<leader>r`

