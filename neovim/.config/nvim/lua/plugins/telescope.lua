return {
  "nvim-telescope/telescope.nvim",

  dependencies = {
    "nvim-lua/plenary.nvim",
  },

  config = function()
    require("telescope").setup({
      defaults = {
        mappings = require("keybinds").telescope_picker_mappings(),
      },

      pickers = {
        find_files = {
          previewer = false,
        },
      },
    })

    require("keybinds").telescope_picker_openers()
  end,
}
