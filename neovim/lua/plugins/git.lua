return {
    {
        "lewis6991/gitsigns.nvim",
        event = "VeryLazy",
        config = function()
            local gs = require("gitsigns")
            gs.setup({})
            local function map(l, r)
                vim.keymap.set("n", "<leader>" .. l, r, {})
            end

            map("hr", gs.reset_hunk)
            map("hR", gs.reset_buffer)
            map("hb", function() gs.blame_line { full = true } end)
            map("hd", gs.diffthis)
            map("hs", gs.toggle_deleted)
        end
    },
    {
        'sindrets/diffview.nvim',
        event = "VeryLazy",
    }
}
