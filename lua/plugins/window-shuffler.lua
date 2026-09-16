return {
  'SpaceShaman/window-shuffler.nvim',
  commit = '4e30f44744912b42f1fbff9427154052b1f52336',
  opts = {
    keymaps = {
      left = '<A-J>',
      down = '<A-K>',
      up = '<A-L>',
      right = '<A-S-;>',
    },
  },
  config = function(_, opts)
    require('window_shuffler').setup(opts)
    require('utils.langmap').translate_mapping('n', opts.keymaps.right, ';', 'l')
  end,
}
