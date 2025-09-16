return {
  {
    -- Autoclose parentheses, tags, etc...
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {},
  },
  {
    "windwp/nvim-ts-autotag",
    opts = {},
  },
  {
    -- Generate documentation
    "danymat/neogen",

    opts = {
      snippet_engine = "luasnip",
    },
  },
  {
    "kylechui/nvim-surround",

    opts = {},
  },
}
