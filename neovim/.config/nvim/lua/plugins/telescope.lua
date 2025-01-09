local keybinds = require("plugin-keybinds")

return {
  -- Fuzzy Finder
  "nvim-telescope/telescope.nvim",
  version = "*",

  dependencies = {
    "nvim-lua/plenary.nvim",

    {
      "nvim-telescope/telescope-fzf-native.nvim",

      build = "make",
      cond = function()
        return vim.fn.executable("make") == 1
      end,
    },

    "nvim-telescope/telescope-ui-select.nvim",
    "nvim-tree/nvim-web-devicons",
  },

  event = "VimEnter",

  config = function()
    local telescope = require("telescope")
    local themes = require("telescope.themes")

    telescope.setup({
      defaults = {
        mappings = keybinds.telescope_menu(),
      },

      extensions = {
        ["ui-select"] = {
          themes.get_dropdown(),
        },
      },

      pickers = {
        git_files = {
          show_untracked = true,
        },
      },
    })

    -- Enable Telescope extensions if they are installed
    pcall(telescope.load_extension, "fzf")
    pcall(telescope.load_extension, "ui-select")

    keybinds.telescope()
  end,
}
