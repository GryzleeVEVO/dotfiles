local keybinds = require("keybinds")

return {

  "nvim-telescope/telescope.nvim", -- Search and pick menu

  dependencies = {
    "nvim-lua/plenary.nvim", -- Depenency
    "nvim-telescope/telescope-ui-select.nvim", -- Use Telescope UI for some native actions
  },

  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")

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
        diagnostics = {
          previewer = false,
          theme = "ivy",
        },
      },

      extensions = {
        ["ui-select"] = require("telescope.themes").get_dropdown({}),
      },
    })

    telescope.load_extension("ui-select")

    keybinds.telescope_keybinds()
  end,
}
