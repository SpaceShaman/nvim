return {
  'ggandor/leap.nvim',
  config = function()
    vim.keymap.set('n', "'", '<Plug>(leap)')
  end,
}
