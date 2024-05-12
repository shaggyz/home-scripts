-------------------------------------------------------------------------------
-- ❇ Neovim: editor settings
-------------------------------------------------------------------------------

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4

vim.opt.cursorline = true
vim.opt.number = true
vim.opt.conceallevel = 2
vim.opt.cc = '100'
vim.opt.termguicolors = true
vim.opt.signcolumn = 'yes'

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.autoindent = true
vim.opt.mouse = 'a'
vim.opt.wildmenu = true
vim.opt.expandtab = true
vim.opt.foldenable = false
vim.opt.updatetime = 300
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Enable filetype detection
vim.cmd('filetype plugin indent on')
vim.cmd('syntax on')

vim.cmd('colorscheme rose-pine-main')

-- Neovim python virtualenv
vim.g.python3_host_prog = '~/.local/nico-virtualenvs/neovim-venv/bin/python'

-- print('editor.lua end')
