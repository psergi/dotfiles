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
vim.lsp.config("tsgo", {
  cmd = { "npx", "tsgo", "--lsp", "--stdio" },
  capabilities = capabilities,
  filetypes = { "typescript", "typescriptreact" },
  root_markers = { "tsconfig.json", "jsconfig.json", "package.json", ".git" },
})
vim.lsp.enable("tsgo")

-- TypeScript OXC
vim.lsp.config("oxlint", {
  cmd = { "npx", "oxlint", "--lsp" },
  capabilities = capabilities,
  filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
  root_markers = { ".oxlintrc.json", "oxlint.config.ts" }
})
vim.lsp.enable("oxlint")
vim.lsp.config("oxfmt", {
  cmd = { "npx", "oxfmt", "--lsp" },
  capabilities = capabilities,
  filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
  root_markers = { ".oxfmtrc.json", ".oxfmtrc.jsonc" },
  on_attach = function(_, bufnr)
    local group = vim.api.nvim_create_augroup("oxfmt-" .. bufnr, { clear = true })
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = group,
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format({
          bufnr = bufnr,
          name = "oxfmt",
          timeout_ms = 3000,
        })
      end,
    })
  end,
})
vim.lsp.enable("oxfmt")

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
