local wiki = require("neowiki.wiki")
local kb = require("neowiki.knowledge_base")
local utils = require("neowiki.utils")

local M = {}

-- Expose config so callers can read/write `require("neowiki").config`
M.config = wiki.config

local function complete_wiki(arglead)
    local out = {}
    for _, name in ipairs(kb.names()) do
        if arglead == "" or name:find(arglead, 1, true) == 1 then
            table.insert(out, name)
        end
    end
    return out
end

-- Main plugin setup
function M.setup(user_config)
    user_config = user_config or {}
    -- Merge user config with the default config (shared table ref)
    for key, value in pairs(user_config) do
        wiki.config[key] = value
    end

    -- Build the knowledge-base registry (also handles backwards-compat for
    -- the legacy single `wiki_directory` config).
    if not kb.configure(wiki.config) then
        return
    end

    -- Daily TODO + markdown helper commands (diary wiki)
    vim.api.nvim_create_user_command("WikiCreateLink", wiki.create_link, {})
    vim.api.nvim_create_user_command("WikiToday", wiki.open_today, {})
    vim.api.nvim_create_user_command("WikiYesterday", wiki.open_yesterday, {})
    vim.api.nvim_create_user_command("WikiTomorrow", wiki.open_tomorrow, {})
    vim.api.nvim_create_user_command("WikiCurrentMonth", wiki.open_current_month, {})
    vim.api.nvim_create_user_command("WikiCreateIndex", wiki.create_index, {})
    vim.api.nvim_create_user_command("WikiFollowLink", wiki.follow_link, {})
    vim.api.nvim_create_user_command("WikiToggleCheckBox", wiki.toggle_checkbox, {})

    -- Named knowledge-base commands
    vim.api.nvim_create_user_command("WikiFind", function(opts)
        kb.find_files(opts.fargs[1])
    end, { nargs = "?", complete = complete_wiki })

    vim.api.nvim_create_user_command("WikiGrep", function(opts)
        kb.live_grep(opts.fargs[1])
    end, { nargs = "?", complete = complete_wiki })

    vim.api.nvim_create_user_command("WikiOpen", function(opts)
        kb.open_wiki(opts.fargs[1])
    end, { nargs = "?", complete = complete_wiki })

    vim.api.nvim_create_user_command("WikiSelect", function(opts)
        kb.select_wiki(opts.fargs[1])
    end, {
        nargs = "?",
        complete = function() return { "find_files", "live_grep", "open" } end,
    })

    -- Optional features
    if wiki.config.format_links then
        wiki.set_format_links_autocmd()
    end

    -- Follow links in markdown files
    vim.api.nvim_create_autocmd("FileType", {
        pattern = "markdown",
        callback = function()
            vim.keymap.set('n', 'gf', wiki.follow_link, { buffer = true, desc = "Follow Wiki Link" })
        end,
    })

    if wiki.config.debug then
        local diary = kb.diary_name() or "<none>"
        utils.debug("Started. Wikis: " .. table.concat(kb.names(), ", ") .. " | diary=" .. diary)
    end
end

-- Public Lua API for keymap wiring
function M.find_files(name, opts) return kb.find_files(name, opts) end
function M.live_grep(name, opts)  return kb.live_grep(name, opts) end
function M.open_wiki(name)        return kb.open_wiki(name) end
function M.select_wiki(action)    return kb.select_wiki(action) end
function M.path(name)             return kb.path(name) end
function M.list()                 return kb.list() end

return M
