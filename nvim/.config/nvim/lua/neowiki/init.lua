local neowiki = {}

-- Utility functions


-- Creates a slug for the given text
local function slugify(text)
    return text:lower()
        :gsub("%s+", "-")           -- Replace spaces with dashes
        :gsub("[^%w%-]", "")        -- Strip everything that isn't alphanumeric or a dash
        :gsub("%-+", "-")           -- Collapse multiple dashes (e.g., "A & B" -> "a--b" -> "a-b")
        :gsub("^%-", "")            -- Strip leading dash
        :gsub("%-$", "")            -- Strip trailing dash
end

-- Check if a table contains the given regex value
local function table_has_regex_value(table, target_regex)
    for _, value in ipairs(table) do
        if string.match(value, target_regex) then
            return true
        end
    end
    return false
end

-- Prints a debug message
local function debug(message, level, context)
    level = level or "debug"
    print("NeoWiki [" .. string.upper(level) .. "]: " .. message)
    if context ~= nil then
        print("--------- Context ---------")
        print(vim.inspect(context))
        print("---------------------------")
    end
end

-- Default configuration
neowiki.config = {
    -- Enable debug flag
    debug = false,
    -- Main directory to store the wiki/markdown files
    wiki_directory = "~/Notes",
    -- Auto-create the main wiki directory if it's missing
    auto_create_wiki_directory = true,
    -- Reuse the previous day contents as template in the new created daily entries
    reuse_previous_day = true,
    -- Format URL and links
    format_links = true,
    -- URL and links color (only applicable if format_links=true)
    links_color = "#6cb6eb",
}

-- Construct the full path to the file
local function get_date_file_path(year, month, date)
    local wiki_path = vim.fn.expand(neowiki.config.wiki_directory)
    return string.format("%s/%s/%s/%s.md", wiki_path, year, month, date)
end

-- Construct the full path to the directory
local function get_date_dir_path(year, month)
    local wiki_path = vim.fn.expand(neowiki.config.wiki_directory)
    return string.format("%s/%s/%s", wiki_path, year, month)
end

-- Returns the date, month and year values for yesterday
local function get_yesterday_date()
    local timestamp = os.time() - 24 * 60 * 60
    local date = os.date("%Y-%m-%d", timestamp)
    local month = os.date("%m", timestamp)
    local year = os.date("%Y", timestamp)
    return date, month, year
end

-- Returns the date, month and year values for yesterday
local function get_tomorrow_date()
    local timestamp = os.time() + 24 * 60 * 60
    local date = os.date("%Y-%m-%d", timestamp)
    local month = os.date("%m", timestamp)
    local year = os.date("%Y", timestamp)
    return date, month, year
end

-- Returns the relative date
-- TODO: use this instead of get_tomorrow_date and get_yesterday_date
local function get_relative_date(days)
    local timestamp = os.time() + (days * 86400) -- 86400 seconds in a day
    return os.date("%Y-%m-%d", timestamp), os.date("%m", timestamp), os.date("%Y", timestamp)
end

-- Returns the default template contents
local function get_default_template(date)
    return string.format("# TODO %s\n\n- [ ] Task", date)
end

-- local function reuse_yesterday_template(current_date)
local function reuse_yesterday_template(current_date)
    local yd_date, month, year = get_yesterday_date()
    local yd_path = get_date_file_path(year, month, yd_date)

    local lines = {}
    local f = io.open(yd_path, "r")
    if f then
        for line in f:lines() do
            -- Optional: only bring over lines that are unfinished tasks
            if line:match("%- %[ %]") or line:match("^#") then
                table.insert(lines, line)
            end
        end
        f:close()
    end

    if #lines > 0 then
        return table.concat(lines, "\n")
    else
        return get_default_template(current_date)
    end
end

