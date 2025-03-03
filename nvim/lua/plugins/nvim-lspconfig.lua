return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
  },
  config = function()
    local lspconfig = require("lspconfig")
    local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

    -- TypeScript
    lspconfig.ts_ls.setup({
      capabilities = lsp_capabilities,
      init_options = {
        preferences = {
          jsxAttributeCompletionStyle = "auto",
          quotePreference = "double",
        }
      }
    });

    -- Go
    lspconfig.gopls.setup({
      cmd = { "gopls" },
      filetypes = { "go", "gomod", "gowork", "gotmpl" },
      root_dir = lspconfig.util.root_pattern("go.work", "go.mod", ".git"),
      settings = {
        gopls = {
          gofumpt = true
        }
      }
    })
  end
}
