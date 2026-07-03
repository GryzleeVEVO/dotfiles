return {
  "stevearc/oil.nvim", -- File explorer

  dependencies = {
    "nvim-web-devicons",
  },

  lazy = false,

  opts = {},

  keys = {
    { "<leader>e", "<cmd>Oil<cr>", desc = "[Oil] Open explorer" },
  },
}
