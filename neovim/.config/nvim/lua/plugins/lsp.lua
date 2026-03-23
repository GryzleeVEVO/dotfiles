local tools = require("tools")

return {
  {
    "neovim/nvim-lspconfig", -- Sane defaults for LSPs
  },
  {
    "mason-org/mason.nvim", -- Tooling package manager

    dependencies = {
      "neovim/nvim-lspconfig", -- Load before Mason
      "mason-org/mason-lspconfig.nvim", -- Set up LSPs installed with Mason
      "WhoIsSethDaniel/mason-tool-installer.nvim", -- Auto install from list
    },

    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup({})
      require("mason-tool-installer").setup({
        ensure_installed = tools.mason_ensure_installed,
      })
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
