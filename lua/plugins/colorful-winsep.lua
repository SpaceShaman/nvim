return {
  'nvim-zh/colorful-winsep.nvim',
  event = { 'WinLeave' },
  config = function()
    local file = io.open(vim.fn.expand '~/.config/theme', 'r')
    local variant = 'light'
    if file then
      variant = file:read '*l' or 'light'
      file:close()
    end

    require('colorful-winsep').setup {
      animate = { enabled = false },
      border = variant == 'dark' and 'single' or 'bold',
      highlight = variant == 'dark' and '#B3B1AD' or '#5C6166',
    }
  end,
}
