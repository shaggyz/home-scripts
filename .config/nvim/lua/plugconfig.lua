--------------------------------------------------------------------------------
-- ❇ Plugins: configuration for each installed plugin
--------------------------------------------------------------------------------

-- FTerm -----------------------------------------------------------------------

require 'FTerm'.setup({
    cmd = 'bash -l',
    border = 'single',
    blend = 8,
})

-- Gitsings --------------------------------------------------------------------

require('gitsigns').setup()

-- TreeSitter (better syntax) --------------------------------------------------

require 'nvim-treesitter.configs'.setup {
    ensure_installed = { "python", "vimdoc", "bash" },
    highlight = {
        enable = true,
        disable = { "sh" },
    },
}

-- Nvim Tree -------------------------------------------------------------------

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
        ignore = false,
        timeout = 5000,
    },
    actions = {
        open_file = {
            resize_window = false
        }
    }
})

-- Lualine --------------------------------------------------------------------

-- Theme example: https://github.com/nvim-lualine/lualine.nvim/wiki/Writing-a-theme

require('lualine').setup {
    options = {
        theme = 'iceberg_dark',
        ignore_focus = { 'NvimTree' },
    },
    sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff' },
        lualine_c = {
            {
                'filename',
                newfile_status = false,
            },
        },
        lualine_x = { 'encoding', 'fileformat', 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = {
            {
                'location',
            },
            {
                'diagnostics',
                sources = { 'nvim_diagnostic', 'coc' },
                sections = { 'error', 'warn', 'info', 'hint' },
                diagnostics_color = {
                    error = 'DiagnosticError',
                    warn  = 'DiagnosticWarn',
                    info  = 'DiagnosticInfo',
                    hint  = 'DiagnosticHint',
                },
                symbols = { error = 'E', warn = 'W', info = 'I', hint = 'H' },
                colored = true,
            },
        }
    },
    tabline = {
        lualine_a = {
            {
                'buffers',
                use_mode_colors = true,
            },
        },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {
            {
                'windows',
                mode = 2,
            },
        },
        lualine_z = {
            {
                'tabs',
            }
        }
    },
    extensions = {
        'fugitive',
        'fzf',
        'nvim-tree',
        'quickfix',
    }
}



-- DAP python (debugger) -------------------------------------------------------

-- require('dap-python').setup('.venv/bin/python')

-- Emmet -----------------------------------------------------------------------

vim.g.user_emmet_install_global = 0
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "html", "css", "vue", "php" },
    command = "EmmetInstall"
})

-- CoC -------------------------------------------------------------------------

-- Highlight the symbol and its references when holding the cursor
vim.api.nvim_create_autocmd("CursorHold", {
    pattern = "*",
    command = "silent call CocActionAsync('highlight')"
})

-- Better Whitespace -----------------------------------------------------------

vim.g.better_whitespace_enabled = 1
vim.g.strip_whitespace_on_save = 1
vim.g.strip_whitespace_confirm = 0
