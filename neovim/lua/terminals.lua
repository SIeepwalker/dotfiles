local Terminal = require("toggleterm.terminal").Terminal

local lazygit = Terminal:new({
    cmd = "lazygit",
    display_name = "Git",
    direction = "float",

    on_open = function(term)
        vim.cmd("startinsert!")
        vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
    end,
})

vim.keymap.set("n", "<leader>g", function() lazygit:toggle() end, { noremap = true, silent = true })
