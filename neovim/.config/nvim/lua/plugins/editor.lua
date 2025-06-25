return {
  -- Autoclose parentheses, tags, etc...
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {},
  },
  {
    "windwp/nvim-ts-autotag",
    opts = {},
  },
  -- Generate doc comments
  "danymat/neogen",

  opts = {
    snippet_engine = "luasnip",
  },
}
