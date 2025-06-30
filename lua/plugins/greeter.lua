return {
  'goolord/alpha-nvim',
  dependencies = {
    'echasnovski/mini.icons',
    'nvim-lua/plenary.nvim',
  },
  config = function()
    local config = require('alpha.themes.theta').config
    local dashboard = require 'alpha.themes.dashboard'
    config.layout[2].val = {
      [[╔═══╗                 ╔═══╗  ╔╗   ╔╗        ]],
      [[║╔═╗║                 ║╔══╝  ║║  ╔╝╚╗       ]],
      [[║╚══╗╔══╗╔══╗ ╔══╗╔══╗║╚══╗╔═╝║╔╗╚╗╔╝╔══╗╔═╗]],
      [[╚══╗║║╔╗║╚ ╗║ ║╔═╝║╔╗║║╔══╝║╔╗║╠╣ ║║ ║╔╗║║╔╝]],
      [[║╚═╝║║╚╝║║╚╝╚╗║╚═╗║║═╣║╚══╗║╚╝║║║ ║╚╗║╚╝║║║ ]],
      [[╚═══╝║╔═╝╚═══╝╚══╝╚══╝╚═══╝╚══╝╚╝ ╚═╝╚══╝╚╝ ]],
      [[     ║║                                     ]],
      [[     ╚╝                                     ]],
    }
    config.layout[#config.layout].val = {
      { type = 'text', val = 'Quick links', opts = { hl = 'SpecialComment', position = 'center' } },
      { type = 'padding', val = 1 },
      dashboard.button('e', '  New file', '<cmd>ene<CR>'),
      dashboard.button('f', '󰈞  Find file', '<cmd>Telescope find_files<CR>'),
      dashboard.button('c', '  Configuration', '<cmd>Telescope find_files cwd=$HOME/.config/nvim<CR>'),
      dashboard.button('u', '  Update plugins', '<cmd>Lazy sync<CR>'),
      dashboard.button('q', '󰅚  Quit', '<cmd>qa<CR>'),
    }
    require('alpha').setup(config)
  end,
}
