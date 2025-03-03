-- disable netrw (built-in file explorer)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- enable 24-bit colour
vim.opt.termguicolors = true

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
