return {
  "nvim-telescope/telescope.nvim",

  dependencies = {
    "nvim-lua/plenary.nvim",
  },

  config = function()
    require("telescope").setup({})
    local builtin = require("telescope.builtin")

    vim.keymap.set({ "n" }, "<leader>f", builtin.find_files, {
      desc = "[Telescope] Find files",
    })
  end,
}
