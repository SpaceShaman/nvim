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
      vim.schedule(function()
        local wins = non_float_wins()
        local is_open = require('zen-mode.view').is_open()
        if wins <= 1 and not is_open then
          require('zen-mode').open()
        elseif wins > 1 and is_open then
          require('zen-mode').close()
        end
      end)
    end

    local initialized = false
    local function init()
      if initialized then
        return
      end
      initialized = true
      vim.api.nvim_create_autocmd('BufEnter', { callback = check_zen })
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
  end,
}
