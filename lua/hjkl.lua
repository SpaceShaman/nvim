return function()
  local map = vim.keymap.set
  local opts = { noremap = true }

  local mappings = {
    ["'"] = ';',
    [';'] = '<Right>',
    ['l'] = '<Up>',
    ['k'] = '<Down>',
    ['j'] = '<Left>',
    ['L'] = '5<Up>',
    ['K'] = '5<Down>',
  }

  for from, to in pairs(mappings) do
    map('', from, to, opts)
  end

  vim.api.nvim_create_autocmd('FileType', {
    pattern = 'neo-tree',
    callback = function()
      local map = vim.keymap.set
      local opts = { noremap = true, buffer = true }

      map('n', 'l', 'k', opts)
      map('n', 'k', 'j', opts)
      map('n', 'j', 'h', opts)
      map('n', ';', 'l', opts)
    end,
  })
end
