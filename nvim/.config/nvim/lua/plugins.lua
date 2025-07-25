----------------------------------------------------------------------------------------------------
-- ❇ Plugins: installation, using: https://github.com/junegunn/vim-plug#neovim
----------------------------------------------------------------------------------------------------

local Plug = vim.fn['plug#']

vim.cmd('call plug#begin()')

-- CoC for neovim
Plug('neoclide/coc.nvim', { branch = 'release' })
-- Icons
Plug 'ryanoasis/vim-devicons'
-- Close all the buffers
Plug 'schickling/vim-bufonly'
-- Git signs in buffers
Plug 'lewis6991/gitsigns.nvim'
-- Automatically remove white spaces
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
-- Lualine
Plug 'nvim-lualine/lualine.nvim'
-- Improved diff tool
Plug 'sindrets/diffview.nvim'
-- Telescope
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
-- UUID generator
Plug 'TrevorS/uuid-nvim'
-- Bind named syntax
Plug 'egberts/vim-syntax-bind-named'
-- IO library for asynchronous Lua
Plug 'nvim-neotest/nvim-nio'
-- Load .env variables in nvim session
Plug 'ellisonleao/dotenv.nvim'
-- Jinja2 syntax
Plug 'glench/vim-jinja2-syntax'
-- GraphQL syntax
Plug 'jparise/vim-graphql'
-- Telescope + COC
Plug 'fannheyward/telescope-coc.nvim'

-- Editor themes
Plug 'sainnhe/edge'


-- Playground for treesitter
-- Plug 'nvim-treesitter/playground'

-- Python debugger
Plug 'mfussenegger/nvim-dap'
Plug 'mfussenegger/nvim-dap-python'
Plug 'rcarriga/nvim-dap-ui'

vim.cmd('call plug#end()')
