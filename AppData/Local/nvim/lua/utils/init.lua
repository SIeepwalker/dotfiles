local M = {}

-- Return `true` if the current buffer is empty, `false` otherwise.
---@param bufnr? integer
---@return boolean
function M.buf_is_empty(bufnr)
    bufnr = bufnr or vim.api.nvim_get_current_buf()
    return vim.api.nvim_buf_line_count(bufnr) == 1
        and vim.api.nvim_buf_get_lines(bufnr, 0, -1, true)[1] == ''
end

-- Pads an array of `lines` so they would be centered in the `window`.
-- Uses current window as default
---@param lines string[]
---@param window? number
---@return string[]
function M.center(lines, window)
    local max_length = 0
    window = window or 0
    for _, line in ipairs(lines) do
        max_length = math.max(max_length, vim.api.nvim_strwidth(line))
    end
    local shift = math.floor(vim.api.nvim_win_get_width(window) / 2 - max_length / 2)
    return vim.tbl_map(function(line)
        return string.rep(' ', shift) .. line
    end, lines)
end

-- Takes a `date` string (format YYYY-MM-DDTHH:MM:SS) and returns the `epoch` value
---@param date string
---@return integer epoch
function M.dateStringToEpoch(date)
    return os.time({
        year = tonumber(string.sub(date, 1, 4)) or 1970,
        month = tonumber(string.sub(date, 6, 7)) or 1,
        day = tonumber(string.sub(date, 8, 9)) or 1,
        hour = tonumber(string.sub(date, 10, 11)) or nil,
        min = tonumber(string.sub(date, 13, 14)) or nil,
        sec = tonumber(string.sub(date, 16, 17)) or nil,
    })
end

-- returns a table containing the buffer number of all listed buffers
---@return integer[]
function M.getListedBufs()
    return vim.tbl_filter(function(bufnr)
        return vim.api.nvim_buf_get_option(bufnr, "buflisted")
    end, vim.api.nvim_list_bufs())
end

-- appends table b to table a and returns the modified table a
---@param a any[]
---@param b any[]
---@return any[]
function M.concatTables(a, b)
    for i = 1, #b do
        a[#a + 1] = b[i]
    end
    return a
end

return M
