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
    local keymap = vim.keymap.set

    keymap('n', '<leader>c', '<Plug>(comment_toggle_linewise_current)', { desc = 'Toggle comment for current line' })
    keymap('x', '<leader>c', '<Plug>(comment_toggle_linewise_visual)', { desc = 'Toggle comment for current line' })
  end,
}
