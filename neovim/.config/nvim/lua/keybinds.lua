local M = {}

local map = vim.keymap.set
local g = vim.g
local au = vim.api.nvim_create_autocmd
local ag = vim.api.nvim_create_augroup

g.mapleader = " "
g.localmapleader = " "

--- MOVEMENT ---

-- Disable arrows
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

-- Make j/k respect wrapped lines, instead of moving to the next real line.
-- Changeable with :ToggleWrappedLinesHandling
-- Ignored when a count is provided
map({ "n", "v" }, "j", function()
  if vim.g.wrapped_lines_jk and vim.v.count == 0 then
    return "gj"
  end
  return "j"
end, {
  expr = true,
  desc = "[Custom] Move one wrapped line down",
})

map({ "n", "v" }, "k", function()
  if vim.g.wrapped_lines_jk and vim.v.count == 0 then
    return "gk"
  end
  return "k"
end, {
  expr = true,
  desc = "[Custom] Move one wrapped line up",
})

--- Editing ---

-- Keep the selection when indenting a block of text
map({ "v" }, "<", "<gv", {
  desc = "[Custom] Keep selection when indenting",
})
map({ "v" }, ">", ">gv", {
  desc = "[Custom] Keep selection when indenting",
})

-- Use to Ctrl+j/k to move an entire block of text up and down while keeping
-- it selected
map({ "v" }, "<c-j>", ":m '>+1<CR>gv=gv", {
  desc = "[Custom] Move entire selection",
})
map({ "v" }, "<c-k>", ":m '<-2<CR>gv=gv", {
  desc = "[Custom] Move entire selection",
})

-- Use H and L to move to the beggining or end of a line
map({ "n", "v" }, "H", "^", {
  desc = "[Custom] Move to first non-blank character",
})
map({ "n", "v" }, "L", "g_", {
  desc = "[Custom] Move to first non-blank character",
})

-- Pasting prefixing leader key does not oveewrite paste register
map("x", "<leader>p", '"_dp', {
  desc = "Paste without overwriting paste register",
  noremap = true,
})
map("x", "<leader>P", '"_dP', {
  desc = "Paste without overwriting paste register",
  noremap = true,
})

--- Visual ---

-- Clear highlight with Escape key
map({ "n" }, "<Esc>", "<cmd>nohlsearch<CR>", {
  desc = "[Custom] Clear search highlight",
})

--- Misc ---

-- Disable macros key
map({ "n", "v" }, "q", "<nop>", {
  desc = "[Custom] Disable macros and cmdline history",
})

-- Close windows
map("n", "<C-q>", "<C-w><C-q>", {
  desc = "[Custom] Close window",
})

-- When an LSP is attached, add this keybinds
M.lsp_keybinds_setup = function(ev)
  local builtin = require("telescope.builtin")

  -- Default grn
  map({ "n" }, "<F2>", vim.lsp.buf.rename, {
    buffer = ev.buf,
    desc = "[LSP] Rename",
  })

  -- Default gra
  map({ "n", "x" }, "<leader>a", vim.lsp.buf.code_action, {
    buffer = ev.buf,
    desc = "[LSP] Code Action",
  })

  -- Default Ctrl-W+d
  map({ "n", "x" }, "<leader>d", vim.diagnostic.open_float, {
    desc = "[LSP] Show diagnostic pop-up",
  })

  map({ "n" }, "gd", builtin.lsp_definitions, {
    desc = "[LSP] Go to definition",
  })
end

return M
