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
        requires = { 'nvim-tree/nvim-web-devicons', opt = true }
    }
end)

-- Colors and theme
vim.opt.termguicolors = true
vim.opt.background = 'dark'
vim.cmd 'colorscheme ayu-mirage'
require('lualine').setup({options = { theme = 'ayu' }})

-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Default 4 space tabs + overrides for 2 spaces tabs
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.api.nvim_create_autocmd( "FileType", {
    pattern = "html,js,css,php",
    command = 'setlocal tabstop = 2 softtabstop = 2 shiftwidth = 2'
})

-- Render whitespaces
vim.opt.list = true
vim.opt.listchars = 'trail:~,tab:>-,nbsp:␣'

-- Disable wrapping
vim.opt.wrap = false

-- Better search highlighting
vim.opt.hlsearch = true
vim.opt.incsearch = true

-- Indent next line if necessary
vim.opt.smartindent = true

-- Top off cursor when scrollingç
vim.opt.scrolloff = 8

-- Do not comment next line
vim.opt.formatoptions:remove({'c', 'r', 'o'})

-- Only one column if there are no errors/warnings
vim.opt.signcolumn = 'number'

-- Short length markers
vim.opt.colorcolumn = '80,120'

-- Do not store swaps or backups
vim.opt.swapfile = false
vim.opt.backup = false

-- Update faster
vim.opt.updatetime = 50

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
