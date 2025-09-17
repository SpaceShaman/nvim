return {
  'rmagatti/auto-session',
  lazy = false,
  keys = {
    { '<leader>ss', '<cmd>AutoSession search<cr>', desc = '[S]earch [S]ession' },
  },
  config = function()
    require('auto-session').setup {
      log_level = 'info',
    }
  end,
}
