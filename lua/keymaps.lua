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

  map('n', '<A-j>', '<C-w><Left>', { desc = 'Go to the left window', noremap = true })
  map('n', '<A-k>', '<C-w><Down>', { desc = 'Go to the lower window', noremap = true })
  map('n', '<A-l>', '<C-w><Up>', { desc = 'Go to the upper window', noremap = true })
  map('n', '<A-;>', '<C-w><Right>', { desc = 'Go to the right window', noremap = true })

  map('n', '<Leader>j', '<C-w>H', { desc = 'Move window to far left ', noremap = true })
  map('n', '<Leader>k', '<C-w>J', { desc = 'Move window to far lower', noremap = true })
  map('n', '<Leader>l', '<C-w>K', { desc = 'Move window to far upper', noremap = true })
  map('n', '<Leader>;', '<C-w>L', { desc = 'Move window right', noremap = true })

  map('n', '<A-a>', '<C-w><LT>', { desc = 'Decrease window width', noremap = true })
  map('n', '<A-s>', '<C-w>-', { desc = 'Decrease window height', noremap = true })
  map('n', '<A-d>', '<C-w>+', { desc = 'Increase window height', noremap = true })
  map('n', '<A-f>', '<C-w>>', { desc = 'Increase window width', noremap = true })

  map({ 'i', 'c' }, '<M-BS>', '<C-w>', { desc = 'Delete previous word', noremap = true })

  map('n', '<Esc>', '<cmd>nohlsearch<CR>', { desc = 'Clear highlights on search when pressing <Esc>' })
end
