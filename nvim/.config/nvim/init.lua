-- OPTIONS

-- THEME
--vim.o.termguicolors  = true

-- SYSTEM
vim.o.mouse          = "a"
vim.o.clipboard      = "unnamedplus"

-- INDENTATION
vim.o.expandtab      = true
vim.o.smarttab       = true

vim.tabstop          = 4
vim.softtabstop      = -1
vim.shiftwidth       = 4

vim.o.autoindent     = true
vim.o.cindent        = true

-- SEARCH
vim.o.hlsearch       = true
vim.o.incsearch      = true
vim.o.wildmode       = "longest,list,full"

-- WINDOW
vim.o.splitright     = true
vim.o.splibelow      = true

-- VISUAL
vim.o.relativenumber = true
vim.o.numberwidth    = 2
vim.o.wrap           = false
vim.o.cursorline     = true
vim.o.scrolloff      = 8
vim.o.list           = true
vim.setlaststatus    = 2
