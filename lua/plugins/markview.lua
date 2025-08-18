return {
  'MeanderingProgrammer/render-markdown.nvim',
  dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' },
  ---@module 'render-markdown'
  ---@type render.md.UserConfig
  opts = {},
  config = function(_, opts)
    require('render-markdown').setup(opts)
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
