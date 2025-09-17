return {
  'akinsho/toggleterm.nvim',
  version = '*',
  config = function()
    require('toggleterm').setup {
      open_mapping = '<A-t>',
      autochdir = true,
      shell = 'fish',
      terminal_mappings = false,
      insert_mappings = false,
    }
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
      on_close = function(term)
        vim.cmd 'startinsert!'
      end,
    }

    function _lazygit_toggle()
      lazygit:toggle()
    end

    local keymap = vim.keymap.set

    keymap('t', '<A-t>', '<cmd>ToggleTerm<CR>', { desc = 'Toggle terminal' })
    keymap('n', '<leader>t', '<cmd>ToggleTerm<CR>', { desc = 'Toggle terminal' })
    keymap('n', '<leader>g', '<cmd>lua _lazygit_toggle()<CR>', { desc = 'Lazygit', noremap = true, silent = true })
  end,
}
