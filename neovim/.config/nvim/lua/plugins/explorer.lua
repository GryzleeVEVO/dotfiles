return {
  "nvim-tree/nvim-tree.lua",

  lazy = false,

  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },

  config = function()
    require("nvim-tree").setup({
      view = { number = true, relativenumber = true },
    })
    require("keybinds").nvim_tree()
  end,
}
