-- List of tools: LSP, DAP, linters, formatters, parsers, etc...

-- NOTE: Check out this plugin for conditionally downloading tools
-- https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim

-- Most of these tools can be installed through Mason, a package manager for
-- tooling. This tools can also be installed manually.
return {
  ------------------------------------------------------------------------------
  -- LSP                                                                       -
  ------------------------------------------------------------------------------
  -- LSP's are attached by nvim-lspconfig. They offer code analysis and
  -- autocompletion (handled through nvim-cmp)
  --
  -- Check lua/plugins/lsp.lua for details

  -- List of LSP's to configure
  servers = {
    bashls = {},
    clangd = {
      cmd = { "clangd", "--background-index", "--clang-tidy" },
    },
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

  -- Don't set up this servers automatically
  local_servers = {
    "clangd",
  },

  ------------------------------------------------------------------------------
  -- Formatters                                                                -
  ------------------------------------------------------------------------------
  -- Formatters are used by conform.nvim.
  -- Chech lua/plugins/formatters.lua for details

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

  ------------------------------------------------------------------------------
  -- Parsers                                                                   -
  ------------------------------------------------------------------------------
  -- Parsers are used by nvim-treesitter
  -- Chech lua/plugins/treesitter.lua for details

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
    "json",
    "lua",
    "luadoc",
    "luap",
    "make",
    "python",
    "typescript",
    "yaml",
  },

  ------------------------------------------------------------------------------
  -- Linters                                                                   -
  ------------------------------------------------------------------------------
  -- Linters are used by nvim-lint
  -- Chech lua/plugins/linters.lua for details

  -- List of linters to be run in order by filetype
  linters = {
    bash = { "shellcheck" },
    javascript = { "eslint_d" },
    javascriptreact = { "eslint_d" },
    python = { "flake8" },
    typescript = { "eslint_d" },
    typescriptreact = { "eslint_d" },
  },
}
