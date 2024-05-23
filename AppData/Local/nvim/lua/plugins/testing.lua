---@diagnostic disable: missing-fields
return {
    {
        "nvim-neotest/neotest",
        dependencies = {
            "nvim-neotest/nvim-nio",
            "nvim-lua/plenary.nvim",
            "antoinemadec/FixCursorHold.nvim",
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
