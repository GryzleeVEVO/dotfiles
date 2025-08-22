return {
  -- {
  --   -- Color scheme
  --   "rebelot/kanagawa.nvim",
  --
  --   priority = 1000,
  --
  --   opts = {
  --     dimInactive = true,
  --   },
  --
  --   init = function()
  --     vim.opt.termguicolors = true
  --     vim.opt.background = "dark"
  --     vim.cmd([[ colorscheme kanagawa-dragon ]])
  --   end,
  -- },
  -- {
  --   "navarasu/onedark.nvim",
  --
  --   priority = 1000,
  --
  --   config = function()
  --     require("onedark").setup({
  --       style = "darker",
  --     })
  --     require("onedark").load()
  --   end,
  -- },
  {
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
    "folke/todo-comments.nvim",

    event = "VimEnter",

    dependencies = {
      "nvim-lua/plenary.nvim",
    },

    opts = {},
  },
}
