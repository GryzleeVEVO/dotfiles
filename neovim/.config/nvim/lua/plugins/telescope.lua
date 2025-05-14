return {
  "nvim-telescope/telescope.nvim",

  dependencies = {
    "nvim-lua/plenary.nvim",
  },

  config = function()
    local actions = require("telescope.actions")

    require("telescope").setup({
      defaults = {
        mappings = {
          i = {
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-y>"] = actions.select_default,
          },
        },
      },

      pickers = {
        find_files = {
          previewer = false,
        },
      },
    })
    local builtin = require("telescope.builtin")

    vim.keymap.set({ "n" }, "<leader>f", builtin.find_files, {
      desc = "[Telescope] Find files",
    })

    vim.keymap.set({ "n" }, "<leader>gl", builtin.git_commits, {
      desc = "[Telescope] Git log",
    })

    vim.keymap.set({ "n" }, "<leader>gb", builtin.git_branches, {
      desc = "[Telescope] Git branches",
    })

    vim.keymap.set({ "n" }, "<leader>gd", builtin.git_status, {
      desc = "[Telescope] Git status diff",
    })
  end,
}
