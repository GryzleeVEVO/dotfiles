local map = vim.keymap.set
local au = vim.api.nvim_create_autocmd
local ag = vim.api.nvim_create_augroup
local tools = require("tools")
local keybinds = require("plugin-keybinds")

--- Register a new LSP server
---
--- @param server string Name of server
local function registerLsp(server)
  local lsp = require('lspconfig')
  local cmp = require("cmp_nvim_lsp")

  -- Let LSP know cmp is available and set up default capabilities
  local capabilities = vim.tbl_deep_extend("force",
    vim.lsp.protocol.make_client_capabilities(),
    cmp.default_capabilities())

  -- Recursively merge the default capabilities with this server's capabilities
  local config = tools.servers[server] or {}
  config.capabilities = vim.tbl_deep_extend("force", {}, capabilities, config.capabilities or {})

  -- Add Schemastore schemas for JSON. YAML already has Schemastore support
  if server == "jsonls" then
    config.settings.json = {
      schemas = require("schemastore").json.schemas(),
      validate = { enable = true },
    }
  end

  -- Run setup
  lsp[server].setup(config)
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

      -- Pull SchemaStore for JSON, YAML, TOML... tag info
      "b0o/schemastore.nvim",
    },

    config = function()
      -- Set up Mason and register LSPs
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = {},
        automatic_installation = false,
        handlers = { registerLsp },
      })

      -- We'll need to run the handler manually for tools not managed by Mason
      for _, server in ipairs(tools.local_servers) do
        registerLsp(server)
      end

      -- Setup attach behaviour
      au("LspAttach", {
        desc = "Configure attached LSP",

        group = ag("lsp-config-attach", { clear = true }),
        callback = function(ev)
          local client = vim.lsp.get_client_by_id(ev.data.client_id)

          keybinds.lsp()

          -- Enable reference highlighting
          if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
            local highlight_ag = ag("lsp-config-highlight", { clear = false })
            local detach_ag = ag("lsp-config-detach", { clear = true })

            au({ "CursorHold", "CursorHoldI" }, {
              desc = "Highlight references when cursor is on a symbol",

              group = highlight_ag,
              buffer = ev.buf,
              callback = vim.lsp.buf.document_highlight,
            })

            au({ "CursorMoved", "CursorMovedI" }, {
              desc = "Clear highlighted references",

              group = highlight_ag,
              buffer = ev.buf,
              callback = vim.lsp.buf.clear_references,
            })

            au("LspDetach", {
              desc = "Remove reference highlight autogroup from buffer",

              group = detach_ag,
              callback = function(ev2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds({
                  group = "lsp-config-highlight",
                  buffer = ev2.buf,
                })
              end,
            })
          end

          -- Toggle inlay hints (like field names)
          if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
            map("n", "<leader>th", function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = ev.buf }))
            end, { desc = "[T]oggle inlay [H]ints" })
          end

          -- Toggle
          if client and client.name == "clangd" then
            map("n", "<leader>h", "<cmd>ClangdSwitchSourceHeader<CR>", {
              desc = "C/C++: Switch [h]eaders",
              silent = true,
            })
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
