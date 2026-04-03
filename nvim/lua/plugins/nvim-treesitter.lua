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
      highlight = {
        enable = true,
        -- Ruby's built-in matchit rules use syntax groups to skip strings/comments.
        -- Keep regex highlighting for Ruby so `%` does not match delimiters inside quotes.
        additional_vim_regex_highlighting = { "ruby" },
      },
      indent = {
        enable = true,
        disable = { "ruby", "scss" }
      }
    })
  end
}
