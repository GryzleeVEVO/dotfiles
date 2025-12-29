return {
  -- Status bar
  "nvim-lualine/lualine.nvim",

  dependencies = {
    "nvim-tree/nvim-web-devicons", -- Dependency
  },

  opts = {
    options = {
      component_separators = "",
      section_separators = { left = "", right = "" },
    },

    sections = {
      lualine_a = { { "mode", separator = { left = "" }, right_padding = 2 } },
      lualine_b = { "filename" },
      lualine_c = { "branch", "diff" },
      lualine_x = { "diagnostics", "lsp_status" },
      lualine_y = { "filetype", "progress" },
      lualine_z = { { "location", separator = { right = "" }, left_padding = 2 } },
    },
  },
}
