----------------------------------------------------------------------------------------------------
-- ❇ Neovim: keybindings
----------------------------------------------------------------------------------------------------

-- Editor ------------------------------------------------------------------------------------------

vim.g.mapleader = ','

-- CTRL+h: move to the previous buffer
vim.keymap.set('n', '<C-h>', ':bprev!<CR>')
-- CTRL+l: move to the next buffer
vim.keymap.set('n', '<C-l>', ':bnext!<CR>')
-- ,q: close the current buffer w/o closing the window and move to the previous
vim.keymap.set('n', '<Leader>q', ':bp<CR> :bd#<CR>')
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

-- <leader>tn Add new tab
vim.keymap.set('n', '<leader>tn', ':tabnew<CR>')
-- <leader>tt Next tab
vim.keymap.set('n', '<leader>tt', ':tabnext<CR>')
-- <leader>T Close tab
vim.keymap.set('n', '<leader>T', ':tabclose<CR>')


-- CoC ---------------------------------------------------------------------------------------------

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


-- Telescope ---------------------------------------------------------------------------------------

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
vim.keymap.set('n', '<leader>fc', builtin.colorscheme, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

vim.keymap.set('n', '<leader>fs', 'Telescope coc workspace-symbols', {})

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
vim.keymap.set('n', '<leader>ws',
    function()
        builtin.live_grep({
            -- Expand the tilde to the full home path
            cwd = vim.fn.expand("~/Nextcloud/VimWiki/personal"),
            additional_args = function(_)
                return { "--glob", "*.md" }
            end,
        })
    end,
    { silent = true, noremap = true }
)


-- Nvim Tree ---------------------------------------------------------------------------------------

-- NvimTree mappings
vim.keymap.set('n', '<leader>vv', "<cmd>NvimTreeToggle<CR>", { silent = true, noremap = true })
vim.keymap.set('n', '<leader>vf', "<cmd>NvimTreeFindFile<CR>", { silent = true, noremap = true })

-- Find current file in NvimTree
vim.keymap.set('n', '<leader>r', function()
    local api = require('nvim-tree.api')
    -- This will open the tree if it's closed and focus the current file
    api.tree.find_file({ open = true, focus = true })
end, { desc = "NvimTree: Find current file", silent = true, noremap = true })

-- DAP ---------------------------------------------------------------------------------------------

vim.keymap.set('n', '<Leader>ds', function() require('dap').continue() end)
vim.keymap.set('n', '<Leader>dq', function() require('dap').terminate() end)
vim.keymap.set('n', '<Leader>do', function() require('dap').step_over() end)
vim.keymap.set('n', '<Leader>di', function() require('dap').step_into() end)
vim.keymap.set('n', '<Leader>dt', function() require('dap').step_out() end)
vim.keymap.set('n', '<Leader>db', function() require('dap').toggle_breakpoint() end)
vim.keymap.set('n', '<Leader>dr', function() require('dap').repl.open() end)
vim.keymap.set('n', '<Leader>dk', function() require('dap.ui.widgets').hover() end)
vim.keymap.set('n', '<Leader>dl', ':e $HOME/.cache/nvim/dap.log<CR>', { silent = true, noremap = true })


-- NeoWiki -----------------------------------------------------------------------------------------
-- Personal plugin under development ---------------------------------------------------------------

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
            vim.keymap.set('n', '<leader>md', '<cmd>WikiToggleCheckBox<CR>', { silent = true, noremap = true })
            -- vim.keymap.set('i', '<cr>', '<cmd>WikiListNewLine<CR>', { silent = true, noremap = true })
        end)
    end,
})

-- UUID ---------------------------------------------------- https://github.com/TrevorS/uuid-nvim --

local uuid = require('uuid-nvim')
vim.keymap.set('i', '<C-u>', uuid.insert_v4)
