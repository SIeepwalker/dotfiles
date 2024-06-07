---@alias DotnetAdapterResultTable table<string, DotnetAdapterResult>
---@alias DotnetTestSet table<string, {index: integer}>

---@class DotnetAdapterResult
---@field passed integer
---@field failed integer
---@field unknown integer
---@field output string
---@field error string
---@field stackTrace string
local M = {
    __index = function(table, key)
        if rawget(table, key) == nil then
            rawset(table, key, { passed = 0, failed = 0, unknown = 0, output = "", error = "", stackTrace = "" })
        end
        return table[key]
    end
}

---@return DotnetAdapterResultTable
function M:new()
    return setmetatable({}, self)
end

return M
