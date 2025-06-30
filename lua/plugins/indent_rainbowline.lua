return {
  'lukas-reineke/indent-blankline.nvim',
  main = 'ibl',
  config = function()
    local is_dark = vim.o.background == 'dark'

    local colors = is_dark and { '#662121', '#767621', '#216631', '#325a5e', '#324b7b', '#562155' } -- ayu-dark
      or { '#e57373', '#dce775', '#81c784', '#4dd0e1', '#64b5f6', '#ba68c8' } -- ayu-light

    local hooks = require 'ibl.hooks'
    hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
      for i, color in ipairs(colors) do
        vim.api.nvim_set_hl(0, 'IndentBlanklineIndent' .. i, {
          fg = color,
          nocombine = true,
        })
      end
    end)

    require('ibl').setup {
      indent = {
        highlight = {
          'IndentBlanklineIndent1',
          'IndentBlanklineIndent2',
          'IndentBlanklineIndent3',
          'IndentBlanklineIndent4',
          'IndentBlanklineIndent5',
          'IndentBlanklineIndent6',
        },
      },
    }
  end,
}
