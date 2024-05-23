---@diagnostic disable: missing-fields

local lib = require("neotest.lib")
local queries = require("test-dotnet-adapter.queries")
local build = require("test-dotnet-adapter.build")
local detection = require("test-dotnet-adapter.detection")
local results   = require("test-dotnet-adapter.results")

---@type neotest.Adapter
local adapter = {
    name = "test-dotnet-adapter",

    root = function(path)
        return lib.files.match_root_pattern("*.sln")(path)
    end,

    is_test_file = function(path)
        if not vim.endswith(path, ".cs") then return false end
        local content = lib.files.read(path)
        for _, v in ipairs(queries.testAttributes) do
            if string.find(content, "%[%s*" .. v .. "%s*%]") then return true end
        end
        return false
    end,

    filter_dir = function(name)
        return name ~= "bin" and name ~= "obj"
    end,

    discover_positions = function(path)
        local query = queries.buildDetectionQuery()
        return lib.treesitter.parse_positions(path, query, {
            build_position = detection.buildPosition,
            position_id = detection.positionId,
            nested_tests = true,
        })
    end,

    build_spec = function(args)
        return build.buildSpecs(args.tree)
    end,

    results = function(spec, _, tree)
        return results.generateTestResults(spec, tree)
    end
}

return adapter
