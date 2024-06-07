local config = require("dashboard.config")
local loadHelpers = require("dashboard.load-helpers")
local commands = require("dashboard.commands")
local utils = require("utils")

local dashboard = {}

function dashboard.load()
    if not config.internalConfig.setup then error("Didn't setup dashboard before loading") end
    if string.match(vim.api.nvim_buf_get_name(0), "%[Dashboard]") then return end

    vim.api.nvim_create_autocmd("UIEnter", {
        once = true,
        callback = function()
            loadHelpers.setupBuffer()

            local t = require("utils.text-renderer"):new()
            t:block({ "", "", "", "", })
            t:block(utils.center(config.options.header.content), config.options.header.highlight)
            t:block({ "", "", })
            t:block(utils.center(config.options.title.content), config.options.title.highlight)
            t:block({ "", "" })
            t:newLine(utils.center({ loadHelpers.lazyStats() })[1], config.options.statsHighlight)
            t:newLine()
            commands.addShortcuts(t)
            t:block({ "", "" })
            commands.setupHistory(t)
            t:block({ "", "", "", })
            t:block(utils.center(config.options.footer.content), config.options.footer.highlight)
            t:render()


            vim.opt_local.modifiable = false
            vim.opt_local.modified = false
            vim.opt_local.filetype = 'dashboard'

            vim.api.nvim_buf_set_name(0, '[Dashboard]')
        end
    })
end

dashboard.setup = config.setup

return dashboard
