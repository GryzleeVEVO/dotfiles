local tools = require("tools")

return {
  "nvim-treesitter/nvim-treesitter", -- Parser

  build = ":TSUpdate",

  main = "nvim-treesitter.configs",
  opts = {
    auto_install = true,
    ignore_install = tools.disable_treesitter_parser,
    highlight = {
      enable = true,
      disable = tools.disable_treesitter_highlight,
    },
    indent = {
      enable = true,
      disable = tools.disable_treesitter_indent,
    },
  },

  init = function()
    -- Use Treesitter for folding
    vim.opt.foldmethod = "expr"
    vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
    vim.opt.foldcolumn = "0"
    vim.opt.foldtext = ""
    vim.opt.foldlevel = 99
  end,
}
