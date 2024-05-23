local utils = require "utils"
---@alias Line {content: string, highlights: LineHighlight[]}
---@alias LineHighlight {group: string, from: number, to: number}

---@class TextRenderer
---@field bufnr number
---@field lines Line[]
local TextRenderer = {}
TextRenderer.__index = TextRenderer

---@param bufnr number
---@param line Line
---@param row number
local function renderLine(bufnr, line, row)
    vim.api.nvim_buf_set_lines(bufnr, row, row, false, { line.content })
    for _, v in ipairs(line.highlights) do
        vim.api.nvim_buf_add_highlight(bufnr, -1, v.group, row, v.from, v.to)
    end
end

---@param bufnr? number
---@return TextRenderer
function TextRenderer:new(bufnr)
    return setmetatable({
        bufnr = bufnr or vim.api.nvim_get_current_buf(),
        lines = {}
    }, self)
end

---@param content? string
---@param highlight? string
function TextRenderer:newLine(content, highlight)
    table.insert(self.lines, { content = "", highlights = {} })
    self:appendToLine(content or "", highlight)
end

---@param content string
---@param highlight? string
function TextRenderer:appendToLine(content, highlight)
    if #self.lines == 0 then
        table.insert(self.lines, { content = "", highlights = {} })
    end

    local lastLine = self.lines[#self.lines]
    local lastHighlight = lastLine.highlights[#lastLine.highlights]
    local highlightFrom = lastHighlight and lastHighlight.to + 1 or 0
    local contentWidth = vim.api.nvim_strwidth(content)
    lastLine.content = lastLine.content .. content
    table.insert(lastLine.highlights,
        { group = highlight or "", from = highlightFrom, to = highlightFrom + contentWidth })
end

---@param content string[]
---@param highlight? string
function TextRenderer:block(content, highlight)
    for _, v in ipairs(content) do
        table.insert(self.lines, {
            content = v,
            highlights = {
                { group = highlight or "", from = 0, to = -1 }
            }
        })
    end
end

-- Center line number `linenr` in the text renderer.
-- Uses last line by default
---@param linenr? integer
function TextRenderer:centerLine(linenr)
    linenr = linenr or #self.lines
    self.lines[linenr].content = utils.center({ self.lines[linenr].content })[1]
    local _, spaces = string.find(self.lines[linenr].content, "^%s+")
    spaces = vim.api.nvim_strwidth(string.rep(" ", spaces or 0)) + 1
    for _, v in ipairs(self.lines[linenr].highlights) do
        v.to = v.to + spaces
        v.from = v.from + spaces
    end
end

---@param row? number
function TextRenderer:render(row)
    row = row or 0
    for _, v in ipairs(self.lines) do
        renderLine(self.bufnr, v, row)
        row = row + 1
    end
end

return TextRenderer
