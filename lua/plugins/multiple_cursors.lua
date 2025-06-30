return {
  'mg979/vim-visual-multi',
  lazy = false,
  init = function()
    vim.g.VM_theme = 'nord'

    vim.cmd [[
  let g:VM_custom_motions = {'j': 'h', 'k': 'j', 'l': 'k', '<Right>': 'l'}
]]
  end,
}
