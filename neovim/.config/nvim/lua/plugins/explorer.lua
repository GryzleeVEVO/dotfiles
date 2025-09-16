return {
  "nvim-tree/nvim-tree.lua",

  lazy = false,

  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },

  config = function()
    local api = require("nvim-tree.api")

    require("nvim-tree").setup({
      view = { number = true, relativenumber = true },
      on_attach = function(bufnr)
        api.config.mappings.default_on_attach(bufnr)
        vim.keymap.set({ "n" }, "<F2>", api.fs.rename, {
          desc = "[nvim-tree] Rename",
        })
      end,
    })

    vim.keymap.set({ "n" }, "<leader>e", api.tree.toggle, {
      desc = "[nvim-tree] Toggle side explorer",
    })
  end,
}
