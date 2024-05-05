-------------------------------------------------------------------------------
-- ❇ Neovide specific configuration
-------------------------------------------------------------------------------

if jit and jit.os == "Linux" then
    -- Linux
    -- Copy/Paste keybindings
    vim.keymap.set('n', '<A-C-v>', '"+P')             -- Paste normal mode
    vim.keymap.set('v', '<A-C-v>', '"+P')             -- Paste visual mode
    vim.keymap.set('t', '<A-C-v>', '<C-\\><C-n>"+PA') -- Paste terminal mode
    vim.keymap.set('i', '<A-C-v>', '<C-o>h"+P')       -- Paste insert mode
    vim.keymap.set('c', '<A-C-v>', '<C-R>+')          -- Paste command mode
    vim.keymap.set('v', '<A-C-c>', '"+y')             -- Copy
    -- Font
    -- https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/JetBrainsMono.zip
    vim.o.guifont = "JetBrainsMonoNL Nerd Font:h11.5"
else
    -- macOS
    -- Copy/Paste keybindings
    vim.keymap.set('v', '<D-c>', '"+y')             -- Copy
    vim.keymap.set('n', '<D-v>', '"+P')             -- Paste normal mode
    vim.keymap.set('v', '<D-v>', '"+P')             -- Paste visual mode
    vim.keymap.set('t', '<D-v>', '<C-\\><C-n>"+PA') -- Paste terminal mode
    vim.keymap.set('c', '<D-v>', '<C-R>+')          -- Paste command mode
    vim.keymap.set('i', '<D-v>', '<C-o>"+P')        -- Paste insert mode
    -- Font
    vim.o.guifont = "JetBrainsMonoNL Nerd Font:h12.5"
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
