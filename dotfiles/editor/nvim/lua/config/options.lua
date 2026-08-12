vim.g.mapleader = " "
vim.g.maplocalleader = ","

local opt = vim.opt
opt.relativenumber = true
opt.number = true

opt.wrap = false

opt.shiftwidth = 2
opt.tabstop = 2
opt.softtabstop = 2
opt.expandtab = true
opt.updatetime = 250

opt.ignorecase = true
opt.smartcase = true
opt.signcolumn = "yes"
opt.termguicolors = true
opt.splitright = true
opt.splitbelow = true
opt.scrolloff = 8
opt.undofile = true

opt.clipboard = "unnamedplus"
