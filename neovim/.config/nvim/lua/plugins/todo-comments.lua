return {
  -- Highlight TODO comments
  "folke/todo-comments.nvim",
  version = "*",

  event = "VimEnter",

  dependencies = {
    "nvim-lua/plenary.nvim",
  },

  opts = {
    signs = false,
  },
}
