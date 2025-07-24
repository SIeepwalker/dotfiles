require("ccc").setup {
    highlighter = {
        auto_enable = true
    }
}

vim.keymap.set("n", "<leader>c", "<Cmd>CccPick<CR>", {})
vim.keymap.set("n", "<leader>C", "<Cmd>CccConvert<CR>", {})
