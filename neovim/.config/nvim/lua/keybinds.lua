local map = vim.keymap.set
local g = vim.g

g.mapleader = " "
g.localmapleader = " "

map({ "n", "v", "i" }, "<left>", "", { desc = "Disable arrows" })
map({ "n", "v", "i" }, "<right>", "", { desc = "Disable arrows" })
map({ "n", "v", "i" }, "<up>", "", { desc = "Disable arrows" })
map({ "n", "v", "i" }, "<down>", "", { desc = "Disable arrows" })

map("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })

map("n", "<C-q>", "<C-w><C-q>", { desc = "Close window" })
