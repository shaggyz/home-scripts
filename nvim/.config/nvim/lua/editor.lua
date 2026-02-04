----------------------------------------------------------------------------------------------------
-- ❇ Neovim: editor settings
----------------------------------------------------------------------------------------------------

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4

vim.opt.cursorline = true
vim.opt.number = true
vim.opt.conceallevel = 1
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
    callback = function(_)
        vim.opt.spell = true
    end
})

-- Automatically trim trailing whitespace on save
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    callback = function()
        local save_cursor = vim.fn.getpos(".")
        vim.cmd([[%s/\s\+$//e]])
        vim.fn.setpos(".", save_cursor)
    end,
})

-- Limit parallel updates to prevent SSL syscall errors on fast hardware
vim.g.plug_threads = 4

vim.cmd('set encoding=utf-8')
vim.cmd('set fileencoding=utf-8')
vim.cmd('filetype plugin indent on')
vim.cmd('syntax on')
