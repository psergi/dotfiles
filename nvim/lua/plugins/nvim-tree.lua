return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  opts = {
    git = { enable = false },
    update_focused_file = {
      enable = true,
      update_root = false
    }
  },
  config = function(_, opts)
    require("nvim-tree").setup(opts)
  end
}
