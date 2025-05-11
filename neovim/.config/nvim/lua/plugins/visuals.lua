return {{
  "rebelot/kanagawa.nvim",

  priority = 1000,

  opts = {
    dimInactive = true,
  },

  init = function()
    vim.opt.termguicolors = true
    vim.opt.background = "dark"
    vim.cmd([[ colorscheme kanagawa-dragon ]])
  end,
},
  {
    "lukas-reineke/indent-blankline.nvim",

    main = "ibl",
    opts = {},
  },
  {
    "nvim-lualine/lualine.nvim",

    dependencies = {
      "nvim-tree/nvim-web-devicons"
    },

    opts = {}
  },
  {
    "j-hui/fidget.nvim",

    opts = {}
  },
}
