local tools = require("tools")
local lsp = vim.lsp

return {
  {
    -- From 0.11, nvim-lspconfig is only a repository with sensible default
    -- configs
    "neovim/nvim-lspconfig",

    config = function()
      -- Enable local servers. The configuration is the merger of lspconfig's
      -- config and the ones in the lsp directory
      for _, server in ipairs(tools.local_lsp_servers) do
        lsp.enable(server)
      end
    end,
  },
  {
    -- Tooling package manager. Yes, we are pulling a package manager with a
    -- package manager that can install package managers
    "mason-org/mason.nvim",

    dependencies = {
      "mason-org/mason-lspconfig.nvim",
      "neovim/nvim-lspconfig",
    },

    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup()
    end,
  },
  {
    -- Support for Neovim API for LuaLS
    "folke/lazydev.nvim",

    ft = "lua",

    opts = {
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
}
