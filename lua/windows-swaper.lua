return function()
  local function swap_or_move_buffer(direction)
    local cur_win = vim.api.nvim_get_current_win()
    local cur_buf = vim.api.nvim_win_get_buf(cur_win)

    -- Try to go to neighbor window
    vim.cmd('wincmd ' .. direction)
    local target_win = vim.api.nvim_get_current_win()

    if cur_win == target_win then
      -- No neighbor, create a new split and move buffer there
      local split_cmd = {
        h = 'leftabove vsplit',
        l = 'rightbelow vsplit',
        k = 'leftabove split',
        j = 'rightbelow split',
      }
      vim.cmd(split_cmd[direction])
      target_win = vim.api.nvim_get_current_win()
      -- -- Move buffer
      vim.api.nvim_win_set_buf(target_win, cur_buf)
    else
      -- Swap buffers
      local target_buf = vim.api.nvim_win_get_buf(target_win)
      vim.api.nvim_win_set_buf(target_win, cur_buf)
      vim.api.nvim_win_set_buf(cur_win, target_buf)
    end
    -- Switch to target window after swap or move
    vim.api.nvim_set_current_win(target_win)
  end

  vim.keymap.set('n', '<leader>j', function()
    swap_or_move_buffer 'h'
  end, { desc = 'Swap or move buffer left' })
  vim.keymap.set('n', '<leader>k', function()
    swap_or_move_buffer 'j'
  end, { desc = 'Swap or move buffer down' })
  vim.keymap.set('n', '<leader>l', function()
    swap_or_move_buffer 'k'
  end, { desc = 'Swap or move buffer up' })
  vim.keymap.set('n', '<leader>;', function()
    swap_or_move_buffer 'l'
  end, { desc = 'Swap or move buffer right' })
end
