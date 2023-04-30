vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Show cursor line
vim.opt.cursorline = true

-- Enable case insensitive search
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

-- Number of screen lines to keep above and below the cursor
vim.opt.scrolloff = 3
-- Always keep the sign gutter open
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.colorcolumn = "100"

-- indent when moving to the next line while writing code
vim.opt.smartindent = true

-- Give more space for displaying messages
vim.opt.cmdheight = 2

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

vim.opt.statusline = "%<%f\\ %h%m%r%{FugitiveStatusline()}%=%-14.(%l,%c%V%)\\ %P"
