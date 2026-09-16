local M = {}
local api = vim.api

local function normal_windows(tab)
  return vim.tbl_filter(function(win)
    return api.nvim_win_get_config(win).relative == ''
  end, api.nvim_tabpage_list_wins(tab))
end

function M.move_buffer(direction)
  local source = api.nvim_get_current_win()
  if api.nvim_win_get_config(source).relative ~= '' then
    return
  end

  local source_tab = api.nvim_get_current_tabpage()
  local index = api.nvim_tabpage_get_number(source_tab)
  local target_tab = api.nvim_list_tabpages()[index + direction]
  local target_placeholder

  if not target_tab then
    -- Duplicate the view temporarily to create an adjacent tab without a new buffer.
    vim.cmd(direction < 0 and '0tab split' or 'tab split')
    target_tab = api.nvim_get_current_tabpage()
    target_placeholder = api.nvim_get_current_win()
  end

  local target = api.nvim_tabpage_get_win(target_tab)
  if api.nvim_win_get_config(target).relative ~= '' then
    target = normal_windows(target_tab)[1]
  end

  -- Neovim 0.11 cannot move the last window out of a tab directly.
  local source_placeholder
  if #normal_windows(source_tab) == 1 then
    source_placeholder = api.nvim_open_win(api.nvim_win_get_buf(source), false, {
      split = 'right',
      win = source,
    })
  end

  -- Move the actual window, preserving its buffer, cursor, folds and local options.
  api.nvim_win_set_config(source, { split = 'right', win = target })
  api.nvim_set_current_win(source)

  if source_placeholder then
    api.nvim_win_close(source_placeholder, false)
  end
  if target_placeholder then
    api.nvim_win_close(target_placeholder, false)
  end
end

return M
