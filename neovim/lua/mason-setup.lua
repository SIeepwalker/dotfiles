local commands = require("lsp-commands")

require("mason").setup()
require("mason-lspconfig").setup { automatic_installation = true }

vim.keymap.set('n', '<leader>ee', vim.diagnostic.open_float)
vim.keymap.set('n', '<leader>eD', vim.diagnostic.goto_prev)
vim.keymap.set('n', '<leader>ed', vim.diagnostic.goto_next)

vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
        local opts = {
            buffer = ev.buf
        }
        local fzf = require("fzf-lua")
        vim.keymap.set('n', 'gD', fzf.lsp_declarations, opts)
        vim.keymap.set('n', 'gd', fzf.lsp_definitions, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', 'gi', fzf.lsp_implementations, opts)
        vim.keymap.set('n', '<leader>D', fzf.lsp_typedefs, opts)
        vim.keymap.set('n', 'cr', fzf.lsp_code_actions, opts)
        vim.keymap.set('n', 'cR', vim.lsp.buf.rename, opts)
        vim.keymap.set('n', 'gr', fzf.lsp_references, opts)
        vim.keymap.set('n', '<leader>L', fzf.lsp_finder, opts)
        vim.keymap.set('n', '<leader>F', function() vim.lsp.buf.format { async = true } end, opts)
        vim.keymap.set('n', '<leader>O', commands.typescript.organizeImports, opts)
    end
})
