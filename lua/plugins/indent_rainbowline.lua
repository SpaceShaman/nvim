local function hex_to_rgb(hex)
  hex = hex:gsub('#', '')
  return {
    tonumber(hex:sub(1, 2), 16),
    tonumber(hex:sub(3, 4), 16),
    tonumber(hex:sub(5, 6), 16),
  }
end

local function mix_colors(fg_hex, bg_hex, alpha)
  local fg = hex_to_rgb(fg_hex)
  local bg = hex_to_rgb(bg_hex)

  local function mix(c1, c2)
    return math.floor(c1 * alpha + c2 * (1 - alpha))
  end

  return string.format('#%02x%02x%02x', mix(fg[1], bg[1]), mix(fg[2], bg[2]), mix(fg[3], bg[3]))
end

return {
  'lukas-reineke/indent-blankline.nvim',
  main = 'ibl',
  config = function()
    local is_dark = vim.o.background == 'dark'
    local bg_color = is_dark and '#000000' or '#ffffff'
    local alpha = 0.1

    local base_colors = {
      '#ffff40',
      '#7fff7f',
      '#ff7fff',
      '#4fecec',
    }

    local colors = {}
    for _, base in ipairs(base_colors) do
      table.insert(colors, mix_colors(base, bg_color, alpha))
    end

    local highlight = {}
    for i = 1, #colors do
      highlight[i] = 'indent_color_' .. i
    end

    local hooks = require 'ibl.hooks'
    hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
      for i, color in ipairs(colors) do
        vim.api.nvim_set_hl(0, highlight[i], {
          bg = color,
          nocombine = true,
        })
      end
    end)

    require('ibl').setup {
      indent = {
        char = '▏',
      },
      whitespace = {
        highlight = highlight,
        remove_blankline_trail = false,
      },
      scope = {
        enabled = true,
      },
    }
  end,
}
