local tools = require("tools")

return {
  -- Easier autoformatting
  "stevearc/conform.nvim",
  version = "*",

  dependencies = {
    "williamboman/mason.nvim",
    "zapling/mason-conform.nvim",
  },

  event = { "BufWritePre" },
  cmd = { "ConformInfo" },

  config = function()
    require("conform").setup({
      formatters_by_ft = tools.formatters,

      default_format_opts = {
        lsp_format = "fallback",
        stop_after_first = true,
      },

      format_on_save = {
        timeout_ms = 500,
      },

      notify_on_error = true,
    })

    require("mason-conform").setup({
      ignore_install = tools.formaters_ignore_install,
    })
  end,
}
