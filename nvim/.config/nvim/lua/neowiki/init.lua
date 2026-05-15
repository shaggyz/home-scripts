local wiki = require("neowiki.wiki")
local utils = require("neowiki.utils")

local M = {}

-- Expose config so callers can read/write `require("neowiki").config`
M.config = wiki.config

-- Main plugin setup
function M.setup(user_config)
    user_config = user_config or {}
    -- Merge user config with the default config
    for key, value in pairs(user_config) do
        wiki.config[key] = value
    end
    M.config = wiki.config

    -- Check if the needed directories are there
    if vim.fn.isdirectory(wiki.config.wiki_directory) == 0 then
        if wiki.config.auto_create_wiki_directory == true then
            local wiki_path = vim.fn.expand(wiki.config.wiki_directory)
            vim.fn.mkdir(wiki_path, "p")
        else
            utils.debug("Not enabled, missing wiki directory: " .. wiki.config.wiki_directory, "error")
            return
        end
    end

    -- Export the plugin functions as NeoVim commands
    vim.api.nvim_create_user_command("WikiCreateLink", wiki.create_link, {})
    vim.api.nvim_create_user_command("WikiToday", wiki.open_today, {})
    vim.api.nvim_create_user_command("WikiYesterday", wiki.open_yesterday, {})
    vim.api.nvim_create_user_command("WikiTomorrow", wiki.open_tomorrow, {})
    vim.api.nvim_create_user_command("WikiCurrentMonth", wiki.open_current_month, {})
    vim.api.nvim_create_user_command("WikiCreateIndex", wiki.create_index, {})
    vim.api.nvim_create_user_command("WikiFollowLink", wiki.follow_link, {})
    vim.api.nvim_create_user_command("WikiToggleCheckBox", wiki.toggle_checkbox, {})

    -- Optional features
    -- Format links and URLs
    if wiki.config.format_links then
        wiki.set_format_links_autocmd()
    end

    -- Follow links in markdown files
    vim.api.nvim_create_autocmd("FileType", {
        pattern = "markdown",
        callback = function()
            vim.keymap.set('n', 'gf', wiki.follow_link, { buffer = true, desc = "Follow Wiki Link" })
        end
    })

    if wiki.config.debug then
        utils.debug("Started: " .. wiki.config.wiki_directory)
    end
end

return M
