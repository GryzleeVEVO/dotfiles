-- Custom keybindings
local map = vim.keymap.set

-- Disable arrow keys
map({ "n", "v", "i" }, "<left>", "")
map({ "n", "v", "i" }, "<right>", "")
map({ "n", "v", "i" }, "<up>", "")
map({ "n", "v", "i" }, "<down>", "")

-- Clear search with Escape
map("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Use Ctrl-j and Ctrl-k to scroll. CONFLICTS WITH WINDOW CONTROLS
-- map({ "n", "v" }, "<C-j>", "<C-d>")
-- map({ "n", "v" }, "<C-k>", "<C-u>")

-- Better window navigation
map("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
map("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
map("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
map("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

map("n", "<C-q>", "<C-w><C-q>", { desc = "Close window" })
