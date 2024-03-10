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
    ensure_installed =  { "python", "vimdoc", "bash" },
    highlight = {
        enable = true,
        disable = { "sh" },
    },
}


-- Nvim Tree

-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- optionally enable 24-bit colour
vim.opt.termguicolors = true

-- Main configuration (check :h nvim-tree-opts)
require("nvim-tree").setup({
    renderer = {
        add_trailing = true,
        highlight_git = "all",
        highlight_opened_files = "name",
        highlight_modified = "name",
        indent_markers = {
            enable = true
        },
    },
    modified = {
        enable = true,
        show_on_dirs = false
    },
    git = {
        enable = true,
        ignore = false
    }
})


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
local Red = '#eb6f92'
local LightBlue = '#3e8fb0'
local DarkGrey = '#474556'

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

-- Custom queries for python (~/.config/nvim/queries/python/highlights.scm)
vim.api.nvim_set_hl(0, '@decorator.identifier.python', { fg = DarkGreen })
vim.api.nvim_set_hl(0, '@decorator.function.object.python', { fg = DarkGreen })
vim.api.nvim_set_hl(0, '@decorator.function.attribute.python', { fg = LightGreen })

-- Coc colors
vim.api.nvim_set_hl(0, 'CocUnusedHighlight', { fg = LightGrey })

-- following colors are not fully working
vim.api.nvim_set_hl(0, 'CocHintSign', { fg = LightBlue })
vim.api.nvim_set_hl(0, 'CocHintVirtualText', { fg = LightBlue })
vim.api.nvim_set_hl(0, 'CocHintFloat', { fg = LightBlue })
vim.api.nvim_set_hl(0, 'CocInlayHint', { fg = LightBlue })

vim.api.nvim_set_hl(0, 'CocInfoSign', { fg = LightBlue })
vim.api.nvim_set_hl(0, 'CocInfoVirtualText', { fg = LightBlue })
vim.api.nvim_set_hl(0, 'CocInfoFloat', { fg = LightBlue })
vim.api.nvim_set_hl(0, 'CocInlayInfo', { fg = LightBlue })

vim.api.nvim_set_hl(0, 'CocErrorSign', { fg = Red })
vim.api.nvim_set_hl(0, 'CocErrorVirtualText', { fg = Red })
vim.api.nvim_set_hl(0, 'CocErrorFloat', { fg = Red })
vim.api.nvim_set_hl(0, 'CocInlayError', { fg = Red })

vim.api.nvim_set_hl(0, 'CocWarningSign', { fg = Yellow })
vim.api.nvim_set_hl(0, 'CocWarningVirtualText', { fg = Yellow })
vim.api.nvim_set_hl(0, 'CocWarningFloat', { fg = Yellow })
vim.api.nvim_set_hl(0, 'CocInlayWarning', { fg = Yellow })

-- Nvim tree colors (use the :NvimTreeHiTest command to check the available groups):
vim.api.nvim_set_hl(0, 'NvimTreeFolderName', { fg = DarkGreen })
vim.api.nvim_set_hl(0, 'NvimTreeFolderIcon', { fg = LightBlue })
vim.api.nvim_set_hl(0, 'NvimTreeGitIgnoredIcon', { fg = LightGrey })
vim.api.nvim_set_hl(0, 'NvimTreeGitFileIgnoredHL', { fg = LightGrey })
vim.api.nvim_set_hl(0, 'NvimTreeIndentMarker', { fg = DarkGrey })

