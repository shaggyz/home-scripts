----------------------------------------------------------------------------------------------------
-- ❇ Custom syntax stuff (for gruvbox light)
----------------------------------------------------------------------------------------------------

-- Main color scheme
vim.o.background = 'light'
vim.cmd('colorscheme gruvbox-material')

-- Available values: 'hard', 'medium'(default), 'soft'
vim.cmd('let g:gruvbox_material_background = "soft"')

-- The foreground color palette used: 'material', 'mix', 'original'
vim.cmd('let g:gruvbox_material_foreground = "material"')

-- Enable / Disable italic in comments
vim.cmd('let g:gruvbox_material_disable_italic_comment = 0')

-- Enable / Disable bold fonts in function names
vim.cmd('let g:gruvbox_material_enable_bold = 1')

-- Cursor color: 'auto', 'red', 'orange', 'yellow', 'green', 'aqua', 'blue', 'purple'
vim.cmd('let g:gruvbox_material_cursor = "auto"')

-- Line contrast type: low, high
vim.cmd('let g:gruvbox_material_ui_contrast = "high"')

-- Airline settings
require('lualine').setup {
    options = {
        theme = 'gruvbox-material',
    }
}

