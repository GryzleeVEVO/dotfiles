-- User config file
-- Options grouped when possible

local o = vim.opt
local g = vim.g
local au = vim.api.nvim_create_autocmd
local ag = vim.api.nvim_create_augroup
local cmd = vim.cmd

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
-- o.cursorline = true

-- Highlight columns
o.colorcolumn = { 80, 100, 120 }

-- Show whitespaces
o.list = true
o.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Keep wraps at indent+2. Try not to wrap in the middle of a word
o.breakindent = true
o.breakindentopt = { "shift:2" }
o.linebreak = true

-- Minimum number of lines below or above cursor
o.scrolloff = 10

--------------------------------------------------------------------------------
-- INDENTATION AND FORMATTING

-- New file defaults. Treesitter and guess-indent are better at determining indents
o.tabstop = 4
o.softtabstop = 4
o.shiftwidth = 4
o.expandtab = true

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
    cmd([[%s/\s\+$//e]])
    vim.fn.setpos(".", cursor)
  end,
})

--------------------------------------------------------------------------------
-- SEARCH AND SUBSTITUTION

-- Case-insensitive by default unless search term has caps
o.ignorecase = true
o.smartcase = true

--------------------------------------------------------------------------------
-- SPLITS

-- New split direction
o.splitright = true
o.splitbelow = true

--------------------------------------------------------------------------------
-- YANKING

-- Use system clipboard
o.clipboard = "unnamedplus"

au("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = ag("qol-highlight", { clear = true }),

  callback = function()
    vim.highlight.on_yank()
  end,
})

-- MISC

au({ "BufRead", "BufNewFile" }, {
  desc = "Fix filetype for Docker Compose files",
  group = ag("qol-filetypes", { clear = true }),
  pattern = "*docker-compose*.{yml,yaml}",

  command = "set filetype=yaml.docker-compose",
})
