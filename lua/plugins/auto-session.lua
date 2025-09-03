return {
  'rmagatti/auto-session',
  lazy = false,
  keys = {
    { '<leader>ss', '<cmd>AutoSession search<cr>', desc = '[S]earch [S]ession' },
  },
  config = function()
    vim.o.sessionoptions = 'blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions'
    require('auto-session').setup {
      log_level = 'info',
    }
  end,
}
