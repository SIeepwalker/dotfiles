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
