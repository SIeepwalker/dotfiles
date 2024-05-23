return {
    {
        'nvim-pack/nvim-spectre',
        keys = { "<leader>S", "<leader>s" },
        config = function()
            local spectre = require("spectre")
            vim.keymap.set('n', '<leader>S', spectre.toggle, {})
            vim.keymap.set('n', '<leader>ss', spectre.toggle, {})
            vim.keymap.set('n', '<leader>sw', function() spectre.open_visual({ select_word = true }) end, {})
            vim.keymap.set('v', '<leader>sw', spectre.open_visual, {})
            vim.keymap.set('n', '<leader>sf', function() spectre.open_file_search({ select_word = true }) end, {})
        end,
        dependencies = { 'nvim-lua/plenary.nvim' }
    },
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        keys = { "<leader>t", "<leader>T", "<leader>gs" },
        cmd = "Neotree",
        dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons", "MunifTanjim/nui.nvim" },
        config = function()
            require("neo-tree").setup {
                sort_case_insensitive = true,
                filesystem = {
                    filtered_items = {
                        hide_dotfiles = false
                    },
                },
                event_handlers = {
                    {
                        event = "neo_tree_buffer_enter",
                        handler = function()
                            vim.keymap.set("n", "K", "5k", { buffer = 0, noremap = true })
                            vim.keymap.set("n", "J", "5j", { buffer = 0, noremap = true })
                        end
                    }
                }
            }

            vim.keymap.set("n", "<leader>t", "<cmd>Neotree toggle position=left<CR>", { noremap = true, silent = true })
            vim.keymap.set("n", "<leader>T", "<cmd>Neotree toggle position=float<CR>", { noremap = true, silent = true })
            vim.keymap.set("n", "<leader>gs", "<cmd>Neotree toggle source=git_status<CR>",
                { noremap = true, silent = true })
        end

    },
    {
        "ggandor/leap.nvim",
        lazy = false,
        config = function ()
            local leap = require("leap")
            leap.create_default_mappings()
        end
    }
}
