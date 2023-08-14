---@type ChadrcConfig 
local M = {}
M.ui = {
  theme = 'nightfox',
  hl_override = {
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
    }
  }
}
M.plugins = "custom.plugins"
M.mappings = require "custom.mappings"
return M
