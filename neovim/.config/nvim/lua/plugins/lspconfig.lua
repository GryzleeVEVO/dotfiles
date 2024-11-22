return {
  {
    -- Install and configure language servers
    "neovim/nvim-lspconfig",

    dependencies = {
      {
        "williamboman/mason.nvim", -- Mason is a package manager for LSPs
        config = true,
      },
      "williamboman/mason-lspconfig.nvim", -- Utilities for configued LSPs installed by Mason
      "hrsh7th/cmp-nvim-lsp", -- Add LSP completion to cmp
    },

    config = function()
      local cmp = require("cmp_nvim_lsp")
      local lspconfig = require("lspconfig")
      local mason = require("mason")
      local mason_lsp = require("mason-lspconfig")
      local m = vim.keymap.set
      local au = vim.api.nvim_create_autocmd
      local ag = vim.api.nvim_create_augroup
      local attach_ag = ag("lsp-config-attach", { clear = true })

      -- Install and configure this servers and tools on startup:
      local servers = {
        clangd = {},
        lua_ls = {},
      }

      au("LspAttach", {
        group = attach_ag,
        desc = "Configure attached LSP",

        callback = function(event)
          local telescope = require("telescope.builtin")
          local client = vim.lsp.get_client_by_id(event.data.client_id)

          -- Setup keymaps
          m("n", "gd", telescope.lsp_definitions, { desc = "[G]oto [D]efinition" })
          m("n", "gr", telescope.lsp_references, { desc = "[G]oto [R]eferences" })
          m("n", "gI", telescope.lsp_implementations, { desc = "[G]oto [I]mplementation" })
          m("n", "<leader>D", telescope.lsp_type_definitions, { desc = "Type [D]efinition" })
          m("n", "<leader>ds", telescope.lsp_document_symbols, { desc = "[D]ocument [S]ymbols" })
          m("n", "<leader>ws", telescope.lsp_dynamic_workspace_symbols, { desc = "[W]orkspace [S]ymbols" })
          m("n", "<leader>rn", vim.lsp.buf.rename, { desc = "[R]e[n]ame" })
          m({ "n", "x" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "[C]ode [A]ction" })
          m("n", "gD", vim.lsp.buf.declaration, { desc = "[G]oto [D]eclaration" })

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
            m("n", "<leader>th", function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
            end, { desc = "[T]oggle inlay [H]ints" })
          end
        end,
      })

      -- Let LSP know cmp is available
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend("force", capabilities, cmp.default_capabilities())

      -- Configure Mason and install missing tools
      mason.setup()
      mason_lsp.setup({
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
            lspconfig[server_name].setup(server)
          end,
        },
      })
    end,
  },
  {
    -- Lua LSP configuration
    "folke/lazydev.nvim",

    ft = "lua",
    opts = {
      library = {
        { path = "luvit-meta/library", words = { "vim%.uv" } }, -- Vim's libUV bindings
      },
    },
  },
  { "Bilal2453/luvit-meta", lazy = true },
}
-- vim: tabstop=2 softtabstop=2 shiftwidth=2 expandtab
