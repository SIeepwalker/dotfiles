local bufferline = require("bufferline")
bufferline.setup {
    options = {
        numbers = "ordinal",
        diagnostics = "nvim_lsp",
        diagnostics_indicator = function(count, level, diagnostics_dict, context)
            local s = " "
            for e, n in pairs(diagnostics_dict) do
                if e == "error" then
                    s = s .. n .. " "
                elseif e == "warning" then
                    s = s .. n .. ""
                end
            end
            return s
        end,
        show_buffer_close_icons = false,
        offsets = {
            {
                filetype = "neo-tree",
                text = "File Explorer",
                highlight = "Directory",
                separator = true
            }
        },
        show_close_icon = false
    },
    highlights = {
        error = {
            fg = "#cc6c6c"
        },
        error_diagnostic = {
            fg = "#cc6c6c"
        },
        warning = {
            fg = "#ffa352"
        },
        warning_diagnostic = {
            fg = "#ffa352"
        },
        modified = {
            fg = {
                attribute = "fg",
                highlight = "BufferLineBackground"
            }
        },
        modified_selected = {
            fg = {
                attribute = "fg",
                highlight = "BufferLineBufferSelected"
            }
        },
        hint_selected = {
            fg = {
                attribute = "fg",
                highlight = "BufferLineBufferSelected"
            }
        },
        info_selected = {
            fg = {
                attribute = "fg",
                highlight = "BufferLineBufferSelected"
            }
        },
    }
}

local function map(l, r)
    local opts = {
        silent = true,
        noremap = true
    }
    vim.keymap.set({ "n", "i", "v" }, "<A-" .. l .. ">", r, opts)
end

map("&", function() bufferline.go_to(1, true) end)
map("é", function() bufferline.go_to(2, true) end)
map("\"", function() bufferline.go_to(3, true) end)
map("'", function() bufferline.go_to(4, true) end)
map("(", function() bufferline.go_to(5, true) end)
map("-", function() bufferline.go_to(6, true) end)
map("è", function() bufferline.go_to(7, true) end)
map("_", function() bufferline.go_to(8, true) end)
map("ç", function() bufferline.go_to(9, true) end)
map("$", function() bufferline.go_to(-1, true) end)
map("1", function() bufferline.go_to(1, true) end)
map("2", function() bufferline.go_to(2, true) end)
map("3", function() bufferline.go_to(3, true) end)
map("4", function() bufferline.go_to(4, true) end)
map("5", function() bufferline.go_to(5, true) end)
map("6", function() bufferline.go_to(6, true) end)
map("7", function() bufferline.go_to(7, true) end)
map("8", function() bufferline.go_to(8, true) end)
map("9", function() bufferline.go_to(9, true) end)
map("$", function() bufferline.go_to(-1, true) end)
map("z", "<cmd>BufferLineCycleNext<CR>")
map("a", "<cmd>BufferLineCyclePrev<CR>")
map("s", "<cmd>BufferLineMoveNext<CR>")
map("q", "<cmd>BufferLineMovePrev<CR>")
map("c", "<cmd>BufferLineCloseOthers<CR>")
map("p", "<cmd>BufferLineTogglePin<CR>")

map("x", function()
    if #require("utils").getListedBufs() > 1 then
        vim.cmd("bp|bd #")
    else
        vim.cmd("bd")
    end
end)
