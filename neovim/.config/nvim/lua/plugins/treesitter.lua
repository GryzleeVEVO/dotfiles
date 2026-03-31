local tools = require("tools")
-- return {
--   enabled = false,
--   "nvim-treesitter/nvim-treesitter", -- Parser
--
--   lazy = false,
--   version = "master",
--   build = ":TSUpdate",
--   main = "nvim-treesitter.configs",
--
--   opts = {
--     auto_install = true,
--     ignore_install = tools.disable_treesitter_parser,
--
--     highlight = {
--       enable = true,
--       disable = tools.disable_treesitter_highlight,
--     },
--
--     indent = {
--       enable = true,
--       disable = tools.disable_treesitter_indent,
--     },
--   },
--
--   init = function()
--     -- Use Treesitter for folding
--     vim.opt.foldmethod = "expr"
--     vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
--     vim.opt.foldcolumn = "0"
--     vim.opt.foldtext = ""
--     vim.opt.foldlevel = 99
--   end,
-- }
--
--

-- return {
--   "nvim-treesitter/nvim-treesitter",
--
--   lazy = false,
--   version = "main",
--   build = ":TSUpdate",
--
--   -- init = function()
--   --   local ts = require("nvim-treesitter")
--   --
--   --   ts.install(tools.treesitter_ensure_installed)
--   --
--   --   -- vim.opt.foldcolumn = "0"
--   --   -- vim.opt.foldtext = ""
--   --   -- vim.opt.foldlevel = 99
--   --   --
--   --   -- vim.api.nvim_create_autocmd("filetype", {
--   --   --   pattern = tools.treesitter_ensure_installed,
--   --   --
--   --   --   callback = function()
--   --   --     vim.treesitter.start()
--   --   --
--   --   --     -- folding
--   --   --     vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
--   --   --     vim.wo[0][0].foldmethod = "expr"
--   --   --
--   --   --     -- indentation
--   --   --     vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
--   --   --   end,
--   --   -- })
--   -- end,
-- }

local function enable_parser(e)
  local ts = require("nvim-treesitter")
  local lang = e.match

  -- Otherwise, the whole buffer will be folded

  local ok, _ = pcall(vim.treesitter.start, e.buf, e.lang)

  if not ok then
    return
  end

  -- -- Folding
  -- vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
  -- vim.wo[0][0].foldmethod = "expr"
  --
  -- -- Indenting
  -- vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
end

return {
  "nvim-treesitter/nvim-treesitter",

  lazy = false,
  build = ":TSUpdate",

  init = function()
    local ts = require("nvim-treesitter")

    ts.install(tools.treesitter_ensure_installed, { summary = false })

    vim.api.nvim_create_autocmd("FileType", {
      group = vim.api.nvim_create_augroup("treesitter_custom", { clear = true }),
      pattern = { "*" },
      callback = enable_parser,
    })

    vim.api.nvim_create_user_command("TSStart", function()
      vim.treesitter.start()

      vim.opt.foldcolumn = "0"
      vim.opt.foldtext = ""
      vim.opt.foldlevel = 99

      -- Folding
      vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
      vim.wo[0][0].foldmethod = "expr"

      -- Indenting
      vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end, {})
  end,
}
