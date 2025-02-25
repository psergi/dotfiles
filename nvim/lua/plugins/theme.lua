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
    },
    groups = {
      all = {
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
      }
    }
  },
  config = function(_, opts)
    require("nightfox").setup(opts);
    vim.cmd("colorscheme nightfox")
  end
}
