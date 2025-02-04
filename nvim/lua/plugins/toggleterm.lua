return {
  "akinsho/toggleterm.nvim",
  version = "*",
  init = function()
    require("toggleterm").setup({
      size = 20,
      shade_terminals = false,
      open_mapping = [[<C-\>]]
    })
  end
}
