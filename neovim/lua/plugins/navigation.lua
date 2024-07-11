return {
    {
        "ibhagwan/fzf-lua",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        keys = { "<leader>f" },
        event = "VeryLazy",
        config = function()
            local fzf = require("fzf-lua")
            fzf.setup({})

            vim.keymap.set('n', '<leader>ff', fzf.files, {})
            vim.keymap.set('n', '<leader>fg', fzf.live_grep, {})
            vim.keymap.set('n', '<leader>fl', fzf.blines, {})
            vim.keymap.set('n', '<leader>fc', fzf.command_history, {})
            vim.keymap.set('n', '<leader>fC', fzf.commands, {})
            vim.keymap.set('n', '<leader>fs', fzf.search_history, {})
            vim.keymap.set('n', '<leader>fm', fzf.marks, {})
            vim.keymap.set('n', '<leader>fd', fzf.diagnostics_document, {})
            vim.keymap.set('n', '<leader>fD', fzf.diagnostics_workspace, {})
            vim.keymap.set('n', '<leader>fk', fzf.keymaps, {})
            vim.keymap.set('n', '<leader>fb', fzf.buffers, {})
            vim.keymap.set('n', '<leader>fo', fzf.oldfiles, {})
            vim.keymap.set('n', '<leader>fq', fzf.quickfix, {})
            vim.keymap.set('n', '<leader>fj', fzf.jumps, {})
            vim.keymap.set('n', '<leader>fr', fzf.registers, {})
            vim.keymap.set('n', '<leader>fa', fzf.builtin, {})
        end
    },
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
        'stevearc/oil.nvim',
        lazy = false,
        config = function()
            local function cdAndNotify()
                require("oil.actions").cd.callback()
                vim.notify("Cwd is now " .. vim.fn.getcwd(), vim.log.levels.INFO)
            end

            require("oil").setup {
                keymaps = {
                    ["gp"] = "actions.preview",
                    ["gd"] = "actions.preview_scroll_down",
                    ["gu"] = "actions.preview_scroll_down",
                    ["g;"] = cdAndNotify,
                    ["<BS>"] = "actions.parent",
                },
                view_options = {
                    is_hidden_file = function(name)
                        return vim.startswith(name, ".") or vim.startswith(name, "node_module")
                    end
                },
                win_options = {
                    winbar = "%{v:lua.require('oil').get_current_dir()}",
                }
            }

            vim.keymap.set("n", "<leader>T", "<Cmd>Oil<CR>", {})
            vim.keymap.set("n", "<leader>t", "<Cmd>Oil " .. vim.fn.getcwd() .. "<CR>", {})
        end,
        dependencies = { "nvim-tree/nvim-web-devicons" },
    },
    {
        "ggandor/leap.nvim",
        lazy = false,
        config = function()
            local leap = require("leap")
            leap.create_default_mappings()
        end
    },
    {
        "kevinhwang91/nvim-bqf",
        version = "1.*",
        event = "VeryLazy",
        commands = { "copen" },
        keys = { "<leader>q" },
        config = function()
            vim.keymap.set("n", "<leader>q", "<Cmd>copen<CR>", {})
        end
    }
}
