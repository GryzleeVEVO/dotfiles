return {
  -- Undo history
  "mbbill/undotree",

  keys = {
    { "<leader>u", "<cmd>UndotreeToggle<cr>", desc = "[undotree] Toggle undo tree" },
  },

  cmd = {
    "UndotreeFocus",
    "UndotreeHide",
    "UndotreePersistUndo",
    "UndotreeShow",
    "UndotreeToggle",
  },
}
