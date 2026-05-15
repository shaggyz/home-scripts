-- Thin shims over external picker plugins. No hard dependency on any of them:
-- each adapter pcalls its require and returns nil if the plugin is missing.

local M = {}

-- opts shape across all backends: { cwd = string, prompt_title = string }

local function adapter_telescope()
    local ok, builtin = pcall(require, "telescope.builtin")
    if not ok then return nil end
    return {
        name = "telescope",
        find_files = function(opts)
            builtin.find_files({
                cwd = opts.cwd,
                prompt_title = opts.prompt_title,
                no_ignore_parent = true,
            })
        end,
        live_grep = function(opts)
            builtin.live_grep({
                cwd = opts.cwd,
                prompt_title = opts.prompt_title,
            })
        end,
    }
end

local function adapter_fzf_lua()
    local ok, fzf = pcall(require, "fzf-lua")
    if not ok then return nil end
    return {
        name = "fzf-lua",
        find_files = function(opts)
            fzf.files({ cwd = opts.cwd, prompt = opts.prompt_title and (opts.prompt_title .. "> ") or nil })
        end,
        live_grep = function(opts)
            fzf.live_grep({ cwd = opts.cwd, prompt = opts.prompt_title and (opts.prompt_title .. "> ") or nil })
        end,
    }
end

local function adapter_snacks()
    local ok, snacks = pcall(require, "snacks")
    if not ok or not snacks.picker then return nil end
    return {
        name = "snacks",
        find_files = function(opts) snacks.picker.files({ cwd = opts.cwd, title = opts.prompt_title }) end,
        live_grep = function(opts) snacks.picker.grep({ cwd = opts.cwd, title = opts.prompt_title }) end,
    }
end

local function adapter_mini()
    local ok, pick = pcall(require, "mini.pick")
    if not ok then return nil end
    return {
        name = "mini.pick",
        find_files = function(opts)
            pick.builtin.files(nil, { source = { cwd = opts.cwd, name = opts.prompt_title } })
        end,
        live_grep = function(opts)
            pick.builtin.grep_live(nil, { source = { cwd = opts.cwd, name = opts.prompt_title } })
        end,
    }
end

local function adapter_vim_ui()
    return {
        name = "vim_ui",
        find_files = function(opts)
            local files = vim.fs.find(function(name) return name:match("%.md$") ~= nil end, {
                limit = math.huge,
                type = "file",
                path = opts.cwd,
            })
            if #files == 0 then
                vim.notify("NeoWiki: no .md files in " .. opts.cwd, vim.log.levels.WARN)
                return
            end
            vim.ui.select(files, { prompt = opts.prompt_title or "Files" }, function(choice)
                if choice then vim.cmd("edit " .. vim.fn.fnameescape(choice)) end
            end)
        end,
        live_grep = function(opts)
            local pattern = vim.fn.input("Grep " .. (opts.prompt_title or "") .. ": ")
            if pattern == "" then return end
            local escaped = vim.fn.escape(pattern, "/\\")
            vim.cmd(string.format("silent! vimgrep /%s/gj %s/**/*.md", escaped, opts.cwd))
            vim.cmd("copen")
        end,
    }
end

local FACTORY = {
    telescope = adapter_telescope,
    ["fzf-lua"] = adapter_fzf_lua,
    fzf_lua = adapter_fzf_lua,
    snacks = adapter_snacks,
    mini = adapter_mini,
    vim_ui = adapter_vim_ui,
}

local PRIORITY = { "telescope", "fzf_lua", "snacks", "mini", "vim_ui" }

local cache = {}

-- Returns adapter table or nil. Pass "auto" (default) to walk PRIORITY.
function M.resolve(name)
    name = name or "auto"
    if cache[name] ~= nil then
        return cache[name] or nil
    end
    local adapter
    if name == "auto" then
        for _, key in ipairs(PRIORITY) do
            adapter = FACTORY[key]()
            if adapter then break end
        end
    else
        local factory = FACTORY[name]
        adapter = factory and factory() or nil
    end
    cache[name] = adapter or false
    return adapter
end

-- Test seam: clears the resolver cache.
function M._reset()
    cache = {}
end

return M
