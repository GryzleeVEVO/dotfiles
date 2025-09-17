local map = vim.keymap.set
local g = vim.g
local au = vim.api.nvim_create_autocmd
local ag = vim.api.nvim_create_augroup

g.mapleader = " "
g.localmapleader = " "

map({ "n", "v", "i" }, "<left>", "", { desc = "Disable arrows" })
map({ "n", "v", "i" }, "<right>", "", { desc = "Disable arrows" })
map({ "n", "v", "i" }, "<up>", "", { desc = "Disable arrows" })
map({ "n", "v", "i" }, "<down>", "", { desc = "Disable arrows" })

map("n", "<Esc>", "<cmd>nohlsearch<CR>", {
  desc = "Clear search highlight",
})

map("n", "<C-q>", "<C-w><C-q>", { desc = "Close window" })

-- map({ "n", "v" }, "<leader>d", [["_d]], { desc = "Delete without yanking" })
-- map({ "n", "v" }, "<leader>p", [["_dP]], { desc = "Paste without yanking" })

-- When an LSP is attached, add this keybinds
local lsp_gr = ag("lsp-attach-keybinds", { clear = true })

au({ "LspAttach" }, {
  desc = "Set up keybindings after attaching an LSP",
  group = lsp_gr,
  callback = function(ev)
    local builtin = require("telescope.builtin")

    map({ "n" }, "<F2>", vim.lsp.buf.rename, {
      buffer = ev.buf,
      desc = "[LSP] Rename",
    })

    map({ "n", "x" }, "<leader>a", vim.lsp.buf.code_action, {
      buffer = ev.buf,
      desc = "[LSP] Code Action",
    })

    map({ "n", "x" }, "<leader>d", vim.diagnostic.open_float, {
      desc = "[LSP] Show diagnostic pop-up",
    })

    map({ "n" }, "gd", builtin.lsp_definitions, {
      desc = "[LSP] Go to definition",
    })
  end,
})
