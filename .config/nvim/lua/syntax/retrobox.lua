--------------------------------------------------------------------------------
-- ❇ Custom syntax stuff (for retrobox)
--------------------------------------------------------------------------------

-- Main Theme
vim.cmd('colorscheme retrobox')

-- Airline settings
require('lualine').setup {
    options = {
        theme = 'modus-vivendi',
    }
}
