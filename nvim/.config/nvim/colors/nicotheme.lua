-- File: ~/.config/nvim/colors/nicotheme.lua
--
-- A minimal, from-scratch Neovim theme.
-- The goal is to provide a clean base for you to build upon.
--
-- Installation:
-- 1. Create the directory if it doesn't exist: mkdir -p ~/.config/nvim/colors
-- 2. Place this file there.
-- 3. Add the following to your init.lua: vim.cmd("colorscheme my-minimal-theme")

-- It's good practice to clear existing highlights when the theme loads.
if vim.fn.exists("syntax_on") then
    vim.cmd("syntax reset")
end

-- Set the name of the colorscheme.
vim.g.colors_name = "nicotheme"

-- Helper function to set a highlight group.
-- This makes the code cleaner.
local function s(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
end

-- 1. DEFINE YOUR COLOR PALETTE
-- ============================
-- Add all your colors here. Using descriptive names makes it easy to
-- manage and update your theme.
local colors = {
    bg = '#FFFFFF',         -- A clean white background
    fg = '#000000',         -- A simple black foreground
    grey = '#888888',       -- A grey for comments and less important text
    light_grey = '#EEEEEE', -- A light grey for UI elements like the cursor line
    red = '#FF0000',        -- A bright red for errors
    --
    -- TODO: Add your own colors here as you build your theme!
    -- For example:
    -- blue = '#0000FF',
    -- green = '#00FF00',
    -- yellow = '#FFFF00',
    -- orange = '#FFA500',
    -- purple = '#800080',
}

-- 2. APPLY HIGHLIGHTS
-- ===================
-- This is where you map highlight groups to the colors in your palette.
-- To find the name of the highlight group under your cursor, you can use
-- the command: :echo synIDattr(synID(line("."), col("."), 1), "name")

-- ### Editor UI Elements ###
s('Normal', { fg = colors.fg, bg = colors.bg })            -- Default text
s('LineNr', { fg = colors.grey, bg = colors.bg })          -- Line numbers
s('SignColumn', { bg = colors.bg })                        -- Gutter for git signs, etc.
s('CursorLine', { bg = colors.light_grey })                -- Highlight for the current line
s('CursorLineNr', { fg = colors.fg, bold = true })         -- Number on the current line
s('Visual', { bg = '#C0C0C0' })                            -- Visual selection
s('Search', { bg = '#FFFF00', fg = colors.fg })            -- Search results
s('Pmenu', { fg = colors.fg, bg = colors.light_grey })     -- Popup menu
s('PmenuSel', { bg = colors.fg, fg = colors.bg })          -- Popup menu selected item
s('TabLine', { fg = colors.grey, bg = colors.light_grey }) -- Tab bar (inactive tabs)
s('TabLineSel', { fg = colors.fg, bg = colors.bg })        -- Tab bar (active tab)
s('TabLineFill', { bg = colors.light_grey })               -- Tab bar unused space

-- ### Basic Syntax ###
-- Start by defining the most common groups.
s('Comment', { fg = colors.grey, italic = true }) -- Comments
s('Error', { fg = colors.red, bold = true })      -- Errors
s('Todo', { fg = colors.fg, bold = true })        -- TODO, FIXME, etc.

-- ### Syntax Groups to Customize ###
-- Most syntax groups below will default to 'Normal' (black text).
-- To color them, uncomment them and assign colors from your palette.
-- Example: To make functions blue, add a 'blue' color to the palette and then use:
-- s('Function', { fg = colors.blue })

-- s('Constant', {})
-- s('String', {})
-- s('Character', {})
-- s('Number', {})
-- s('Boolean', {})
-- s('Float', {})

-- s('Identifier', {})
-- s('Function', {})

-- s('Statement', {})
-- s('Conditional', {})
-- s('Repeat', {})
-- s('Label', {})
-- s('Operator', {})
-- s('Keyword', {})
-- s('Exception', {})

-- s('PreProc', {})
-- s('Include', {})
-- s('Define', {})
-- s('Macro', {})
-- s('PreCondit', {})

-- s('Type', {})
-- s('StorageClass', {})
-- s('Structure', {})
-- s('Typedef', {})

-- s('Special', {})
-- s('SpecialChar', {})
-- s('Tag', {})
-- s('Delimiter', {})
-- s('SpecialComment', {})
-- s('Debug', {})
