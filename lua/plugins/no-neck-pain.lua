return {
  'shortcuts/no-neck-pain.nvim',
  commit = '4bc52782524fd50c5658685d584df6fa48fe49f9',
  config = function()
    require('no-neck-pain.util.constants').INTEGRATIONS.neotest = nil

    require('no-neck-pain').setup {
      autocmds = {
        enableOnVimEnter = true,
        enableOnTabEnter = true,
      },
    }
  end,
}
