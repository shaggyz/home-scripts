--------------------------------------------------------------------------------
-- ❇ Custom syntax stuff (for rosepine light)
--------------------------------------------------------------------------------

-- Main color scheme
vim.o.background = 'light'
vim.cmd('colorscheme rose-pine-dawn')

-- Airline settings
require('lualine').setup {
    options = {
        theme = 'solarized_light',
    }
}
