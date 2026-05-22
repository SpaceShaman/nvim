return {
  url = 'https://codeberg.org/andyg/leap.nvim',
  commit = 'e20f33507bd2d6c671b7273f797f2d3cf521ac61',
  config = function()
    vim.keymap.set('n', "'", '<Plug>(leap)')
  end,
}
