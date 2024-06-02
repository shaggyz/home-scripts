local neowiki = {}


-- Default configuration
neowiki.config = {
    -- Enable debug flag
    debug = false,
    -- Main directory to store the wiki/markdown files
    wiki_directory = "~/Notes",
    -- Auto-create the main wiki directory if it's missing
    auto_create_wiki_directory = true
}

-- Creates and opens the daily TODO file
local function get_or_create_daily_todo_file(date, month, year)
    local vim = vim
    local wiki_path = vim.fn.expand(neowiki.config.wiki_directory)

    -- Construct the full path to the file
    local full_path = string.format("%s/%s/%s/%s.md", wiki_path, year, month, date)

    -- Check and create the directory structure if it doesn't exist
    local dir_path = string.format("%s/%s/%s", wiki_path, year, month)

    if vim.fn.isdirectory(dir_path) == 0 then
        vim.fn.mkdir(dir_path, "p")
    end

    -- Check if the file exists before opening
    if vim.fn.filereadable(full_path) == 0 then
        -- File does not exist, create it and add the template
        local file = io.open(full_path, "w")
        if file == nil then
            print(string.format("NeoWiki: ERROR the file %s cannot be created", full_path))
            return
        end

        local template = string.format("# TODO %s\n\n- [ ] Task", date)
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
    local timestamp = os.time() - 24 * 60 * 60
    local date = os.date("%Y-%m-%d", timestamp)
    local month = os.date("%m", timestamp)
    local year = os.date("%Y", timestamp)
    get_or_create_daily_todo_file(date, month, year)
end

-- Creates and opens the daily TODO file for tomorrow
function neowiki.open_tomorrow()
    local timestamp = os.time() + 24 * 60 * 60
    local date = os.date("%Y-%m-%d", timestamp)
    local month = os.date("%m", timestamp)
    local year = os.date("%Y", timestamp)
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
    local new_line = string.format("%s[%s]()%s", prefix, title, sufix)

    -- TODO: read clipboard, if we have a URL maybe we can just add it as target.

    -- Update the line contents
    vim.fn.setline(current_line_number, new_line)

    -- Cursor is placed between the parenthesis (computing the added symbols: []()  == 4)
    vim.fn.cursor(current_line_number, #prefix + #title + 4)

    -- Go back to normal mode
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<ESC>", true, false, true), 'n', false)
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
            print(string.format("NeoWiki disabled: the wiki directory %s is missing", neowiki.config.wiki_directory))
            return
        end
    end
    -- Export the plugin functions as NeoVim commands
    vim.api.nvim_create_user_command("WikiCreateLink", neowiki.create_link, {})
    vim.api.nvim_create_user_command("WikiToday", neowiki.open_today, {})
    vim.api.nvim_create_user_command("WikiYesterday", neowiki.open_yesterday, {})
    vim.api.nvim_create_user_command("WikiTomorrow", neowiki.open_tomorrow, {})

    if neowiki.config.debug then
        print(string.format("NeoWiki started: %s", neowiki.config.wiki_directory))
    end
end

return neowiki
