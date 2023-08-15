local opt = vim.opt

-------------------------------------- options ------------------------------------------
opt.splitright = false
opt.splitbelow = false
opt.wrap = false
opt.ignorecase = false
opt.smartcase = false
opt.autoindent = true

-- go formatting
vim.cmd("autocmd Filetype go setlocal noexpandtab shiftwidth=4 tabstop=4")
vim.cmd("autocmd FileType * if &diff | setlocal ft=diff | endif")
-- fix for ruby indent issue: https://github.com/nvim-treesitter/nvim-treesitter/issues/3363
vim.cmd("autocmd FileType ruby setlocal indentkeys-=.")
-- set jbuilder files as ruby
vim.cmd("autocmd BufNewFile,BufRead *.json.jbuilder set ft=ruby")
-- Disable smart index for ruby
-- vim.cmd("autocmd FileType ruby setlocal smartindent")
-- fix for Shift-Space outputting ;2u in terminal mode: https://github.com/onivim/oni/issues/2342
vim.cmd("tnoremap <S-Space> <Space>")
-- Command to close all other buffers except the current: https://www.rockyourcode.com/vim-close-all-other-buffers/
vim.cmd("command Bo silent! execute '%bdelete|edit #|normal `\"'")
