return {
  'mg979/vim-visual-multi',
  lazy = false,
  init = function()
    vim.g.VM_theme = 'nord'
    vim.g.VM_custom_motions = {
      [';'] = 'l',
      ['l'] = 'k',
      ['k'] = 'j',
      ['j'] = 'h',
    }
  end,
}
