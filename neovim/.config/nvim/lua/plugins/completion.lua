local keybinds = require("plugin-keybinds")

return {
  -- Autocompletion
  "hrsh7th/nvim-cmp",

  dependencies = {
    {
      -- Snippet engine
      "L3MON4D3/LuaSnip",
      version = "*",

      dependencies = {
        {
          -- Get VS Code snippets
          "rafamadriz/friendly-snippets",

          config = function()
            require("luasnip.loaders.from_vscode").lazy_load()
          end,
        },
      },

      build = (function()
        if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
          return
        end
        return "make install_jsregexp"
      end)(),
    },

    "saadparwaiz1/cmp_luasnip",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-path",
  },

  event = "InsertEnter",

  config = function()
    local cmp = require("cmp")
    local mapping = cmp.mapping
    local luasnip = require("luasnip")

    luasnip.config.setup({})
    cmp.setup({
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },

      completion = {
        completeopt = "menu,menuone,noinsert",
      },

      sources = {
        {
          name = "lazydev",

          -- Skip LuaLS
          group_index = 0,
        },
        {
          name = "nvim_lsp",

          -- Remove text completions, they are pretty useless
          entry_filter = function(entry, _)
            return cmp.lsp.CompletionItemKind ~= entry:get_kind()
          end,
        },
        { name = "luasnip" },
        { name = "path" },
      },

      mapping = keybinds.cmp_menu(),
    })
  end,
}
