-- Pull in the wezterm API
local wezterm = require 'wezterm'
local act = wezterm.action
local mux = wezterm.mux

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

-- ------------- Workspaces settings ---------------

-- Function to build the 'Work' workspace
local function create_work_workspace(window, pane)
    local workspace_name = 'work'

    -- If it already exists, just switch to it
    local active_workspaces = wezterm.mux.get_workspace_names()
    for _, name in ipairs(active_workspaces) do
        if name == workspace_name then
            window:perform_action(wezterm.action.SwitchToWorkspace { name = workspace_name }, pane)
            return
        end
    end

    -- Otherwise, create the layout
    -- Tab 1: LDD
    local ldd_dir = wezterm.home_dir .. '/Development/direct-data/link-direct-data'
    local tab, ldd_pane, new_window = mux.spawn_window { workspace = workspace_name, cwd = ldd_dir }
    tab:set_title('📦 LDD')
    ldd_pane:split { direction = 'Right', size = 0.5, cwd = ldd_dir }

    -- Tab 2: DocID
    local docid_dir = wezterm.home_dir .. '/Development/docid/veeva-docid-api'
    local tab2, docid_pane, _ = new_window:spawn_tab { cwd = docid_dir }
    tab2:set_title('🪪 DocID')
    docid_pane:split { direction = 'Right', size = 0.5, cwd = docid_dir }

    -- Tab 3: AWS
    local aws_dir = wezterm.home_dir .. '/Development/link/deploycfg'
    local tab3, aws_pane, _ = new_window:spawn_tab { cwd = aws_dir }
    tab3:set_title('📟 AWS')
    aws_pane:split { direction = 'Right', size = 0.5, cwd = aws_dir }

    -- Tab 4: data
    local data_dir = wezterm.home_dir .. '/Data'
    local tab4, data_pane, _ = new_window:spawn_tab { cwd = data_dir }
    tab4:set_title('📋 data')
    data_pane:split { direction = 'Right', size = 0.5, cwd = data_dir }

    -- Tab 5: osiris
    local tab5, osiris_pane, _ = new_window:spawn_tab { cwd = wezterm.home_dir }
    tab5:set_title('🧿 osiris')
    osiris_pane:split { direction = 'Right', size = 0.5, cwd = wezterm.home_dir }

    -- Tab 6: onyx
    local onyx_dir = wezterm.home_dir .. '/Development/side/onyx'
    local tab6, onyx_pane, _ = new_window:spawn_tab { cwd = onyx_dir }
    tab6:set_title('🖲️ onyx')
    onyx_pane:split { direction = 'Right', size = 0.5, cwd = onyx_dir }
    -- Focus back on the first tab
    tab:activate()
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
    { key = 'c',     mods = key_special .. '|' .. key_mod, action = act.SplitVertical { domain = 'CurrentPaneDomain' } },
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
    { key = 'w',     mods = 'SHIFT|' .. key_mod,           action = wezterm.action_callback(create_work_workspace) },
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

-- Font
config.font = wezterm.font_with_fallback {
    {
        -- install: brew install font-0xproto-nerd-font
        family = '0xProto',
        -- harfbuzz_features = { 'ss01' }
    },
    'JetBrains Mono'
}
config.font_size = 12.5
-- line height
config.line_height = .9
-- horizontal space
config.cell_width = 1.0

-- Use the new tab bar
config.use_fancy_tab_bar = true

-- Tab bar settings

config.window_frame = {
    font_size = (is_darwin and 13.5 or 12),
}

-- Debug key events
config.debug_key_events = false

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

-- Display workspace name in the window bar
wezterm.on('update-right-status', function(window, _)
    window:set_right_status(wezterm.format {
        { Text = 'Workspace: ' .. window:active_workspace() .. '  ' },
    })
end)


-- and finally, return the configuration to wezterm
return config
