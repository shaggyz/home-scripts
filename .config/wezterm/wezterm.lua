-- Pull in the wezterm API
local wezterm = require 'wezterm'
local act = wezterm.action

-- This will hold the configuration.
local config = wezterm.config_builder()

-- Disable all the default keybindings
config.disable_default_key_bindings = true

-- Key mappings, only for macOS ATM
config.keys = {
    { key = '1', mods = 'SUPER', action = act.ActivateTab(0) },
    { key = '2', mods = 'SUPER', action = act.ActivateTab(1) },
    { key = '3', mods = 'SUPER', action = act.ActivateTab(2) },
    { key = '4', mods = 'SUPER', action = act.ActivateTab(3) },
    { key = '5', mods = 'SUPER', action = act.ActivateTab(4) },
    { key = '6', mods = 'SUPER', action = act.ActivateTab(5) },
    { key = '7', mods = 'SUPER', action = act.ActivateTab(6) },
    { key = '8', mods = 'SUPER', action = act.ActivateTab(7) },
    { key = '9', mods = 'SUPER', action = act.ActivateTab(8) },
    { key = '0', mods = 'SUPER', action = act.ResetFontSize },
    { key = 'v', mods = 'SHIFT|SUPER', action = act.SplitHorizontal { domain =  'CurrentPaneDomain' } },
    { key = 'h', mods = 'SHIFT|SUPER', action = act.SplitVertical { domain =  'CurrentPaneDomain' } },
    { key = 'w', mods = 'SUPER', action = act.CloseCurrentTab {confirm=true} },
    { key = 't', mods = 'SUPER', action = act.SpawnTab "CurrentPaneDomain" },
    { key = '-', mods = 'SUPER', action = act.DecreaseFontSize },
    { key = '=', mods = 'SUPER', action = act.IncreaseFontSize },
    { key = 'q', mods = 'SUPER', action = act.QuitApplication },
    { key = 'r', mods = 'SUPER', action = act.ReloadConfiguration },
    { key = 'Enter', mods = 'ALT', action = act.ToggleFullScreen },
    { key = 'z', mods = 'SUPER', action = act.TogglePaneZoomState },
    { key = 'l', mods = 'SHIFT|CTRL', action = act.MoveTabRelative(1) },
    { key = 'h', mods = 'SHIFT|CTRL', action = act.MoveTabRelative(-1) },
    { key = 'l', mods = 'SHIFT|SUPER', action = act.ActivateTabRelative(1) },
    { key = 'h', mods = 'SHIFT|SUPER', action = act.ActivateTabRelative(-1) },
    { key = 'l', mods = 'SUPER', action = act.ActivatePaneDirection 'Right' },
    { key = 'h', mods = 'SUPER', action = act.ActivatePaneDirection 'Left' },
    { key = 'k', mods = 'SUPER', action = act.ActivatePaneDirection 'Up' },
    { key = 'j', mods = 'SUPER', action = act.ActivatePaneDirection 'Down' },
    { key = 'f', mods = 'SUPER', action = act.Search 'CurrentSelectionOrEmptyString' },
    { key = 'm', mods = 'SUPER', action = act.Hide },
    { key = 'n', mods = 'SUPER', action = act.SpawnWindow },
    { key = 't', mods = 'SHIFT|SUPER', action = act.SendString "wezterm cli set-tab-title " },
    { key = 'v', mods = 'SUPER', action = act.PasteFrom "Clipboard" },
    {
        key = 'c',
        mods = 'SUPER',
        -- A special handler to allow copying text within nvim in macOS CLI
        action = wezterm.action_callback(function(window, pane)
            if string.find(pane:get_foreground_process_name(), "vim") == nil then
                -- The rest of programs
                window:perform_action(act.CopyTo "Clipboard", pane)
            else
                -- vim, neovim, etc.
                window:perform_action(act.Multiple {
                    act.SendKey{ key=',' },
                    act.SendKey{ key='x' },
                    act.SendKey{ key='c' },
                }, pane)
            end
        end)
    }
}

-- Debug key events
config.debug_key_events = false

-- Color scheme
config.color_scheme = 'rose-pine'

-- Color scheme modifications
config.colors = {
    selection_bg = '#182e1e',
}

-- Bell
config.audible_bell = "Disabled"

-- and finally, return the configuration to wezterm
return config
