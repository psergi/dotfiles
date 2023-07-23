---@type ChadrcConfig 
local M = {}
M.ui = {
  theme = 'nightfox',
  hl_override = {
    WinSeparator = {
      fg = "grey"
    }
  }
}
M.plugins = "custom.plugins"
M.mappings = require "custom.mappings"
return M
