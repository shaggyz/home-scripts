local M = {}

-- Creates a slug for the given text
function M.slugify(text)
    return text:lower()
        :gsub("%s+", "-")           -- Replace spaces with dashes
        :gsub("[^%w%-]", "")        -- Strip everything that isn't alphanumeric or a dash
        :gsub("%-+", "-")           -- Collapse multiple dashes (e.g., "A & B" -> "a--b" -> "a-b")
        :gsub("^%-", "")            -- Strip leading dash
        :gsub("%-$", "")            -- Strip trailing dash
end

-- Prints a debug message
function M.debug(message, level, context)
    level = level or "debug"
    print("NeoWiki [" .. string.upper(level) .. "]: " .. message)
    if context ~= nil then
        print("--------- Context ---------")
        print(vim.inspect(context))
        print("---------------------------")
    end
end

-- Returns the date, month and year values for yesterday
function M.get_yesterday_date()
    local timestamp = os.time() - 24 * 60 * 60
    local date = os.date("%Y-%m-%d", timestamp)
    local month = os.date("%m", timestamp)
    local year = os.date("%Y", timestamp)
    return date, month, year
end

-- Returns the date, month and year values for tomorrow
function M.get_tomorrow_date()
    local timestamp = os.time() + 24 * 60 * 60
    local date = os.date("%Y-%m-%d", timestamp)
    local month = os.date("%m", timestamp)
    local year = os.date("%Y", timestamp)
    return date, month, year
end

-- Returns the relative date
-- TODO: use this instead of get_tomorrow_date and get_yesterday_date
function M.get_relative_date(days)
    local timestamp = os.time() + (days * 86400) -- 86400 seconds in a day
    return os.date("%Y-%m-%d", timestamp), os.date("%m", timestamp), os.date("%Y", timestamp)
end

-- Construct the full path to a dated file under a wiki base directory
function M.date_file_path(base, year, month, date)
    local wiki_path = vim.fn.expand(base)
    return string.format("%s/%s/%s/%s.md", wiki_path, year, month, date)
end

-- Construct the full path to a dated directory under a wiki base directory
function M.date_dir_path(base, year, month)
    local wiki_path = vim.fn.expand(base)
    return string.format("%s/%s/%s", wiki_path, year, month)
end

return M
