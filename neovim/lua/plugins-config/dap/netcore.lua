local M = {}

M.register_adapter = function()
    local dap = require("dap")
    dap.adapters.netcore = {
        type = 'executable',
        command = vim.fn.expand("~/scoop/apps/netcoredbg/current/netcoredbg.exe"),
        args = { '--interpreter=vscode' }
    }

    dap.configurations.cs = {
        {
            type = "netcore",
            name = "launch - netcoredbg",
            request = "launch",
            program = function()
                return vim.fn.input('Path to dll', vim.fn.getcwd() .. '/bin/Debug/', 'file')
            end,
        },
    }
end

M.set_start_project_and_profile = function()

end

M.get_start_project_and_profile = function()
    local a = require("plenary.async")
    a.uv.fs_open()

end

return M
