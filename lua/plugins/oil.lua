return {
  'stevearc/oil.nvim',
  commit = '17c0a8faaf48298a0c0cfb0d757c0eaee4ff7a32',
  ---@module 'oil'
  ---@type oil.SetupOpts
  dependencies = {
    { 'echasnovski/mini.icons', commit = '5b9076dae1bfbe47ba4a14bc8b967cde0ab5d77e' },
    { 'malewicz1337/oil-git.nvim', commit = 'd153b6aa67f69fd80b43228ca899daec5602e652' },
  },
  lazy = false,
  config = function()
    require('oil').setup {
      keymaps = {
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
