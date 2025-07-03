return {
  {
    'akinsho/toggleterm.nvim',
    version = '*',
    opts = {
      open_mapping = '`',
      on_create = function(term)
        term:send 'fish'
        term:send 'clear'
      end,
    },
  },
}
