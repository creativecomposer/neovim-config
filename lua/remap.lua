vim.g.mapleader = " "

-- shortcut to open netrw
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- shortcut to format current buffer
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

-- highlight lines and move them around with J and K
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- keep the cursor in the middle of the screen when searching
-- vim.keymap.set("n", "n", "nzzzv")
-- vim.keymap.set("n", "N", "Nzzzv")

-- shortcut to copy highlighted text to clipboard
vim.keymap.set({ "n", "v" }, "<leader>c", [["+y]])
-- shortcut to paste from clipboard
vim.keymap.set('n', '<Leader>p', '"+p')
-- do not lose the previously yanked text when pasting on a selected text
vim.keymap.set("x", "p", [["_dP]])

-- Shortcut to paste from the register 0 in order to paste from last yanked text
vim.keymap.set('n', '<Leader>0', '"0p')

-- shortcut to open previous buffer
vim.keymap.set('n', '<S-Tab>', ':bp<CR>')
-- shortcut to open next buffer
vim.keymap.set('n', '<Tab>', ':bn<CR>')
-- map c-a because it is easier than doing c-^ or c-6 to go to the alternative file
vim.keymap.set('n', '<C-a>', '<C-^>')
-- move quickfix and location lists easier
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- shortcut to open terminal window
vim.keymap.set('n', '<leader>pt', ':15new <Bar> terminal<CR>i', { desc = "o[P]en [T]erminal" })
-- move to next split easily from terminal mode
vim.keymap.set('t', '<C-w>', '<C-\\><C-n><C-w>j', { desc = "Move down from termial" })
-- use Esc to come out of terminal mode
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>')

-- source current buffer
vim.keymap.set("n", "<leader><leader>", function()
  vim.cmd("so")
end)

-- See and clear messages
vim.keymap.set("n", "gm", ":5mes<cr>", { desc = "[G]o to last 5 [M]essages" })
vim.keymap.set("n", "<leader>gm", ":mes clear<cr>", { desc = "Clear all [M]essages" })
