return {
  "EdenEast/nightfox.nvim",
  lazy = false,
  priority = 1000,
  opts = {
    options = {
      terminal_colors = false,
      styles = {
        comments = "italic"
      }
    }
  },
  config = function(_, opts)
    require("nightfox").setup(opts);
    vim.cmd("colorscheme nightfox")
  end
}
