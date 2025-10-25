-- Setup leader keys
vim.g.mapleader = "\\"
vim.g.maplocalleader = "\\\\"

default_opts = { noremap = true, silent = true }

-- NvimTree
vim.keymap.set("n", "<C-n>", ":NvimTreeToggle<CR>", default_opts)

-- Telescope
vim.keymap.set("n", "<C-p>", ":Telescope find_files<CR>", default_opts)
vim.keymap.set("n", "<C-l>", ":Telescope live_grep_args<CR>", default_opts)
vim.keymap.set("n", "<C-o>", ":Telescope buffers<CR>", default_opts)
vim.keymap.set("n", "<D-p>", ":Telescope find_files<CR>", default_opts)
vim.keymap.set("n", "<D-l>", ":Telescope live_grep_args<CR>", default_opts)
vim.keymap.set("n", "<D-o>", ":Telescope buffers<CR>", default_opts)

-- Vim Test
vim.keymap.set("n", "<leader>s", ":TestNearest<CR>", default_opts)
vim.keymap.set("n", "<leader>t", ":TestFile<CR>", default_opts)
vim.keymap.set("n", "<leader>a", ":TestSuite<CR>", default_opts)

-- ALE
vim.keymap.set("n", "<leader>f", ":ALEFix<CR>", default_opts)

-- Clear search when hitting escape
vim.keymap.set("n", "<Esc>", ":nohlsearch<CR>", default_opts)

-- Alternate file
vim.keymap.set("n", "<C-a>", "<C-^>", default_opts)

-- CMD+C copy to clipboard selected text in visual mode
vim.keymap.set("v", "<leader>c", '"+y')
vim.keymap.set("v", "<D-c>", '"+y')

-- ToggleTerm
-- see open_mapping within toggleterm.lua
