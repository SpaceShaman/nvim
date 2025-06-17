--  See `:help vim.keymap.set()`
function setup()
-- Use jkl; instead of hjkl as ergonomic alternative over historic
vim.keymap.set('', "'", ';', { noremap = true })
vim.keymap.set('', ';', 'l', { noremap = true })
vim.keymap.set('', 'l', 'k', { noremap = true })
vim.keymap.set('', 'k', 'j', { noremap = true })
vim.keymap.set('', 'j', 'h', { noremap = true })
vim.keymap.set('', 'L', '5k', { noremap = true })
vim.keymap.set('', 'K', '5j', { noremap = true })

--  Use CTRL+<jkl;> to switch between windows
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-j>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-;>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

vim.keymap.set({ 'i', 'c' }, '<M-BS>', '<C-w>', { desc = 'Delete previous word', noremap = true })
vim.keymap.set('', '<C-s>', ':w<CR>', { desc = 'Save file', noremap = true })

-- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
end

return { setup}
