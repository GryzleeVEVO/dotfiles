local map = vim.keymap.set
local g = vim.g
local au = vim.api.nvim_create_autocmd
local ag = vim.api.nvim_create_augroup

g.mapleader = " "
g.localmapleader = " "

map({ "n", "v", "i" }, "<left>", "<nop>", {
  desc = "[Custom] Disable arrows",
})
map({ "n", "v", "i" }, "<right>", "<nop>", {
  desc = "[Custom] Disable arrows",
})
map({ "n", "v", "i" }, "<up>", "<nop>", {
  desc = "[Custom] Disable arrows",
})
map({ "n", "v", "i" }, "<down>", "<nop>", {
  desc = "[Custom] Disable arrows",
})

map({ "n", "v" }, "k", "v:count == 0 ? 'gk' : 'k'", {
  expr = true,
  desc = "[Custom] Move up one line even if wrapped, ignore if count provided",
})
map({ "n", "v" }, "j", "v:count == 0 ? 'gj' : 'j'", {
  expr = true,
  desc = "[Custom] Move up one line even if wrapped, ignore if count provided",
})

map({ "n", "v" }, "H", "^", {
  desc = "[Custom] Move to first non-blank character",
})
map({ "n", "v" }, "L", "g_", {
  desc = "[Custom] Move to first non-blank character",
})

map({ "n", "v" }, "q", "<nop>", {
  desc = "[Custom] Disable macros and cmdline history",
})

map({ "n" }, "<Esc>", "<cmd>nohlsearch<CR>", {
  desc = "[Custom] Clear search highlight",
})

map("n", "<C-q>", "<C-w><C-q>", {
  desc = "[Custom] Close window",
})

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
