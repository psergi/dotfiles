local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Common config options
vim.lsp.config("*", {
  root_markers = { ".git" }
})

-- Ruby
vim.lsp.config("ruby_lsp", {
  cmd = { "ruby-lsp" },
  capabilities = capabilities,
  filetypes = { "ruby" },
  init_options = {
    addonSettings = {
      ["Ruby LSP Rails"] = {
        enablePendingMigrationsPrompt = false
      }
    }
  }
})
vim.lsp.enable("ruby_lsp")

-- TypeScript
vim.lsp.config("ts_ls", {
  cmd = { "npx", "typescript-language-server", "--stdio" },
  capabilities = capabilities,
  filetypes = { "typescript", "typescriptreact" },
  init_options = {
    preferences = {
      jsxAttributeCompletionStyle = "auto",
      quotePreference = "double"
    }
  }
})
vim.lsp.enable("ts_ls")

-- Go
vim.lsp.config("gopls", {
  cmd = { "gopls" },
  capabilities = capabilities,
  filetypes = { "go", "gomod", "gowork", "gotmpl" },
  settings = {
    gopls = {
      gofumpt = true
    }
  }
})
vim.lsp.enable("gopls")
