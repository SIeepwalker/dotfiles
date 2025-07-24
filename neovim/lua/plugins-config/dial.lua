vim.keymap.set("n", "<C-s>", function()
    require("dial.map").manipulate("increment", "gnormal")
end)
vim.keymap.set("n", "<C-q>", function()
    require("dial.map").manipulate("decrement", "gnormal")
end)
vim.keymap.set("v", "<C-s>", function()
    require("dial.map").manipulate("increment", "gvisual")
end)
vim.keymap.set("v", "<C-q>", function()
    require("dial.map").manipulate("decrement", "gvisual")
end)

local augend = require("dial.augend")

local createWordAugend = function(elements)
    return augend.constant.new({
        word = true, cyclic = true, preserve_case = true, elements = elements
    })
end

local function createSymbolAugend(elements)
    return augend.constant.new({
        word = false, cyclic = true, elements = elements
    })
end

require("dial.config").augends:register_group {
    default = {
        augend.integer.alias.decimal,
        augend.integer.alias.hex,
        augend.constant.alias.bool,
        augend.constant.alias.alpha,
        augend.constant.alias.Alpha,
        createWordAugend({ "monday", "tuesday", "wednesday", "thursday", "friday", "saturday", "sunday" }),
        createWordAugend({ "lundi", "mardi", "mercredi", "jeudi", "vendredi", "samedi", "dimanche" }),
        createWordAugend({ "january", "february", "march", "april", "may", "june", "july", "august",
            "october", "november", "december" }),
        createWordAugend({ "janvier", "fevrier", "mars", "avril", "mai", "juin", "juillet", "aout",
            "octobre", "novembre", "decembre" }),
        createWordAugend({ "and", "or" }),
        createWordAugend({ "yes", "no" }),
        createWordAugend({ "true", "false" }),
        createSymbolAugend({ "||", "&&" }),
        createSymbolAugend({ " == ", " === ", " != ", " !== ", " > ", " >= ", " < ", " <= " }),
        createWordAugend({ "public", "private", "protected", "internal" }),
        createWordAugend({"class", "interface"}),
    }
}
