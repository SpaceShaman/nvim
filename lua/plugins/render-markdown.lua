return {
  'MeanderingProgrammer/render-markdown.nvim',
  dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim', 'zk-org/zk-nvim' },
  ---@module 'render-markdown'
  ---@type render.md.UserConfig
  opts = {},
  config = function()
    require('lazy').load { plugins = { 'zk-nvim' } }
    local api = require 'zk.api'
    local notes = {}

    vim.schedule(function()
      api.list(nil, {
        select = { 'title', 'filenameStem' },
      }, function(err, _notes)
        if err then
          return vim.notify(err, vim.log.levels.ERROR)
        end
        for _, n in ipairs(_notes) do
          notes[n.filenameStem] = n.title
        end
      end)
    end)

    require('render-markdown').setup {
      link = {
        wiki = {
          body = function(ctx)
            return notes[ctx.destination] or nil
          end,
        },
      },
    }
    vim.api.nvim_create_autocmd({ 'BufEnter', 'BufRead', 'BufNewFile' }, {
      callback = function(args)
        local name = vim.api.nvim_buf_get_name(args.buf)
        local tail = vim.fn.fnamemodify(name, ':t')
        if tail == 'copilot-chat' then
          vim.bo[args.buf].filetype = 'markdown'
        end
      end,
    })
  end,
}