-- Creates and opens the daily TODO file
local function get_or_create_daily_todo_file(date, month, year)
    local vim = vim

    -- Construct the full path to the file
    local full_path = get_date_file_path(year, month, date)

    -- Check and create the directory structure if it doesn't exist
    local dir_path = get_date_dir_path(year, month)
    if vim.fn.isdirectory(dir_path) == 0 then
        vim.fn.mkdir(dir_path, "p")
    end

    -- Check if the file exists before opening
    if vim.fn.filereadable(full_path) == 0 then
        local expanded_path = vim.fn.expand(full_path)
        local file = io.open(expanded_path, "w")

        if file == nil then
            debug("The file " .. full_path .. " cannot be created", "error")
            return
        end

        local template = ""
        if neowiki.config.reuse_previous_day then
            template = reuse_yesterday_template(date)
        else
            template = get_default_template(date)
        end

        file:write(template)
        file:close()
    end

    -- Open the file in a new buffer
    vim.cmd('edit ' .. full_path)
end

-- Creates and opens the daily TODO file for today
function neowiki.open_today()
    local date = os.date("%Y-%m-%d")
    local month = os.date("%m")
    local year = os.date("%Y")
    get_or_create_daily_todo_file(date, month, year)
end

-- Creates and opens the daily TODO file for yesterday
function neowiki.open_yesterday()
    local date, month, year = get_yesterday_date()
    get_or_create_daily_todo_file(date, month, year)
end

-- Creates and opens the daily TODO file for tomorrow
function neowiki.open_tomorrow()
    local date, month, year = get_tomorrow_date()
    get_or_create_daily_todo_file(date, month, year)
end

