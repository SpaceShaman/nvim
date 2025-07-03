return function()
  vim.g.mapleader = ' '
  vim.g.maplocalleader = ' '
  local map = vim.keymap.set
  local opts = { noremap = true }

  map('', "'", ';', opts)
  map('', 'j', 'h', opts)
  map('', 'k', 'j', opts)
  map('', 'l', 'k', opts)
  map('', ';', 'l', opts)
  map('', 'K', '5<Down>', opts)
  map('', 'L', '5<Up>', opts)

  map('n', '<A-j>', '<C-w><Left>', { desc = 'Go to the left window', noremap = true })
  map('n', '<A-k>', '<C-w><Down>', { desc = 'Go to the lower window', noremap = true })
  map('n', '<A-l>', '<C-w><Up>', { desc = 'Go to the upper window', noremap = true })
  map('n', '<A-;>', '<C-w><Right>', { desc = 'Go to the right window', noremap = true })

  map('n', '<A-a>', '<Cmd>vertical resize -2<CR>', { desc = 'Decrease window width', noremap = true })
  map('n', '<A-s>', '<Cmd>horizontal resize -2<CR>', { desc = 'Decrease window height', noremap = true })
  map('n', '<A-d>', '<Cmd>horizontal resize +2<CR>', { desc = 'Increase window height', noremap = true })
  map('n', '<A-f>', '<Cmd>vertical resize +2<CR>', { desc = 'Increase window width', noremap = true })

  map({ 'i', 'c' }, '<M-BS>', '<C-w>', { desc = 'Delete previous word', noremap = true })

  map('n', '<Esc>', '<cmd>nohlsearch<CR>', { desc = 'Clear highlights on search when pressing <Esc>' })

  map('', '<C-p>', '<Plug>(telescope-find-files)', { desc = 'Find files' })

  -- Terminal
  map('', '<A-t>', '<cmd>ToggleTerm<CR>', { desc = 'Toggle terminal' })
  map('t', '<A-t>', '<cmd>ToggleTerm<CR>', { desc = 'Toggle terminal' })
  map('t', '<Esc>', '<C-\\><C-n>', { desc = 'Return to normal mode' })
  map('t', '<A-j>', '<Cmd>wincmd h<CR>', { desc = 'Go to the left window', noremap = true })
  map('t', '<A-k>', '<Cmd>wincmd j<CR>', { desc = 'Go to the lower window', noremap = true })
  map('t', '<A-l>', '<Cmd>wincmd k<CR>', { desc = 'Go to the upper window', noremap = true })
  map('t', '<A-;>', '<Cmd>wincmd l<CR>', { desc = 'Go to the right window', noremap = true })
  map('t', '<A-a>', '<Cmd>vertical resize -2<CR>', { desc = 'Decrease window width', noremap = true })
  map('t', '<A-s>', '<Cmd>horizontal resize -2<CR>', { desc = 'Decrease window height', noremap = true })
  map('t', '<A-d>', '<Cmd>horizontal resize +2<CR>', { desc = 'Increase window height', noremap = true })
  map('t', '<A-f>', '<Cmd>vertical resize +2<CR>', { desc = 'Increase window width', noremap = true })
end
