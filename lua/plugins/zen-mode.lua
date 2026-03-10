return {
  'folke/zen-mode.nvim',
  config = function()
    require('zen-mode').setup {
      plugins = {
        options = {
          laststatus = 0, -- hide the statusline
        },
      },
    }
    vim.keymap.set('n', 'gz', '<Cmd>ZenMode<CR>', { desc = 'Toggle Zen Mode' })
  end,
}
