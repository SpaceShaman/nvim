return {
  'stevearc/oil.nvim',
  ---@module 'oil'
  ---@type oil.SetupOpts
  dependencies = { { 'echasnovski/mini.icons', opts = {} } },
  lazy = false,
  opts = {
    keymaps = {
      ['<C-_>'] = { 'actions.show_help', mode = 'n' },
      ['<C-v>'] = { 'actions.select', opts = { vertical = true } },
    },
  },
}
