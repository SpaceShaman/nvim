return {
  'stevearc/oil.nvim',
  commit = '0fcc83805ad11cf714a949c98c605ed717e0b83e',
  ---@module 'oil'
  ---@type oil.SetupOpts
  dependencies = { { 'echasnovski/mini.icons', commit = '5b9076dae1bfbe47ba4a14bc8b967cde0ab5d77e', opts = {} } },
  lazy = false,
  config = function()
    require('oil').setup {
      keymaps = {
        ['<C-_>'] = { 'actions.show_help', mode = 'n' },
        ['<C-v>'] = { 'actions.select', opts = { vertical = true } },
      },
      view_options = {
        is_hidden_file = function(name, bufnr)
          local hidden_names = {
            ['__pycache__'] = true,
            ['node_modules'] = true,
          }
          return name:match '^%.' or hidden_names[name]
        end,
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
