-- disable netrw (built-in file explorer)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- enable 24-bit colour
if vim.env.COLORTERM == "truecolor" or vim.env.COLORTERM == "24bit" then
  vim.opt.termguicolors = true
end

-- enable line number and relative line number
vim.opt.number = true

-- width of a tab
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.softtabstop = 2

-- use number of spaces to insert a <Tab>
vim.opt.expandtab = true

-- Enable signcolumn always so Ale doesn't shift it
vim.opt.signcolumn = "yes"

-- Enable code folding based on treesitter
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldlevelstart = 99

-- Disable wrapping
vim.opt.wrap = false

-- Diagnostics
vim.diagnostic.config({
  virtual_text = false,  -- inline text
  signs = true,         -- gutter icons
  underline = true,
  update_in_insert = false,
  severity_sort = true
})

-- Show floating message on hover
vim.o.updatetime = 300
vim.cmd [[autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })]]

-- Format comments correctly
vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function()
    local cs = vim.bo.commentstring
    if cs and not cs:find(" %%s") then
      vim.bo.commentstring = cs:gsub("%%s", " %%s")
    end
  end,
})

-- TypeScript gf use telescope
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
  callback = function()
    vim.keymap.set("n", "gf", function()
      vim.lsp.buf.type_definition()
    end, { buffer = true })
    -- vim.keymap.set("n", "gf", "<cmd>Telescope lsp_type_definitions<CR>", { buffer = true })
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "typescript", "typescriptreact", "javascript", "javascriptreact", "ruby" },
  callback = function()
    vim.keymap.set("n", "gd", function()
      vim.lsp.buf.definition()
    end, { buffer = true })
    -- vim.keymap.set("n", "gf", "<cmd>Telescope lsp_type_definitions<CR>", { buffer = true })
  end,
})
