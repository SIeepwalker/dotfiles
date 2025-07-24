---@diagnostic disable: missing-fields
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
