----------------------------------------------------------------------------------------------------
-- ❇ Plugins: configuration for each installed plugin
----------------------------------------------------------------------------------------------------

local cwd = vim.fn.getcwd()

-- Gitsings ------------------------------------------ https://github.com/lewis6991/gitsigns.nvim --

require('gitsigns').setup()


-- TreeSitter (better syntax) ---------------- https://github.com/nvim-treesitter/nvim-treesitter --

require('nvim-treesitter').setup({
    -- Ensure all your core languages are here
    ensure_installed = { "python", "vimdoc", "bash", "markdown", "markdown_inline", "make", "lua" },
    -- This forces Neovim to wait for one parser to finish before starting the next.
    sync_install = true,
    -- Keep this true for convenience
    auto_install = true,
    highlight = {
        enable = true,
        -- Ensure this is empty so Treesitter takes over highlighting
        disable = {},
    },
})

-- Nvim Tree ----------------------------------------- https://github.com/nvim-tree/nvim-tree.lua --

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
    update_focused_file = {
        enable = false,
        update_root = {
            enable = false,
            ignore_list = {},
        },
        exclude = false,
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
            -- resize_window = false,
            window_picker = {
                enable = false
            }
        }
    },
    diagnostics = {
        enable = false,
    },
})



-- Render Markdown --------------------------------- https://github.com/nvim-lualine/lualine.nvim --

require('render-markdown').setup({
    code = {
        -- 'full' makes the background span the width of the window
        -- 'block' only highlights the code itself
        style = 'full',
        position = 'left',
        width = 'full',
        left_pad = 2,
        right_pad = 2,
        -- Use the highlight group we want to customize
        highlight = 'RenderMarkdownCode',
    },
})

-- Now, link that group to your preferred black background
-- vim.api.nvim_set_hl(0, "RenderMarkdownCode", { bg = "#000000" })
-- -- Usually, we want the "inline" code to stay as is or be slightly different
-- vim.api.nvim_set_hl(0, "RenderMarkdownCodeInline", { bg = "#1a1a1a" })


-- Lualine ----------------------------------------- https://github.com/nvim-lualine/lualine.nvim --

-- Example: https://github.com/nvim-lualine/lualine.nvim/wiki/Writing-a-theme

require('lualine').setup {
    options = {
        -- theme = 'iceberg_dark',
        -- theme = 'onedark',
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



-- CoC ----------------------------------------------------- https://github.com/neoclide/coc.nvim --

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

-- Better Whitespace -------------------------- https://github.com/ntpeters/vim-better-whitespace --

vim.g.better_whitespace_enabled = 1
vim.g.strip_whitespace_on_save = 1
vim.g.strip_whitespace_confirm = 0


-- NeoWiki -----------------------------------------------------------------------------------------

-- files at: ~/.config/nvim/lua/neowiki/init.lua

require("neowiki").setup({
    debug = false,
    wiki_directory = "~/Nextcloud/Notes",
    reuse_previous_day = true,
})


-- UUID generator ------------------------------------------ https://github.com/TrevorS/uuid-nvim --

require('uuid-nvim').setup {
    case = 'lower',
    quotes = 'double',
}


-- DotEnv -------------------------------------------- https://github.com/ellisonleao/dotenv.nvim --

local env_file = cwd .. "/.env"

if vim.fn.filereadable(env_file) == 1 then
    require('dotenv').setup({
        enable_on_load = true,
        verbose = true,
    })
end

-- Telescope ---------------------------------------------------------------------------------------

require("telescope").setup({
    extensions = {
        coc = {
            -- theme = 'ivy',
            prefer_locations = true,    -- always use Telescope locations to preview definitions
            push_cursor_on_edit = true, -- save the cursor position to jump back in the future
            timeout = 3000,             -- timeout for coc commands
        }
    },
})
require('telescope').load_extension('coc')
