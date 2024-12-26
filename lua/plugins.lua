local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'

-- Auto-install lazy.nvim if not present
if not vim.uv.fs_stat(lazypath) then
  print('Installing lazy.nvim....')
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
  print('Done.')
end

vim.opt.rtp:prepend(lazypath)

-- Install the desired plugins using lazy.nvim
require('lazy').setup({
  {
    'folke/tokyonight.nvim',
    config = function()
      vim.opt.termguicolors = true
      vim.cmd.colorscheme('tokyonight-moon')
    end,
  },

  {
    'nvim-telescope/telescope.nvim', tag = '0.1.8',
    dependencies = { 'nvim-lua/plenary.nvim' }
  },

  {
    "nvim-treesitter/nvim-treesitter", build = ":TSUpdate",
    config = function ()
      local configs = require("nvim-treesitter.configs")

      configs.setup({
          ensure_installed = { "bash", "css", "dockerfile", "html", "javascript", "lua", "markdown", "python", "scss", "typescript", "vim", "yaml", },
          sync_install = false,
          highlight = { enable = true },
          indent = { enable = true },
        })
    end,
  },

  {'tpope/vim-fugitive'},
  {'tpope/vim-eunuch'},

  {'mbbill/undotree'},

  -- Language Server Protocol related plugins
  {'neovim/nvim-lspconfig'},
  {'hrsh7th/cmp-nvim-lsp'},
  {'hrsh7th/nvim-cmp'},
})

