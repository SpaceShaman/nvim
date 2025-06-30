return {
  'lukas-reineke/indent-blankline.nvim',
  main = 'ibl',
  config = function()
    local is_dark = vim.o.background == 'dark'

    local colors = is_dark and { '#2e1a1a', '#2f2f1a', '#1a2e1a', '#1a2a2e', '#1a1f2f', '#2a1a2f' }
      or { '#ffeaea', '#ffffe0', '#e8f5e9', '#e0f7fa', '#e3f2fd', '#f3e5f5' }

    local hooks = require 'ibl.hooks'

    local highlight = {}
    for i in ipairs(colors) do
      table.insert(highlight, 'indent_color_' .. i)
    end
    hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
      for i, color in ipairs(colors) do
        local color_name = 'indent_color_' .. i
        vim.api.nvim_set_hl(0, color_name, {
          bg = color,
          nocombine = true,
        })
      end
    end)

    require('ibl').setup {
      indent = {
        char = '',
        highlight = highlight,
      },
      whitespace = {
        highlight = highlight,
        remove_blankline_trail = false,
      },
      scope = {
        enabled = false,
      },
    }
  end,
}
