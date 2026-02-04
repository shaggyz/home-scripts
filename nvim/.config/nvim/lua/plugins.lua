----------------------------------------------------------------------------------------------------
-- ❇ Plugins: installation, using: https://github.com/junegunn/vim-plug#neovim
----------------------------------------------------------------------------------------------------

local Plug = vim.fn['plug#']

vim.cmd('call plug#begin()')

-- CoC for neovim
Plug('neoclide/coc.nvim', { branch = 'release' })

--- UI & Icons
Plug 'nvim-tree/nvim-web-devicons'
Plug 'nvim-lualine/lualine.nvim'
Plug 'nvim-tree/nvim-tree.lua'
Plug 'xiyaowong/virtcolumn.nvim'

-- Navigation & Git
Plug 'lewis6991/gitsigns.nvim'
Plug 'tpope/vim-fugitive'
Plug 'sindrets/diffview.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'fannheyward/telescope-coc.nvim'

-- Syntax (The heavy lifter)
Plug('nvim-treesitter/nvim-treesitter', { ['do'] = ':TSUpdate' })

-- Utilities
Plug 'schickling/vim-bufonly'
Plug 'TrevorS/uuid-nvim'
Plug 'ellisonleao/dotenv.nvim'

-- Themes
Plug 'sainnhe/edge'

-- Python debugger
-- Plug 'mfussenegger/nvim-dap'
-- Plug 'mfussenegger/nvim-dap-python'
-- Plug 'rcarriga/nvim-dap-ui'
--
vim.cmd('call plug#end()')
