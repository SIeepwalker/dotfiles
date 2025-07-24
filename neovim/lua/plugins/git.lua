return {
    {
        "lewis6991/gitsigns.nvim",
        event = "VeryLazy",
        config = function() require("plugins-config.gitsigns") end
    },
    {
        'sindrets/diffview.nvim',
        event = "VeryLazy",
    }
}
