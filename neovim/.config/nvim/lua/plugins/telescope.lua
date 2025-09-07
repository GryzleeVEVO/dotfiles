return {
  "nvim-telescope/telescope.nvim",

  dependencies = {
    "nvim-lua/plenary.nvim",

    "nvim-telescope/telescope-ui-select.nvim",
  },

  config = function()
    local telescope = require("telescope")

    telescope.setup({
      defaults = {
        mappings = require("keybinds").telescope_picker_mappings(),
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

    require("keybinds").telescope_pickers()
  end,
}
