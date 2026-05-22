return {
  'MeanderingProgrammer/render-markdown.nvim',
  commit = 'e3c18ddd27a853f85a6f513a864cf4f2982b9f26',
  dependencies = {
    { 'nvim-treesitter/nvim-treesitter', commit = '6620ae1c44dfa8623b22d0cbf873a9e8d073b849' },
    { 'echasnovski/mini.nvim', commit = '439cdcd6992bc9012efd7d8ed7a7b7a0f1fac32a' },
    { 'zk-org/zk-nvim', commit = 'dea1ee6cd6d07568c92ea8353063d4d85c58a964' },
  },
  ---@module 'render-markdown'
  ---@type render.md.UserConfig
  opts = {},
  config = function()
    require('render-markdown').setup {
      -- anti_conceal = { enabled = false },
    }
    vim.api.nvim_create_autocmd({ 'BufEnter', 'BufRead', 'BufNewFile' }, {
      callback = function(args)
        if not vim.api.nvim_buf_is_valid(args.buf) then return end
        local name = vim.api.nvim_buf_get_name(args.buf)
        local tail = vim.fn.fnamemodify(name, ':t')
        if tail == 'copilot-chat' then
          vim.bo[args.buf].filetype = 'markdown'
        end
      end,
    })
  end,
}
