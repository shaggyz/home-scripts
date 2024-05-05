--------------------------------------------------------------------------------
-- ❇ Plugins: installation, using: https://github.com/junegunn/vim-plug#neovim
--------------------------------------------------------------------------------

local Plug = vim.fn['plug#']

vim.cmd('call plug#begin()')

-- Rose-pine colorscheme
Plug 'rose-pine/neovim'
-- CoC for neovim
Plug('neoclide/coc.nvim', { branch = 'release' })
-- Fuzz search
Plug('ibhagwan/fzf-lua', { branch = 'main' })
-- Icons
Plug 'ryanoasis/vim-devicons'
-- Markdown plugin
Plug 'preservim/vim-markdown'
-- Emmet, HTML tools
Plug 'mattn/emmet-vim'
-- Close all the buffers
Plug 'schickling/vim-bufonly'
-- Floating terminal
Plug 'numToStr/FTerm.nvim'
-- Git signs in buffers
Plug 'lewis6991/gitsigns.nvim'
-- Automatically remove whitespaces
Plug 'ntpeters/vim-better-whitespace'
-- Max width column
Plug 'xiyaowong/virtcolumn.nvim'
-- Icons used by FZF
Plug 'nvim-tree/nvim-web-devicons'
-- File tree
Plug 'nvim-tree/nvim-tree.lua'
-- Git CLI complement
Plug 'tpope/vim-fugitive'
-- Adds additional highlight groups, used for syntax highlighting
Plug('nvim-treesitter/nvim-treesitter', { ['do'] = ':TSUpdate' })
-- Kotlin syntax highlight
Plug 'udalov/kotlin-vim'
-- Astro syntax
Plug 'wuelnerdotexe/vim-astro'
-- Lualine
Plug 'nvim-lualine/lualine.nvim'

-- Database viewer
Plug 'tpope/vim-dadbod'
Plug 'kristijanhusak/vim-dadbod-ui'

--TODO: Color Scheme edition plugins:
--Colorcheme creation
--Plug 'rktjmp/lush.nvim'
--Playground for treesitter
--Plug 'nvim-treesitter/playground'

--TODO: Python debugger testing
--Plug 'mfussenegger/nvim-dap'
--Plug 'mfussenegger/nvim-dap-python/'

-- luacheck: ignore
vim.cmd('call plug#end()')

-- print('plugins.lua end')
