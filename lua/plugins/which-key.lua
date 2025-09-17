return {
  'folke/which-key.nvim',
  event = 'VimEnter',
  opts = {
    delay = 0,
    icons = {
      mappings = vim.g.have_nerd_font,
    },
    -- Document existing key chains
    spec = {
      { '<leader>s', group = '[S]earch' },
      { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
      { '<leader>m', group = '[M]essage' },
      { 'gt', group = '[T]ests' },
    },
  },
}
