-- User config file
-- Options grouped when possible

local o = vim.opt
local g = vim.g
local m = vim.keymap.set
local au = vim.api.nvim_create_autocmd
local ag = vim.api.nvim_create_augroup
local c = vim.cmd

--------------------------------------------------------------------------------
-- BASIC

-- Map leader
g.mapleader = " "
g.maplocalleader = " "

-- Enable mouse
o.mouse = "a"

-- Update swap file faster
o.updatetime = 250

-- Faster timeout for ambiguous key sequences
o.timeoutlen = 500

-- Save undo history
o.undofile = true

--------------------------------------------------------------------------------
-- VISUAL

-- Use relative numbers
o.number = true
o.relativenumber = true

-- Draw sign column
o.signcolumn = "yes"

-- Highlight cursor line
o.cursorline = true

-- Highlight columns
o.colorcolumn = { 80, 100, 120 }

-- Show whitespaces
o.list = true
o.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Preserve indentation when wrapping
o.breakindent = true

-- Minimum number of lines below or above cursor
o.scrolloff = 10

--------------------------------------------------------------------------------
-- INDENTATION

-- Treesitter is better at determining how to indent a file and guess-indent
-- at guessing the indentation of the current file
-- Per filetype defaults are provided in after/ftplugin
-- By default, just use 4-wide spaces instead of 8-wide tabs
o.tabstop = 4
o.softtabstop = 4
o.shiftwidth = 4
o.expandtab = true

--------------------------------------------------------------------------------
-- SEARCH AND SUBSTITUTION

-- Case-insensitive by default unless search term has caps
o.ignorecase = true
o.smartcase = true

-- Clear search with Escape
m("n", "<Esc>", "<cmd>nohlsearch<CR>")

--------------------------------------------------------------------------------
-- SPLITS

-- New split direction
o.splitright = true
o.splitbelow = true

m("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
m("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
m("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
m("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

m("n", "<C-q>", "<C-w><C-q>", { desc = "Close window" })

--------------------------------------------------------------------------------
-- YANKING

-- Use system clipboard
o.clipboard = "unnamedplus"

au("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = ag("qol-highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

--------------------------------------------------------------------------------
-- MISC

-- Disable arrow keys
m({ "n", "v" }, "<left>", "")
m({ "n", "v" }, "<right>", "")
m({ "n", "v" }, "<up>", "")
m({ "n", "v" }, "<down>", "")

-- formatoptions is reset by default plugins. Set them back with an autocmd
au("BufEnter", {
  desc = "Don't add comment prefix when pressing Enter on a line with a comment",
  group = ag("qol-no-comment-after-enter", { clear = true }),
  pattern = "",
  command = "set formatoptions-=c formatoptions-=r formatoptions-=o",
})

au("BufWritePre", {
  desc = "Remove trailing whitespace before saving",
  group = ag("qol-format", { clear = true }),
  pattern = "",
  callback = function()
    local cursor = vim.fn.getpos(".")
    c([[%s/\s\+$//e]])
    vim.fn.setpos(".", cursor)
  end,
})

-- vim: tabstop=2 softtabstop=2 shiftwidth=2 expandtab
