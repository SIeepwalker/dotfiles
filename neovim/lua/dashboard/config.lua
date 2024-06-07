local art = require("dashboard.art")

local M = {}

---@alias DashboardShortcut {text: string, key: string, action: string | function, highlight: string}
---@alias DashboardHistory {display: boolean, max?: number}
---@alias HistoryHighlights {key: string, path: string, title: string}
---@alias DashboardBlock {content: string[], highlight: string }

---@class DashboardConfig
---@field shortcuts? DashboardShortcut[]
---@field projects? DashboardHistory
---@field oldfiles? DashboardHistory
---@field historyHighlights? HistoryHighlights
---@field header? DashboardBlock
---@field title? DashboardBlock
---@field footer? DashboardBlock
---@field statsHighlight? string
M.options = {}

---@class DashboardInternalConfig
---@field setup boolean
---@field oldfilesKeys string
---@field projectsKeys string
---@field historyLines string[]
M.internalConfig = { setup = false, historyLines = {} }

---@type DashboardConfig
local default = {
    shortcuts = {},
    oldfiles = {
        display = true,
        max = 8,
    },
    projects = {
        display = true,
        max = 5,
    },
    historyHighlights = {
        key = "DiagnosticInfo",
        path = "Normal",
        title = "Directory"
    },
    header = { content = art.sleepwalker, highlight = "Directory" },
    footer = { content = art.dreamers, highlight = "NonText" },
    title = { content = { "Neovim" }, highlight = "Directory" },
    statsHighlight = "NonText"
}

---@param opts? DashboardConfig
function M.setup(opts)
    M.internalConfig.setup = true
    M.options = vim.tbl_deep_extend("force", default, opts or {})

    local shortcutKeysPattern = "["
    for _, v in ipairs(M.options.shortcuts) do shortcutKeysPattern = shortcutKeysPattern .. v.key end
    shortcutKeysPattern = shortcutKeysPattern .. "]"
    local oldfilesKeys = string.gsub("azertyuiopwxc", shortcutKeysPattern, "")
    local projectsKeys = string.gsub("qsdfghjklmvbn", shortcutKeysPattern, "")
    local tempOldfilesKeys = oldfilesKeys
    oldfilesKeys = oldfilesKeys .. string.sub(projectsKeys, M.options.projects.max + 1)
    projectsKeys = projectsKeys .. string.sub(tempOldfilesKeys, M.options.oldfiles.max + 1)
    M.internalConfig.oldfilesKeys = oldfilesKeys
    M.internalConfig.projectsKeys = projectsKeys
end

return M
