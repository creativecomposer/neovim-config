return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use({
    'folke/tokyonight.nvim',
    config = function()
      vim.opt.termguicolors = true
      vim.cmd.colorscheme('tokyonight-moon')
    end
  })

  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.5', -- or, branch = '0.1.x',
    requires = { { 'nvim-lua/plenary.nvim' } }
  }

  use({ 'nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' } })
  use('nvim-treesitter/playground')

  use('tpope/vim-fugitive')
  use('tpope/vim-eunuch')

  use('mbbill/undotree')

  -- autocomplete sources
  use('hrsh7th/cmp-path')

  use {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v2.x',
    requires = {
      -- LSP Support
      { 'neovim/nvim-lspconfig' }, -- Required
      {
        -- Optional
        'williamboman/mason.nvim',
        run = function()
          pcall(vim.cmd, 'MasonUpdate')
        end,
      },
      { 'williamboman/mason-lspconfig.nvim' }, -- Optional

      -- Autocompletion
      { 'hrsh7th/nvim-cmp' },     -- Required
      { 'hrsh7th/cmp-nvim-lsp' }, -- Required
      { 'L3MON4D3/LuaSnip' },     -- Required
    }
  }

  use({
    'jose-elias-alvarez/null-ls.nvim',
    requires = { { 'nvim-lua/plenary.nvim' } }
  })

  -- use('/home/learner/plugins/stackmap.nvim')
end)
