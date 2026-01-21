return {
  -- Colorscheme
  "EdenEast/nightfox.nvim",

  enabled = false,

  opts = {
    options = {
      styles = {
        comments = "italic",
      },
    },
  },

  init = function()
    vim.opt.termguicolors = true
    vim.opt.background = "dark"
    vim.cmd([[colorscheme carbonfox]])
  end,
}
