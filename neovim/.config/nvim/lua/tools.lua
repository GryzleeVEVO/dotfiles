local M = {}

-- List of tools to be installed automatically by Mason
local tools = {
  "lua_ls",
  "stylua",
  npm = {
    "ansiblels",
    "bashls",
    "prettierd",
  },
  python = {
    "autopep8",
    "basedpyright",
  },
}

-- List of formatters with their associated filetype
local formatters = {
  autopep8 = { "python" },
  prettierd = { "css", "html", "javascript", "json", "jsx", "typescript" },
  shfmt = { "bash", "zsh " },
}

-- List of parsers to install
local treesitter = {
  "jinja",
  "jinja_inline",
  "lua",
  "luadoc",
  "vimdoc",
  "yaml",
}

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
