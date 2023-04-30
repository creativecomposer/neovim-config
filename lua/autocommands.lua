local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local home = vim.fn.expand("~")

autocmd({ "BufWritePost" }, {
  group = augroup('FormatAutogroup', { clear = true }),
  pattern = { home .. "/.config/nvim/lua/*.lua", home .. "/.config/nvim/after/plugin/*.lua" },
  command = [[so <afile>]]
})
