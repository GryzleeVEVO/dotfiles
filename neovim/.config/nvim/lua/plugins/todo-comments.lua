return {
  -- Highlight TODO comments
  "folke/todo-comments.nvim",
  version = "*",

  event = "BufEnter",

  dependencies = {
    "nvim-lua/plenary.nvim",
  },

  opts = {
    signs = false,
  },
}
