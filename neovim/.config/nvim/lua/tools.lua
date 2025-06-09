return {
  -- Local LSP servers to be enabled (those installed by Mason get enabled on start)
  local_lsp_servers = {},

  -- Formatters per filetype
  conform_formatters = {
    sh = { "shfmt" },
    bash = { "shfmt" },

    json = { "prettierd" },

    lua = { "stylua" },

    python = { "autopep8" },

    xml = { "xmlformatter" },
  },

  -- Non LSP linters to be registered for nvim-lint
  linters = {},

  -- Disable this Treesitter parsers completely
  disable_treesitter_parser = {
    "latex", -- Need to complile grammar manually
  },

  -- Disable highlighting for these Treesitter parsers
  disable_treesitter_highlight = {
    "csv", -- No rainbow colours :(
  },
}
