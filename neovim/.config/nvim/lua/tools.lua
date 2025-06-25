return {
  -- Local LSP servers to be enabled (those installed by Mason get enabled on start)
  local_lsp_servers = {},

  -- Formatters per filetype
  conform_formatters = {
    bash = { "shfmt" },
    css = { "prettierd" },
    html = { "prettierd" },
    javascript = { "prettierd" },
    json = { "prettierd" },
    jsx = { "prettierd" },
    lua = { "stylua" },
    python = { "autopep8" },
    sh = { "shfmt" },
    typescript = { "prettierd" },
    xml = { "xmlformatter" },
    yaml = { "prettierd" },
    zsh = { "shfmt" },
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
