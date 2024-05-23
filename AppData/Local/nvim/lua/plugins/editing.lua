return {
    {
        "kylechui/nvim-surround",
        version = "*", -- Use for stability; omit to use `main` branch for the latest features
        event = "VeryLazy",
        opts = {}
    },
    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        config = function()
            require("nvim-autopairs").setup({})
            local cmp_autopairs = require('nvim-autopairs.completion.cmp')
            local cmp = require('cmp')
            cmp.event:on(
                'confirm_done',
                cmp_autopairs.on_confirm_done()
            )
        end,
        dependencies = { 'hrsh7th/nvim-cmp' }
    },
    {
        "monaqa/dial.nvim",
        event = "VeryLazy",
        config = function()
            require("dial-config")
        end
    },
    {
        'numToStr/Comment.nvim',
        keys = { "gc", "gb" },
        opts = {},
    },
    {
        "uga-rosa/ccc.nvim",
        event = "VeryLazy",
        config = function()
            require("ccc").setup {
                highlighter = {
                    auto_enable = true
                }
            }

            vim.keymap.set("n", "<leader>c", "<Cmd>CccPick<CR>", {})
            vim.keymap.set("n", "<leader>C", "<Cmd>CccConvert<CR>", {})
        end
    }
}
