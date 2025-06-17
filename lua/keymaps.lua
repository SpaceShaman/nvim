return function()
  local map = vim.keymap.set
  local opts = { noremap = true }

  map('', "'", ';', opts)
  map('', 'j', '<Left>', opts)
  map('', 'k', '<Down>', opts)
  map('', 'l', '<Up>', opts)
  map('', ';', '<Right>', opts)
  map('', 'K', '5<Down>', opts)
  map('', 'L', '5<Up>', opts)

  map('n', '<A-j>', '<C-w><Left>', { desc = 'Move focus to the left window', noremap = true })
  map('n', '<A-k>', '<C-w><Down>', { desc = 'Move focus to the lower window', noremap = true })
  map('n', '<A-l>', '<C-w><Up>', { desc = 'Move focus to the upper window', noremap = true })
  map('n', '<A-;>', '<C-w><Right>', { desc = 'Move focus to the right window', noremap = true })

  map({ 'i', 'c' }, '<M-BS>', '<C-w>', { desc = 'Delete previous word', noremap = true })

  map('n', '<Esc>', '<cmd>nohlsearch<CR>', { desc = 'Clear highlights on search when pressing <Esc>' })
end
