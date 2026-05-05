return {
  'folke/zen-mode.nvim',
  config = function()
    require('zen-mode').setup {
      plugins = {
        options = {
          laststatus = 0,
        },
      },
    }
    vim.keymap.set('n', 'gz', '<Cmd>ZenMode<CR>', { desc = 'Toggle Zen Mode' })

    local function non_float_wins()
      local count = 0
      for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
        local ok, cfg = pcall(vim.api.nvim_win_get_config, win)
        if ok and cfg.relative == '' then
          count = count + 1
        end
      end
      return count
    end

    local function check_zen()
      if vim.g.nvim_exiting then
        return
      end
      vim.schedule(function()
        local wins = non_float_wins()
        local is_open = require('zen-mode.view').is_open()
        if wins <= 1 and not is_open then
          require('zen-mode').open()
        end
      end)
    end

    -- Keep M.parent's buffer in sync with M.win so closing zen-mode
    -- lands on the buffer the user is currently editing, not the original one.
    local function sync_parent_buf()
      local view = require 'zen-mode.view'
      if not view.is_open() then
        return
      end
      if not (view.win and vim.api.nvim_win_is_valid(view.win)) then
        return
      end
      if not (view.parent and vim.api.nvim_win_is_valid(view.parent)) then
        return
      end
      local cur_buf = vim.api.nvim_win_get_buf(view.win)
      if vim.api.nvim_win_get_buf(view.parent) ~= cur_buf then
        vim.api.nvim_win_set_buf(view.parent, cur_buf)
      end
    end

    local initialized = false
    local function init()
      if initialized then
        return
      end
      initialized = true
      vim.api.nvim_create_autocmd('BufEnter', { callback = sync_parent_buf })
      vim.api.nvim_create_autocmd('WinClosed', { callback = check_zen })
      vim.api.nvim_create_autocmd('BufDelete', { callback = check_zen })
      check_zen()
    end

    vim.api.nvim_create_autocmd('User', {
      pattern = 'AutoSessionRestorePost',
      once = true,
      callback = init,
    })
    vim.api.nvim_create_autocmd('VimEnter', {
      once = true,
      callback = function()
        vim.defer_fn(init, 200)
      end,
    })

    -- Close zen-mode before any plugin saves the session
    vim.api.nvim_create_autocmd('VimLeavePre', {
      callback = function()
        vim.g.nvim_exiting = true
        local ok, view = pcall(require, 'zen-mode.view')
        if ok and view.is_open() then
          require('zen-mode').close()
        end
      end,
    })
  end,
}
