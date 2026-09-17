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
      watch_for_changes = true,
    }
    -- Open Oil on startup when no file is opened
    vim.api.nvim_create_autocmd('VimEnter', {
      once = true,
      callback = function()
        if vim.fn.argc() > 0 then
          return
        end
        vim.schedule(function()
          -- Sessions can restore unloaded buffer entries without opening a file.
          for _, buf in ipairs(vim.fn.getbufinfo { buflisted = 1 }) do
            if buf.changed == 1 or (buf.loaded == 1 and buf.name ~= '') then
              return
            end
          end
          if vim.fn.bufname() ~= '' or vim.bo.buftype ~= '' or vim.bo.modified then
            return
          end
          if vim.fn.line '$' == 1 and vim.fn.getline(1) == '' then
            require('oil').open()
          end
        end)
      end,
    })
  end,
}
