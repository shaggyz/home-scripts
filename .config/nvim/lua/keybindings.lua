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
vim.keymap.set('n', '<C-c><C-c>', ':silent! nohls<CR>')
-- ,ca: Close all the buffers, except the current one
vim.keymap.set('n', '<leader>ca', ':BufOnly<CR>')

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

-- Toggle terminal in normal mode
vim.keymap.set('n', '<C-i>', require("FTerm").toggle, { noremap = true, silent = true })

-- Toggle terminal in terminal mode
vim.keymap.set('t', '<C-i>', '<C-\\><C-n><cmd>lua require("FTerm").toggle()<CR>',
    { noremap = true, silent = true })

-- Unmap <Tab> in terminal mode
vim.cmd('tunmap <Tab>')


-- CoC ------------------------------------------------------------------------

vim.keymap.set('n', '<leader>dd', '<Plug>(coc-definition)', { silent = true })
vim.keymap.set('n', '<leader>yy', '<Plug>(coc-type-definition)', { silent = true })
vim.keymap.set('n', '<leader>im', '<Plug>(coc-implementation)', { silent = true })
vim.keymap.set('n', '<leader>us', '<Plug>(coc-references)', { silent = true })
vim.keymap.set('n', '<leader>rn', '<Plug>(coc-rename)', { silent = true })

-- Clear previous autocmds and define new ones for Python files
--vim.api.nvim_create_augroup('PythonAutocomplete', { clear = true })
--vim.api.nvim_create_autocmd('FileType', {
    --group = 'PythonAutocomplete',
    --pattern = 'python',
    --callback = function()
        --vim.bo.completeopt = 'menuone,noinsert,noselect'
        --vim.bo.shortmess = vim.bo.shortmess .. 'c'
    --end
--})

-- Map keys for formatting code in visual and normal modes
vim.keymap.set('x', '<leader>ff', '<Plug>(coc-format-selected)', { silent = true })
vim.keymap.set('n', '<leader>ff', '<Plug>(coc-format-selected)', { silent = true })

-- Make <CR> to accept selected completion item or notify coc.nvim to format
-- <C-g>u breaks current undo, please make your own choice
-- vim.keymap.set("i", "<cr>", [[coc#pum#visible() ? coc#pum#confirm() : "<cr>"]], {silent = true, nowait = true})

-- Map <CR> to confirm and select the autocomplete suggestion
vim.keymap.set('i', '<CR>', 'coc#pum#visible() ? coc#pum#confirm() : "<CR>"', { expr = true, noremap = true })


-- Use <c-space> to trigger completion
vim.keymap.set("i", "<c-space>", "coc#refresh()", {silent = true, expr = true})

-- Use K to show documentation in preview window
function _G.show_docs()
    local cw = vim.fn.expand('<cword>')
    if vim.fn.index({'vim', 'help'}, vim.bo.filetype) >= 0 then
        vim.api.nvim_command('h ' .. cw)
    elseif vim.api.nvim_eval('coc#rpc#ready()') then
        vim.fn.CocActionAsync('doHover')
    else
        vim.api.nvim_command('!' .. vim.o.keywordprg .. ' ' .. cw)
    end
end
vim.keymap.set("n", "K", '<CMD>lua _G.show_docs()<CR>', {silent = true})


-- FZF ------------------------------------------------------------------------

-- List project files
vim.keymap.set('n', '<leader>f', require('fzf-lua').files, { silent = true, noremap = true })
-- List open files
vim.keymap.set('n', '<leader>o', require('fzf-lua').buffers, { silent = true, noremap = true })
-- Grep in project
vim.keymap.set('n', '<leader>g',
    function()
        require('fzf-lua').live_grep({
            cmd = "git grep --line-number --column --color=always"
        })
    end,
    { silent = true, noremap = true }
)

-- Grep in wiki
vim.keymap.set('n', '<leader>s',
    function()
        require('fzf-lua').files({
            prompt = "WIKI❯ ",
            cmd = "find -type f",
            cwd = "~/Nextcloud/VimWiki/personal"
        })
    end,
    { silent = true, noremap = true }
)


-- Nvim Tree ------------------------------------------------------------------

-- NvimTree mappings
vim.keymap.set('n', '<leader>v', "<cmd>NvimTreeToggle<CR>", { silent = true, noremap = true })
-- Find file in NvimTree using a Lua function
vim.keymap.set('n', '<leader>r', require('nvim-tree.api').tree.find_file, {
    noremap = true,
    silent = true
})


-- DBUI -----------------------------------------------------------------------

-- Toggle the DBUI GUI
vim.keymap.set('n', '<leader>dt', '<cmd>DBUIToggle<CR>', { silent = true, noremap = true })
-- Add databsae
vim.keymap.set('n', '<leader>da', '<cmd>DBUIAddConnection<CR>', { silent = true, noremap = true })
