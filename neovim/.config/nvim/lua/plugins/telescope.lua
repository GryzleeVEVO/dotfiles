return {
  "nvim-telescope/telescope.nvim", -- Search and pick menu

  dependencies = {
    "nvim-lua/plenary.nvim", -- Depenency
    "nvim-telescope/telescope-ui-select.nvim", -- Use Telescope UI for some native actions
  },

  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")
    local builtin = require("telescope.builtin")

    telescope.setup({
      defaults = {
        mappings = {
          i = {
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-y>"] = actions.select_default,
          },
        },
      },

      pickers = {
        find_files = {
          previewer = false,
        },
      },

      extensions = {
        ["ui-select"] = require("telescope.themes").get_dropdown({}),
      },
    })

    telescope.load_extension("ui-select")

    vim.keymap.set({ "n" }, "<leader>f", builtin.find_files, { desc = "[Telescope] Find files" })

    vim.keymap.set({ "n" }, "<leader>/", builtin.live_grep, { desc = "[Telescope] Find string" })

    vim.keymap.set(
      { "n" },
      "<leader>s",
      builtin.lsp_document_symbols,
      { desc = "[Telescope] Show current document symbols" }
    )

    vim.keymap.set(
      { "n" },
      "<leader>S",
      builtin.lsp_dynamic_workspace_symbols,
      { desc = "[Telescope] Show workspace symbols" }
    )
  end,
}
