-------------------------------------------------------------------------------
-- ❇ Neovim: keybindings
-------------------------------------------------------------------------------

-- Editor ---------------------------------------------------------------------

vim.g.mapleader = ','

-- CTRL+h: move to the previous buffer
vim.keymap.set('n', '<C-h>', ':bprev!<CR>')
-- CTRL+l: move to the next buffer
vim.keymap.set('n', '<C-l>', ':bnext!<CR>')
-- ,q: close the current buffer w/o closing the window and move to the previous
vim.keymap.set('n', '<Leader>q', ':bp<CR> :bd#<CR>')
-- CTRL+c CTRL+c: Remove hlsearch
-- vim.keymap.set('n', '<C-c><C-c>', ':silent! nohls<CR>')
-- ,ca: Close all the buffers, except the current one
vim.keymap.set('n', '<leader>ca', ':BufOnly<CR>')
-- CTRL+x: copy visual selected text into system clipboard (wezterm needs this to make CMD+c work in macOS)
vim.api.nvim_set_keymap('v', '<Leader>xc', '"+y', { noremap = true, silent = true })

-- Define the ShowDocumentation function
function ShowDocumentation()
    if vim.fn.CocAction('hasProvider', 'hover') == 1 then
        vim.fn.CocActionAsync('doHover')
    else
        vim.api.nvim_feedkeys(
            vim.api.nvim_replace_termcodes('K', true, false, true), 'n', false
        )
    end
end

-- Map 'K' to call the ShowDocumentation function in normal mode
vim.keymap.set('n', 'K', ShowDocumentation, { noremap = true, silent = true })

-- Edit main Neovim configuration
vim.keymap.set('n', '<leader>ev', ':e ~/.config/nvim/init.lua<CR>', {
    noremap = true,
    silent = true
})


-- Terminal --------------------------------------------------------------------

-- -- Toggle terminal in normal mode
-- vim.keymap.set('n', '<C-i>', require("FTerm").toggle, { noremap = true, silent = true })
--
-- -- Toggle terminal in terminal mode
-- vim.keymap.set('t', '<C-i>', '<C-\\><C-n><cmd>lua require("FTerm").toggle()<CR>',
--     { noremap = true, silent = true })
--
-- -- Unmap <Tab> in terminal mode
-- vim.cmd('tunmap <Tab>')


-- CoC ------------------------------------------------------------------------

vim.keymap.set('n', '<leader>dd', '<Plug>(coc-definition)', { silent = true })
vim.keymap.set('n', '<leader>yy', '<Plug>(coc-type-definition)', { silent = true })
vim.keymap.set('n', '<leader>im', '<Plug>(coc-implementation)', { silent = true })
vim.keymap.set('n', '<leader>us', '<Plug>(coc-references)', { silent = true })
vim.keymap.set('n', '<leader>rn', '<Plug>(coc-rename)', { silent = true })

-- Map keys for formatting code in visual and normal modes
vim.keymap.set('x', '<leader>ff', '<Plug>(coc-format-selected)', { silent = true })
vim.keymap.set('n', '<leader>ff', '<Plug>(coc-format-selected)', { silent = true })

-- Map <CR> to confirm and select the autocomplete suggestion
vim.keymap.set('i', '<CR>', 'coc#pum#visible() ? coc#pum#confirm() : "<CR>"', { expr = true, noremap = true })

-- Use <c-space> to trigger completion
vim.keymap.set("i", "<c-space>", "coc#refresh()", { silent = true, expr = true })

-- Use K to show documentation in preview window
function _G.show_docs()
    local cw = vim.fn.expand('<cword>')
    if vim.fn.index({ 'vim', 'help' }, vim.bo.filetype) >= 0 then
        vim.api.nvim_command('h ' .. cw)
    elseif vim.api.nvim_eval('coc#rpc#ready()') then
        vim.fn.CocActionAsync('doHover')
    else
        vim.api.nvim_command('!' .. vim.o.keywordprg .. ' ' .. cw)
    end
end

