local utils = require("utils")

local M = {}

local function save_user_settings()
    local savedOptions = {}
    savedOptions.user_laststatus = vim.o.laststatus
    savedOptions.user_showtabline = vim.o.showtabline

    vim.api.nvim_create_autocmd("BufEnter", {
        callback = function(opt)
            local bufs = vim.api.nvim_list_bufs()
            bufs = vim.tbl_filter(function(k)
                return vim.bo[k].filetype == 'dashboard'
            end, bufs)
            if #bufs == 0 then
                vim.o.laststatus = tonumber(savedOptions.user_laststatus)
                vim.o.showtabline = tonumber(savedOptions.user_showtabline)
                vim.api.nvim_del_autocmd(opt.id)
            end
        end
    })
end

local function deleteExtraBuffer()
    vim.api.nvim_create_autocmd("BufEnter", {
        callback = function(args)
            if args.file == "" or string.match(args.file, "Dashboard") then
                return;
            end

            for _, v in ipairs(vim.api.nvim_list_bufs()) do
                if vim.api.nvim_buf_get_option(v, "modified") == false
                    and vim.api.nvim_buf_line_count(v) == 0
                    and vim.api.nvim_buf_get_name(v) == "" then
                    vim.api.nvim_buf_delete(v, {})
                end
            end

            vim.api.nvim_del_autocmd(args.id)
        end
    })
end

-- create a new buffer if needed then sets its options for dashboard display
function M.setupBuffer()
    if not utils.buf_is_empty() then
        if vim.bo.filetype == "dashboard" then return end
        local bufnr = vim.api.nvim_create_buf(false, true)
        vim.api.nvim_win_set_buf(0, bufnr)
    end

    vim.opt_local.bufhidden = 'wipe'
    vim.opt_local.buflisted = false
    vim.opt_local.colorcolumn = ''
    vim.opt_local.cursorcolumn = false
    vim.opt_local.cursorline = false
    vim.opt_local.foldcolumn = '0'
    vim.opt_local.list = false
    vim.opt_local.modifiable = true
    vim.opt_local.number = false
    vim.opt_local.readonly = false
    vim.opt_local.relativenumber = false
    vim.opt_local.signcolumn = 'no'
    vim.opt_local.spell = false
    vim.opt_local.statuscolumn = ''
    vim.opt_local.swapfile = false
    vim.opt_local.winbar = ''
    vim.opt_local.wrap = false

    save_user_settings()
    vim.o.laststatus = 0
    vim.o.showtabline = 0

    deleteExtraBuffer()
end

-- return a string of loading stats to display
---@return string stats
function M.lazyStats()
    local stats = require("lazy").stats()
    return "Startup time: " .. math.floor(stats.startuptime + 0.5) .. "ms - loaded "
        .. stats.loaded .. "/" .. stats.count .. " plugins"
end

return M
