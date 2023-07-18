vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
	-- Bootstrap packer
    use 'wbthomason/packer.nvim'

	-- Syntax highlighting 
	use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })

	-- Theme
	use 'Shatur/neovim-ayu'

	-- Status line
	use {'nvim-lualine/lualine.nvim', requires = {'nvim-tree/nvim-web-devicons', opt = true}}

	-- LSP
	use {
  'VonHeikemen/lsp-zero.nvim',
  branch = 'v2.x',
  requires = {
    -- LSP Support
    {'neovim/nvim-lspconfig'},             -- Required
    {                                      -- Optional
      'williamboman/mason.nvim',
      run = function()
        pcall(vim.cmd, 'MasonUpdate')
      end,
    },
    {'williamboman/mason-lspconfig.nvim'}, -- Optional

    -- Autocompletion
    {'hrsh7th/nvim-cmp'},     -- Required
    {'hrsh7th/cmp-nvim-lsp'}, -- Required
    {'L3MON4D3/LuaSnip'},     -- Required
  }
}

end)
