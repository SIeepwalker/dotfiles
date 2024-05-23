return {
    {
        "ziontee113/icon-picker.nvim",
        keys = "<leader>i",
        config = function()
            require("icon-picker").setup({
                disable_legacy_commands = true
            })

            local snopts = { noremap = true, silent = true }
            vim.keymap.set("n", "<leader>if", "<cmd>IconPickerNormal alt_font<cr>", snopts)
            vim.keymap.set("n", "<leader>is", "<cmd>IconPickerNormal symbols<cr>", snopts)
            vim.keymap.set("n", "<leader>ie", "<cmd>IconPickerNormal emoji<cr>", snopts)
            vim.keymap.set("n", "<leader>ii", "<cmd>IconPickerNormal nerd_font_v3<cr>", snopts)
            vim.keymap.set("n", "<leader>iyf", "<cmd>IconPickerYank alt_font<cr>", snopts)
            vim.keymap.set("n", "<leader>iys", "<cmd>IconPickerYank symbols<cr>", snopts)
            vim.keymap.set("n", "<leader>iye", "<cmd>IconPickerYank emoji<cr>", snopts)
            vim.keymap.set("n", "<leader>iyi", "<cmd>IconPickerYank nerd_font_v3<cr>", snopts)
            vim.keymap.set("n", "<leader><C-i>f", "<cmd>IconPickerInsert alt_font<cr>", snopts)
            vim.keymap.set("n", "<leader><C-i>s", "<cmd>IconPickerInsert symbols<cr>", snopts)
            vim.keymap.set("n", "<leader><C-i>e", "<cmd>IconPickerInsert emoji<cr>", snopts)
            vim.keymap.set("n", "<leader><C-i>i", "<cmd>IconPickerInsert nerd_font_v3<cr>", snopts)
        end
    },
    {
        "numToStr/FTerm.nvim",
        keys = { "<A-b>", "<leader>b" },
        config =
            function()
                local FTerm = require("FTerm")
                FTerm.setup {
                    cmd = "nu"
                }
                vim.keymap.set('n', '<A-b>', FTerm.toggle, {})
                vim.keymap.set('t', '<A-b>', FTerm.toggle, {})
                vim.keymap.set('n', '<leader>b', function()
                    vim.ui.input({ prompt = "Command" }, function(input)
                        if input == nil then return end
                        FTerm.scratch({ cmd = input })
                    end)
                end, {})
            end
    },
    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        event = "VeryLazy",
        keys = { "<leader>fC" },
        config = function()
            require("todo-comments").setup {}
            vim.keymap.set("n", "<leader>fC", "<cmd>TodoTelescope<cr>", { silent = true })
        end

    },
    {
        "eandrju/cellular-automaton.nvim",
        keys = "<leader><leader>",
        config = function()
            vim.keymap.set("n", "<leader><leader>M", "<cmd>CellularAutomaton make_it_rain<CR>", { silent = true })
            vim.keymap.set("n", "<leader><leader>L", "<cmd>CellularAutomaton game_of_life<CR>", { silent = true })
        end
    }
}
