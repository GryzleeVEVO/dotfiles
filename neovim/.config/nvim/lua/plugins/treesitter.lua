---@type LazySpec
return {
  -- Parser and AST generator. Better syntax, indenting, etc...
  "nvim-treesitter/nvim-treesitter",

  lazy = false,
  build = ":TSUpdate",

  init = function()
    local ts = require("nvim-treesitter")

    ts.install(require("tools").treesitter_ensure_installed)
    require("commands").treesitter()
    require("autocmds").treesitter()
  end,
}
