-- List of tools: LSP, DAP, linters, formatters, parsers, etc...

return {
  -- List of LSP installed by Mason
  servers = {
    bashls = {},
    docker_compose_language_service = {},
    dockerls = {},
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
    clangd = {
      cmd = { "clangd", "--background-index", "--clang-tidy" },
    },
  },

  -- List of formatters configured by Conform
  formatters = {
    bash = { "shfmt" },
    c = { "clang_format", lsp_format = "never" },
    cpp = { "clang_format", lsp_format = "never" },
    css = { "prettierd" },
    html = { "prettierd" },
    javascript = { "prettierd" },
    javascriptreact = { "prettierd" },
    json = { "prettierd" },
    lua = { "stylua" },
    python = { "autopep8" },
    sh = { "shfmt" },
    typescript = { "prettierd" },
    typescriptreact = { "prettierd" },
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
    "dockerfile",
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
    "yaml",
  },

  -- Linters to be used by nvim-lint
  linters = {
    bash = { "shellcheck" },
    javascript = { "eslint_d" },
    javascriptreact = { "eslint_d" },
    python = { "flake8" },
    typescript = { "eslint_d" },
    typescriptreact = { "eslint_d" },
  },

  -- This linters will not be installed by Mason
  linters_ignore_install = {},
}
