local tools = require("tools")

return {
  {
    "stevearc/conform.nvim",

    event = { "BufWritePre" },
    cmd = { "ConformInfo" },

    opts = {
      formatters_by_ft = tools.formatters,

      default_format_opts = {
        lsp_format = "fallback",
        stop_after_first = true,
      },

      format_on_save = function()
        if vim.g.enable_autoformat then
          return { timeout_ms = 500 }
        end
        return {}
      end,

      notify_on_error = true,
    },
  },
  {
    "NMAC427/guess-indent.nvim",

    opts = {},
  },
}
