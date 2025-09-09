return {
  dir = '~/Dev/ttt.nvim',
  requires = { 'nvim-lua/plenary.nvim' },
  config = function()
    require('ttt').setup()
  end,
}
