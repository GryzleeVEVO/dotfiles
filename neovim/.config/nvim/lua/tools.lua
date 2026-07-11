local M = {}

local util = require("util")

-- List of tools to be installed automatically by Mason
local tools = {
  "docker_language_server",
  "lua_ls",
  "pgformatter",
  "shellcheck",
  "stylua",
  "systemd_lsp",
  npm = {
    "ansiblels",
    "bashls",
    "json-lsp",
    "prettierd",
  },
  python = {
    "autopep8",
    "basedpyright",
    "ruff",
  },
  cargo = {
    "jinja-lsp",
  },
}

-- List of formatters with their associated filetype
local formatters = {
  autopep8 = { "python" },
  pg_format = { "sql" },
  prettierd = { "css", "html", "javascript", "javascriptreact", "json", "typescript", "typescriptreact" },
  ruff = { "python" },
  shfmt = { "sh", "bash", "zsh" },
}

-- List of parsers to install
local treesitter = {
  "bash",
  "cpp",
  "csv",
  "erlang",
  "git_config",
  "ini",
  "javascript",
  "jinja",
  "json",
  "jsx",
  "lua",
  "luadoc",
  "markdown",
  "properties",
  "python",
  "sql",
  "tsx",
  "typescript",
  "vimdoc",
  "xml",
  "yaml",
}

-- TODO: Create treesitter exclude list

--------------------------------------------------------------------------------

M.mason_ensure_installed = util.create_mason_install_list(tools)

M.conform_formatters = util.create_conform_formatter_list(formatters)

M.treesitter_ensure_installed = treesitter

return M
