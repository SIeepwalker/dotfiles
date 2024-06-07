---@diagnostic disable: missing-fields
return {
    {
        "nvim-neotest/neotest",
        version = "5.*",
        dependencies = {
            {"nvim-neotest/nvim-nio", version = "1.*"},
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
        },
        keys = { "<leader>u", "<leader>U" },
        config = function()
            local neotest = require("neotest")
            neotest.setup {
                adapters = {
                    require("test-dotnet-adapter")
                },
                summary = {
                    open = "botright vsplit | vertical resize 80 | set nowrap"
                }
            }

            vim.keymap.set("n", "<leader>U", neotest.summary.toggle, {})
        end
    }
    --TODO: nvim-dap
}
