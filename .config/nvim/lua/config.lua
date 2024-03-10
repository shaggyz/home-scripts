-- Neovide specific configuration

if vim.g.neovide then
    if jit and jit.os == "Linux" then
        -- Linux
        -- Copy/Paste keybindings
        vim.keymap.set('n', '<A-C-v>', '"+P') -- Paste normal mode
        vim.keymap.set('i', '<A-C-v>', '<ESC>l"+Pli') -- Paste insert mode
        vim.keymap.set('v', '<A-C-c>', '"+y') -- Copy
        -- Font
        --vim.o.guifont = "JetBrainsMono Nerd Font Mono:h10.5"
        vim.o.guifont = "Hack Nerd Font Mono:h11"

    else
        -- macOS
        -- Copy/Paste keybindings
        vim.keymap.set('v', '<D-c>', '"+y') -- Copy
        vim.keymap.set('n', '<D-v>', '"+P') -- Paste normal mode
        vim.keymap.set('v', '<D-v>', '"+P') -- Paste visual mode
        vim.keymap.set('c', '<D-v>', '<C-R>+') -- Paste command mode
        vim.keymap.set('i', '<D-v>', '<ESC>l"+Pli') -- Paste insert mode
        -- Font
        vim.o.guifont = "JetBrainsMono Nerd Font Mono:h12.5"

    end

    -- Increase / decrease font size
    vim.keymap.set({ "n", "v" }, "<C-+>", ":lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor + 0.1<CR>")
    vim.keymap.set({ "n", "v" }, "<C-->", ":lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor - 0.1<CR>")
    vim.keymap.set({ "n", "v" }, "<C-0>", ":lua vim.g.neovide_scale_factor = 1<CR>")

    -- Additional cursor particle effect
    vim.g.neovide_cursor_vfx_mode = "sonicboom"
    -- Cursor animation time
    vim.g.neovide_cursor_trail_size = 0.2
    -- Scrolling animation time
    vim.g.neovide_scroll_animation_length = 0.2
end

-- FTerm
require'FTerm'.setup({
    cmd = 'bash -l',
    border = 'single',
    blend = 8,
})

-- Gitsings
require('gitsigns').setup()

-- TreeSitter (better syntax)
require'nvim-treesitter.configs'.setup {
    ensure_installed =  { "python", "vimdoc" },
    highlight = {
        enable = true,
    },
}


-- Custom syntax stuff (for rosepine)

-- Rosepine pallete: https://rosepinetheme.com/palette/ingredients/
local LighterGreen = '#d9fbeb'
local LightGreen = '#9ccfd8'
local DarkGreen = '#31748f'
local LighterYellow = '#fbf1d9'
local Grey = '#908caa'
local Yellow = '#fee1b8'
local White = '#ffffff'
local LightGrey = '#a3a0b5'

-- Global
vim.api.nvim_set_hl(0, '@type', { fg = LighterGreen, italic = false })
vim.api.nvim_set_hl(0, '@variable.builtin.vim', { fg = LightGreen, bold = false })

-- Python
vim.api.nvim_set_hl(0, '@variable.parameter.python', { fg = LighterYellow, italic = false })
vim.api.nvim_set_hl(0, '@variable.python', { italic = false })
vim.api.nvim_set_hl(0, '@operator.python', { fg = DarkGreen})
vim.api.nvim_set_hl(0, '@constant.builtin.python', { fg = DarkGreen, bold = false })
vim.api.nvim_set_hl(0, '@function.method.call.python', { fg = LightGreen })
vim.api.nvim_set_hl(0, '@function.call.python', { fg = White })
vim.api.nvim_set_hl(0, '@string.documentation.python', { fg = Grey })
vim.api.nvim_set_hl(0, '@string.python', { fg = Yellow })
vim.api.nvim_set_hl(0, 'CocUnusedHighlight', { fg = LightGrey })

-- Custom queries for python (~/.config/nvim/queries/python/highlights.scm)
vim.api.nvim_set_hl(0, '@decorator.identifier.python', { fg = DarkGreen })
vim.api.nvim_set_hl(0, '@decorator.function.object.python', { fg = DarkGreen })
vim.api.nvim_set_hl(0, '@decorator.function.attribute.python', { fg = LightGreen })
