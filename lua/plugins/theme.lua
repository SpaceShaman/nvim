return {
  'Shatur/neovim-ayu',
  -- dir = '~/Dev/neovim-ayu',
  commit = 'e5a9f0fa2918d6b5f57c21b3ac014314ee5e41c8',
  priority = 1000, -- Make sure to load this before all the other start plugins.
  config = function()
    require('ayu').setup {
      overrides = {
        Normal = { bg = 'None' },
        SignColumn = { bg = 'None' },
        WinSeparator = { bg = 'None' },
      },
    }

    local schema = 'org.gnome.desktop.interface'
    local key = 'color-scheme'

    local function apply_theme(value)
      local variant = value:find 'prefer%-light' and 'light' or 'dark'

      vim.o.background = variant
      vim.cmd.colorscheme('ayu-' .. variant)
    end

    apply_theme(vim.fn.system { 'gsettings', 'get', schema, key })

    vim.fn.jobstart({ 'gsettings', 'monitor', schema, key }, {
      on_stdout = function(_, data)
        local value = table.concat(data, '\n')

        if value ~= '' then
          vim.schedule(function()
            apply_theme(value)
          end)
        end
      end,
    })
  end,
}
