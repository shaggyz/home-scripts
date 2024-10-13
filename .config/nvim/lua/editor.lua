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

vim.opt.hlsearch = false
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
vim.opt.clipboard:append { 'unnamed', 'unnamedplus' }

-- Enable spell only in certain files
vim.opt.spell = false
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
    pattern = { "*.md", "*.py", "*.html", "*.lua" },
    callback = function(ev)
        vim.opt.spell = true
    end
})

vim.cmd('filetype plugin indent on')
vim.cmd('syntax on')
vim.cmd('colorscheme rose-pine-moon')

-- color scheme
-- dark
-- vim.cmd('colorscheme rose-pine-main')
-- medium
-- vim.cmd('colorscheme retrobox')
