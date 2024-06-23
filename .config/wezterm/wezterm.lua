-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- Key mappings, for linux
config.keys = {
    {
        key = 'C',
        mods = 'SUPER',
        action = wezterm.action.CopyTo 'ClipboardAndPrimarySelection',
    },
}

-- Color scheme
config.color_scheme = 'rose-pine'

-- Color scheme modifications
config.colors = {
    selection_bg = '#182e1e',
}

-- and finally, return the configuration to wezterm
return config
