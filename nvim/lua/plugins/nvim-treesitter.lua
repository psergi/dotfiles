return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function() 
    local configs = require("nvim-treesitter.configs")

    configs.setup({
      ensure_installed = {
        "lua",
        "yaml",
        "go",
        "javascript",
        "typescript",
        "vue",
        "json",
        "html",
        "css",
        "scss",
        "diff",
        "ruby",
        "svelte",
        "vim",
        "vimdoc",
        "gotmpl",
        "mermaid"
      },
      sync_install = false,
      highlight = { enable = true },
      indent = {
        enable = true,
        disable = { "ruby", "scss" }
      }
    })
  end
}
