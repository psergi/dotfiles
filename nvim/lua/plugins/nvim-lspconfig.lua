return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
  },
  config = function()
    local lspconfig = require("lspconfig")
    local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

    -- Ruby
    lspconfig.ruby_lsp.setup({
      cmd = { "ruby-lsp" },
      capabilities = lsp_capabilities,
      filetypes = { "ruby" },
      root_dir = lspconfig.util.root_pattern(".git"),
      init_options = {
        addonSettings = {
          ["Ruby LSP Rails"] = {
            enablePendingMigrationsPrompt = false,
          },
        },
      }
    })

    -- TypeScript
    lspconfig.ts_ls.setup({
      cmd = { "npx", "typescript-language-server", "--stdio" },
      capabilities = lsp_capabilities,
      filetypes = { "typescript", "typescriptreact" },
      init_options = {
        preferences = {
          jsxAttributeCompletionStyle = "auto",
          quotePreference = "double",
        }
      }
    })

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