-- Converts the highlighted text or the word under the cursor into a Markdown link
function neowiki.create_link()
    -- This should not be always executed
    if vim.bo.readonly or vim.bo.filetype ~= "markdown" then
        return
    end

    local start_text
    local end_text
    local current_line = vim.fn.getline('.')
    local cursor_position = vim.fn.getpos(".")
    local current_line_number = cursor_position[2]

    if vim.fn.mode() == 'v' then
        -- Visual highlighted text
        local visual_position = vim.fn.getpos("v")
        -- Do not allow multi-line links
        start_text = visual_position[3]
        end_text = cursor_position[3]
    else
        -- Use the word under the cursor as the link text if no visual selection
        local word = vim.fn.expand('<cword>')
        start_text, end_text = current_line:find(vim.pesc(word), 1, true)
    end

    -- Ugly swap for reversed visual selections
    if start_text > end_text then
        local swap = end_text
        end_text = start_text
        start_text = swap
    end

    if start_text == nil then
        return
    end

    local prefix = current_line:sub(0, start_text - 1)
    local title = current_line:sub(start_text, end_text)
    local sufix = current_line:sub(end_text + 1)

    -- Read clipboard, if we have a URL we can just add it as target.
    local clipboard = vim.fn.getreg('+')
    local url = ""
    if clipboard:match("^https?://") then
        url = clipboard
    end

    local new_line = string.format("%s[%s]()%s", prefix, title, sufix)


    -- Update the line contents
    vim.fn.setline(current_line_number, new_line)

    -- Cursor is placed between the parenthesis (computing the added symbols: []()  == 4)
    vim.fn.cursor(current_line_number, #prefix + #title + 4)

    -- Go back to normal mode
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<ESC>", true, false, true), 'n', false)
end

-- Generates a Table of Contents based on headers
function neowiki.create_index()
    local bufnr = 0 -- Current buffer
    local parser = vim.treesitter.get_parser(bufnr, "markdown")
    local tree = parser:parse()[1]
    local root = tree:root()

    -- This query finds all heading nodes
    local query = vim.treesitter.query.parse("markdown", [[
        (atx_heading (atx_h1_marker) (inline) @cap)
        (atx_heading (atx_h2_marker) (inline) @cap)
        (atx_heading (atx_h3_marker) (inline) @cap)
        (atx_heading (atx_h4_marker) (inline) @cap)
        (atx_heading (atx_h5_marker) (inline) @cap)
        (atx_heading (atx_h6_marker) (inline) @cap)
    ]])

    -- Initial table with title and a single blank line
    local index_lines = { "# Index", "" }

    for id, node in query:iter_captures(root, bufnr) do
        local text = vim.treesitter.get_node_text(node, bufnr)
        local slug = slugify(text)

        -- Extract level from the parent node's first child (the marker, e.g., atx_h1_marker)
        local parent = node:parent()
        local level = 1
        if parent then
            local marker_type = parent:child(0):type()
            local level_str = marker_type:match("atx_h(%d)_marker")
            level = tonumber(level_str) or 1
        end

        local indent = string.rep("  ", level - 1)
        table.insert(index_lines, string.format("%s- [%s](#%s)", indent, text, slug))
    end

    if #index_lines > 2 then
        -- Add two blank lines at the end of the index for spacing
        table.insert(index_lines, "")
        table.insert(index_lines, "")

        -- Insert at the top of the buffer
        vim.api.nvim_buf_set_lines(bufnr, 0, 0, false, index_lines)
        debug("Index created with " .. (#index_lines - 4) .. " headers") -- Adjusted debug count
    else
        debug("No headers found to create index", "warning")
    end
end

function neowiki.go_to_header(header_slug)
    -- Clean the incoming target (remove '#' if present)
    local target = slugify(header_slug)
    local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)

    for i, line in ipairs(lines) do
        -- Only look at lines starting with #
        if line:match("^#+") then
            -- Extract just the text part of the header
            local header_text = line:gsub("^#+%s*", "")
            if slugify(header_text) == target then
                -- Move cursor to line (i is 1-indexed, cursor needs 1-indexed)
                vim.api.nvim_win_set_cursor(0, { i, 0 })
                -- Center the screen
                vim.cmd("normal! zz")
                return true
            end
        end
    end
    debug("Anchor not found: " .. target, "warning")
    return false
end

-- Opens a markdown internal_section/external/local_file link
local function open_link(target)
    if target:match("^#") then
        -- Internal section link (e.g., #my-header)
        neowiki.go_to_header(target)
    elseif target:match("^http") then
        -- External link - Mac 'open' command
        vim.fn.jobstart({ "open", target })
    elseif target:match("%.md$") then
        -- Local Markdown file
        -- We use 'p' to expand to full path relative to current file
        local file_path = vim.fn.expand("%:p:h") .. "/" .. target
        vim.cmd('edit ' .. vim.fn.fnameescape(file_path))
    else
        debug("Unknown link type: " .. target, "error")
    end
end

-- Follows an external/internal-markdown link
function neowiki.follow_link()
    -- Get the line and find what's under the cursor
    local line = vim.api.nvim_get_current_line()
    local col = vim.api.nvim_win_get_cursor(0)[2] + 1 -- Lua is 1-indexed

    -- Search for [text](target) patterns in the current line
    for label, target in line:gmatch("%[([^%]]+)%]%(([^%)]+)%)") do
        -- Find the start and end positions of this specific link in the line
        -- This ensures we only follow the link the cursor is actually ON
        local pattern = vim.pesc("[" .. label .. "](" .. target .. ")")
        local s, e = line:find(pattern)

        if s and col >= s and col <= e then
            open_link(target)
            return
        end
    end
    debug("No link found under cursor", "info")
end

function neowiki.handle_markdown_list()
    local line = vim.api.nvim_get_current_line()
    local cursor_pos = vim.api.nvim_win_get_cursor(0)[2] -- Cursor column position
    local insert_text = ""

    -- Check if the line is a list item and prepare continuation
    if line:sub(1, cursor_pos + 1):match("^%s*-%s+[[][%sxX]?[]]%s+") then
        -- Line with checkbox
        insert_text = "\n- [ ] "
    elseif line:sub(1, cursor_pos + 1):match("^%s*-%s+") then
        -- Regular list item
        insert_text = "\n- "
    elseif line:sub(1, cursor_pos + 1):match(":%s*$") then
        -- Ends with colon (nested list continuation)
        insert_text = "\n    - "
    end

    if insert_text ~= "" then
        -- Insert the new line with continuation using nvim_feedkeys
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(insert_text, true, false, true), 'n', true)
    else
        -- Default behavior, just start a new line
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("\n", true, false, true), 'n', true)
    end
end

-- Opens the current month's folder
function neowiki.open_current_month()
    local month = os.date("%m")
    local year = os.date("%Y")
    local wiki_path = vim.fn.expand(neowiki.config.wiki_directory)
    local full_path = string.format("%s/%s/%s/", wiki_path, year, month)
    debug("Current month folder: " .. full_path, "info")
    vim.cmd('edit ' .. full_path)
end

-- Toggles checkboxes
function neowiki.toggle_checkbox()
    local line = vim.api.nvim_get_current_line()
    local row = vim.api.nvim_win_get_cursor(0)[1]
    local new_line

    if line:match("%- %[ %]") then
        new_line = line:gsub("%- %[ %]", "- [x]", 1)
    elseif line:match("%- %[x%]") then
        new_line = line:gsub("%- %[x%]", "- [ ]", 1)
    elseif line:match("%- ") then
        new_line = line:gsub("%- ", "- [ ] ", 1)
    else
        new_line = "- [ ] " .. line
    end

    vim.api.nvim_buf_set_lines(0, row - 1, row, true, { new_line })
end

-- Sets an auto-command to Add specific format and colors for URLs
function neowiki.set_format_links_autocmd()
    vim.api.nvim_create_autocmd("FileType", {
        pattern = "markdown",
        callback = function()
            -- Use vim.fn.matchadd for a more "Lua-friendly" way to add matches
            -- This avoids the complex escaping issues of 'syntax match'
            vim.fn.matchadd("Hyperlink", "https\\?://[^[:space:]]\\+")
            vim.fn.matchadd("Hyperlink", "mailto:[^[:space:]]\\+")

            -- Set the color for the "Hyperlink" group
            -- This links it to 'Underlined' but also sets a specific color for Edge
            vim.api.nvim_set_hl(0, "Hyperlink", {
                fg = "#6cb6eb",
                underline = true
            })
        end
    })
end

-- Main plugin setup
function neowiki.setup(user_config)
    user_config = user_config or {}
    -- Merge user config with the default config
    for key, value in pairs(user_config) do
        neowiki.config[key] = value
    end
    -- Check if the needed directories are there
    if vim.fn.isdirectory(neowiki.config.wiki_directory) == 0 then
        if neowiki.config.auto_create_wiki_directory == true then
            local wiki_path = vim.fn.expand(neowiki.config.wiki_directory)
            vim.fn.mkdir(wiki_path, "p")
        else
            debug("Not enabled, missing wiki directory: " .. neowiki.config.wiki_directory, "error")
            return
        end
    end
    -- Export the plugin functions as NeoVim commands
    vim.api.nvim_create_user_command("WikiCreateLink", neowiki.create_link, {})
    vim.api.nvim_create_user_command("WikiToday", neowiki.open_today, {})
    vim.api.nvim_create_user_command("WikiYesterday", neowiki.open_yesterday, {})
    vim.api.nvim_create_user_command("WikiTomorrow", neowiki.open_tomorrow, {})
    vim.api.nvim_create_user_command("WikiCurrentMonth", neowiki.open_current_month, {})
    vim.api.nvim_create_user_command("WikiCreateIndex", neowiki.create_index, {})
    vim.api.nvim_create_user_command("WikiFollowLink", neowiki.follow_link, {})
    vim.api.nvim_create_user_command("WikiToggleCheckBox", neowiki.toggle_checkbox, {})

    -- Optional features
    -- Format links and URLs
    if neowiki.config.format_links then
        neowiki.set_format_links_autocmd()
    end

    -- Follow links in markdown files
    vim.api.nvim_create_autocmd("FileType", {
        pattern = "markdown",
        callback = function()
            vim.keymap.set('n', 'gf', neowiki.follow_link, { buffer = true, desc = "Follow Wiki Link" })
        end
    })

    if neowiki.config.debug then
        debug("Started: " .. neowiki.config.wiki_directory)
    end
end

return neowiki
