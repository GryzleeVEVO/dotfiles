---@type LazySpec
return {
  -- Picker menus
  "nvim-telescope/telescope.nvim",

  dependencies = {
    -- Depenency
    "nvim-lua/plenary.nvim",

    -- Use Telescope UI for some native actions
    "nvim-telescope/telescope-ui-select.nvim",
  },

  keys = require("keymap").telescope_pickers(),

  config = function()
    local telescope = require("telescope")

    telescope.setup({
      defaults = {
        mappings = require("keymap").telescope_actions(),
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
  end,
}
