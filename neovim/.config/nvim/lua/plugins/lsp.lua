-- Download and configure this servers with Mason
local map = vim.keymap.set
local au = vim.api.nvim_create_autocmd
local ag = vim.api.nvim_create_augroup
local tools = require("tools")
local keybinds = require("plugin-keybinds")

local ensure_installed = {}
for k, _ in pairs(tools.servers) do
  ensure_installed[#ensure_installed + 1] = k
end

return {
  {
    -- Install and configure language servers
    "neovim/nvim-lspconfig",
    version = "*",

    dependencies = {
      {
        -- Package manager for LSPs
        "williamboman/mason.nvim",
        version = "*",

        config = true,
      },
      {
        -- Utilities for configued LSPs installed by Mason
        "williamboman/mason-lspconfig.nvim",
        version = "*",
      },
      -- Add LSP completion to cmp
      "hrsh7th/cmp-nvim-lsp",
    },

    config = function()
      local cmp = require("cmp_nvim_lsp")
      local lspconfig = require("lspconfig")
      local attach_ag = ag("lsp-config-attach", { clear = true })
      local capabilities = vim.lsp.protocol.make_client_capabilities()

      -- Let LSP know cmp is available
      capabilities = vim.tbl_deep_extend("force", capabilities, cmp.default_capabilities())

      -- Set up Mason and install missing tools
      require("mason").setup()

      require("mason-lspconfig").setup({
        ensure_installed = ensure_installed,
        automatic_installation = false,
        handlers = {
          function(server)
            local config = tools.servers[server] or {}
            config.capabilities = vim.tbl_deep_extend("force", {}, capabilities, config.capabilities or {})
            lspconfig[server].setup(config)
          end,
        },
      })

      -- Set up local tools
      for server, config in pairs(tools.local_servers) do
        config.capabilities = vim.tbl_deep_extend("force", {}, capabilities, config.capabilities or {})
        lspconfig[server].setup(config)
      end

      -- Setup attach behaviour
      au("LspAttach", {
        group = attach_ag,
        desc = "Configure attached LSP",

        callback = function(event)
          local client = vim.lsp.get_client_by_id(event.data.client_id)

          keybinds.lsp()

          -- Enable reference highlighting
          if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
            local highlight_ag = ag("lsp-config-highlight", { clear = false })
            local detach_ag = ag("lsp-config-detach", { clear = true })

            au({ "CursorHold", "CursorHoldI" }, {
              group = highlight_ag,
              desc = "Highlight references when cursor is on a symbol",
              buffer = event.buf,
              callback = vim.lsp.buf.document_highlight,
            })

            au({ "CursorMoved", "CursorMovedI" }, {
              group = highlight_ag,
              desc = "Clear highlighted references",
              buffer = event.buf,
              callback = vim.lsp.buf.clear_references,
            })

            au("LspDetach", {
              group = detach_ag,
              desc = "Remove reference highlight autogroup from buffer",
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds({
                  group = "lsp-config-highlight",
                  buffer = event2.buf,
                })
              end,
            })
          end

          -- Toggle inlay hints (like field names)
          if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
            map("n", "<leader>th", function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
            end, { desc = "[T]oggle inlay [H]ints" })
          end
        end,
      })
    end,
  },
  {
    -- Lua LSP configuration
    "folke/lazydev.nvim",
    version = "*",

    ft = "lua",

    opts = {
      library = {
        { path = "luvit-meta/library", words = { "vim%.uv" } }, -- Vim's libUV bindings
      },
    },
  },
  {
    "Bilal2453/luvit-meta",
    lazy = true,
  },
}
