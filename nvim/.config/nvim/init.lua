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


-- Force markdown code blocks to have a specific background color
vim.api.nvim_set_hl(0, "RenderMarkdownCode", { bg = "#1c1c1c", force = true })
vim.api.nvim_set_hl(0, "RenderMarkdownCodeInline", { bg = "#1c1c1c", force = true })
-- This handles the background of the 'language' name tag (e.g., "python")
-- vim.api.nvim_set_hl(0, "RenderMarkdownInfo", { bg = "#1c1c1c", fg = "#5eacd3", force = true })
