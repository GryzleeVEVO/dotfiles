return {
  {
    "saghen/blink.cmp",
    version = "*",

    dependencies = {
      {
        "L3MON4D3/LuaSnip", -- Snippet engine
        version = "*",

        dependencies = {
          "rafamadriz/friendly-snippets", -- Snippets
        },

        run = "make install_jsregexp",

        config = function()
          require("luasnip.loaders.from_vscode").lazy_load({})
        end,
      },
    },

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      snippets = { preset = "luasnip" },

      -- https://cmp.saghen.dev/configuration/keymap
      keymap = {
        -- C-p, Up/C-n, Down: Select up/down
        -- C-y: Select
        -- C-e: Cancel

        -- C-space: Toggle documentation
        -- C-b/C-f: Scroll up/down

        -- C-k: Toggle signature

        -- After inserting a snippet
        -- Tab: Go to next gap
        -- S-Tab: Go to previous gap
        preset = "default",

        -- Use j/k to select items
        ["<C-j>"] = { "select_next", "fallback" },
        ["<C-k>"] = { "select_prev", "fallback" },
      },

      signature = {
        enabled = true, -- Show function signature when filling in arguments
        window = {
          show_documentation = true, -- Show docs by default
        },
      },

      completion = {
        ghost_text = {
          enabled = true, -- Show suggestion as ghost text
        },
      },

      appearance = {
        kind_icons = {
          Text = "󰉿",
          Method = "󰆧",
          Function = "󰊕",
          Constructor = "",
          Field = "󰜢",
          Variable = "󰀫",
          Class = "󰠱",
          Interface = "",
          Module = "",
          Property = "󰜢",
          Unit = "󰑭",
          Value = "󰎠",
          Enum = "",
          Keyword = "󰌋",
          Snippet = "",
          Color = "󰏘",
          File = "󰈙",
          Reference = "󰈇",
          Folder = "󰉋",
          EnumMember = "",
          Constant = "󰏿",
          Struct = "󰙅",
          Event = "",
          Operator = "󰆕",
          TypeParameter = "",
        },
      },
    },
  },
}
