return {
    {
        "nvim-neotest/neotest",
        version = "5.*",
        dependencies = {
            { "nvim-neotest/nvim-nio", version = "1.*" },
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
        },
        keys = { "<leader>u", "<leader>U" },
        config = function() require("plugins-config.neotest") end
    },
    {
        "mfussenegger/nvim-dap",
        version = "0.*",
        keys = { "<leader>b", "<leader>d" },
        config = function() require("plugins-config.dap") end,
        dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" }
    }
}
