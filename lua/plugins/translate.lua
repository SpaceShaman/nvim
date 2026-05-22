return {
  'uga-rosa/translate.nvim',
  commit = '1a841e56407ba02e919ed9af573dbe531404aebb',
  config = function()
    require('translate').setup {
      default = {
        command = 'translate_shell',
        output = 'replace',
      },
      silent = true,
    }

    local map = vim.keymap.set
    map('x', 'gtp', "<Cmd>'<,'>Translate PL<CR>", { desc = '[T]ranslate to [P]olish' })
    map('x', 'gte', "<Cmd>'<,'>Translate EN<CR>", { desc = '[T]ranslate to [E]nglish' })
  end,
}
