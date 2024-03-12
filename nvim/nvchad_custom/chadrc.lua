---@type ChadrcConfig 
local M = {}
M.ui = {
  theme = 'nightfox',
  hl_override = {
    Comment = {
      fg = "#6e7e91"
    },
    WinSeparator = {
      fg = "grey"
    },
    DiffAdd = {
      fg = "NONE",
      bg = "#203B23"
    },
    DiffDelete = {
      fg = "#532325",
      bg = "#532325"
    },
    DiffChange = {
      fg = "NONE",
      bg = "#203B23"
    },
    DiffText = {
      fg = "NONE",
      bg = "#236827"
    },
    ["@constructor"] = {
      fg = "#86abdc"
    },
  },
  statusline = {
    overriden_modules = function(modules)
      table.insert(modules, " Ln %l, Col %c")
    end,
  }
}

-- M.ui.hl_override["@constructor.go"] = { fg = "#FF0000" }
M.plugins = "custom.plugins"
M.mappings = require "custom.mappings"
return M
