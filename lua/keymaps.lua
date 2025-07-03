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

  local function swap_buffer_with_neighbor(direction)
    local cur_win = vim.api.nvim_get_current_win()
    local cur_buf = vim.api.nvim_win_get_buf(cur_win)

    -- Move in the given direction (only to get the target window)
    vim.cmd('wincmd ' .. direction)
    local target_win = vim.api.nvim_get_current_win()

    if cur_win == target_win then
      -- No neighbor in that direction
      return
    end

    local target_buf = vim.api.nvim_win_get_buf(target_win)

    -- Swap buffers between current and target window
    vim.api.nvim_win_set_buf(cur_win, target_buf)
    vim.api.nvim_win_set_buf(target_win, cur_buf)

    -- Move cursor back to the target window (after swap)
    vim.api.nvim_set_current_win(target_win)
  end

  vim.keymap.set('n', '<leader>j', function()
    swap_buffer_with_neighbor 'h'
  end, { desc = 'Swap buffer with left' })
  vim.keymap.set('n', '<leader>k', function()
    swap_buffer_with_neighbor 'j'
  end, { desc = 'Swap buffer with down' })
  vim.keymap.set('n', '<leader>l', function()
    swap_buffer_with_neighbor 'k'
  end, { desc = 'Swap buffer with up' })
  vim.keymap.set('n', '<leader>;', function()
    swap_buffer_with_neighbor 'l'
  end, { desc = 'Swap buffer with right' })

  map('n', '<A-a>', '<Cmd>vertical resize -2<CR>', { desc = 'Decrease window width', noremap = true })
  map('n', '<A-s>', '<Cmd>horizontal resize -2<CR>', { desc = 'Decrease window height', noremap = true })
  map('n', '<A-d>', '<Cmd>horizontal resize +2<CR>', { desc = 'Increase window height', noremap = true })
  map('n', '<A-f>', '<Cmd>vertical resize +2<CR>', { desc = 'Increase window width', noremap = true })

  map({ 'i', 'c' }, '<M-BS>', '<C-w>', { desc = 'Delete previous word', noremap = true })

  map('n', '<Esc>', '<cmd>nohlsearch<CR>', { desc = 'Clear highlights on search when pressing <Esc>' })

  map('', '<C-p>', '<Plug>(telescope-find-files)', { desc = 'Find files' })

  -- Terminal
  -- map('n', 't', '<cmd>ToggleTerm<CR>', { desc = 'Toggle terminal' })
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
