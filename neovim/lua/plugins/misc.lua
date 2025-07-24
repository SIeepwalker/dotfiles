return {
    {
        "ziontee113/icon-picker.nvim",
        keys = "<leader>i",
        config = function() require("plugins-config.icon-picker") end
    },
    {
        "akinsho/toggleterm.nvim",
        version = "2.*",
        keys = { "<A-b>", "<leader>B", "<leader>g" },
        event = "VeryLazy",
        config = function() require("plugins-config.toggleterm") end
    },
    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        event = "VeryLazy",
        version = "1.*",
        keys = { "<leader>fC" },
        config = function() require("plugins-config.todo-comments") end

    },
    {
        "eandrju/cellular-automaton.nvim",
        keys = "<leader><leader>",
        config = function() require("plugins-config.cellular-automaton") end
    }
}
