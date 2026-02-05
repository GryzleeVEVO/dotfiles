return {
  "ellisonleao/gruvbox.nvim",
  priority = 1000,
  opts = {},
  init = function()
    vim.opt.background = "dark"
    vim.cmd("colorscheme gruvbox")
  end,
}
