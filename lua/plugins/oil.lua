return {
  'stevearc/oil.nvim',
  ---@module 'oil'
  ---@type oil.SetupOpts
  dependencies = { { 'echasnovski/mini.icons', opts = {} } },
  lazy = false,
  config = function()
    require('oil').setup {
      keymaps = {
        ['<C-_>'] = { 'actions.show_help', mode = 'n' },
        ['<C-v>'] = { 'actions.select', opts = { vertical = true } },
      },
    }
    -- Open Oil on startup when no file is opened
    vim.api.nvim_create_autocmd('VimEnter', {
      once = true,
      callback = function()
        if vim.fn.argc() > 0 then
          return
        end
        vim.schedule(function()
          local listed = vim.fn.getbufinfo { buflisted = 1 }
          if #listed == 1 and listed[1].name == '' then
            require('oil').open()
          end
        end)
      end,
    })
  end,
}
