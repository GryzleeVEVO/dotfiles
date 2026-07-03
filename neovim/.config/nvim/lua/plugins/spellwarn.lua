return {
  {
    "ravibrock/spellwarn.nvim",
    enabled = false,
    event = "VeryLazy",

    opts = {
      severity = {
        spellbad = "INFO",
        spellcap = "HINT",
        spelllocal = "HINT",
        spellrare = "INFO",
      },
    },
  },
}
