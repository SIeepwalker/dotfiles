return {
    {
        'nvim-lualine/lualine.nvim',
        event = { "BufReadPost", "BufNewFile" },
        config = function()
            require("lualine-config")
        end,
        dependencies = { 'nvim-tree/nvim-web-devicons', 'folke/noice.nvim' }
    },
    {
        'akinsho/bufferline.nvim',
        version = "4.*",
        event = "BufEnter",
        config = function()
            require("tabs-config")
        end,
        dependencies = 'nvim-tree/nvim-web-devicons'
    },
    {
        'stevearc/dressing.nvim',
        version = "2.*",
        opts = {},
        event = "VeryLazy",
    },
    {
        dir = vim.fn.stdpath("config") .. "/lua/dashboard",
        enabled = false,
        event = "VimEnter",
        config = function()
            local dashboard = require("dashboard")
            dashboard.setup({
                shortcuts = {
                    { key = "s", action = "Lazy sync", text = "󰚰 Sync", highlight = "String" },
                    { key = "w", action = "Telescope workspaces", text = " Workspaces", highlight = "DiagnosticWarn" },
                    { key = "b", action = "Neotree dir=~/ position=current", text = "󰥨 Browse", highlight = "ReferencesCount" }
                }
            })
            dashboard.load()
            vim.keymap.set("n", "<leader><leader>D", function()
                dashboard.load()
            end, {})
        end,
        dependencies = { "natecraddock/workspaces.nvim" }
    },
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        version = "4.*",
        config = function()
            local nf = require('notify')
            local _notify = nf.notify
            ---@diagnostic disable-next-line: duplicate-set-field
            nf.notify = function(msg, level, opts)
                if msg == 'No information available' then
                    return
                end

                return _notify(msg, level, opts)
            end

            local noice = require("noice")
            noice.setup {
                lsp = {
                    override = {
                        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                        ["vim.lsp.util.stylize_markdown"] = true,
                        ["cmp.entry.get_documentation"] = true,
                    },
                },
                messages = {
                    view_history = "popup"
                },
                presets = {
                    command_palette = true,       -- position the cmdline and popupmenu together
                    long_message_to_split = true, -- long messages will be sent to a split
                    lsp_doc_border = true,        -- add a border to hover docs and signature help
                },
                commands = {
                    history = {
                        view = "popup"
                    }
                }
            }

            vim.keymap.set("n", "<leader>nl", "<cmd>Noice last<CR>", {})
            vim.keymap.set("n", "<leader>nd", "<cmd>Noice dismiss<CR>", {})
            vim.keymap.set("n", "<leader>ne", "<cmd>Noice errors<CR>", {})
            vim.keymap.set("n", "<leader>nm", "<cmd>messages<CR>", {})
            vim.keymap.set("n", "<leader>nh", "<cmd>Noice<CR>", {})
            vim.keymap.set({ "n", "i", "s" }, "<c-a>", function()
                if not require("noice.lsp").scroll(4) then
                    return "<c-f>"
                end
            end, { silent = true, expr = true })

            vim.keymap.set({ "n", "i", "s" }, "<c-z>", function()
                if not require("noice.lsp").scroll(-4) then
                    return "<c-b>"
                end
            end, { silent = true, expr = true })
        end,
        dependencies = {
            "MunifTanjim/nui.nvim",
            "nvim-treesitter/nvim-treesitter",
            "rcarriga/nvim-notify"
        }

    },
    {
        "xiyaowong/virtcolumn.nvim",
        event = { "BufReadPost", "BufNewFile" },
    },
    {
        "karb94/neoscroll.nvim",
        version = "0.*",
        event = "VeryLazy",
        opts = {}
    }
}
