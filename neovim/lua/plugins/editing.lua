return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        event = "VeryLazy",
        config = function() require("plugins-config.treesitter") end,
        dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" }
    },
    {
        "kylechui/nvim-surround",
        version = "2.*",
        event = "VeryLazy",
        opts = {}
    },
    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        config = function() require("plugins-config.autopairs") end,
        dependencies = { 'hrsh7th/nvim-cmp' }
    },
    {
        "monaqa/dial.nvim",
        event = "VeryLazy",
        config = function() require("plugins-config.dial") end
    },
    {
        "uga-rosa/ccc.nvim",
        event = "VeryLazy",
        version = "2.*",
        config = function() require("plugins-config.ccc") end
    }
}
