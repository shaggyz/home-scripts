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

-- os.date("*t").wday: 1=Sunday, 2=Monday, ..., 7=Saturday
local function is_weekend_wday(wday)
    return wday == 1 or wday == 7
end

local function unpack_ts(ts)
    return os.date("%Y-%m-%d", ts), os.date("%m", ts), os.date("%Y", ts)
end

-- Returns the previous Mon-Fri relative to `base_ts` (defaults to now).
-- Always returns a workday strictly before the base.
function M.get_previous_workday(base_ts)
    base_ts = base_ts or os.time()
    local ts = base_ts - 86400
    while is_weekend_wday(os.date("*t", ts).wday) do
        ts = ts - 86400
    end
    return unpack_ts(ts)
end

-- Returns the next Mon-Fri relative to `base_ts` (defaults to now).
-- Always returns a workday strictly after the base.
function M.get_next_workday(base_ts)
    base_ts = base_ts or os.time()
    local ts = base_ts + 86400
    while is_weekend_wday(os.date("*t", ts).wday) do
        ts = ts + 86400
    end
    return unpack_ts(ts)
end

-- Parses "YYYY-MM-DD" into a noon-localtime timestamp. Returns nil on bad input.
-- Noon avoids DST edge cases when adding/subtracting whole days.
function M.date_to_timestamp(date_str)
    local y, m, d = tostring(date_str or ""):match("^(%d+)-(%d+)-(%d+)$")
    if not y then return nil end
    return os.time({
        year = tonumber(y),
        month = tonumber(m),
        day = tonumber(d),
        hour = 12,
        min = 0,
        sec = 0,
    })
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
