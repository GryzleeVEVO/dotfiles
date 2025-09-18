return {
  {
    "EdenEast/nightfox.nvim", -- Colorscheme

    init = function()
      vim.opt.termguicolors = true
      vim.opt.background = "dark"
      vim.cmd([[colorscheme carbonfox]])
    end,
  },
  {
    "lukas-reineke/indent-blankline.nvim", -- Indentation marks

    main = "ibl",
    opts = {},
  },
  {
    "nvim-lualine/lualine.nvim", -- Status bar

    dependencies = {
      "nvim-tree/nvim-web-devicons", -- Dependency
    },

    opts = {},
  },
  {
    "j-hui/fidget.nvim", --  Notifications

    opts = {},
  },
  {
    "MeanderingProgrammer/render-markdown.nvim", -- Markdown pretty printing

    ft = "markdown",

    dependencies = {
      "nvim-treesitter/nvim-treesitter", -- Dependency
      "nvim-tree/nvim-web-devicons", -- Dependency
    },

    opts = {},
  },
  {
    "lewis6991/gitsigns.nvim", -- Git icons

    opts = {},
  },
  {
    "folke/todo-comments.nvim", -- Highlight TODO comments

    dependencies = {
      "nvim-lua/plenary.nvim", -- Dependency
    },

    opts = {},
  },
  {
    "akinsho/bufferline.nvim", -- Show opened buffers like tabs

    version = "*",

    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },

    opts = {},
  },
}
