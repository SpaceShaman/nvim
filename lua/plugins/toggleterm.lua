return {
  {
    'akinsho/toggleterm.nvim',
    version = '*',
    opts = {
      autochdir = true,
      shell = 'fish',
      on_open = function()
        vim.cmd 'startinsert'
      end,
    },
  },
}
