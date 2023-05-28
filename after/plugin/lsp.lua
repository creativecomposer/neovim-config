local lsp = require('lsp-zero').preset({})

-- Ensure the following language servers are installed
-- You have to install the language servers separately.
-- For lua, run "brew install lua-language-server" and
-- "npm install -g typescript typescript-language-server vscode-langservers-extracted"
-- for typescript and eslint. Or add to ~/.nvm/default-packages
lsp.ensure_installed({
  'tsserver',
  'eslint',
  'lua_ls',
  'cssls',
})

lsp.on_attach(function(_, bufnr)
  lsp.default_keymaps({ buffer = bufnr })
  vim.keymap.set('n', '<F5>', '<cmd>lua vim.lsp.buf.code_action()<cr>', { buffer = true })
end)

-- (Optional) Configure lua language server for neovim
local lspconfig = require('lspconfig')
lspconfig.lua_ls.setup(lsp.nvim_lua_ls())

local filetypes = {
  "css",
  "graphql",
  "html",
  "javascript",
  "javascriptreact",
  "json",
  "jsonc",
  "less",
  "markdown",
  "scss",
  "typescript",
  "typescriptreact",
  "yaml",
}

lsp.format_on_save({
  format_opts = {
    timeout_ms = 10000,
  },
  servers = {
    ['lua_ls'] = { 'lua' },
    ['null-ls'] = filetypes,
  }
})

lsp.setup()

-- Make sure you setup `cmp` after lsp-zero
local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()

cmp.setup({
  sources = {
    { name = 'nvim_lsp' },
    { name = 'nvim_lua' }
  },
  mapping = {
    -- `Enter` key to confirm completion
    ['<CR>'] = cmp.mapping.confirm({ select = true }),

    -- Ctrl+Space to trigger completion menu
    ['<C-Space>'] = cmp.mapping.complete(),

    -- Navigate between snippet placeholder
    ['<C-f>'] = cmp_action.luasnip_jump_forward(),
    ['<C-b>'] = cmp_action.luasnip_jump_backward(),
  }
})

local null_ls = require('null-ls')

null_ls.setup({
  sources = {
    null_ls.builtins.formatting.prettier,
  }
})
