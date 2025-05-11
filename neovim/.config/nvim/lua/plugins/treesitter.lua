local tools = require("tools")

return {
  "nvim-treesitter/nvim-treesitter",

  build = ":TSUpdate",

  main = "nvim-treesitter.configs",
  opts = {
    auto_install = true,
    ignore_install = tools.disable_treesitter,
    highlight = {
      enable = true,
      disable = tools.disable_highlight,
    },
    indent = { enable = true },
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