vim.keymap.set("n", "K", '<CMD>lua _G.show_docs()<CR>', { silent = true })


-- Telescope ------------------------------------------------------------------

local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>ff',
    function()
        builtin.find_files({ no_ignore_parent = true })
    end,
    {}
)

vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fo', builtin.buffers, {})
vim.keymap.set('n', '<leader>fm', builtin.command_history, {})
vim.keymap.set('n', '<leader>fq', builtin.quickfix, {})
vim.keymap.set('n', '<leader>fr', builtin.resume, {})
vim.keymap.set('n', '<leader>fk', builtin.keymaps, {})

vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.keymap.set('n', '<leader>fs', builtin.treesitter, {})

vim.keymap.set('n', '<leader>fc', builtin.git_commits, {})
vim.keymap.set('n', '<leader>fb', builtin.git_branches, {})
vim.keymap.set('n', '<leader>gs', builtin.git_status, {})

-- Find and open wiki files
vim.keymap.set('n', '<leader>ss',
    function()
        builtin.find_files({
            cwd = "~/Nextcloud/VimWiki/personal",
            no_ignore_parent = true,
        })
    end,
    { silent = true, noremap = true }
)


-- Find in wiki content
-- For some reason live_grep is not working
vim.keymap.set('n', '<leader>ws',
    function()
        builtin.live_grep({
            cwd = "~/Nextcloud/VimWiki/personal",
            type_filter = "markdown"
        })
    end,
    { silent = true, noremap = true }
)


-- Nvim Tree -------------------------------------------------------------------

-- NvimTree mappings
vim.keymap.set('n', '<leader>v', "<cmd>NvimTreeToggle<CR>", { silent = true, noremap = true })
-- Find file in NvimTree using a Lua function
vim.keymap.set('n', '<leader>r', require('nvim-tree.api').tree.find_file, {
    noremap = true,
    silent = true
})


-- DBUI --------------------- https://github.com/kristijanhusak/vim-dadbod-ui --

-- Toggle the DBUI GUI
-- vim.keymap.set('n', '<leader>dt', '<cmd>DBUIToggle<CR>', { silent = true, noremap = true })
-- Add database
-- vim.keymap.set('n', '<leader>da', '<cmd>DBUIAddConnection<CR>', { silent = true, noremap = true })


-- DAP UI -------------------------- https://github.com/rcarriga/nvim-dap-ui --

-- vim.keymap.set('n', '<leader>de', require("dapui").toggle, { silent = true, noremap = true })


-- NeoWiki ---------------------------------------------------------------------
-- Personal plugin under development -------------------------------------------

vim.keymap.set('n', '<leader>mt', '<cmd>WikiToday<CR>', { silent = true, noremap = true })
vim.keymap.set('n', '<leader>my', '<cmd>WikiYesterday<CR>', { silent = true, noremap = true })
vim.keymap.set('n', '<leader>mo', '<cmd>WikiTomorrow<CR>', { silent = true, noremap = true })
vim.keymap.set('n', '<leader>mm', '<cmd>WikiCurrentMonth<CR>', { silent = true, noremap = true })

-- Enable this keymaps only for markdown files
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "markdown" },
    callback = function()
        vim.schedule(function()
            vim.keymap.set('n', '<s-cr>', '<cmd>WikiCreateLink<CR>', { silent = true, noremap = true })
            vim.keymap.set('v', '<s-cr>', '<cmd>WikiCreateLink<CR>', { silent = true, noremap = true })
            vim.keymap.set('n', '<leader>mi', '<cmd>WikiCreateIndex<CR>', { silent = true, noremap = true })
            vim.keymap.set('n', '<cr>', '<cmd>WikiFollowLink<CR>', { silent = true, noremap = true })
            -- vim.keymap.set('i', '<cr>', '<cmd>WikiListNewLine<CR>', { silent = true, noremap = true })
        end)
    end,
})

-- UUID -------------------------------- https://github.com/TrevorS/uuid-nvim --

local uuid = require('uuid-nvim')
vim.keymap.set('i', '<C-u>', uuid.insert_v4)
