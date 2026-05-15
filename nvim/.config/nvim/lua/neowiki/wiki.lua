local utils = require("neowiki.utils")

local M = {}

-- Default configuration
M.config = {
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

local function get_date_file_path(year, month, date)
    return utils.date_file_path(M.config.wiki_directory, year, month, date)
end

local function get_date_dir_path(year, month)
    return utils.date_dir_path(M.config.wiki_directory, year, month)
end

-- Returns the default template contents
local function get_default_template(date)
    return string.format("# TODO %s\n\n- [ ] Task", date)
end

local function reuse_yesterday_template(current_date)
    local yd_date, month, year = utils.get_yesterday_date()
    local yd_path = get_date_file_path(year, month, yd_date)
    local expanded_yd_path = vim.fn.expand(yd_path)

    local lines = {}
    -- 1. Start with the fresh current date header
    table.insert(lines, "# TODO " .. current_date)

    local f = io.open(expanded_yd_path, "r")
    if f then
        local line_count = 0
        for line in f:lines() do
            line_count = line_count + 1

            -- 2. Skip the old date header (first line)
            if line_count > 1 then
                -- 3. Logic: If it's a COMPLETED task, ignore it.
                -- Otherwise, keep it (this preserves blank lines, notes, and unfinished tasks).
                if not line:match("^%s*%- %[x%]") then
                    table.insert(lines, line)
                end
            end
        end
        f:close()
    else
        return get_default_template(current_date)
    end

    return table.concat(lines, "\n")
end

-- Creates and opens the daily TODO file
local function get_or_create_daily_todo_file(date, month, year)
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
            utils.debug("The file " .. full_path .. " cannot be created", "error")
            return
        end

        local template = ""
        if M.config.reuse_previous_day then
            template = reuse_yesterday_template(date)
        else
            template = get_default_template(date)
        end

        file:write(template)
        file:close()
    end

    -- Open the file in a new buffer
    vim.cmd('edit ' .. vim.fn.fnameescape(full_path))
end

-- Creates and opens the daily TODO file for today
function M.open_today()
    local date = os.date("%Y-%m-%d")
    local month = os.date("%m")
    local year = os.date("%Y")
    get_or_create_daily_todo_file(date, month, year)
end

-- Creates and opens the daily TODO file for yesterday
function M.open_yesterday()
    local date, month, year = utils.get_yesterday_date()
    get_or_create_daily_todo_file(date, month, year)
end

-- Creates and opens the daily TODO file for tomorrow
function M.open_tomorrow()
    local date, month, year = utils.get_tomorrow_date()
    get_or_create_daily_todo_file(date, month, year)
end

-- Converts the highlighted text or the word under the cursor into a Markdown link
function M.create_link()
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
        if word == nil or word == "" then
            return
        end
        start_text, end_text = current_line:find(vim.pesc(word), 1, true)
    end

    if start_text == nil or end_text == nil then
        return
    end

    -- Ugly swap for reversed visual selections
    if start_text > end_text then
        local swap = end_text
        end_text = start_text
        start_text = swap
    end

    local prefix = current_line:sub(1, start_text - 1)
    local title = current_line:sub(start_text, end_text)
    local sufix = current_line:sub(end_text + 1)

    -- Read clipboard, if we have a URL we can just add it as target.
    local clipboard = vim.fn.getreg('+') or ""
    local url = ""
    if type(clipboard) == "string" and clipboard:match("^https?://") then
        url = clipboard
    end

    local new_line = string.format("%s[%s](%s)%s", prefix, title, url, sufix)

    -- Update the line contents
    vim.fn.setline(current_line_number, new_line)

    -- Cursor placed on the closing ')' so `i` inserts inside the parens
    vim.fn.cursor(current_line_number, #prefix + #title + #url + 4)

    -- Go back to normal mode
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<ESC>", true, false, true), 'n', false)
end

local INDEX_START = "<!-- neowiki:index:start -->"
local INDEX_END = "<!-- neowiki:index:end -->"

-- Locate an existing index block. Returns (start_row, end_row) 0-indexed
-- end-exclusive (suitable for nvim_buf_set_lines), or nil if absent.
local function find_existing_index(bufnr)
    local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
    local s
    for i, line in ipairs(lines) do
        if line == INDEX_START then
            s = i - 1
        elseif line == INDEX_END and s then
            -- Include trailing blank line if present, for clean re-render
            local e = i
            if lines[i + 1] == "" then e = i + 1 end
            return s, e
        end
    end
    return nil
end

-- Generates a Table of Contents based on headers
function M.create_index()
    local bufnr = 0 -- Current buffer
    local ok, parser = pcall(vim.treesitter.get_parser, bufnr, "markdown")
    if not ok or not parser then
        utils.debug("Markdown treesitter parser not available", "error")
        return
    end
    local tree = parser:parse()[1]
    if not tree then
        utils.debug("Failed to parse markdown buffer", "error")
        return
    end
    local root = tree:root()

    -- Skip heading nodes that fall inside the existing index block so we
    -- never index our own '# Index' header on re-runs.
    local skip_start_row, skip_end_row
    local existing_s, existing_e = find_existing_index(bufnr)
    if existing_s then
        skip_start_row = existing_s
        skip_end_row = existing_e
    end

    local query = vim.treesitter.query.parse("markdown", [[
        (atx_heading (atx_h1_marker) (inline) @cap)
        (atx_heading (atx_h2_marker) (inline) @cap)
        (atx_heading (atx_h3_marker) (inline) @cap)
        (atx_heading (atx_h4_marker) (inline) @cap)
        (atx_heading (atx_h5_marker) (inline) @cap)
        (atx_heading (atx_h6_marker) (inline) @cap)
    ]])

    local entries = {}
    for _, node in query:iter_captures(root, bufnr) do
        local row = node:start()
        local in_skip = skip_start_row and row >= skip_start_row and row < skip_end_row
        if not in_skip then
            local text = vim.treesitter.get_node_text(node, bufnr)
            local slug = utils.slugify(text)

            local parent = node:parent()
            local level = 1
            if parent then
                local marker_type = parent:child(0):type()
                local level_str = marker_type:match("atx_h(%d)_marker")
                level = tonumber(level_str) or 1
            end

            local indent = string.rep("  ", level - 1)
            table.insert(entries, string.format("%s- [%s](#%s)", indent, text, slug))
        end
    end

    if #entries == 0 then
        utils.debug("No headers found to create index", "warning")
        return
    end

    local index_lines = { INDEX_START, "# Index", "" }
    for _, entry in ipairs(entries) do
        table.insert(index_lines, entry)
    end
    table.insert(index_lines, "")
    table.insert(index_lines, INDEX_END)
    table.insert(index_lines, "")

    if existing_s then
        vim.api.nvim_buf_set_lines(bufnr, existing_s, existing_e, false, index_lines)
        utils.debug("Index updated with " .. #entries .. " headers")
    else
        vim.api.nvim_buf_set_lines(bufnr, 0, 0, false, index_lines)
        utils.debug("Index created with " .. #entries .. " headers")
    end
end

function M.go_to_header(header_slug)
    -- Clean the incoming target (remove '#' if present)
    local target = utils.slugify(header_slug)
    local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)

    for i, line in ipairs(lines) do
        -- Only look at lines starting with #
        if line:match("^#+") then
            -- Extract just the text part of the header
            local header_text = line:gsub("^#+%s*", "")
            if utils.slugify(header_text) == target then
                -- Move cursor to line (i is 1-indexed, cursor needs 1-indexed)
                vim.api.nvim_win_set_cursor(0, { i, 0 })
                -- Center the screen
                vim.cmd("normal! zz")
                return true
            end
        end
    end
    utils.debug("Anchor not found: " .. target, "warning")
    return false
end

-- Dispatch an external URL to the OS default handler
local function open_external(target)
    if vim.ui and vim.ui.open then
        vim.ui.open(target)
        return
    end
    local opener
    if vim.fn.has("mac") == 1 then
        opener = "open"
    elseif vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1 then
        opener = "explorer"
    elseif vim.fn.has("wsl") == 1 then
        opener = "wslview"
    elseif vim.fn.has("unix") == 1 then
        opener = "xdg-open"
    end
    if not opener then
        utils.debug("No URL opener available for this platform", "error")
        return
    end
    vim.fn.jobstart({ opener, target }, { detach = true })
end

-- Opens a markdown internal_section/external/local_file link
local function open_link(target)
    if target:match("^#") then
        -- Internal section link (e.g., #my-header)
        M.go_to_header(target)
    elseif target:match("^https?://") or target:match("^mailto:") then
        open_external(target)
    elseif target:match("%.md$") then
        -- Local Markdown file relative to current file
        local file_path = vim.fn.expand("%:p:h") .. "/" .. target
        vim.cmd('edit ' .. vim.fn.fnameescape(file_path))
    else
        utils.debug("Unknown link type: " .. target, "error")
    end
end

-- Scan a line for [label](target) links, supporting balanced parens
-- and backslash escapes inside the target (CommonMark inline-link rules).
local function find_links(line)
    local links = {}
    local i = 1
    local n = #line
    while i <= n do
        local lbr = line:find("%[", i)
        if not lbr then break end
        local rbr = line:find("%]", lbr + 1)
        if not rbr then break end
        if line:sub(rbr + 1, rbr + 1) ~= "(" then
            i = rbr + 1
        else
            local j = rbr + 2
            local depth = 1
            local closed = false
            while j <= n do
                local ch = line:sub(j, j)
                if ch == "\\" then
                    j = j + 2
                elseif ch == "(" then
                    depth = depth + 1
                    j = j + 1
                elseif ch == ")" then
                    depth = depth - 1
                    if depth == 0 then
                        closed = true
                        break
                    end
                    j = j + 1
                else
                    j = j + 1
                end
            end
            if closed then
                table.insert(links, {
                    label = line:sub(lbr + 1, rbr - 1),
                    target = line:sub(rbr + 2, j - 1),
                    s = lbr,
                    e = j,
                })
                i = j + 1
            else
                i = rbr + 1
            end
        end
    end
    return links
end

-- Follows an external/internal-markdown link
function M.follow_link()
    local line = vim.api.nvim_get_current_line()
    local col = vim.api.nvim_win_get_cursor(0)[2] + 1 -- Lua is 1-indexed

    for _, link in ipairs(find_links(line)) do
        if col >= link.s and col <= link.e then
            open_link(link.target)
            return
        end
    end
    utils.debug("No link found under cursor", "info")
end

function M.handle_markdown_list()
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
function M.open_current_month()
    local month = os.date("%m")
    local year = os.date("%Y")
    local full_path = get_date_dir_path(year, month) .. "/"
    utils.debug("Current month folder: " .. full_path, "info")
    vim.cmd('edit ' .. vim.fn.fnameescape(full_path))
end

-- Toggles checkboxes
function M.toggle_checkbox()
    local line = vim.api.nvim_get_current_line()
    local row = vim.api.nvim_win_get_cursor(0)[1]
    local indent = line:match("^(%s*)") or ""
    local new_line

    if line:match("^%s*%- %[ %]") then
        new_line = line:gsub("%- %[ %]", "- [x]", 1)
    elseif line:match("^%s*%- %[[xX]%]") then
        new_line = line:gsub("%- %[[xX]%]", "- [ ]", 1)
    elseif line:match("^%s*%- ") then
        new_line = line:gsub("%- ", "- [ ] ", 1)
    else
        new_line = indent .. "- [ ] " .. line:sub(#indent + 1)
    end

    vim.api.nvim_buf_set_lines(0, row - 1, row, true, { new_line })
end

-- Sets an auto-command to Add specific format and colors for URLs
function M.set_format_links_autocmd()
    vim.api.nvim_create_autocmd("FileType", {
        pattern = "markdown",
        callback = function()
            -- matchadd is window-scoped; guard so re-entering the buffer
            -- in the same window does not stack duplicate matches.
            if not vim.w.neowiki_links_set then
                vim.w.neowiki_links_set = true
                vim.fn.matchadd("Hyperlink", "https\\?://[^[:space:]]\\+")
                vim.fn.matchadd("Hyperlink", "mailto:[^[:space:]]\\+")
            end

            vim.api.nvim_set_hl(0, "Hyperlink", {
                fg = M.config.links_color,
                underline = true,
            })
        end,
    })
end

return M
