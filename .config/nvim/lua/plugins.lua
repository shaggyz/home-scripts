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
-- Kotlin syntax highlight
Plug 'udalov/kotlin-vim'
-- Lualine
Plug 'nvim-lualine/lualine.nvim'

-- Database viewer
-- Plug 'tpope/vim-dadbod'
-- Plug 'kristijanhusak/vim-dadbod-ui'
-- Improved diff tool
Plug 'sindrets/diffview.nvim'

-- Telescope
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
-- Markdown viewer
Plug 'MeanderingProgrammer/markdown.nvim'

-- Playground for treesitter
-- Plug 'nvim-treesitter/playground'

-- Python debugger
-- Plug 'mfussenegger/nvim-dap'
-- Plug 'nvim-neotest/nvim-nio'
-- Plug 'rcarriga/nvim-dap-ui'

-- Testing: Highlight colors
-- Plug 'brenoprata10/nvim-highlight-colors'

-- Testing: UUID generator
Plug 'TrevorS/uuid-nvim'
-- Testing: Bind named syntax
Plug 'egberts/vim-syntax-bind-named'
-- Testing: Markdown viewer
Plug 'MeanderingProgrammer/markdown.nvim'
-- Testing: python documentation
Plug 'girishji/pythondoc.vim'

vim.cmd('call plug#end()')
