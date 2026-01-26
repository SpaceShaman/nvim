return {
  url = 'https://codeberg.org/andyg/leap.nvim',
  config = function()
    vim.keymap.set('n', "'", '<Plug>(leap)')
  end,
}
