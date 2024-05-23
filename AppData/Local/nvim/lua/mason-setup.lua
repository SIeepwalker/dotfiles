local commands = require("lsp-commands")

require("mason").setup()
require("mason-lspconfig").setup { automatic_installation = true }
require("mason-registry").refresh(require("lsp-setup").setupLsp)

vim.keymap.set('n', '<leader>ee', vim.diagnostic.open_float)
vim.keymap.set('n', '<leader>eD', vim.diagnostic.goto_prev)
vim.keymap.set('n', '<leader>ed', vim.diagnostic.goto_next)

vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
        local opts = {
            buffer = ev.buf
        }
        local tel_builtin = require("telescope.builtin")
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', 'gd', tel_builtin.lsp_definitions, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', 'gi', tel_builtin.lsp_implementations, opts)
        vim.keymap.set('n', '<leader>D', tel_builtin.lsp_type_definitions, opts)
        vim.keymap.set('n', 'cR', vim.lsp.buf.rename, opts)
        vim.keymap.set('n', 'gr', function()
            tel_builtin.lsp_references {
                include_declaration = false,
                include_current_line = false,
                show_line = false
            }
        end, opts)
        vim.keymap.set('n', '<leader>F', function() vim.lsp.buf.format { async = true } end, opts)
        vim.keymap.set('n', '<leader>O', commands.typescript.organizeImports, opts)
    end
})
