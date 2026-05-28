return {
  'akinsho/toggleterm.nvim',
  commit = '50ea089fc548917cc3cc16b46a8211833b9e3c7c',
  config = function()
    require('toggleterm').setup {
      open_mapping = false,
      autochdir = true,
      shell = 'fish',
      terminal_mappings = false,
      insert_mappings = false,
    }

    local function smart_toggle(id)
      local cmd = id and ('ToggleTerm ' .. id .. ' direction=horizontal') or 'ToggleTerm direction=horizontal'
      vim.cmd(cmd)
    end

    local Terminal = require('toggleterm.terminal').Terminal
    local lazygit = Terminal:new {
      cmd = 'lazygit',
      dir = 'git_dir',
      direction = 'float',
      float_opts = {
        border = 'curved',
      },
      on_open = function(term)
        vim.cmd 'startinsert!'
        vim.api.nvim_buf_set_keymap(term.bufnr, 't', '<esc>', '<esc>', { noremap = true, silent = true })
        vim.api.nvim_buf_set_keymap(term.bufnr, 'n', 'q', '<cmd>close<CR>', { noremap = true, silent = true })
      end,
      on_close = function()
        vim.cmd 'startinsert!'
      end,
    }

    local keymap = vim.keymap.set

    keymap('t', '<A-t>', '<cmd>ToggleTerm<CR>', { desc = 'Toggle terminal' })
    keymap('n', '<A-t>', '<cmd>ToggleTerm<CR>', { desc = 'Toggle terminal' })
    keymap('n', '<leader>t', '<cmd>ToggleTerm<CR>', { desc = 'Toggle terminal' })
    for i = 1, 9 do
      keymap('n', i .. '<leader>t', function()
        smart_toggle(i)
      end, { desc = 'Toggle terminal ' .. i })
      keymap('n', i .. '<A-t>', function()
        smart_toggle(i)
      end, { desc = 'Toggle terminal ' .. i })
    end
    keymap('n', '<leader>g', function()
      lazygit:toggle()
    end, { desc = 'Lazygit', noremap = true, silent = true })
  end,
}
