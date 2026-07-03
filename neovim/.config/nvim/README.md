# Neovim

This Neovim config uses [lazy.nvim](https://github.com/folke/lazy.nvim) as a plugin manager. All plugin specs are in the `lua/plugins` directory.

This config assumes you are using Neovim >=0.11, which implements a native LSP client.

Some other files include:

- `opts`: `:set` commands, with some better defaults.
- `autocmds`: Any autocommand that does not set up keybinds or is plugin-specific goes here.
- `globals`: User-defined global variables.
- `keybinds`: Mappings, including those of plugins (which get exported as a function).
- `diagnostics`: Set up diagnostics
- `tools`: Configurations for formatters, linters, parsers, and manually enabled LSPs.
    - Since nvim 0.11, `nvim-lspconfig` only provides configuration files with sane defaults. Any changes must be put in `lsp/<lsp_name>`, which will get merged with the defaults.
