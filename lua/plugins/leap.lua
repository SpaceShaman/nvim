return {
  'ggandor/leap.nvim',
  config = function()
    vim.keymap.set('n', '<A-enter>', '<Plug>(leap)')
  end,
}
