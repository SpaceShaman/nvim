return function()
  local zig_process

  vim.api.nvim_create_autocmd('FileType', {
    pattern = 'zig',
    callback = function(event)
      vim.keymap.set('n', 'zr', function()
        if zig_process then
          pcall(vim.uv.kill, -zig_process.pid, 15)
        end

        zig_process = vim.system { 'setsid', 'zig', 'build', 'run' }
      end, {
        buffer = event.buf,
        desc = '[Z]ig build [r]un',
      })
    end,
  })
end
