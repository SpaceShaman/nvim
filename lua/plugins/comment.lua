return {
  'numToStr/Comment.nvim',
  version = 'v0.8.0',
  opts = {
    mappings = {
      basic = false,
      extra = false,
    },
  },
  config = function()
    vim.keymap.set('n', '<leader>c', '<Plug>(comment_toggle_linewise_current)', { desc = 'Toggle comment for current line' })
    vim.keymap.set('x', '<leader>c', '<Plug>(comment_toggle_linewise_visual)', { desc = 'Toggle comment for current line' })
  end,
}
