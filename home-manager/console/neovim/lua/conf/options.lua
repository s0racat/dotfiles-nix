-- Make line numbers default
vim.wo.number = true

-- Enable mouse mode
vim.o.mouse = "a"

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.o.clipboard = "unnamedplus"

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = "yes"

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = "menuone,noselect"

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

vim.o.hlsearch = true

vim.o.confirm = true

vim.o.scrolloff = 8

vim.o.sidescrolloff = 16

vim.o.sidescroll = 1
vim.o.cmdheight = 0
vim.g.mapleader = " "
vim.g.maplocalleader = " "
-- expandtab オプションを設定します。タブ文字をスペースに変換します。
vim.opt.expandtab = true

-- tabstop オプションを設定します。タブ文字の幅を4スペースに設定します。
vim.opt.tabstop = 4

-- softtabstop オプションを設定します。インサートモードでのタブの幅を4スペースに設定します。
vim.opt.softtabstop = 4

-- shiftwidth オプションを設定します。インデントに使用するスペースの幅を4スペースに設定します。
vim.opt.shiftwidth = 4
