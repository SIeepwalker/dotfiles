local M = {}

M.typescript = {
    organizeImports = function ()
        vim.lsp.buf.execute_command({command = "_typescript.organizeImports", arguments = {vim.fn.expand("%:p")}})
    end
}

return M
