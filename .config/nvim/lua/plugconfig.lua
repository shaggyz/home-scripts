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

-- Lua Airline ----------------------------------------------------------------



-- Vim Airline ----------------------------------------------------------------

vim.g.airline_theme = 'solarized'
vim.g.airline_powerline_fonts = 1
-- vim.g['airline#extensions#tabline#enabled'] = 1
-- vim.g['airline#extensions#coc#enabled'] = 1
-- vim.g['airline#extensions#coc#error_symbol'] = ' '
-- vim.g['airline#extensions#coc#warning_symbol'] = ' '
-- vim.g['airline#extensions#coc#show_coc_status'] = 1
-- vim.g['airline#parts#ffenc#skip_expected_string'] = 'utf-8[unix]'
vim.g.airline_section_c_only_filename = 1
-- vim.g['airline#extensions#wordcount#enabled'] = 0
-- vim.g['airline#extensions#hunks#enabled'] = 1
-- vim.g['airline#extensions#hunks#hunk_symbols'] = { ' ', ' ', ' ' }

-- Initialize airline_symbols if it doesn't exist
-- if vim.g.airline_symbols == nil then
-- vim.g.airline_symbols = {}
-- end

-- Set the properties of airline_symbols
-- vim.g.airline_symbols['dirty'] = ''
-- vim.g.airline_symbols['linenr'] = ' Ⓛ '
-- vim.g.airline_symbols['maxlinenr'] = ' '
-- vim.g.airline_symbols['colnr'] = 'Ⓒ '
-- vim.g.airline_symbols['branch'] = ' '

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
