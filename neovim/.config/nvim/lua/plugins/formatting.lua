local tools = require("tools")

return {
  {
    "stevearc/conform.nvim",

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
          if vim.g.enable_autoformat then
            return { timeout_ms = 500 }
          end
        end,

        notify_on_error = true,
      })

      vim.api.nvim_create_user_command("Format", function(args)
        local range = nil

        if args.count ~= -1 then
          local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
          range = {
            start = { args.line1, 0 },
            ["end"] = { args.line2, end_line:len() },
          }
        end

        conform.format({ async = true, range = range })
      end, { range = true })
    end,
  },
  {
    "NMAC427/guess-indent.nvim",

    opts = {},
  },
}
