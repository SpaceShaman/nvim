return {
  'rmagatti/auto-session',
  commit = '62437532b38495551410b3f377bcf4aaac574ebe',
  lazy = false,
  keys = {
    { '<leader>se', '<cmd>AutoSession search<cr>', desc = '[S]earch [S]ession' },
  },
  config = function()
    require('auto-session').setup {
      log_level = 'info',
    }
  end,
}
