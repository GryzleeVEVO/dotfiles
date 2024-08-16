return {
  -- Color scheme
  "ellisonleao/gruvbox.nvim",

  priority = 1000,
  config = true,

  opts = ...,

  init = function()
    vim.o.background = "dark"
    vim.cmd.colorscheme("gruvbox")
  end
}
