-- List of tools: LSP, DAP, linters, formatters, parsers, etc...

return {
  -- List of LSP installed by Mason
  servers = {
    bashls = {},
    gopls = {},
    html = {},
    java_language_server = {},
    jsonls = {},
    lua_ls = {},
    pyright = {},
    ts_ls = {},
  },

  -- List of LSP *not* installed by Mason
  local_servers = {
    clangd = {},
  },

  -- List of formatters configured by Conform
  formatters = {
    bash = { "shfmt" },
    c = { "clang_format", lsp_format = "never" },
    cpp = { "clang_format", lsp_format = "never" },
    html = { "prettierd", "prettier" },
    css = { "prettierd", "prettier" },
    lua = { "stylua" },
    javascript = { "prettierd", "prettier" },
    json = { "prettierd", "prettier" },
    sh = { "shfmt" },
    typescript = { "prettierd", "prettier" },
    zsh = { "shfmt" },
  },

  -- This formatters will not be installed by Mason
  formatters_ignore_install = {
    "clang_format",
  },

  -- Parsers to be installed for Treesitter
  parsers = {
    "bash",
    "c",
    "cpp",
    "css",
    "csv",
    "html",
    "java",
    "javascript",
    "jsdoc",
    "lua",
    "luadoc",
    "luap",
    "make",
    "python",
    "typescript",
  },

  -- Linters to be used by nvim-lint
  linters = {
    typescript = { "eslint_d" },
    bash = { "shellcheck" },
  },

  -- This linters will not be installed by Mason
  linters_ignore_install = {},
}
