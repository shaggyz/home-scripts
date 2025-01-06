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

-- Colors
local Black = '#000000'
local Green = '#b7bb00'

-- Customizations

-- Markdown
-- vim.api.nvim_set_hl(0, 'RenderMarkdownCode', { fg = Yellow })
-- vim.api.nvim_set_hl(0, '@code_span', { bg = Black, fg = Yellow })

