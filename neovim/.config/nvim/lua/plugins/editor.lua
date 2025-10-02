return {
  {
    "windwp/nvim-autopairs", -- Autopair characters

    event = "InsertEnter",
    opts = {},
  },
  {
    "windwp/nvim-ts-autotag", -- Autopair tags

    opts = {},
  },
  {
    "kylechui/nvim-surround", -- Add, delete or change matching pairs

    opts = {},
  },
  {
    "danymat/neogen", -- Generate documentation

    opts = {
      snippet_engine = "luasnip",
    },
  },
  {
    "mbbill/undotree",

    keys = {
      { "<leader>u", "<cmd>UndotreeToggle<cr>", desc = "[undotree] Toggle undo tree" },
    },

    cmd = {
      "UndotreeFocus",
      "UndotreeHide",
      "UndotreePersistUndo",
      "UndotreeShow",
      "UndotreeToggle",
    },
  },
}
