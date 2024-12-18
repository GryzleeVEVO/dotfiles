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
    local builtin = require("telescope.builtin")
    local actions = require("telescope.actions")
    local m = vim.keymap.set

    telescope.setup({
      defaults = {
        mappings = {
          n = {
            ["<Down>"] = actions.nop,
            ["<Up>"] = actions.nop,
            ["<Left>"] = actions.nop,
            ["<Right>"] = actions.nop,
          },
          i = {
            ["<Down>"] = actions.nop,
            ["<Up>"] = actions.nop,
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
          },
        },

        -- Ignore this directories
        file_ignore_patterns = {
          ".git/",
        },
      },

      extensions = {
        ["ui-select"] = {
          themes.get_dropdown(),
        },
      },

      pickers = {
        find_files = {
          hidden = true,
        },
      },
    })

    -- Enable Telescope extensions if they are installed
    pcall(telescope.load_extension, "fzf")
    pcall(telescope.load_extension, "ui-select")

    -- See `:help telescope.builtin`
    m("n", "<leader>f", builtin.find_files, { desc = "Search [F]iles" })
    --m("n", "<leader>ss", builtin.builtin, { desc = "Search [S]elect Telescope" })
    --m("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
    --m("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
    m("n", "<leader>d", builtin.diagnostics, { desc = "Search [D]iagnostics" })
    --m("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
    --m("n", "<leader>s.", builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
    m("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })

    -- m("n", "<leader>/", function()
    --   builtin.current_buffer_fuzzy_find(themes.get_dropdown({
    --     winblend = 10,
    --     previewer = false,
    --   }))
    -- end, { desc = "[/] Fuzzily search in current buffer" })

    -- m("n", "<leader>s/", function()
    --   builtin.live_grep({
    --     grep_open_files = true,
    --     prompt_title = "Live Grep in Open Files",
    --   })
    -- end, { desc = "[S]earch [/] in Open Files" })
  end,
}
