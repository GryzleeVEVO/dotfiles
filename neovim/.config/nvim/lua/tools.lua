return {
  -- LSP
  -- Configuration overrides can be set in the lsp/ directory

  -- Enable LSP for this locally installed servers
  local_servers = {},

  -- LSPs installed with Mason are auto-enabled

  -- FORMATTERS

  -- Formatters per filetype
  formatters = {
    lua = { "stylua" },
  },

  -- LINTERS

  -- Linters without LSP capabilities per filetype
  linters = {},

  -- TREESITTER

  -- Disable this Treesitter parsers completely
  disable_treesitter = {
    "latex", -- Need to complile grammar manually
  },

  -- Disable highlighting for these parsers
  disable_highlight = {
    "csv", -- No rainbow colours :(
  },
}
