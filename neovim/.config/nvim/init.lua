require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'

    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
        requires = {
            {'williamboman/mason.nvim'},
            {'williamboman/mason-lspconfig.nvim'},

            -- LSP Support
            {'neovim/nvim-lspconfig'},

            -- Autocompletion
            {'hrsh7th/nvim-cmp'},
            {'hrsh7th/cmp-nvim-lsp'},
            {'L3MON4D3/LuaSnip'},
        }
    }

    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    }

    use 'Shatur/neovim-ayu'

    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'nvim-tree/nvim-web-devicons', opt = false }
    }

    use {
        'github/copilot.vim'
    }
end)

local lsp_zero = require('lsp-zero')


require('mason').setup {}

require('mason-lspconfig').setup {
    ensure_installed = {
        'lua_ls',
        'clangd',
        'bashls',
    },

    handlers = {
        lsp_zero.default_setup,
    }
}

-- Colors and theme
vim.opt.termguicolors = true
vim.opt.background = 'dark'
vim.cmd 'colorscheme ayu-mirage'
require('lualine').setup({options = { theme = 'ayu' }})


require('config')
require('rebinds')
