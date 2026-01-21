local lsp = vim.lsp

return {
  "b0o/schemastore.nvim",

  config = function()
    local schema = require("schemastore")

    lsp.config("jsonls", {
      settings = {
        json = {
          schemas = schema.json.schemas(),
          validate = { enable = true },
        },
      },
    })

    lsp.config("yamlls", {
      settings = {
        yaml = {
          schemaStore = { enable = false, url = "" },
          schemas = schema.yaml.schemas(),
        },
      },
    })
  end,
}
