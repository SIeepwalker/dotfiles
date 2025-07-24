require('nvim-treesitter.configs').setup {

    ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "regex", "bash", "markdown", "markdown_inline" },
    sync_install = false,
    auto_install = true,
    ignore_install = {},
    modules = {},
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false
    },
    indent = {
        enable = true
    },
    textobjects = {
        select = {
            enable = true,
            lookahead = false,
            keymaps = {
                ["aF"] = "@function.outer",
                ["iF"] = "@function.inner",
                ["ac"] = "@class.outer",
                ["ic"] = "@class.inner",
                ["aa"] = "@assignment.outer",
                ["ia"] = "@assignment.inner",
                ["la"] = "@assignment.lhs",
                ["ra"] = "@assignment.rhs",
                ["ab"] = "@block.outer",
                ["ib"] = "@block.inner",
                ["af"] = "@call.outer",
                ["if"] = "@call.inner",
                ["ai"] = "@conditional.outer",
                ["ii"] = "@conditional.inner",
                ["al"] = "@loop.outer",
                ["il"] = "@loop.inner",
                ["ap"] = "@parameter.outer",
                ["ip"] = "@parameter.inner",
                ["ar"] = "@return.outer",
                ["ir"] = "@return.inner",
                ["aR"] = "@regex.outer",
                ["iR"] = "@regex.inner",
            },
        },
        swap = {
            enable = true,
            swap_next = {
                ["<leader>x"] = "@parameter.inner",
            },
            swap_previous = {
                ["<leader>X"] = "@parameter.inner",
            },
        }
    }
}

---@class ParserConfig
local parser_config = require 'nvim-treesitter.parsers'.get_parser_configs()
parser_config.gotmpl = {
    install_info = {
        url = "https://github.com/ngalaiko/tree-sitter-go-template",
        files = { "src/parser.c" }
    },
    filetype = "gotmpl",
    used_by = { "helm" }
}

local function toggleHelm()
    vim.bo.filetype = "helm"
    vim.cmd("LspStop yamlls")
    vim.cmd("LspStart helm_ls")
end
vim.keymap.set("n", "<leader>H", toggleHelm, { silent = true })
