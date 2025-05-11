local o = vim.opt

-- Enable mouse
o.mouse = "a"

-- Use system clipboard as copy register
o.clipboard = "unnamedplus"

-- Update swap file more frequently
o.updatetime = 250

-- Time out for key sequence that can be continued
-- (e.g. if <space>k and <space>km are both valid keybinds, <space>k will be run only after the timeout expires
o.timeoutlen = 500

-- Save undo history across sessions
o.undofile = true

-- Show relative numbers to the current line, which shows the absolute line number
o.number = true
o.relativenumber = true

-- Always draw sign column (column left of the numbers, where diagnostic icons are shown)
o.signcolumn = "yes"

-- Draw ruler columns
o.colorcolumn = { 80, 100, 120 }

-- Draw whitespaces
o.list = true
o.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Keep wrapped lines indented.
o.breakindent = true
o.breakindentopt = { "shift:2" }

-- Try not to break words when wrapping
o.linebreak = true

-- Scrolling limits
o.scrolloff = 10
o.sidescrolloff = 10

-- Set window title
o.title = true

-- Case-insensitive search UNLESS term has caps
o.ignorecase = true
o.smartcase = true

-- Always split right and below
o.splitright = true
o.splitbelow = true
