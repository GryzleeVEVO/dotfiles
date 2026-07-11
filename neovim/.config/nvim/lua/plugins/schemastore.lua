---@type LazySpec
return {
  -- Get schemas for JSON and YAML files
  "b0o/schemastore.nvim",

  config = function()
    local schema = require("schemastore")

    vim.lsp.config("jsonls", {
      settings = {
        json = {
          schemas = schema.json.schemas(),
          validate = { enable = true },
        },
      },
    })

    vim.lsp.config("yamlls", {
      settings = {
        yaml = {
          schemaStore = { enable = false, url = "" },
          schemas = schema.yaml.schemas(),
        },
      },
    })
  end,
}
