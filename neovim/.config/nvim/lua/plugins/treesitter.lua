return {
  -- Text parser. Better syntax highlighting, indentation, code navigation...
  "nvim-treesitter/nvim-treesitter",

  build = ":TSUpdate",
  main = "nvim-treesitter.configs", -- Call setup on this module

  opts = {
    ensure_installed = {
      "bash",
      "c",
      "cpp",
      "css",
      "csv",
      "html",
      "java",
      "javascript",
      "lua",
      "luadoc",
      "luap",
      "make",
      "python",
      "typescript",
    },

    auto_install = true,

    highlight = {
      enable = true,
    },

    indent = {
      enable = true,
    },
  },

  init = function()
    -- FOLDING
    -- Use Treesitter to determine what to fold
    vim.opt.foldmethod = "expr"
    vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
    -- Don't show folds column. indent-blankline does it inline
    vim.opt.foldcolumn = "0"
    -- Keep syntax highlighting
    vim.opt.foldtext = ""
    -- Don't autofold on open
    vim.opt.foldlevel = 99
  end,
}

-- vim: tabstop=2 softtabstop=2 shiftwidth=2 expandtab
