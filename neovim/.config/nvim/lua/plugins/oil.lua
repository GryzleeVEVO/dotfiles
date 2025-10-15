return {
  "stevearc/oil.nvim",

  dependencies = {
    "nvim-web-devicons",
  },

  lazy = false,

  config = function()
    local oil = require("oil")
    oil.setup({})

    vim.keymap.set({ "n" }, "<leader>e", "<cmd>:Oil<CR>", { desc = "[Oil] Open explorer" })
  end,
}
