---@type LazySpec
return {
  -- Generate documentation
  "danymat/neogen",

  cmd = { "Neogen" },

  keys = require("keymap").neogen,

  opts = {
    snippet_engine = "luasnip",
  },
}
