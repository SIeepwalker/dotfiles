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
        command_palette = true,                   -- position the cmdline and popupmenu together
        long_message_to_split = true,             -- long messages will be sent to a split
        lsp_doc_border = true,                    -- add a border to hover docs and signature help
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
