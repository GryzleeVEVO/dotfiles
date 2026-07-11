---@type LazySpec
return {
  {
    -- Sane defaults for LSPs
    "neovim/nvim-lspconfig",
  },
  {
    -- Tooling package manager
    "mason-org/mason.nvim",

    dependencies = {
      -- Load before Mason
      "neovim/nvim-lspconfig",

      -- Set up LSPs installed with Mason
      "mason-org/mason-lspconfig.nvim",

      -- Auto install from list
      "WhoIsSethDaniel/mason-tool-installer.nvim",
    },

    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup({})
      require("mason-tool-installer").setup({
        ensure_installed = require("tools").mason_ensure_installed,
      })
    end,
  },
  {
    -- Support for nvim lua API
    "folke/lazydev.nvim",

    ft = "lua",

    opts = {
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
}
