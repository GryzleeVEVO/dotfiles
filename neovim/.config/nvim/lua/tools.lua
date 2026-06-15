local M = {}

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
  prettierd = { "css", "html", "javascript", "json", "jsx", "typescript" },
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
  "jinja",
  "json",
  "lua",
  "luadoc",
  "markdown",
  "properties",
  "python",
  "sql",
  "vimdoc",
  "xml",
  "yaml",
}

--------------------------------------------------------------------------------

M.mason_ensure_installed = (function(t)
  local res = {}

  for k, v in pairs(t) do
    if type(k) == "number" and type(v) == "string" then
      table.insert(res, v)
    elseif vim.fn.executable(k) == 1 then
      for _, tool in pairs(v) do
        table.insert(res, tool)
      end
    end
  end

  return res
end)(tools)

M.conform_formatters = (function(f)
  local res = {}

  for tool, fts in pairs(f) do
    for _, ft in ipairs(fts) do
      if not res[ft] then
        res[ft] = {}
      end

      table.insert(res[ft], tool)
    end
  end

  return res
end)(formatters)

M.treesitter_ensure_installed = treesitter

return M
