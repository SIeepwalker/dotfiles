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
