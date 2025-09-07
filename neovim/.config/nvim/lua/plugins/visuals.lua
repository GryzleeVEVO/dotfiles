return {
  {
    -- Colorscheme
    "EdenEast/nightfox.nvim",

    init = function()
      vim.opt.termguicolors = true
      vim.opt.background = "dark"
      vim.cmd([[colorscheme carbonfox]])
    end,
  },
  {
    -- Show indentation marks
    "lukas-reineke/indent-blankline.nvim",

    main = "ibl",
    opts = {},
  },
  {
    -- Fancy status bar
    "nvim-lualine/lualine.nvim",

    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },

    opts = {},
  },
  {
    -- Show notifications on bottom right
    "j-hui/fidget.nvim",

    opts = {},
  },
  {
    -- Fancier Markdown documents
    "MeanderingProgrammer/render-markdown.nvim",

    ft = "markdown",

    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },

    opts = {},
  },
  {
    -- Show git diff in gutter
    "lewis6991/gitsigns.nvim",

    opts = {},
  },
  {
    -- To-do comments. Duh.
    "folke/todo-comments.nvim",

    event = "VimEnter",

    dependencies = {
      "nvim-lua/plenary.nvim",
    },

    opts = {},
  },
}
