-- Use this formatters
local formatters = {
  bash = { "shfmt" },
  c = { "clang_format", lsp_format = "never" },
  cpp = { "clang_format", lsp_format = "never" },
  lua = { "stylua" },
  javascript = { "prettierd", "prettier" },
  json = { "prettierd", "prettier" },
  sh = { "shfmt" },
  typescript = { "prettierd", "prettier" },
  zsh = { "shfmt" },
}

-- Don't automatically install this formatters
local ignore_install = {
  "clang_format",
}

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

  keys = {
    {
      "<leader>f",
      function()
        require("conform").format({ async = true })
      end,
      mode = "",
      desc = "[F]ormat buffer",
    },
  },

  config = function()
    require("conform").setup({
      formatters_by_ft = formatters,

      default_format_opts = {
        lsp_format = "fallback",
        stop_after_first = true,
      },

      format_on_save = {
        timeout_ms = 500,
      },

      notify_on_error = true,
    })

    require("mason-conform").setup({ ignore_install = ignore_install })
  end,
}
