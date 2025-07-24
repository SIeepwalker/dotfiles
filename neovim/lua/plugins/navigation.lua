return {
    {
        "ibhagwan/fzf-lua",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        keys = { "<leader>f" },
        event = "VeryLazy",
        config = function() require("plugins-config.fzf-lua") end
    },
    {
        'nvim-pack/nvim-spectre',
        keys = { "<leader>S", "<leader>s" },
        config = function() require("plugins-config.spectre") end,
        dependencies = { 'nvim-lua/plenary.nvim' }
    },
    {
        'stevearc/oil.nvim',
        lazy = false,
        config = function() require("plugins-config.oil") end,
        dependencies = { "nvim-tree/nvim-web-devicons" },
    },
    {
        "ggandor/leap.nvim",
        lazy = false,
        config = function() require("plugins-config.leap") end
    },
    {
        "kevinhwang91/nvim-bqf",
        version = "1.*",
        event = "VeryLazy",
        commands = { "copen" },
        keys = { "<leader>q" },
        config = function() require("plugins-config.bqf") end
    }
}
