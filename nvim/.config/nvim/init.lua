require('plugins')

vim.cmd.set('termguicolors')                           -- Use 256-color terminal
vim.cmd.colorscheme(color or 'ayu-mirage')             -- Colorscheme
vim.cmd([[highlight Normal ctermbg=none guibg=none]])  -- Transparency
vim.cmd([[highlight NonText ctermbg=none guibg=none]]) --

vim.cmd.set('mouse=a')                                 -- Enable mouse
vim.cmd.set('clipboard+=unnamedplus')                  -- Use system clipboard

vim.cmd.set('encoding=utf-8')                          -- Encoding
vim.cmd.set('fileformat=unix')                         -- Use LF

vim.cmd.set('tabstop=4')                               -- 4 space tabs
vim.cmd.set('shiftwidth=4')                            --
vim.cmd.set('softtabstop=4')                           --
vim.cmd.set('expandtab')                               --
vim.cmd.set('autoindent')                              --

vim.cmd.set('relativenumber')                          -- Numbering relative to current line

-- REMAPS
vim.keymap.set('', '<Up>', '<nop>', { noremap = true, silent = true })    -- Disable arrow keys
vim.keymap.set('', '<Down>', '<nop>', { noremap = true, silent = true })  --
vim.keymap.set('', '<Left>', '<nop>', { noremap = true, silent = true })  --
vim.keymap.set('', '<Right>', '<nop>', { noremap = true, silent = true }) --
