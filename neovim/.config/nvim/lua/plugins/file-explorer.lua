local keybinds = require("plugin-keybinds")

return {
  "nvim-neo-tree/neo-tree.nvim",
  version = "*",

  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },

  event = "VimEnter",

  config = function()
    require("neo-tree").setup({
      filesystem = {
        hijack_netrw_behavior = "open_current",
      },
    })

    keybinds.neotree()
  end,
}
