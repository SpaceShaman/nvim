return function()
  local function is_special_buf(bufnr)
    local name = vim.api.nvim_buf_get_name(bufnr)
    return name:match 'neo%-tree' or name:match '^term://'
  end

  local function move_window(direction)
    local cur_win = vim.api.nvim_get_current_win()
    local cur_buf = vim.api.nvim_win_get_buf(cur_win)

    -- Do not allow moving/swapping from a special buffer
    if is_special_buf(cur_buf) then
      vim.notify('Moving or swapping special buffers is not allowed.', vim.log.levels.WARN)
      return
    end

    -- Search for the next window with a normal buffer in the given direction
    local win_found = false
    local start_win = cur_win
    local max_jumps = vim.fn.winnr '$'
    local target_win, target_buf

    for _ = 1, max_jumps do
      vim.cmd('wincmd ' .. direction)
      target_win = vim.api.nvim_get_current_win()
      if target_win == start_win then
        break
      end

      target_buf = vim.api.nvim_win_get_buf(target_win)
      if not is_special_buf(target_buf) then
        win_found = true
        break
      end
    end

    if win_found then
      -- Swap buffers
      vim.api.nvim_win_set_buf(target_win, cur_buf)
      vim.api.nvim_win_set_buf(cur_win, target_buf)
      vim.api.nvim_set_current_win(target_win)
    else
      -- No normal neighbor found, create a new split and move buffer there
      local split_cmd = {
        h = 'leftabove vsplit',
        l = 'rightbelow vsplit',
        k = 'leftabove split',
        j = 'rightbelow split',
      }
      vim.api.nvim_set_current_win(start_win)
      vim.cmd(split_cmd[direction])
      local new_win = vim.api.nvim_get_current_win()
      vim.api.nvim_win_set_buf(new_win, cur_buf)
      vim.api.nvim_set_current_win(new_win)
    end
  end

  vim.keymap.set('n', '<leader>j', function()
    move_window 'h'
  end, { desc = 'Swap or move buffer left (skip neo-tree/term)' })
  vim.keymap.set('n', '<leader>k', function()
    move_window 'j'
  end, { desc = 'Swap or move buffer down (skip neo-tree/term)' })
  vim.keymap.set('n', '<leader>l', function()
    move_window 'k'
  end, { desc = 'Swap or move buffer up (skip neo-tree/term)' })
  vim.keymap.set('n', '<leader>;', function()
    move_window 'l'
  end, { desc = 'Swap or move buffer right (skip neo-tree/term)' })
end
