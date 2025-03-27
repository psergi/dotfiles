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
        MatchParen = {
          fg = "NONE",
          bg = "#263B53"
        }
      }
    }
  },
  config = function(_, opts)
    if vim.o.termguicolors then
      require("nightfox").setup(opts);
      vim.cmd("colorscheme nightfox")
    else
      vim.cmd("colorscheme industry")  -- Basic 256-color fallback
    end
  end
}
