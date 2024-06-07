local noice = require("noice")
require("lualine").setup({
    options = {
        theme = "tokyonight",
    },
    sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff', 'diagnostics' },
        lualine_c = { 'filename',
            {
                noice.api.status.mode.get,
                cond = noice.api.status.mode.has,
                color = { fg = "#ff9e64" },
            },
        },
        lualine_x = { 'encoding', 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' }
    },
})
