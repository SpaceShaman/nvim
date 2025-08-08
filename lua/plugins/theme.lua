return {
  'Shatur/neovim-ayu',
  priority = 1000, -- Make sure to load this before all the other start plugins.
  config = function()
    require('ayu').setup {
      overrides = {
        Normal = { bg = 'None' },
        SignColumn = { bg = 'None' },
      },
    }
    local file = io.open(vim.fn.expand '~/.config/theme', 'r')
    local variant = 'light'
    if file then
      variant = file:read '*l' or 'light'
      file:close()
    end

    local theme = string.format('ayu-%s', variant)
    vim.cmd.colorscheme(theme)
  end,
}
