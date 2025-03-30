local tools = require("tools")

return {
  -- Easier autoformatting
  "stevearc/conform.nvim",
  version = "*",

  dependencies = {
    "williamboman/mason.nvim",
  },

  event = { "BufWritePre" },
  cmd = { "ConformInfo" },

  opts = {
    formatters_by_ft = tools.formatters,

    default_format_opts = {
      lsp_format = "fallback",
      stop_after_first = true,
    },

    format_on_save = function()
      -- TODO: Add toggle autoformat
      if vim.g.disable_autoformat then
        return
      end

      return { timeout_ms = 500 }
    end,

    notify_on_error = true,
  },

  init = function()
    vim.g.disable_autoformat = false
  end,
}
