local M = {}

---@class DotNetPosition : neotest.Position
---@field method string
---@field namespace string
---@field class string

local function getNodeType(nodes)
    if nodes["test.name"] then return "test" end
    if nodes["namespace.name"] then return "namespace" end
end

---@param path string
---@param source string
---@param nodes table<string, TSNode>
---@return DotNetPosition | DotNetPosition[] |nil
function M.buildPosition(path, source, nodes)
    local type = getNodeType(nodes)
    local name = vim.treesitter.get_node_text(nodes[type .. ".name"], source)
    local namespace = vim.treesitter.get_node_text(nodes["namespace.identifier"], source)
    local class = vim.treesitter.get_node_text(nodes["class.name"], source)
    local method = nodes["method.name"] and vim.treesitter.get_node_text(nodes["method.name"], source) or nil

    if nodes["data_attribute"] then name = string.sub(name, 2, -2) end

    local range = { nodes[type .. ".definition"]:range() }

    return {
        type = type,
        name = string.gsub(name, "[\n\r]", ""),
        path = path,
        range = range,
        method = method,
        namespace = namespace,
        class = class
    }
end

---@param position DotNetPosition
---@param _ DotNetPosition[]
---@return string
function M.positionId(position, _)
    local path = position.namespace .. "." .. position.class .. "."
    local id
    if position.method then
        id = path .. position.method .. ":++" .. string.gsub(position.name, "%s*%,%s*", "|") .. "++:"
    else
        id = path .. position.name
    end
    return id
end

return M
