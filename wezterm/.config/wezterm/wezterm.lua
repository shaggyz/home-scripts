-- Pull in the wezterm API
local wezterm = require 'wezterm'
local act = wezterm.action

-- This will hold the configuration.
local config = wezterm.config_builder()

-- OS detection
local is_linux <const> = wezterm.target_triple:find("linux") ~= nil
local is_darwin <const> = wezterm.target_triple:find("darwin") ~= nil

-- Disable all the default keybindings
config.disable_default_key_bindings = true

local key_mod = 'SUPER'
local key_special = 'SHIFT'

if is_linux then
    key_mod = 'ALT'
    key_special = 'CTRL'
end

-- Global keybindings:
config.keys = {
    { key = '1',     mods = key_mod,                       action = act.ActivateTab(0) },
    { key = '2',     mods = key_mod,                       action = act.ActivateTab(1) },
    { key = '3',     mods = key_mod,                       action = act.ActivateTab(2) },
    { key = '4',     mods = key_mod,                       action = act.ActivateTab(3) },
    { key = '5',     mods = key_mod,                       action = act.ActivateTab(4) },
    { key = '6',     mods = key_mod,                       action = act.ActivateTab(5) },
    { key = '7',     mods = key_mod,                       action = act.ActivateTab(6) },
    { key = '8',     mods = key_mod,                       action = act.ActivateTab(7) },
    { key = '9',     mods = key_mod,                       action = act.ActivateTab(8) },
    { key = '0',     mods = key_mod,                       action = act.ResetFontSize },
    { key = 'v',     mods = key_special .. '|' .. key_mod, action = act.SplitHorizontal { domain = 'CurrentPaneDomain' } },
    { key = 'h',     mods = key_special .. '|' .. key_mod, action = act.SplitVertical { domain = 'CurrentPaneDomain' } },
    { key = 'w',     mods = key_mod,                       action = act.CloseCurrentTab { confirm = true } },
    { key = 't',     mods = key_mod,                       action = act.SpawnTab "CurrentPaneDomain" },
    { key = '-',     mods = key_mod,                       action = act.DecreaseFontSize },
    { key = '=',     mods = key_mod,                       action = act.IncreaseFontSize },
    { key = 'q',     mods = key_mod,                       action = act.QuitApplication },
    { key = 'r',     mods = key_mod,                       action = act.ReloadConfiguration },
    { key = 'Enter', mods = 'ALT',                         action = act.ToggleFullScreen },
    { key = 'z',     mods = key_mod,                       action = act.TogglePaneZoomState },
    { key = 'l',     mods = 'SHIFT|CTRL',                  action = act.MoveTabRelative(1) },
    { key = 'h',     mods = 'SHIFT|CTRL',                  action = act.MoveTabRelative(-1) },
    { key = 'l',     mods = 'SHIFT|' .. key_mod,           action = act.ActivateTabRelative(1) },
    { key = 'h',     mods = 'SHIFT|' .. key_mod,           action = act.ActivateTabRelative(-1) },
    { key = 'l',     mods = key_mod,                       action = act.ActivatePaneDirection 'Right' },
    { key = 'h',     mods = key_mod,                       action = act.ActivatePaneDirection 'Left' },
    { key = 'k',     mods = key_mod,                       action = act.ActivatePaneDirection 'Up' },
    { key = 'j',     mods = key_mod,                       action = act.ActivatePaneDirection 'Down' },
    { key = 'f',     mods = key_mod,                       action = act.Search 'CurrentSelectionOrEmptyString' },
    { key = 'm',     mods = key_mod,                       action = act.Hide },
    { key = 'n',     mods = key_mod,                       action = act.SpawnWindow },
    { key = 't',     mods = 'SHIFT|' .. key_mod,           action = act.SendString "wezterm cli set-tab-title " },
    { key = 'v',     mods = key_mod,                       action = act.PasteFrom "Clipboard" },
    {
        key = 'c',
        mods = key_mod,
        -- A special handler to allow copying text within nvim in macOS CLI
        action = wezterm.action_callback(function(window, pane)
            if string.find(pane:get_foreground_process_name(), "vim") == nil then
                -- The rest of programs
                window:perform_action(act.CopyTo "Clipboard", pane)
            else
                -- vim, neovim, etc.
                window:perform_action(act.Multiple {
                    act.SendKey { key = ',' },
                    act.SendKey { key = 'x' },
                    act.SendKey { key = 'c' },
                }, pane)
            end
        end)
    },
    {
        key = ' ',
        mods = 'CTRL',
        -- Enable <c-space>
        action = act.SendKey {
            key = ' ',
            mods = 'CTRL',
        },
    }
}

-- Use the new tab bar
config.use_fancy_tab_bar = true

-- Tab bar settings
config.window_frame = {
    font_size = 13.5,
}

-- Debug key events
config.debug_key_events = false

-- Color scheme tests
-- config.color_scheme = 'rose-pine'
-- config.color_scheme = 'Ef-Bio'
-- config.color_scheme = 'Material Darker (base16)'
-- config.color_scheme = 'Everblush'
-- config.color_scheme = 'MaterialDesignColors'

-- Color scheme
local color_scheme = 'Railscasts (base16)'

-- Current color scheme customization
local color_definition = wezterm.color.get_builtin_schemes()[color_scheme]
color_definition.background = '#000000'

config.color_schemes = {
    [color_scheme] = color_definition
}

config.color_scheme = color_scheme

-- Color scheme modifications
config.colors = {
    selection_bg = '#464646',
    selection_fg = 'none',
}

-- Bell
config.audible_bell = "Disabled"

-- and finally, return the configuration to wezterm
return config
