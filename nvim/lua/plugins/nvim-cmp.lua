-- this is a WIP, see here: https://lsp-zero.netlify.app/docs/tutorial.html
return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-nvim-lsp-signature-help"
  },
  config = function()
    local cmp = require("cmp")

    cmp.setup({
      mapping = cmp.mapping.preset.insert({
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<CR>"] = cmp.mapping.confirm({
          behavior = cmp.ConfirmBehavior.Insert,
          select = true
        }),
        ["<Tab>"] = cmp.mapping.confirm({
          behavior = cmp.ConfirmBehavior.Insert,
          select = true
        })
      }),
      sources = {
        { name = "nvim_lsp" },
        { name = "nvim_lsp_signature_help" }
      },
      completion = {
        autocomplete = false
      }
    })
  end
}
