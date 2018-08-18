# My unix home configuration files

Configurations/plugins for some unix programs that I use every day.

- GNU screen
- vim
- bash
- X11

## Vim 

For vim, there is a script to maintain/update plugins and configurations, you can execute it with this command:

```
./configs/vim/update.sh
``` 

It will backup your current configuration in `$HOME/.vim.backup` before to make any change.

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

