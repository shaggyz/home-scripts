--------------------------------------------------------------------------------
-- ❇ Custom syntax stuff (for edge)
--------------------------------------------------------------------------------

-- Main color scheme
vim.o.background = 'dark'
-- vim.o.background = 'light'
vim.cmd('colorscheme edge')

-- Custom Colors
local Grey = '#908caa'

-- Python modifications
vim.api.nvim_set_hl(0, '@string.documentation.python', { fg = Grey })
