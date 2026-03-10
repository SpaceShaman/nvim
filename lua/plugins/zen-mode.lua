return {
  'folke/zen-mode.nvim',
  opts = {},
  config = function()
    vim.keymap.set('n', 'gz', '<Cmd>ZenMode<CR>', { desc = 'Toggle Zen Mode' })
  end,
}
