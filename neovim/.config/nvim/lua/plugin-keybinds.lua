-- A centralized place for plugin-specific keybinds
local map = vim.keymap.set
local buf = vim.lsp.buf

return {
  -- Keymaps for cmp's drop-down menu
  cmp_menu = function()
    local mapping = require("cmp").mapping

    return mapping.preset.insert({
      ["<C-j>"] = mapping.select_next_item(),
      ["<C-n>"] = mapping.select_next_item(),

      ["<C-k>"] = mapping.select_prev_item(),
      ["<C-p>"] = mapping.select_prev_item(),

      ["<C-b>"] = mapping.scroll_docs(-4),
      ["<C-f>"] = mapping.scroll_docs(4),

      ["<C-y>"] = mapping.confirm({ select = true }),
      ["<Enter>"] = mapping.confirm({ select = true }),

      -- Open completions menu
      ["<C-Space>"] = mapping.complete({}),
    })
  end,

  neotree = function()
    map("n", "<leader>e", "<cmd>Neotree toggle<CR>", {
      desc = "Open [e]xplorer",
      silent = true,
    })

    map("n", "<leader>E", "<cmd>Neotree toggle current <CR>", {
      desc = "Open [E]xplorer on current window",
      silent = true,
    })
  end,

  nvim_lint = function()
    local lint = require("lint")

    map("n", "<leader>l", lint.try_lint, {
      desc = "Run [l]inter",
    })
  end,

  -- LSP related keybindings
  lsp = function()
    local builtin = require("telescope.builtin")

    map("n", "gd", builtin.lsp_definitions, {
      desc = "[G]oto [D]efinition",
    })

    map("n", "gr", builtin.lsp_references, {
      desc = "[G]oto [R]eferences",
    })

    map("n", "gI", builtin.lsp_implementations, {
      desc = "[G]oto [I]mplementation",
    })

    map("n", "<leader>D", builtin.lsp_type_definitions, {
      desc = "Goto Type [D]efinition",
    })

    map("n", "<leader>ds", builtin.lsp_document_symbols, {
      desc = "[D]ocument [S]ymbols",
    })

    map("n", "<leader>ws", builtin.lsp_dynamic_workspace_symbols, {
      desc = "[W]orkspace [S]ymbols",
    })

    map("n", "<C-p>", builtin.lsp_dynamic_workspace_symbols, {
      desc = "[W]orkspace [S]ymbols",
    })

    map("n", "<leader>d", vim.diagnostic.open_float, {
      desc = "Show [D]iagnostic message",
    })

    map("n", "<leader>rn", buf.rename, {
      desc = "[R]e[n]ame",
    })

    map("n", "<F2>", buf.rename, {
      desc = "[R]e[n]ame",
    })

    map({ "n", "x" }, "<leader>ca", buf.code_action, {
      desc = "[C]ode [A]ction",
    })

    map({ "n", "x" }, "<leader>a", buf.code_action, {
      desc = "[C]ode [A]ction",
    })
  end,

  -- Keybinings that open telescope pickers
  telescope = function()
    local builtin = require("telescope.builtin")

    map("n", "<leader>f", function()
      if os.execute("git rev-parse --is-inside-work-tree") == 0 then
        builtin.git_files()
      else
        builtin.find_files()
      end
    end, {
      desc = "Search [f]iles",
    })

    map("n", "<leader>F", function()
      builtin.find_files({ hidden = true })
    end, { desc = "Search all [F]iles" })

    map("n", "<leader>sb", builtin.buffers, {
      desc = "[S]earch active [B]uffers",
    })

    map("n", "<leader>sw", builtin.grep_string, {
      desc = "[S]earch current [W]ord",
    })

    map("n", "<leader>sg", builtin.live_grep, {
      desc = "[S]earch by [G]rep",
    })

    map("n", "<leader>sd", builtin.diagnostics, {
      desc = "Search [D]iagnostics",
    })

    map("n", "<leader>sd", builtin.diagnostics, {
      desc = "[S]earch [D]iagnostics",
    })

    map("n", "<leader>sk", builtin.keymaps, {
      desc = "[S]earch [K]eymaps",
    })

    map("n", "<leader>ss", builtin.builtin, {
      desc = "[SS] Select Telescope picker",
    })
  end,

  telescope_menu = function()
    local actions = require("telescope.actions")

    return {
      n = {
        ["<Down>"] = actions.nop,
        ["<Up>"] = actions.nop,
        ["<Left>"] = actions.nop,
        ["<Right>"] = actions.nop,

        ["<C-y>"] = actions.select_default,
      },
      i = {
        ["<Down>"] = actions.nop,
        ["<Up>"] = actions.nop,

        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-y>"] = actions.select_default,
      },
    }
  end,
}
