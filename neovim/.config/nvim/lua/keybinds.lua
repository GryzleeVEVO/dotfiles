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
local lsp_gr = ag("lsp-attach-keybinds", { clear = true })

au({ "LspAttach" }, {
  desc = "Set up keybindings after attaching an LSP",
  group = lsp_gr,
  callback = function(ev)
    local builtin = require("telescope.builtin")
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    local inlayHintSupported = client
      and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint, ev.buf)

    -- Default: grn
    map({ "n" }, "<F2>", vim.lsp.buf.rename, {
      buffer = ev.buf,
      desc = "[LSP] Rename",
    })

    -- Default: gra
    map({ "n", "x" }, "<leader>a", vim.lsp.buf.code_action, {
      buffer = ev.buf,
      desc = "[LSP] Code Action",
    })

    -- Default: <C-w>d
    map({ "n", "x" }, "<leader>d", vim.diagnostic.open_float, {
      desc = "[LSP] Show diagnostic pop-up",
    })

    map({ "n" }, "<leader>D", builtin.diagnostics, {
      desc = "[LSP] Diagnostics list",
    })

    -- Default: grn
    map({ "n" }, "gd", builtin.lsp_definitions, {
      desc = "[LSP] Go to definition",
    })

    map({ "n" }, "gD", vim.lsp.buf.declaration, {
      desc = "[LSP] Go to declaration",
    })

    -- Default: grr
    map({ "n" }, "gR", builtin.lsp_references, {
      desc = "[LSP] Show references",
    })

    map({ "n" }, "gi", builtin.lsp_implementations, {
      desc = "[LSP] Go to implementation",
    })

    -- Default: gO
    map({ "n" }, "<leader>s", builtin.lsp_document_symbols, {
      desc = "[LSP] Document symbols",
    })

    map({ "n" }, "<leader>S", builtin.lsp_dynamic_workspace_symbols, {
      desc = "[LSP] Workspace symbols symbols",
    })

    if inlayHintSupported then
      map({ "n" }, "<leader>th", function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = ev.buf }))
      end, {
        desc = "[LSP] Toggle inlay hints",
      })
    end
  end,
})

-- Plugin-specific keybinds
return {
  blink = {
    preset = "default",

    ["<C-j>"] = { "select_next", "fallback" },
    ["<C-k>"] = { "select_prev", "fallback" },
  },

  nvim_tree = function()
    local api = require("nvim-tree.api")
    vim.keymap.set({ "n" }, "<leader>e", api.tree.toggle, { desc = "Toggle side explorer" })
  end,

  telescope_picker_mappings = function()
    local actions = require("telescope.actions")

    return {
      i = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-y>"] = actions.select_default,
      },
    }
  end,

  telescope_picker_openers = function()
    local builtin = require("telescope.builtin")

    vim.keymap.set({ "n" }, "<leader>f", builtin.find_files, {
      desc = "[Telescope] Find files",
    })

    vim.keymap.set({ "n" }, "<leader>F", function()
      builtin.find_files({ hidden = true })
    end, {
      desc = "[Telescope] Find files (including hidden)",
    })

    vim.keymap.set({ "n" }, "<leader>gl", builtin.git_commits, {
      desc = "[Telescope] Git log",
    })

    vim.keymap.set({ "n" }, "<leader>gb", builtin.git_branches, {
      desc = "[Telescope] Git branches",
    })

    vim.keymap.set({ "n" }, "<leader>gd", builtin.git_status, {
      desc = "[Telescope] Git status diff",
    })
  end,
}
