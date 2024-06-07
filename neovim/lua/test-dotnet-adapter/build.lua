local M = {}

---@param positionId string
---@return string
local function getTestFqnFromPositionId(positionId)
    local parametersDelimiterStart = string.find(positionId, ":%+%+")
    if parametersDelimiterStart == nil then return positionId end
    return string.sub(positionId, 1, parametersDelimiterStart - 1)
end

---@param node neotest.Tree
---@param acc? string[] only used for recursive calls
---@param type? string only used for recursive calls
---@return string[] runablePositions, "test" | "project"  positionsType
local function getRecursiveTestsOrProjects(node, acc, type)
    acc = acc or {}
    local currentPosition = node:data()
    if currentPosition.type == "test" or currentPosition.type == "namespace" then
        table.insert(acc, getTestFqnFromPositionId(currentPosition.id))
        return acc, "test"
    end

    local project = vim.fn.glob(currentPosition.path .. "/*.csproj")
    if currentPosition.type == "dir" and #project > 0 then
        table.insert(acc, project)
        return acc, "project"
    end

    for _, childNode in ipairs(node:children()) do
        acc, type = getRecursiveTestsOrProjects(childNode, acc, type)
    end

    return acc, type
end

local function buildProjectSpecs(runablePositions)
    local specs = {}
    local resultPath = vim.fn.tempname()

    for i, project in ipairs(runablePositions) do
        local projectResultPath = resultPath .. "-" .. i
        local command = {
            "dotnet",
            "build",
            project,
            "&&",
            "dotnet",
            "test",
            "-t",
            "--no-build",
            project,
            ">",
            projectResultPath .. "-list",
            "&&",
            "dotnet",
            "test",
            project,
            "--no-build",
            "--results-directory",
            vim.fn.fnamemodify(projectResultPath, ":h"),
            "--logger",
            '"trx;logfilename=' .. vim.fn.fnamemodify(projectResultPath, ":t") .. '"',
        }
        table.insert(specs, {
            command = table.concat(command, " "),
            context = {
                project = project,
                resultPath = projectResultPath
            }
        })
    end

    return #specs > 1 and specs or specs[1]
end

local function buildTestSpecs(runablePositions, runPath)
    local projectFolder = require("neotest.lib").files.match_root_pattern("*.csproj")(runPath)
    if not projectFolder then return end
    local filter = table.concat(runablePositions, " | ")

    local resultPath = vim.fn.tempname()

    local command = {
        "dotnet",
        "build",
        projectFolder,
        "&&",
        "dotnet",
        "test",
        "-t",
        "--no-build",
        projectFolder,
        ">",
        resultPath .. "-list",
        "&&",
        "dotnet",
        "test",
        "--no-build",
        projectFolder,
        "--filter",
        '"' .. filter .. '"',
        "--results-directory",
        vim.fn.fnamemodify(resultPath, ":h"),
        "--logger",
        '"trx;logfilename=' .. vim.fn.fnamemodify(resultPath, ":t") .. '"',
    }

    return {
        command = table.concat(command, " "),
        context = {
            project = projectFolder,
            resultPath = resultPath
        }
    }
end

---@param tree neotest.Tree
function M.buildSpecs(tree)
    local runPath = tree:data().path
    local runablePositions, positionsType = getRecursiveTestsOrProjects(tree)

    if positionsType == "project" then
        return buildProjectSpecs(runablePositions)
    else
        return buildTestSpecs(runablePositions, runPath)
    end
end

return M
