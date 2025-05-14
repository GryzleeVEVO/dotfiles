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

map("n", "<C-q>", "<C-w><C-q>", {
  desc = "Close window",
})

-- When an LSP is attached, add this keybinds
local lsp_gr = ag("user-lsp-attach", { clear = true })

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

    map({ "n" }, "<leader>D", builtin.diagnostics, {
      desc = "[LSP] Diagnostics list",
    })

    map({ "n" }, "gd", builtin.lsp_definitions, {
      desc = "[LSP] Go to definition",
    })

    map({ "n" }, "gD", vim.lsp.buf.declaration, {
      desc = "[LSP] Go to declaration",
    })

    map({ "n" }, "gr", builtin.lsp_references, {
      desc = "[LSP] Show references",
    })

    map({ "n" }, "gi", builtin.lsp_implementations, {
      desc = "[LSP] Go to implementation",
    })

    map({ "n" }, "<leader>s", builtin.lsp_document_symbols, {
      desc = "[LSP] Document symbols",
    })
  end,
})
