return { -- Highlight todo, notes, etc in comments
  'folke/todo-comments.nvim',
  commit = '31e3c38ce9b29781e4422fc0322eb0a21f4e8668',
  event = 'VimEnter',
  dependencies = { { 'nvim-lua/plenary.nvim', commit = 'b9fd5226c2f76c951fc8ed5923d85e4de065e509' } },
  opts = { signs = false },
}
