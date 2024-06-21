--------------------------------------------------------------------------------
-- ❇ Plugins: installation, using: https://github.com/junegunn/vim-plug#neovim
--------------------------------------------------------------------------------

local Plug = vim.fn['plug#']

vim.cmd('call plug#begin()')

-- Rose-pine color scheme
Plug 'rose-pine/neovim'
-- CoC for neovim
Plug('neoclide/coc.nvim', { branch = 'release' })
-- Icons
Plug 'ryanoasis/vim-devicons'
-- Markdown plugin
-- Plug 'preservim/vim-markdown'
-- Emmet, HTML tools
-- Plug 'mattn/emmet-vim'
-- Close all the buffers
Plug 'schickling/vim-bufonly'
-- Floating terminal
Plug 'numToStr/FTerm.nvim'
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
-- Kotlin syntax highlight
Plug 'udalov/kotlin-vim'
-- Lualine
Plug 'nvim-lualine/lualine.nvim'
-- Database viewer
Plug 'tpope/vim-dadbod'
Plug 'kristijanhusak/vim-dadbod-ui'
-- Improved diff tool
Plug 'sindrets/diffview.nvim'
--Telescope
Plug 'nvim-lua/plenary.nvim'
Plug('nvim-telescope/telescope-fzf-native.nvim',
    {
        ['do'] =
        'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
    })
Plug('nvim-telescope/telescope.nvim', { ['tag'] = '0.1.6' })

--TODO: Color Scheme edition plugins:
--Color scheme creation
--Plug 'rktjmp/lush.nvim'

--Playground for treesitter
Plug 'nvim-treesitter/playground'

-- Python debugger
Plug 'mfussenegger/nvim-dap'
Plug 'nvim-neotest/nvim-nio'
Plug 'rcarriga/nvim-dap-ui'

-- luacheck: ignore
vim.cmd('call plug#end()')
