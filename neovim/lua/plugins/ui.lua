return {
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        opts = {},
    },
    {
        'nvim-lualine/lualine.nvim',
        event = { "BufReadPost", "BufNewFile" },
        config = function() require("plugins-config.lualine") end,
        dependencies = { 'nvim-tree/nvim-web-devicons', 'folke/noice.nvim' }
    },
    {
        'akinsho/bufferline.nvim',
        version = "4.*",
        event = "BufEnter",
        config = function() require("plugins-config.bufferline") end,
        dependencies = 'nvim-tree/nvim-web-devicons'
    },
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        version = "4.*",
        config = function() require("plugins-config.noice") end,
        dependencies = {
            "MunifTanjim/nui.nvim",
            "nvim-treesitter/nvim-treesitter",
            "rcarriga/nvim-notify"
        }

    },
    {
        "xiyaowong/virtcolumn.nvim",
        event = { "BufReadPost", "BufNewFile" },
    },
    {
        "karb94/neoscroll.nvim",
        version = "0.*",
        event = "VeryLazy",
        opts = {}
    }
}
