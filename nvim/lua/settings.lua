local opt = vim.opt

-- Indentation
opt.tabstop = 3
opt.shiftwidth = 3
vim.cmd("filetype plugin indent on")

-- Line Numbers
opt.number = true
opt.relativenumber = true
