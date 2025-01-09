local tools = require("tools")
local keybinds = require("plugin-keybinds")

return {
  -- Linting support, including for no LSP-based ones
  "mfussenegger/nvim-lint",

  dependencies = {
    "williamboman/mason.nvim",
    "rshkarin/mason-nvim-lint",
  },

  config = function()
    local lint = require("lint")
    lint.linters_by_ft = tools.linters

    require("mason-nvim-lint").setup({
      ignore_install = tools.linters_ignore_install,
    })

    vim.api.nvim_create_autocmd("BufWritePost", {
      desc = "Run linter for current filetye",

      callback = function()
        lint.try_lint()
      end,
    })

    keybinds.nvim_lint()
  end,
}
