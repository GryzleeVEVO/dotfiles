-- Download and configure this servers with Mason
local mason_servers = {
  lua_ls = {},
  gopls = {},
}

local ensure_installed = {}
for k, _ in pairs(mason_servers) do
  ensure_installed[#ensure_installed + 1] = k
end

-- Configure this servers if locally installed
local local_servers = {
  clangd = {},
}

local function setKeymaps()
  local map = vim.keymap.set
  local buf = vim.lsp.buf
  local builtin = require("telescope.builtin")

  -- Go-to
  map("n", "gd", builtin.lsp_definitions, { desc = "[G]oto [D]efinition" })
  map("n", "gr", builtin.lsp_references, { desc = "[G]oto [R]eferences" })
  map("n", "gI", builtin.lsp_implementations, { desc = "[G]oto [I]mplementation" })
  -- map("n", "<leader>D", builtin.lsp_type_definitions, { desc = "Goto Type [D]efinition" })
  -- gf = goto file

  -- Symbol search
  map("n", "<leader>ds", builtin.lsp_document_symbols, { desc = "[D]ocument [S]ymbols" })
  map("n", "<leader>ws", builtin.lsp_dynamic_workspace_symbols, { desc = "[W]orkspace [S]ymbols" })
  map("n", "<C-p>", builtin.lsp_dynamic_workspace_symbols, { desc = "[W]orkspace [S]ymbols" })

  -- Diagnostics
  map("n", "<leader>D", vim.diagnostic.open_float, { desc = "Show [D]iagnostic message" })
  -- <leader>d = show diagnostics list

  -- Rename

  map("n", "<leader>rn", buf.rename, { desc = "[R]e[n]ame" })
  map("n", "<F2>", buf.rename, { desc = "[R]e[n]ame" })

  -- Code actions
  map({ "n", "x" }, "<leader>ca", buf.code_action, { desc = "[C]ode [A]ction" })
  map({ "n", "x" }, "<leader>a", buf.code_action, { desc = "[C]ode [A]ction" })
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
      local m = vim.keymap.set
      local au = vim.api.nvim_create_autocmd
      local ag = vim.api.nvim_create_augroup
      local attach_ag = ag("lsp-config-attach", { clear = true })
      local capabilities = vim.lsp.protocol.make_client_capabilities()

      setKeymaps()

      -- Let LSP know cmp is available
      capabilities = vim.tbl_deep_extend("force", capabilities, cmp.default_capabilities())

      -- Set up Mason and install missing tools
      require("mason").setup()

      require("mason-lspconfig").setup({
        ensure_installed = ensure_installed,
        automatic_installation = false,
        handlers = {
          function(server)
            local config = mason_servers[server] or {}
            config.capabilities = vim.tbl_deep_extend("force", {}, capabilities, config.capabilities or {})
            lspconfig[server].setup(config)
          end,
        },
      })

      -- Set up local tools
      for server, config in pairs(local_servers) do
        config.capabilities = vim.tbl_deep_extend("force", {}, capabilities, config.capabilities or {})
        lspconfig[server].setup(config)
      end

      -- Setup attach behaviour
      au("LspAttach", {
        group = attach_ag,
        desc = "Configure attached LSP",

        callback = function(event)
          local client = vim.lsp.get_client_by_id(event.data.client_id)

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
