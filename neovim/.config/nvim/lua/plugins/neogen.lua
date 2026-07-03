return {
  "danymat/neogen", -- Generate documentation

  cmd = { "Neogen" },

  keys = {
    {
      "<leader>c",
      function()
        require("neogen").generate()
      end,
      { desc = "[Neogen] Generate comment" },
    },
  },

  opts = {
    snippet_engine = "luasnip",
  },
}
