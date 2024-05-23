--------------------------------------------------------------------------------
-- Nico's neovim configuration for Linux and macOS
--------------------------------------------------------------------------------
-- The following configuration files are part of the configuration too:
--------------------------------------------------------------------------------

-- ~/.config/nvim/lua/plugins.lua - Plugin installation
require 'plugins'

-- ~/.config/nvim/lua/editor.lua - Editor settings
require 'editor'

-- ~/.config/nvim/lua/plugconfig.lua - Plugin configuration
require 'plugconfig'

-- ~/.config/nvim/lua/neovide.lua - Neovide specific configuration
if vim.g.neovide then require 'neovide' end

-- ~/.config/nvim/lua/keybindings.lua - Custom keybindings
require 'keybindings'

-- ~/.config/nvim/lua/syntax.lua - Custom syntax modifications
require 'syntax'

