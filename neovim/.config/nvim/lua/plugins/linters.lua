local tools = require("tools")
local keybinds = require("plugin-keybinds")

return {
  -- Linting support, including for no LSP-based ones
  "mfussenegger/nvim-lint",

  dependencies = {
    "williamboman/mason.nvim",
    -- "rshkarin/mason-nvim-lint",
  },

  events = { "BufEnter" },

  config = function()
    local lint = require("lint")
    lint.linters_by_ft = tools.linters

    -- FIXME: Don't auto install linters
    -- require("mason-nvim-lint").setup({
    --   ignore_install = tools.linters_ignore_install,
    -- })

    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost" }, {
      desc = "Run linter for current filetype when opening it",

      callback = function()
        lint.try_lint()
      end,
    })

    keybinds.nvim_lint()
  end,
}
