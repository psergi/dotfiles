return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  opts = {
    git = {
      enable = false
    }
  },
  config = function(_, opts)
    require("nvim-tree").setup(opts)
  end
}
