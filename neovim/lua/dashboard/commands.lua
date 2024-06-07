local config = require("dashboard.config")
local utils = require("utils")

local M = {}

-- Binds keys for oldfiles and adds to text renderer
local function oldfiles()
    local max = config.options.oldfiles.max

    local fileCount = 0
    for _, v in ipairs(vim.v.oldfiles) do
        if max <= fileCount then break end
        if vim.fn.filereadable(v) == 1 then
            fileCount = fileCount + 1
            local key = string.sub(config.internalConfig.oldfilesKeys, fileCount, fileCount)
            local lastSlash = string.find(v, "[\\/][^\\/]*$")
            local fileDirectory = string.sub(v, 0, lastSlash - 1)
            local fileName = string.sub(v, lastSlash + 1, -1)

            table.insert(config.internalConfig.historyLines,
                "[" .. key .. "]  " .. fileName .. " - " .. fileDirectory)

            vim.keymap.set("n", key, function()
                vim.cmd("e " .. v)
            end, { buffer = 0 })
        end
    end
end

local function workspaces()
    local wk = require("workspaces")
    local workspaceList = wk.get()
    for i, v in ipairs(workspaceList) do
        if i > config.options.projects.max then break end
        local key = string.sub(config.internalConfig.projectsKeys, i, i)
        table.insert(config.internalConfig.historyLines, "[" .. key .. "]  " .. v.name)
        vim.keymap.set("n", key, function()
            wk.open(v.name)
        end, { buffer = 0 })
    end
end

---@param renderer TextRenderer
local function addHistoryToRenderer(renderer)
    local history = utils.center(config.internalConfig.historyLines)
    for _, v in ipairs(history) do
        local keyEnds = string.find(v, "]")

        if keyEnds == nil then
            renderer:newLine(v, config.options.historyHighlights.title)
        else
            local keyString = string.sub(v, 0, keyEnds)
            local pathString = string.sub(v, keyEnds + 1)
            renderer:newLine(keyString, config.options.historyHighlights.key)
            renderer:appendToLine(pathString, config.options.historyHighlights.path)
        end
    end
end

-- generate project and oldfiles history then add them to the provided text `renderer`
---@param renderer TextRenderer
function M.setupHistory(renderer)
    config.internalConfig.historyLines = {}

    if config.options.projects.display then
        table.insert(config.internalConfig.historyLines, "Recent workspaces:")
        table.insert(config.internalConfig.historyLines, "")
        workspaces()
        table.insert(config.internalConfig.historyLines, "")
    end

    if config.options.oldfiles.display then
        table.insert(config.internalConfig.historyLines, "Recent files:")
        table.insert(config.internalConfig.historyLines, "")
        oldfiles()
        table.insert(config.internalConfig.historyLines, "")
    end

    if config.options.oldfiles.display or config.options.projects.display then
        addHistoryToRenderer(renderer)
    end
end

-- generate shortcuts and add them to the provided text `renderer`
---@param renderer TextRenderer
function M.addShortcuts(renderer)
    if #config.options.shortcuts == 0 then return end
    renderer:newLine()
    for _, v in ipairs(config.options.shortcuts) do
        local text = { "  " .. v.text .. "[" .. v.key .. "]  " }
        renderer:appendToLine(text[1], v.highlight)
        local action = type(v.action) == "function" and v.action or "<cmd>" .. v.action .. "<CR>"
        vim.keymap.set("n", v.key, action, { buffer = 0 })
    end
    renderer:centerLine()
end

return M
