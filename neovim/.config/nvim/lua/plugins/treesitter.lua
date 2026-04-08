local tools = require("tools")

local function enable_parser(e)
  -- local ok, _ = pcall(vim.treesitter.start, e.buf)
  local ok, _ = pcall(vim.treesitter.start)

  if not ok then
    return
  end

  vim.opt.foldcolumn = "0"
  vim.opt.foldtext = ""
  vim.opt.foldlevel = 99

  -- Folding
  vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
  vim.wo[0][0].foldmethod = "expr"

  -- Indenting
  vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
end

return {
  "nvim-treesitter/nvim-treesitter",

  commit = "f8bbc31",
  lazy = false,
  build = ":TSUpdate",

  init = function()
    local ts = require("nvim-treesitter")

    ts.install(tools.treesitter_ensure_installed)

    vim.api.nvim_create_autocmd("FileType", {
      group = vim.api.nvim_create_augroup("treesitter_custom", { clear = true }),
      pattern = { "*" },
      callback = enable_parser,
    })

    vim.api.nvim_create_user_command("TSStart", enable_parser, {})
  end,
}
