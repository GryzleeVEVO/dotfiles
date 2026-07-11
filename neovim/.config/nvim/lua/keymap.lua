local M = {}

local map = vim.keymap.set
local g = vim.g

-- Use the spacebar as a leader key
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

-- Unless disabled, j/k should behave like gj/gk
map({ "n", "v" }, "j", function()
  if vim.g.up_down_display_lines and vim.v.count == 0 then
    return "gj"
  end
  return "j"
end, {
  expr = true,
  desc = "[Custom] Move one wrapped line down",
})

map({ "n", "v" }, "k", function()
  if vim.g.up_down_display_lines and vim.v.count == 0 then
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

-- Use H and L to move to the beginning or end of a line
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

--- Set up keybinds on LSP attach
---@param ev vim.api.keyset.create_autocmd.callback_args event
M.lsp = function(ev)
  local builtin = require("telescope.builtin")

  -- F2 to rename, default grn
  map({ "n" }, "<F2>", vim.lsp.buf.rename, {
    buffer = ev.buf,
    desc = "[LSP] Rename",
  })

  -- <leader>a to open code actions, default gra
  map({ "n", "x" }, "<leader>a", vim.lsp.buf.code_action, {
    buffer = ev.buf,
    desc = "[LSP] Code Action",
  })

  -- <leader>d to open  default Ctrl-W+d
  map({ "n", "x" }, "<leader>d", vim.diagnostic.open_float, {
    buffer = ev.buf,
    desc = "[LSP] Show diagnostic pop-up",
  })

  map({ "n" }, "gd", builtin.lsp_definitions, {
    buffer = ev.buf,
    desc = "[LSP] Go to definition",
  })

  map({ "n" }, "<leader>s", builtin.lsp_document_symbols, {
    buffer = ev.buf,
    desc = "[Telescope] Current document symbols",
  })

  map({ "n" }, "<leader>S", builtin.lsp_dynamic_workspace_symbols, {
    buffer = ev.buf,
    desc = "[Telescope] Workspace symbols",
  })
end

--- PLUGINS ---

--- Set up keymap for blink.cmp
---@type blink.cmp.KeymapConfig
M.blink = {
  preset = "default",

  -- Use j/k to select items
  ["<C-j>"] = { "select_next", "fallback" },
  ["<C-k>"] = { "select_prev", "fallback" },
}

-- Set up keymap for Neogen
---@type LazyKeysSpec[]
M.neogen = {
  {
    "<leader>c",
    function()
      require("neogen").generate()
    end,
    desc = "[Neogen] Generate comment",
  },
}

--- Set up keymap for oil.nvim
---@type LazyKeysSpec[]
M.oil = {
  {
    "<leader>e",
    "<cmd>Oil<cr>",
    desc = "[Oil] Open explorer",
  },
}

--- Set up keymap for Telescope's menu
---@return table
M.telescope_actions = function()
  local actions = require("telescope.actions")
  return {
    i = {
      ["<C-j>"] = actions.move_selection_next,
      ["<C-k>"] = actions.move_selection_previous,
      ["<C-y>"] = actions.select_default,
    },
  }
end

--- Set up keymap for Telescope pickers
---@return LazyKeysSpec[]
M.telescope_pickers = function()
  local builtin = require("telescope.builtin")

  return {
    {
      "<leader>f",
      builtin.find_files,
      desc = "[Telescope] Show open buffers",
    },
    {
      "<leader>b",
      builtin.buffers,
      desc = "[Telescope] Show open buffers",
    },
    {
      "<leader>/",
      builtin.live_grep,
      desc = "[Telescope] Find string in workspace",
    },
    {
      "<leader>H",
      builtin.help_tags,
      desc = "[Telescope] Find help tag",
    },
    {
      "<leader>D",
      builtin.diagnostics,
      desc = "[Telescope] Diagnostics",
    },
  }
end

--- Set up keymaps for undotree
---@type LazyKeysSpec[]
M.undotree = {
  {
    "<leader>u",
    "<cmd>UndotreeToggle<cr>",
    desc = "[undotree] Toggle undo tree",
  },
}

--- Set up keybinds for which-key
---@return LazyKeysSpec[]
M.which_key = function()
  return {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "[Which-key] Open",
    },
  }
end

return M
