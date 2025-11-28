return {
  {
    'CopilotC-Nvim/CopilotChat.nvim',
    dependencies = {
      { 'nvim-lua/plenary.nvim', branch = 'master' },
    },
    build = 'make tiktoken',
    config = function()
      local present, telescope = pcall(require, 'telescope')
      if present then
        telescope.load_extension 'ui-select'
      end
      require('CopilotChat').setup {
        model = 'gpt-4.1',
        language = 'Polish',
        show_help = false,
        headers = {
          user = '👤 User ',
          assistant = '🤖 AI ',
          tool = '🔧 Tool ',
        },
        tools = { 'copilot' },
        sticky = { '#buffers:full' },
      }
      vim.keymap.set('n', '<leader>i', '<cmd>CopilotChatToggle<cr>', { silent = true, desc = 'AI Chat' })
      vim.keymap.set({ 'i', 'n' }, '<A-i>', '<cmd>CopilotChatToggle<cr>', { silent = true, desc = 'AI Chat' })
      vim.api.nvim_create_autocmd('BufEnter', {
        pattern = 'copilot-*',
        callback = function()
          local bufnr = vim.api.nvim_get_current_buf()
          vim.keymap.set('', '<esc>', '<cmd>CopilotChatStop<cr>', { silent = true, noremap = true, buffer = bufnr })
        end,
      })
    end,
  },
}
