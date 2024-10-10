-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- Make relative line numbers default
vim.opt.number = true
vim.opt.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = "a"

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
vim.opt.clipboard = "unnamedplus"

-- Keep wrapped lines indented
vim.opt.breakindent = true

-- Save undo history (default: ~/.local/state/nvim/undo)
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Highlight search
vim.opt.hlsearch = true

-- Keep signcolumn on by default
vim.opt.signcolumn = "yes"

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300

-- Always create horizontal splits to the right and vertical splits below
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Render whitespace characters
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Preview substitutions live, as you type!
vim.opt.inccommand = "split"

-- Minimal number of screen lines to keep above and below/right of the cursor.
vim.opt.scrolloff = 10
vim.opt.sidescrolloff = 8

-- Wrap text
vim.opt.wrap = true

--------------------------------------------------------------------------------
-- Visual                                                                      -
--------------------------------------------------------------------------------

-- Rulers at 80, 100 and 120 columns
vim.opt.colorcolumn = "80,100,120"

-- Highlight line your cursor is on
vim.opt.cursorline = true
