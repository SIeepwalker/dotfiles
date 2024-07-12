-- Config
vim.o.number = true
vim.o.relativenumber = true
vim.o.termguicolors = true
vim.o.history = 500
vim.o.so = 7
vim.o.ignorecase = true
vim.o.magic = true
vim.o.expandtab = true
vim.o.shiftwidth = 4
vim.o.tabstop = 4
vim.o.colorcolumn = "120"
vim.cmd("language en_US")

vim.o.autoread = true
vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "CursorHoldI", "FocusGained" }, {
    command = "if mode() != 'c' | checktime | endif",
    pattern = { "*" },
})

-- Global remaps

vim.g.mapleader = " "
vim.keymap.set({ "i", "v" }, "jk", "<Esc>", { noremap = true })
vim.keymap.set({ "i", "v" }, "kj", "<Esc>", { noremap = true })
vim.keymap.set('n', '<Leader>l', '<Cmd>noh<CR>', { silent = true })
vim.keymap.set({ 'n', 'v', 'i' }, '<C-l>', '20zl', { silent = true })
vim.keymap.set({ 'n', 'v', 'i' }, '<C-h>', '20zh', { silent = true })
vim.keymap.set("n", "x", '"_x', { silent = true, noremap = true })

-- Lazy

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system(
        { "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", -- latest stable release
            lazypath })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins", {
    defaults = { lazy = true }
})

vim.cmd [[colorscheme tokyonight-night]]

--[[
TODO:
- zoxide integration
- http-server for quick testing (Plenary ? ToggleTerm ?)
- csharp tools: package manager, launcher, project/file creation etc.
- LSP workspace commands
]]
