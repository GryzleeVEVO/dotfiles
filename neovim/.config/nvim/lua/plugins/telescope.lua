local function setKeymaps()
  local builtin = require("telescope.builtin")
  local map = vim.keymap.set

  -- Files
  map("n", "<leader>sf", function()
    if os.execute("git rev-parse --is-inside-work-tree") == 0 then
      builtin.git_files()
    else
      builtin.find_files()
    end
  end, { desc = "[S]earch [F]iles" })

  map("n", "<leader>sF", function()
    builtin.find_files({ hidden = true })
  end, { desc = "[S]earch all [F]iles" })

  -- Buffers
  map("n", "<leader>sb", builtin.buffers, { desc = "[S]earch active [B]uffers" })

  -- Grep search
  map("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
  map("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })

  -- Diagnostics
  map("n", "<leader>d", builtin.diagnostics, { desc = "Search [D]iagnostics" })
  map("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
  -- <leader>D: Show diagnostics message

  -- Keymaps
  map("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })

  map("n", "<leader>ss", builtin.builtin, { desc = "[SS] Select Telescope picker" })
end

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
    local actions = require("telescope.actions")

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

    setKeymaps()
  end,
}
