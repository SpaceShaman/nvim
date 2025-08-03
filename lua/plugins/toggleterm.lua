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
    local lazygit = Terminal:new { cmd = 'lazygit', hidden = true, direction = 'float', dir = 'git_dir' }

    function _lazygit_toggle()
      lazygit:toggle()
    end

    vim.api.nvim_set_keymap('n', '<leader>g', '<cmd>lua _lazygit_toggle()<CR>', { noremap = true, silent = true })
  end,
}
