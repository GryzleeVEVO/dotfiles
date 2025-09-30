return {
  "nvim-tree/nvim-tree.lua", -- File explorer

  enabled = false,

  lazy = false,

  dependencies = {
    "nvim-tree/nvim-web-devicons", -- Dependency
  },

  config = function()
    local api = require("nvim-tree.api")

    require("nvim-tree").setup({
      view = { number = true, relativenumber = true },
      on_attach = function(bufnr)
        api.config.mappings.default_on_attach(bufnr)
        -- g? for help

        vim.keymap.set({ "n" }, "<F2>", api.fs.rename, { desc = "[nvim-tree] Rename" })
        vim.keymap.set({ "n" }, "gd", api.tree.change_root_to_node, { desc = "[nvim-tree] CD into directory" })
      end,
    })

    vim.keymap.set({ "n" }, "<leader>e", api.tree.toggle, { desc = "[nvim-tree] Toggle side explorer" })
  end,
}
