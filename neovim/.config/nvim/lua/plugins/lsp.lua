local tools = require("tools")
local lsp = vim.lsp

return {
  {
    "neovim/nvim-lspconfig", -- Sane defaults for LSPs

    config = function()
      -- Enable LSPs that are not handled by mason
      for _, server in ipairs(tools.local_lsp_servers) do
        lsp.enable(server)
      end
    end,
  },
  {
    "mason-org/mason.nvim", -- Tooling package manager

    dependencies = {
      "mason-org/mason-lspconfig.nvim", -- Automatically set up tools installed with Mason
      "neovim/nvim-lspconfig", -- Load before Mason
    },

    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup()
    end,
  },
  {
    "folke/lazydev.nvim", -- Support for nvim lua API

    ft = "lua",

    opts = {
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
}
