# NeoWiki

> This is WIP


NeoWiki a neovim plugin to provide some of the features from the old [VimWiki](https://github.com/vimwiki/vimwiki) plugin.

## WIP notes

At this point the plugin is just included in my personal nvim config as this:


```lua

-- NeoWiki -------------------------------------------------------------------------------------

-- files at: ~/.config/nvim/lua/neowiki/init.lua

require("neowiki").setup({
    debug = false,
    wiki_directory = "~/Nextcloud/Notes",
    reuse_previous_day = true,
})

```


## Supported features

- One single knowledge wiki
- Search functions
- Diary and TODO management
- TODO toggle shortcuts
- Automatic Markdown index creation
- Markdown local/remote link generation


## Features to develop

- [Task 1] Add an option to allow the `reuse_previous_day` to use only week days.
- [Task 2] Create a proper README for users (indicating this plugin is for myself)
- [Task 3] Create a proper structure for an nvim plugin able to redistribute
- [Task 4] Publish the plugin.
