return function()
  vim.g.mapleader = ' '
  vim.g.maplocalleader = ' '
  vim.opt.langmap:append "hjkl\\;';\\'hjkl\\;"
  local map = vim.keymap.set
  local opts = { noremap = true }

  map('', 'K', '5<Down>', opts)
  map('', 'L', '5<Up>', opts)

  map('n', '<A-h>', '<C-w><Left>', { desc = 'Go to the left window', noremap = true })
  map('n', '<A-j>', '<C-w><Down>', { desc = 'Go to the lower window', noremap = true })
  map('n', '<A-k>', '<C-w><Up>', { desc = 'Go to the upper window', noremap = true })
  map('n', '<A-l>', '<C-w><Right>', { desc = 'Go to the right window', noremap = true })

  map({ 'n', 't' }, '<C-A-j>', '<cmd>vertical resize -2<CR>', { desc = 'Decrease window width', noremap = true })
  map({ 'n', 't' }, '<C-A-k>', '<cmd>horizontal resize -2<CR>', { desc = 'Decrease window height', noremap = true })
  map({ 'n', 't' }, '<C-A-l>', '<cmd>horizontal resize +2<CR>', { desc = 'Increase window height', noremap = true })
  map({ 'n', 't' }, '<C-A-;>', '<cmd>vertical resize +2<CR>', { desc = 'Increase window width', noremap = true })

  require('utils.langmap').translate_mapping({ 'n', 't' }, '<C-A-;>', ';', 'l')

  map({ 'n', 't' }, '<A-s>', '<cmd>tabprevious<CR>', { desc = 'Go to the previous tab' })
  map({ 'n', 't' }, '<A-d>', '<cmd>tabnext<CR>', { desc = 'Go to the next tab' })
  map({ 'n', 't' }, '<A-S>', function()
    require('utils.tabs').move_buffer(-1)
  end, { desc = 'Move buffer to the previous tab' })
  map({ 'n', 't' }, '<A-D>', function()
    require('utils.tabs').move_buffer(1)
  end, { desc = 'Move buffer to the next tab' })

  map({ 'i', 'c' }, '<M-BS>', '<C-w>', { desc = 'Delete previous word', noremap = true })

  map('n', '<Esc>', '<cmd>nohlsearch<CR>', { desc = 'Clear highlights on search when pressing <Esc>' })

  -- go to previous buffer
  map('n', 'gb', '<C-^>', { desc = 'Go to previous buffer' })

  -- Terminal
  map('t', '<Esc>', '<C-\\><C-n>', { desc = 'Return to normal mode' })
  map('t', '<A-h>', '<cmd>wincmd h<CR>', { desc = 'Go to the left window', noremap = true })
  map('t', '<A-j>', '<cmd>wincmd j<CR>', { desc = 'Go to the lower window', noremap = true })
  map('t', '<A-k>', '<cmd>wincmd k<CR>', { desc = 'Go to the upper window', noremap = true })
  map('t', '<A-l>', '<cmd>wincmd l<CR>', { desc = 'Go to the right window', noremap = true })

  -- Copy line Up/Down
  map('n', '<C-Down>', 'yyp', opts)
  map('n', '<C-Up>', 'yyP', opts)
  map('v', '<C-Down>', "y'<Pgv", opts)
  map('v', '<C-Up>', "y'>pgv", opts)

  map('n', '-', '<cmd>Oil<CR>', { desc = 'Toggle Oil', noremap = true })
end
