return {
  'folke/zen-mode.nvim',
  commit = '8564ce6d29ec7554eb9df578efa882d33b3c23a7',
  config = function()
    require('zen-mode').setup {
      plugins = { options = { laststatus = 0 } },
    }
    vim.keymap.set('n', 'gz', '<Cmd>ZenMode<CR>', { desc = 'Toggle Zen Mode' })

    local view = require 'zen-mode.view'

    local function non_float_wins()
      local n = 0
      for _, w in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
        local ok, cfg = pcall(vim.api.nvim_win_get_config, w)
        if ok and cfg.relative == '' then
          n = n + 1
        end
      end
      return n
    end

    local function check_zen()
      if vim.g.nvim_exiting then
        return
      end
      vim.schedule(function()
        if non_float_wins() <= 1 and not view.is_open() then
          require('zen-mode').open()
        end
      end)
    end

    -- Sync M.parent buffer with M.win so closing zen-mode returns to the current file.
    local function sync_parent_buf()
      if not view.is_open() then
        return
      end
      if not (view.win and vim.api.nvim_win_is_valid(view.win)) then
        return
      end
      if not (view.parent and vim.api.nvim_win_is_valid(view.parent)) then
        return
      end
      local buf = vim.api.nvim_win_get_buf(view.win)
      if vim.api.nvim_win_get_buf(view.parent) ~= buf then
        vim.api.nvim_win_set_buf(view.parent, buf)
      end
    end

    local initialized = false
    local function init()
      if initialized then
        return
      end
      initialized = true
      vim.api.nvim_create_autocmd('BufEnter', { callback = sync_parent_buf })
      vim.api.nvim_create_autocmd('WinClosed', {
        callback = function(ev)
          if view.is_open() and tonumber(ev.match) == view.win and vim.fn.exists '#Zen' == 1 then
            vim.schedule(function()
              vim.cmd 'quit'
            end)
          else
            check_zen()
          end
        end,
      })
      vim.api.nvim_create_autocmd('BufDelete', { callback = check_zen })
      vim.api.nvim_create_autocmd('BufWinEnter', {
        callback = function(args)
          local ft = vim.bo[args.buf].filetype
          if (ft:match '^neotest%-' or ft:match '^dapui' or ft == 'dap-repl') and view.is_open() then
            require('zen-mode').close()
          end
        end,
      })
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

    vim.api.nvim_create_autocmd('VimLeavePre', {
      callback = function()
        vim.g.nvim_exiting = true
        if view.is_open() then
          require('zen-mode').close()
        end
      end,
    })
  end,
}
