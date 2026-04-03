return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    local languages = {
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
      "mermaid",
    }

    -- Install parsers and queries for supported languages
    require("nvim-treesitter").install(languages)

    -- Enable highlighting for supported languages
    vim.api.nvim_create_autocmd("FileType", {
      pattern = languages,
      callback = function(args)
        vim.treesitter.start(args.buf)

        -- `vim.treesitter.start()` disables regex syntax highlighting by
        -- default. Ruby's built-in matchit rules rely on legacy syntax groups
        -- to skip strings/comments when matching `do` / `end`.
        if args.match == "ruby" then
          vim.bo[args.buf].syntax = "ON"
        end
      end
    })
  end
}
