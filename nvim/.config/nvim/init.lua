----------------------------------------------------------------------------------------------------
-- Nico's neovim configuration for Linux and macOS
----------------------------------------------------------------------------------------------------
-- The following configuration files are part of the configuration too:
----------------------------------------------------------------------------------------------------

-- ~/.config/nvim/lua/plugins.lua - Plugin installation
require 'plugins'

-- ~/.config/nvim/lua/editor.lua - Editor settings
require 'editor'

-- ~/.config/nvim/lua/plugconfig.lua - Plugin configuration
require 'plugconfig'

-- ~/.config/nvim/lua/dap.lua - Python debugger
-- require 'dap'

-- ~/.config/nvim/lua/neovide.lua - Neovide specific configuration
if vim.g.neovide then require 'neovide' end

-- ~/.config/nvim/lua/keybindings.lua - Custom keybindings
require 'keybindings'

-- Syntax color configurations

-- ~/.config/nvim/lua/syntax/rosepine.lua
-- require 'syntax.rosepine'

-- ~/.config/nvim/lua/syntax/retrobox.lua
-- require 'syntax.retrobox'

-- ~/.config/nvim/lua/syntax/roselight.lua
-- require 'syntax.roselight'

-- ~/.config/nvim/lua/syntax/gruvboxlight.lua
-- require 'syntax.gruvboxlight'

-- ~/.config/nvim/lua/syntax/edge.lua
require 'syntax.edge'

-- ~/.config/nvim/lua/syntax/edgelight.lua
-- require 'syntax.edgelight'

-- ~/.config/nvim/lua/syntax/nightfox.lua
-- require 'syntax.nightfox'

-- --------------------- Markdown settings ----------------------

vim.api.nvim_create_autocmd("FileType", {
    pattern = "markdown",
	callback = function()
        -- Start treesitter for markdown files (some quirks with neovim 0.11)
        vim.treesitter.start()
        -- Force markdown code blocks to have a specific background color
        vim.api.nvim_set_hl(0, "RenderMarkdownCode", { bg = "#1c1c1c", force = true })
        vim.api.nvim_set_hl(0, "RenderMarkdownCodeInline", { bg = "#1c1c1c", force = true })
        -- Force markdown headers to use these colours
        -- backgrounds
        vim.api.nvim_set_hl(0, "RenderMarkdownH1Bg", { bg = "#1e1e1e", force = true, underline = true, sp = "#3b3b3b" })
        vim.api.nvim_set_hl(0, "RenderMarkdownH2Bg", { bg = "#1e1e1e", force = true, underline = true, sp = "#3b3b3b" })
        vim.api.nvim_set_hl(0, "RenderMarkdownH3Bg", { bg = "#1e1e1e", force = true, underline = true, sp = "#3b3b3b" })
        vim.api.nvim_set_hl(0, "RenderMarkdownH4Bg", { bg = "#1e1e1e", force = true, underline = true, sp = "#3b3b3b" })
        vim.api.nvim_set_hl(0, "RenderMarkdownH5Bg", { bg = "#1e1e1e", force = true, underline = true, sp = "#3b3b3b" })
        vim.api.nvim_set_hl(0, "RenderMarkdownH6Bg", { bg = "#1e1e1e", force = true, underline = true, sp = "#3b3b3b" })
        -- texts
        vim.api.nvim_set_hl(0, "@markup.heading.1.markdown", { fg = "#9ec67e", force = true, bold = true })
        vim.api.nvim_set_hl(0, "@markup.heading.2.markdown", { fg = "#6cb6eb", force = true, bold = true })
        vim.api.nvim_set_hl(0, "@markup.heading.3.markdown", { fg = "#ec7279", force = true, bold = true })
        vim.api.nvim_set_hl(0, "@markup.heading.4.markdown", { fg = "#deb974", force = true, bold = true })
        vim.api.nvim_set_hl(0, "@markup.heading.5.markdown", { fg = "#885a9b", force = true, bold = true })
        vim.api.nvim_set_hl(0, "@markup.heading.6.markdown", { fg = "#ad3861", force = true, bold = true })
    end,
})
