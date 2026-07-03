local tools = require("tools")
local util = require("util")

return {
  "stevearc/conform.nvim", -- Detect and run formatters

  event = { "BufWritePre" },
  cmd = { "ConformInfo", "Format" },

  config = function()
    local conform = require("conform")

    conform.setup({
      formatters_by_ft = tools.conform_formatters,

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

    vim.api.nvim_create_user_command("Format", util.format, {
      desc = "Format buffer",
      range = true,
    })
  end,
}
