local utils = require("neowiki.utils")
local pickers = require("neowiki.pickers")

local M = {}

M.registry = {}        -- name -> { path = absolute, diary = bool }
M._diary_name = nil
M._default_name = nil
M._picker_choice = "auto"

-- Build the registry from the resolved neowiki config.
-- Returns true on success, false on validation failure (setup should bail).
function M.configure(cfg)
    M.registry = {}
    M._diary_name = nil
    M._default_name = nil
    M._picker_choice = cfg.picker or "auto"

    local wikis = cfg.wikis

    -- Backwards-compat shim: synthesize a single wiki from legacy
    -- `wiki_directory` when no `wikis` table was provided.
    if type(wikis) ~= "table" or next(wikis) == nil then
        if not cfg.wiki_directory or cfg.wiki_directory == "" then
            utils.debug("no wikis configured", "error")
            return false
        end
        wikis = { default = { path = cfg.wiki_directory, diary = true } }
        cfg.default_wiki = cfg.default_wiki or "default"
    end

    for name, entry in pairs(wikis) do
        local path = type(entry) == "table" and entry.path or nil
        if type(path) ~= "string" or path == "" then
            utils.debug("wiki '" .. name .. "' missing path", "error")
            return false
        end
        local expanded = vim.fn.expand(path)
        if vim.fn.isdirectory(expanded) == 0 then
            if cfg.auto_create_wiki_directory then
                vim.fn.mkdir(expanded, "p")
            else
                utils.debug("wiki '" .. name .. "' directory missing: " .. expanded, "error")
                return false
            end
        end
        M.registry[name] = { path = expanded, diary = entry.diary == true }
    end

    -- Diary resolution: at most one wiki may be flagged as the diary base.
    local diaries = {}
    for n, e in pairs(M.registry) do
        if e.diary then table.insert(diaries, n) end
    end
    if #diaries > 1 then
        utils.debug("multiple wikis marked diary=true; only one supported", "error")
        return false
    end
    M._diary_name = diaries[1]

    -- Default wiki resolution.
    if cfg.default_wiki then
        if not M.registry[cfg.default_wiki] then
            utils.debug("default_wiki '" .. cfg.default_wiki .. "' not in wikis", "error")
            return false
        end
        M._default_name = cfg.default_wiki
    else
        M._default_name = M._diary_name
        if not M._default_name then
            -- Deterministic pick when nothing else marks a default.
            local names = M.names()
            M._default_name = names[1]
        end
    end

    return true
end

function M.names()
    local out = {}
    for name in pairs(M.registry) do table.insert(out, name) end
    table.sort(out)
    return out
end

function M.list()
    local out = {}
    for _, name in ipairs(M.names()) do
        local entry = M.registry[name]
        table.insert(out, { name = name, path = entry.path, diary = entry.diary })
    end
    return out
end

-- Resolve a (possibly nil) name to (name, entry) or nil with logged error.
local function resolve(name)
    name = name or M._default_name
    if not name then
        utils.debug("no default wiki configured", "error")
        return nil
    end
    local entry = M.registry[name]
    if not entry then
        utils.debug("wiki '" .. name .. "' not registered", "error")
        return nil
    end
    return name, entry
end

function M.path(name)
    local _, entry = resolve(name)
    return entry and entry.path or nil
end

function M.diary_name()
    return M._diary_name
end

-- Path of the diary wiki, or nil if none configured.
function M.diary_path()
    if not M._diary_name then return nil end
    return M.registry[M._diary_name].path
end

local function ensure_picker()
    local picker = pickers.resolve(M._picker_choice)
    if not picker then
        utils.debug("no picker backend available (tried " .. M._picker_choice .. ")", "error")
        return nil
    end
    return picker
end

function M.find_files(name, opts)
    local resolved_name, entry = resolve(name)
    if not entry then return end
    local picker = ensure_picker()
    if not picker then return end
    opts = opts or {}
    opts.cwd = entry.path
    opts.prompt_title = opts.prompt_title or ("Wiki: " .. resolved_name)
    picker.find_files(opts)
end

function M.live_grep(name, opts)
    local resolved_name, entry = resolve(name)
    if not entry then return end
    local picker = ensure_picker()
    if not picker then return end
    opts = opts or {}
    opts.cwd = entry.path
    opts.prompt_title = opts.prompt_title or ("Grep: " .. resolved_name)
    picker.live_grep(opts)
end

function M.open_wiki(name)
    local _, entry = resolve(name)
    if not entry then return end
    vim.cmd("edit " .. vim.fn.fnameescape(entry.path))
end

-- action: "find_files" (default) | "live_grep" | "open"
function M.select_wiki(action)
    action = action or "find_files"
    local items = M.list()
    if #items == 0 then
        utils.debug("no wikis registered", "warning")
        return
    end
    vim.ui.select(items, {
        prompt = "Select wiki",
        format_item = function(item)
            return item.diary and (item.name .. " [diary]") or item.name
        end,
    }, function(choice)
        if not choice then return end
        if action == "find_files" then
            M.find_files(choice.name)
        elseif action == "live_grep" then
            M.live_grep(choice.name)
        elseif action == "open" then
            M.open_wiki(choice.name)
        else
            utils.debug("unknown select action: " .. tostring(action), "error")
        end
    end)
end

return M
