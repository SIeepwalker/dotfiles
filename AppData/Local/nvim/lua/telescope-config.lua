local telescope = require('telescope')
require("workspaces").setup {
    hooks = { open = { "Neotree position=current" } }
}

telescope.load_extension('fzy_native')
telescope.load_extension('workspaces')

telescope.setup {
    defaults = {
        file_ignore_patterns = { ".git" },
        mappings = {
            i = {
                ["<C-h>"] = "which_key"
            },
        },
        sorting_strategy = "ascending",
        layout_config = {
            prompt_position = "top",
            horizontal = {
                height = 0.9,
                preview_cutoff = 120,
                width = 0.8
            }
        }
    },
}

local tel_builtin = require("telescope.builtin")
vim.keymap.set('n', '<leader>ff', function() tel_builtin.find_files { hidden = true } end, {})
vim.keymap.set('n', '<leader>fg', function() tel_builtin.live_grep {} end, {})
vim.keymap.set('n', '<leader>fc', tel_builtin.command_history, {})
vim.keymap.set('n', '<leader>fC', tel_builtin.commands, {})
vim.keymap.set('n', '<leader>fs', tel_builtin.search_history, {})
vim.keymap.set('n', '<leader>fm', tel_builtin.marks, {})
vim.keymap.set('n', '<leader>fd', tel_builtin.diagnostics, {})
vim.keymap.set('n', '<leader>fk', tel_builtin.keymaps, {})
vim.keymap.set('n', '<leader>fb', tel_builtin.buffers, {})
vim.keymap.set('n', '<leader>fo', tel_builtin.oldfiles, {})
vim.keymap.set('n', '<leader>fq', tel_builtin.quickfix, {})
vim.keymap.set('n', '<leader>fj', tel_builtin.jumplist, {})
vim.keymap.set('n', '<leader>fr', tel_builtin.registers, {})
vim.keymap.set('n', '<leader>fk', tel_builtin.keymaps, {})
vim.keymap.set('n', '<leader>gc', tel_builtin.git_commits, {})
vim.keymap.set('n', '<leader>gx', tel_builtin.git_stash, {})
vim.keymap.set('n', '<leader>gb', tel_builtin.git_branches, {})
vim.keymap.set('n', '<leader>fp', telescope.extensions.workspaces.workspaces)
