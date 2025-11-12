return {
  'MeanderingProgrammer/render-markdown.nvim',
  dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim', 'zk-org/zk-nvim' },
  ---@module 'render-markdown'
  ---@type render.md.UserConfig
  opts = {},
  config = function()
    require('render-markdown').setup {
      anti_conceal = { enabled = false },
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
