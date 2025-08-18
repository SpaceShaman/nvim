local M = {}

local function apply()
  if not vim.g.__cursor_remap_langmap_set then
    vim.opt.langmap:append "jkl\\;';hjkl\\;"
    vim.g.__cursor_remap_langmap_set = true
  end
end

function M.setup()
  vim.api.nvim_create_autocmd('VimEnter', {
    callback = function()
      vim.schedule(apply)
    end,
  })
  pcall(function()
    vim.api.nvim_create_autocmd('User', {
      pattern = 'VeryLazy',
      callback = function()
        vim.schedule(apply)
      end,
    })
  end)
  local g = vim.api.nvim_create_augroup('CursorRemapGuard', { clear = true })
  vim.api.nvim_create_autocmd({ 'BufWinEnter', 'FileType', 'TermOpen', 'WinEnter' }, {
    group = g,
    callback = function()
      vim.schedule(apply)
    end,
  })
end

return M
