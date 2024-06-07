local lib = require("neotest.lib")
local async = require("neotest.async")
local red = "[31m"
local green = "[32m"
local utils = require('utils')

local M = {}


---@alias LeveledTree table<integer, neotest.Tree[]>
---@param tree neotest.Tree
---@param testNameList string[]
---@return LeveledTree leveledTree, table<string, string> testNamesMap
local function getLevelsAndNamesMap(tree, testNameList)
    ---@param names string[]
    local function parseParameterizedTestNames(names)
        local currentNamespace = ""
        local currentPosition = 1
        local output = {}
        for _, name in ipairs(names) do
            local processedName = string.gsub(name, "%s", "")
            local parenPosition = string.find(processedName, "%(")

            if parenPosition ~= nil then
                local namespace = string.sub(processedName, 1, parenPosition - 1)
                if namespace == currentNamespace then
                    currentPosition = currentPosition + 1
                else
                    currentPosition = 1
                    currentNamespace = namespace
                end
                output[namespace .. ":" .. currentPosition] = processedName
            end
        end

        return output
    end

    local leveledTree = {}
    local testNamesMap = {}
    local pTestsSet = parseParameterizedTestNames(testNameList)

    ---@param currentLevel integer
    ---@param currentNode neotest.Tree
    local function getRecursiveLevel(currentLevel, currentNode)
        leveledTree[currentLevel] = leveledTree[currentLevel] or {}
        local currentData = currentNode:data()
        table.insert(leveledTree[currentLevel], currentNode)
        for i, childNode in ipairs(currentNode:children()) do
            getRecursiveLevel(currentLevel + 1, childNode)

            local childData = childNode:data()
            if childData.type == "test" then
                if currentData.type == "namespace" then
                    testNamesMap[pTestsSet[currentData.id .. ":" .. i]] = childData.id
                else
                    testNamesMap[childData.id] = childData.id
                end
            end
        end
    end

    getRecursiveLevel(1, tree)
    return leveledTree, testNamesMap
end

---@param resultPath string
---@param testMap table<string, string>
---@return DotnetAdapterResultTable
local function parseTestResults(resultPath, testMap)
    local function removeBom(str)
        if string.byte(str, 1) == 239 and string.byte(str, 2) == 187 and string.byte(str, 3) == 191 then
            str = string.sub(str, 4)
        end
        return str
    end

    local function parseXml(file)
        local xml = lib.files.read(file)
        local noBomXml = removeBom(xml)
        return lib.xml.parse(noBomXml)
    end

    local resultTable = require("test-dotnet-adapter.results-table"):new()
    local parsedData = parseXml(resultPath)
    local testResults = parsedData.TestRun and parsedData.TestRun.Results
    testResults = #testResults.UnitTestResult > 1 and testResults.UnitTestResult or testResults

    for _, result in ipairs(testResults) do
        local testId = testMap[string.gsub(result._attr.testName, "%s", "")]
        local outcome = result._attr.outcome

        if outcome == "Passed" then
            resultTable[testId].passed = 1
        elseif outcome == "Failed" then
            resultTable[testId].failed = 1
        else
            resultTable[testId].unknown = 1
        end

        resultTable[testId].output = result.Output and result.Output.StdOut or ""
        resultTable[testId].error = result.ErrorInfo and result.ErrorInfo.Message or ""
        resultTable[testId].stackTrace = result.ErrorInfo and result.ErrorInfo.StackStrace or ""
    end

    return resultTable
end

---@param spec neotest.RunSpec
---@param tree neotest.Tree
---@return neotest.Result[]
function M.generateTestResults(spec, tree)
    -- for key, value in pairs(testResults) do
    -- value._attr.testName
    -- value.Output.StdOut
    --     value.ErrorInfo.Message / ErrorInfo.StackTrace
    -- end


    local nameList = lib.files.read_lines(spec.context.resultPath .. "-list")
    local leveledTree, testMap = getLevelsAndNamesMap(tree, nameList)
    local resultTable = parseTestResults(spec.context.resultPath, testMap)

    local output = {}
    for id, result in pairs(resultTable) do
        local temp = async.fn.tempname()
        local outputText = "passed: " .. result.passed .. "failed: " .. result.failed
        async.fn.writefile({ outputText }, temp, "S")
        local testOutput = {
            status = result.passed == 1 and "passed" or "failed",
            output = temp,
            short = "This is a YT short",
            -- errors = {
            --     { message = "coucou", },
            --     { message = "bouh",   line = 2 }
            -- }
        }
        output[id] = testOutput
    end

    return output
end

return M
