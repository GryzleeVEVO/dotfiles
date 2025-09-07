# Gryzlee's incredibly subpar Neovim setup

This Neovim config uses [lazy.nvim](https://github.com/folke/lazy.nvim) as a plugin manager. All plugin specs are in the `lua/plugins` directory, which is organized by topic instead of by plugin, since many of them depend on each other anyway in order to set them up.

This config assumes you are using Neovim >=0.11, which implements a native LSP client.

Some other files include:

- `opts`: `:set` commands, because Vim's defaults are designed by fucking aliens.
- `autocmds`: Any autocommand that does not set up keybinds or is plugin-specific goes here.
- `globals`: User-defined or changed `:let`s.
- `keybinds`: Mappings, including those of plugins (which get exported as a function).
- `diagnostics`: Probably does not warrant it's own file, but there it is
- `tools`: Configurations for formatters, linters, parsers, and manually enabled LSPs.
    - Since nvim 0.11, `nvim-lspconfig` only provides configuration files with sane defaults. Any changes must be put in `lsp/<lsp_name>`, which will get merged with the defaults.
