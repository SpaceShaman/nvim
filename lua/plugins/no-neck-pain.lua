return {
  'shortcuts/no-neck-pain.nvim',
  commit = '434fed70b1ee553f8f27e6da7b3899f71b3c6f99',
  config = function()
    require('no-neck-pain').setup {
      autocmds = {
        enableOnVimEnter = true,
        enableOnTabEnter = true,
      },
    }
  end,
}
