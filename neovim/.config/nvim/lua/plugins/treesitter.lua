return {
  -- Text parser. Better syntax highlighting, indentation, code navigation...
  "nvim-treesitter/nvim-treesitter",
  -- version = "*",

  build = ":TSUpdate",
  main = "nvim-treesitter.configs", -- Call setup on this module

  opts = {
    ensure_installed = require("tools").parsers,

    auto_install = true,

    highlight = {
      enable = true,
    },

    indent = {
      enable = true,
    },
  },

  init = function()
    -- Use Treesitter to determine what to fold
    vim.opt.foldmethod = "expr"
    vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"

    -- Don't show folds column. indent-blankline does it inline
    vim.opt.foldcolumn = "0"

    -- Keep syntax highlighting
    vim.opt.foldtext = ""

    -- Don't autofold on open
    vim.opt.foldlevel = 99

    vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
      desc = "Disable treesitter highlighting for CSV files",
      group = vim.api.nvim_create_augroup("qol-filetypes", { clear = true }),

      callback = function(event)
        if vim.bo[event.buf].filetype == "csv" then
          vim.cmd([[:TSBufDisable highlight]])
        end
      end,
    })
  end,
}
