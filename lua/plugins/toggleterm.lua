return {
  'akinsho/toggleterm.nvim',
  version = '*',
  -- opts = {
  --   open_mapping = 't',
  --   autochdir = true,
  --   shell = 'fish',
  --   terminal_mappings = false,
  --   insert_mappings = false,
  -- },
  config = function()
    require('toggleterm').setup {
      open_mapping = 't',
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
        vim.api.nvim_buf_set_keymap(term.bufnr, 't', '<esc>', '<nop>', { noremap = true, silent = true })
        vim.api.nvim_buf_set_keymap(term.bufnr, 'n', 'q', '<cmd>close<CR>', { noremap = true, silent = true })
      end,
      on_close = function(term)
        vim.cmd 'startinsert!'
      end,
    }

    function _lazygit_toggle()
      lazygit:toggle()
    end

    vim.api.nvim_set_keymap('n', '<leader>g', '<cmd>lua _lazygit_toggle()<CR>', { noremap = true, silent = true })
  end,
}
