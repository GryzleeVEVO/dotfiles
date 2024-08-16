return {
  -- LSP Configuration & Plugins
  "neovim/nvim-lspconfig",

  dependencies = {
    -- LSP manager menu
    {
      "williamboman/mason.nvim",
      config = true
    },
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",

    -- Useful status updates for LSP.
    {
      "j-hui/fidget.nvim",
      opts = {}
    },

    -- Lua LSP configuration for Neovim API
    -- TODO: Replace with lazydev (neodev is EOL)
    {
      "folke/neodev.nvim",
      opts = {}
    },
  },

  config = function()
    vim.api.nvim_create_autocmd(
      "LspAttach",
      {
        group = vim.api.nvim_create_augroup(
          "kickstart-lsp-attach",
          { clear = true }
        ),

        callback = function(event)
          local function map(keys, func, desc)
            vim.keymap.set(
              "n",
              keys,
              func,
              {
                buffer = event.buf,
                desc = "LSP: " .. desc
              }
            )
          end

          map(
            "gd",
            require("telescope.builtin").lsp_definitions,
            "[G]oto [D]efinition"
          )
          map(
            "gr",
            require("telescope.builtin").lsp_references,
            "[G]oto [R]eferences"
          )
          map(
            "gI",
            require("telescope.builtin").lsp_implementations,
            "[G]oto [I]mplementation"
          )
          map(
            "<leader>D",
            require("telescope.builtin").lsp_type_definitions,
            "Type [D]efinition"
          )
          map(
            "<leader>ds",
            require("telescope.builtin").lsp_document_symbols,
            "[D]ocument [S]ymbols"
          )
          map(
            "<leader>ws",
            require("telescope.builtin").lsp_dynamic_workspace_symbols,
            "[W]orkspace [S]ymbols"
          )
          map(
            "<leader>rn",
            vim.lsp.buf.rename,
            "[R]e[n]ame"
          )
          map(
            "<leader>ca",
            vim.lsp.buf.code_action,
            "[C]ode [A]ction"
          )
          map(
            "K",
            vim.lsp.buf.hover,
            "Hover Documentation"
          )
          map(
            "gD",
            vim.lsp.buf.declaration,
            "[G]oto [D]eclaration")

          local client = vim.lsp.get_client_by_id(event.data.client_id)

          -- Highlight symbol the cursor is on, clear it when moving
          if client and client.server_capabilities.documentHighlightProvider then
            local highlight_augroup = vim.api.nvim_create_augroup(
              "kickstart-lsp-highlight",
              { clear = false }
            )

            vim.api.nvim_create_autocmd(
              { "CursorHold", "CursorHoldI" },
              {
                buffer = event.buf,
                group = highlight_augroup,
                callback = vim.lsp.buf.document_highlight,
              }
            )

            vim.api.nvim_create_autocmd(
              { "CursorMoved", "CursorMovedI" },
              {
                buffer = event.buf,
                group = highlight_augroup,
                callback = vim.lsp.buf.clear_references,
              }
            )

            vim.api.nvim_create_autocmd(
              "LspDetach",
              {
                group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
                callback = function(event2)
                  vim.lsp.buf.clear_references()
                  vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
                end,
              }
            )
          end

          -- Show/hide inlay hints (e.g. argument names)
          if client and client.server_capabilities.inlayHintProvider
              and vim.lsp.inlay_hint
          then
            map(
              "<leader>th",
              function()
                vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled {})
              end,
              "[T]oggle Inlay [H]ints"
            )
          end
        end,
      })

    -- Extend LSP capabilities
    local capabilities = vim.lsp.protocol.make_client_capabilities()

    capabilities = vim.tbl_deep_extend(
      "force",
      capabilities,
      require("cmp_nvim_lsp").default_capabilities()
    )

    -- Enable the following language servers
    local servers = {
      lua_ls = {
        settings = {
          Lua = {
            completion = {
              callSnippet = "Replace",
            },
          },
        },
      },
    }

    local ensure_installed = vim.tbl_keys(servers or {})

    vim.list_extend(ensure_installed, {})

    require("mason").setup()
    require("mason-tool-installer").setup { ensure_installed = ensure_installed }
    require("mason-lspconfig").setup {
      handlers = {
        function(server_name)
          local server = servers[server_name] or {}
          server.capabilities = vim.tbl_deep_extend(
            "force",
            {},
            capabilities,
            server.capabilities or {}
          )
          require("lspconfig")[server_name].setup(server)
        end,
      },
    }
  end,
}
