local neowiki = {}


-- Default configuration
neowiki.config = {
    debug = false,
    wiki_directory = "~/Notes"
}


-- Converts the highlighted text or the word under the cursor into a Markdown link
function neowiki.create_link()
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
    -- Export the plugin functions as NeoVim commands
    vim.api.nvim_create_user_command("WikiCreateLink", neowiki.create_link, {})

    if neowiki.config.debug then
        print(string.format("NeoWiki: %s", neowiki.config.wiki_directory))
    end
end

return neowiki
