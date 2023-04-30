------ Lua config used for NeoVim 0.9.0 ------

local set = vim.opt

-- Set the behavior of tab
set.tabstop = 2
set.shiftwidth = 2
set.softtabstop = 2
set.expandtab = true

-- Show line numbers
set.number = true
set.relativenumber = true

-- indent when moving to the next line while writing code 
set.smartindent = true

-- Show cursor line
set.cursorline = true

-- Always keep the sign gutter open
set.signcolumn = 'yes'

-- Enable case insensitive search
set.ignorecase = true
set.smartcase = true

-- Number of screen lines to keep above and below the cursor
set.scrolloff = 3

-- Give more space for displaying messages
set.cmdheight = 2

-- use space as a the leader key
vim.g.mapleader = ' '

------ Start: plugins setup

-- If lazy.nvim plugin manager is not installed, install it
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Add required plugins to lazy.nvim
require("lazy").setup({
  {
    "folke/tokyonight.nvim",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      set.termguicolors = true
      vim.cmd([[colorscheme tokyonight-moon]])
    end,
  },
  {
    "nvim-lua/plenary.nvim", -- helper lua functions. Many plugins depend on this.
    lazy = false,
  },
  -- LSP setup 1. Install mason, mason-lspconfig, and nvim-lspconfig
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",
  "neovim/nvim-lspconfig",
  -- Autocompletion
  "hrsh7th/nvim-cmp", -- Autocompletion plugin
  "hrsh7th/cmp-nvim-lsp", -- LSP source for nvim-cmp
  "saadparwaiz1/cmp_luasnip", -- Snippets source for nvim-cmp
  "L3MON4D3/LuaSnip", -- Snippets plugin
  {"junegunn/fzf", build = function() vim.call("fzf#install") end },
  "jose-elias-alvarez/null-ls.nvim",
  "MunifTanjim/prettier.nvim",
})

-- LSP setup 2: Initialize mason and ensure to install the desired LSP servers
-- May have to run "brew install lua-language-server" and 
-- "npm install -g typescript typescript-language-server" to install the language servers
require("mason").setup()
require("mason-lspconfig").setup {
  ensure_installed = { "lua_ls", "tsserver" },
}
-- LSP setup 3: Initialize the LSP servers
local lspconfig = require('lspconfig')
local lsp_defaults = lspconfig.util.default_config
lsp_defaults.capabilities = vim.tbl_deep_extend(
  'force',
  lsp_defaults.capabilities,
  require('cmp_nvim_lsp').default_capabilities()
)

lspconfig.tsserver.setup {}
lspconfig.lua_ls.setup {}

-- Configure autocomplete
local luasnip = require 'luasnip'
local cmp = require 'cmp'
cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-u>'] = cmp.mapping.scroll_docs(-4), -- Up
    ['<C-d>'] = cmp.mapping.scroll_docs(4), -- Down
    -- C-b (back) C-f (forward) for snippet placeholder navigation.
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}

local null_ls = require("null-ls")
null_ls.setup({
    sources = {
        null_ls.builtins.diagnostics.eslint,
        null_ls.builtins.formatting.prettier
    },
})

require("prettier").setup({
  bin = 'prettier', -- or `'prettierd'` (v0.23.3+)
  filetypes = {
    "css",
    "graphql",
    "html",
    "javascript",
    "javascriptreact",
    "json",
    "less",
    "markdown",
    "scss",
    "typescript",
    "typescriptreact",
    "yaml",
  },
})
------ End: plugins setup

------ Start: Set keybindings ------

-- shortcut to run prettier on current buffer
vim.keymap.set('n', 'gp', ':Prettier<CR>', { silent = true })

-- shortcut to open fuzzy file finder
vim.keymap.set('n', '<C-p>', ':<C-u>FZF<CR>')

-- shortcut to clear previous search highlighting
vim.keymap.set('n', '<Leader>/', ':nohlsearch<CR>', { silent = true })
-- shortcut to copy highlighted text to clipboard
vim.keymap.set('v', '<Leader>c', '"+y')
-- shortcut to paste from clipboard
vim.keymap.set('n', '<Leader>p', '"+p')

-- Shortcut to paste from the register 0 in order to paste from last yanked text
vim.keymap.set('n', '<Leader>0', '"0p')

-- shortcut to open previous buffer
vim.keymap.set('n', '<S-Tab>', ':bp<CR>')
-- shortcut to open next buffer
vim.keymap.set('n', '<Tab>', ':bn<CR>')
-- map c-a because it is easier than doing c-^ or c-6 to go to the alternative file
vim.keymap.set('n', '<C-a>', '<C-^>')

-- shortcut to open terminal window
vim.keymap.set('n', '<C-k>', ':15new <Bar> terminal<CR>i')
-- move to next split easily from terminal mode 
vim.keymap.set('t', '<C-w>', '<C-\\><C-n><C-w>j')
-- use Esc to come out of terminal mode
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>')

-- Add keybindings when a LSP server is attached to a buffer
-- Reference: https://vonheikemen.github.io/devlog/tools/setup-nvim-lspconfig-plus-nvim-cmp/
vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP actions',
  callback = function()
    local bufmap = function(mode, lhs, rhs)
      local opts = {buffer = true}
      vim.keymap.set(mode, lhs, rhs, opts)
    end

    -- Displays hover information about the symbol under the cursor
    bufmap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>')

    -- Jump to the definition
    bufmap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>')

    -- Jump to declaration
    bufmap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>')

    -- Lists all the implementations for the symbol under the cursor
    -- Disable this map for now because gi is already mapped to last edit point
    -- bufmap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>')

    -- Jumps to the definition of the type symbol
    bufmap('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>')

    -- Lists all the references 
    bufmap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>')

    -- Displays a function's signature information
    bufmap('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>')

    -- Renames all references to the symbol under the cursor
    bufmap('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>')

    -- Selects a code action available at the current cursor position
    bufmap('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>')
    bufmap('x', '<F4>', '<cmd>lua vim.lsp.buf.range_code_action()<cr>')

    -- Show diagnostics in a floating window
    bufmap('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>')

    -- Move to the previous diagnostic
    bufmap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>')

    -- Move to the next diagnostic
    bufmap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>')
  end
})

------ End: Set keybindings ------
