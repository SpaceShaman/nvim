local function hex_to_rgb(hex)
  hex = hex:gsub('#', '')
  return {
    tonumber(hex:sub(1, 2), 16),
    tonumber(hex:sub(3, 4), 16),
    tonumber(hex:sub(5, 6), 16),
  }
end

local function rgb_to_hex(rgb)
  return string.format('#%02x%02x%02x', rgb[1], rgb[2], rgb[3])
end

local function mix_color_with_alpha(fg_hex, alpha)
  local fg = hex_to_rgb(fg_hex)
  local mixed = {}
  for i = 1, 3 do
    mixed[i] = math.floor(fg[i] * alpha + 0 * (1 - alpha))
  end
  return rgb_to_hex(mixed)
end

return {
  'lukas-reineke/indent-blankline.nvim',
  main = 'ibl',
  config = function()
    local is_dark = vim.o.background == 'dark'
    local alpha = is_dark and 0.3 or 0.7

    local base_colors = {
      '#ffff40',
      '#7fff7f',
      '#ff7fff',
      '#4fecec',
    }

    local colors = {}
    for _, base in ipairs(base_colors) do
      table.insert(colors, mix_color_with_alpha(base, alpha))
    end

    local highlight = {}
    for i = 1, #colors do
      highlight[i] = 'indent_color_' .. i
    end

    local hooks = require 'ibl.hooks'
    hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
      for i, color in ipairs(colors) do
        vim.api.nvim_set_hl(0, highlight[i], {
          fg = color,
          nocombine = true,
        })
      end
    end)

    require('ibl').setup {
      indent = {
        char = '▏',
        highlight = highlight,
      },
      scope = {
        enabled = false,
      },
    }
  end,
}
