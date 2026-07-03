local tools = require("tools")
local util = require("util")

return {
  "nvim-treesitter/nvim-treesitter",

  lazy = false,
  build = ":TSUpdate",

  init = function()
    local ts = require("nvim-treesitter")

    ts.install(tools.treesitter_ensure_installed)

    vim.api.nvim_create_autocmd("FileType", {
      group = vim.api.nvim_create_augroup("treesitter_custom", { clear = true }),
      pattern = { "*" },
      callback = util.enable_parser,
    })

    vim.api.nvim_create_user_command("TSStart", util.enable_parser, {})
  end,
}
