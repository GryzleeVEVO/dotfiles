-- TODO: Since 0.11 Neovim has native support for LSPs, so nvim-lspconfig is no
-- longer strictly required as a plugin. However lspconfig is still usefull
-- since it provides sensible defaults.

local au = vim.api.nvim_create_autocmd
local ag = vim.api.nvim_create_augroup
local tools = require("tools")
local keybinds = require("plugin-keybinds")

--- Register a new LSP server
---
--- @param server string Name of server
local function registerLsp(server)
  local lsp = require("lspconfig")
  local cmp = require("cmp_nvim_lsp")

  -- Let LSP know cmp is available and set up default capabilities
  local capabilities = vim.tbl_deep_extend("force", vim.lsp.protocol.make_client_capabilities(), cmp.default_capabilities())

  -- Recursively merge the default capabilities with this server's capabilities
  local config = tools.servers[server] or {}
  config.capabilities = vim.tbl_deep_extend("force", {}, capabilities, config.capabilities or {})

  -- Add Schemastore schemas for JSON. YAML already has Schemastore support
  if server == "jsonls" then
    if not config.settings then
      config.settings = {}
    end

    config.settings.json = {
      schemas = require("schemastore").json.schemas(),
      validate = { enable = true },
    }
  end

  -- Run setup
  lsp[server].setup(config)
end

--- Run after an LSP is attached
---
--- @param event vim.api.keyset.create_autocmd.callback_args
local function onLspAttach(event)
  local client = vim.lsp.get_client_by_id(event.data.client_id)

  if client == nil then
    return
  end

  keybinds.lsp(client, event)

  -- Enable reference highlighting
  if client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
    local highlight_ag = ag("lsp-config-highlight", { clear = false })

    au({ "CursorHold", "CursorHoldI" }, {
      desc = "Highlight references when cursor is on a symbol",
      group = highlight_ag,
      buffer = event.buf,

      callback = vim.lsp.buf.document_highlight,
    })

    au({ "CursorMoved", "CursorMovedI" }, {
      desc = "Clear highlighted references",
      group = highlight_ag,
      buffer = event.buf,

      callback = vim.lsp.buf.clear_references,
    })
  end
end

--- Run after an LSP is detached
---
--- @param event vim.api.keyset.create_autocmd.callback_args
local function onLspDetach(event)
  vim.lsp.buf.clear_references()
  vim.api.nvim_clear_autocmds({
    group = "lsp-config-highlight",
    buffer = event.buf,
  })
end

return {
  {
    -- Sensible configurations for language servers
    "neovim/nvim-lspconfig",
    version = "*",

    dependencies = {
      {
        -- Package manager for LSPs
        "williamboman/mason.nvim",
        version = "*",
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

      -- Setup attach and detach behaviour
      au("LspAttach", {
        desc = "Configure attached LSP",
        group = ag("lsp-config-attach", { clear = true }),
        callback = onLspAttach,
      })

      au("LspDetach", {
        desc = "Clean up after an LSP has been detached",
        group = ag("lsp-config-detach", { clear = true }),
        callback = onLspDetach,
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
