----------------------------------------------------------------------------------------------------
-- ❇ Plugins: configuration for each installed plugin
----------------------------------------------------------------------------------------------------


-- Gitsings ------------------------------------------ https://github.com/lewis6991/gitsigns.nvim --

require('gitsigns').setup()


-- TreeSitter (better syntax) ---------------- https://github.com/nvim-treesitter/nvim-treesitter --

require 'nvim-treesitter.configs'.setup {
    ensure_installed = { "python", "vimdoc", "bash", "markdown" },
    highlight = {
        enable = true,
        disable = { "sh" },
    },
}


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
      enable = true,
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


-- DAP python (debugger) ------------------------------- https://github.com/mfussenegger/nvim-dap --

local dap = require('dap')

dap.adapters.python = {
    type = 'executable',
    command = os.getenv('HOME') .. '/.local/share/debugpy/bin/python3',
    args = { '-m', 'debugpy.adapter' },
    options = {
        source_filetype = 'python',
    },
}

local cwd = vim.fn.getcwd()

dap.configurations.python = {
    {
        type = 'python',
        request = 'launch',
        name = "Launch file",
        program = "${file}",
        pythonPath = function()
            local cwd = vim.fn.getcwd()
            if vim.fn.executable(cwd .. '/venv/bin/python') == 1 then
                return cwd .. '/venv/bin/python'
            elseif vim.fn.executable(cwd .. '/.venv/bin/python') == 1 then
                return cwd .. '/.venv/bin/python'
            elseif vim.fn.executable(cwd .. '/.venv/bin/python3') == 1 then
                return cwd .. '/.venv/bin/python3'
            else
                return '/usr/bin/python3'
            end
        end,
    },
    {
        type = 'python',
        request = 'launch',
        name = "Launch LDD application",
        program = cwd .. "/.venv/bin/fastapi",
        args = {'run', cwd .. '/link_direct_data/api/main.py'},
        pythonPath = function()
            if vim.fn.executable(cwd .. '/venv/bin/python') == 1 then
                return cwd .. '/venv/bin/python'
            elseif vim.fn.executable(cwd .. '/.venv/bin/python') == 1 then
                return cwd .. '/.venv/bin/python'
            elseif vim.fn.executable(cwd .. '/.venv/bin/python3') == 1 then
                return cwd .. '/.venv/bin/python3'
            else
                return '/usr/bin/python3'
            end
        end,
    },
}

-- FIXME: Unknown character error
-- vim.fn.sign_define('DapBreakpoint', {text='', texthl='#de4948', linehl='', numhl=''})
-- vim.fn.sign_define('DapStopped', {text='', texthl='#1f717b', linehl='', numhl=''})
-- vim.fn.sign_define('DapBreakpointRejected', {text='', texthl='#ffa100', linehl='', numhl=''})

-- Nvim DAP UI ------------------------------------------ https://github.com/rcarriga/nvim-dap-ui --

local dapui = require("dapui")

dapui.setup()

dap.listeners.before.attach.dapui_config = function()
  dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
  dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
  dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
  dapui.close()
end


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

require("neowiki").setup({
    debug = true,
    wiki_directory = "~/Nextcloud/Notes"
})


-- UUID generator ------------------------------------------ https://github.com/TrevorS/uuid-nvim --

require('uuid-nvim').setup{
  case = 'lower',
  quotes = 'double',
}


-- DotEnv -------------------------------------------- https://github.com/ellisonleao/dotenv.nvim --

require('dotenv').setup()
