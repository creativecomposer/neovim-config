local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>pb', require('telescope.builtin').buffers, { desc = 'gre[P] [B]uffers' })
vim.keymap.set('n', '<leader>pf', builtin.find_files, { desc = 'gre[P] [F]iles' })
vim.keymap.set('n', '<C-p>', builtin.git_files, { desc = 'gre[p] git files' })
vim.keymap.set('n', '<leader>pw', function()
	builtin.grep_string({ search = vim.fn.input("Grep > ") });
end, { desc = 'gre[P] input [W]ord' })
vim.keymap.set('n', '<leader>pc', builtin.grep_string, { desc = 'gre[P] [C]urrent word' })
vim.keymap.set('n', '<leader>ph', builtin.help_tags, { desc = 'gre[P] [H]elp' })
