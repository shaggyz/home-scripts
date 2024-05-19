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
    sync_root_with_cwd = true,
    renderer = {
        add_trailing = true,
        highlight_git = "name",
        highlight_opened_files = "none",
        highlight_modified = "name",
        indent_markers = {
            enable = true
        },
        icons = {
            git_placement = 'before',
            modified_placement = 'after',
            glyphs = {
                git = {
                    untracked = '󰐗',
                    unstaged = '',
                    deleted = '󰯆'
                },
            },
        },
    },
    view = {
        width = 30,
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
            resize_window = false,
            window_picker = {
                enable = false
            }
        }
    },
    diagnostics = {
        enable = true,
    },
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

-- Highlight the symbol and its references on a CursorHold event(cursor is idle)
vim.api.nvim_create_augroup("CocGroup", {})
vim.api.nvim_create_autocmd("CursorHold", {
    group = "CocGroup",
    command = "silent call CocActionAsync('highlight')",
    desc = "Highlight symbol under cursor on CursorHold"
})

-- Autocomplete
function _G.check_back_space()
    local col = vim.fn.col('.') - 1
    return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
end

-- Better Whitespace -----------------------------------------------------------

vim.g.better_whitespace_enabled = 1
vim.g.strip_whitespace_on_save = 1
vim.g.strip_whitespace_confirm = 0


-- DBUI --------------------- https://github.com/kristijanhusak/vim-dadbod-ui --

vim.g.db_ui_win_position = 'right'
vim.g.db_ui_show_database_icon = true
vim.g.db_ui_use_nerd_fonts = true
vim.g.db_ui_auto_execute_table_helpers = true
vim.g.db_ui_show_help = false
vim.g.db_ui_save_location = '~/.local/share/db_ui'


-- Better diff tool
-- TBD > https://github.com/sindrets/diffview.nvim?tab=readme-ov-file
