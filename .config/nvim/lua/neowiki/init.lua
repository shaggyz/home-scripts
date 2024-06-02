local neowiki = {}


-- Default configuration
neowiki.config = {
    debug = false,
    wiki_directory = "~/Notes"
}


function neowiki.do_something()
    print("Doing something...")
end

function neowiki.insert_link()
    local vim = vim
    local title, start_pos, end_pos
    local current_line = vim.fn.getline('.')
    local cursor_pos = vim.fn.col('.')

    -- Determine if there is a visual selection
    if vim.fn.mode() == 'v' or vim.fn.mode() == 'V' or vim.fn.mode() == "\22" then
        vim.cmd('normal! gv"vy')
        title = vim.fn.getreg('v')
        local vs = vim.fn.getpos("'<")
        local ve = vim.fn.getpos("'>")
        start_pos = vs[2] == ve[2] and vs[3] or 1                      -- start of selection in line or start of line
        end_pos = ve[2] == vs[2] and ve[3] or string.len(current_line) -- end of selection in line or end of line
    else
        -- Use the word under the cursor as the link text if no visual selection
        local word = vim.fn.expand('<cword>')
        local s, e = current_line:find(vim.pesc(word), 1, true)
        if s and e then
            start_pos = s
            end_pos = e
            title = word
        end
    end

    -- Replace the selected text or word with the markdown link format, cursor placed for target
    if title and start_pos and end_pos then
        local markdown_link = string.format('[%s]()', title)
        local new_line = current_line:sub(1, start_pos - 1) .. markdown_link .. current_line:sub(end_pos + 1)

        vim.fn.setline('.', new_line)
        -- Move cursor inside the parentheses
        local new_cursor_pos = start_pos + #title + 2 -- Adjust for the length of the title and the brackets
        vim.fn.cursor('.', new_cursor_pos)
    else
        print('No valid text selected and no word under cursor!')
    end
end

function neowiki.setup(user_config)
    user_config = user_config or {}
    -- Merge user config with the default config
    for key, value in pairs(user_config) do
        neowiki.config[key] = value
    end
    -- Export the plugin functions as NeoVim commands
    vim.api.nvim_create_user_command("Wiki", neowiki.do_something, {})
    vim.api.nvim_create_user_command("WikiCreateLink", neowiki.insert_link, {})

    if neowiki.config.debug then
        print("NeoWiki has been initialized!")
        print(neowiki.config.wiki_directory)
    end
end

return neowiki
