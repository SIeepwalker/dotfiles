function _G.set_terminal_keymaps()
    local opts = { buffer = 0 }
    vim.keymap.set('t', '<C-n>', [[<C-\><C-n>]], opts)
    vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
    vim.keymap.set({ 'n', 't' }, '<C-k>', "<cmd>bw!<cr>", opts)
end

vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

require("toggleterm").setup {
    open_mapping = "<A-b>",
    float_opts = {
        border = 'curved',
        title_pos = 'center'
    }
}

vim.keymap.set("n", "<leader>B", "<cmd>ToggleTermToggleAll<cr>", { silent = true })

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
