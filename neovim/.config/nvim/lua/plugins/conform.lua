---@type LazySpec
return {
  -- Detect and run formatters
  "stevearc/conform.nvim",

  event = { "BufWritePre" },
  cmd = { "ConformInfo", "Format" },

  config = function()
    local conform = require("conform")

    conform.setup({
      formatters_by_ft = require("tools").conform_formatters,

      default_format_opts = {
        lsp_format = "fallback",
        stop_after_first = true,
      },

      format_on_save = function()
        if vim.g.autoformat then
          return { timeout_ms = 3000 }
        end
      end,

      notify_on_error = true,
    })

    require("commands").conform()
  end,
}
