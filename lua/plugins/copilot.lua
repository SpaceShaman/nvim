return {
  {
    'CopilotC-Nvim/CopilotChat.nvim',
    dependencies = {
      { 'nvim-lua/plenary.nvim', branch = 'master' },
    },
    build = 'make tiktoken',
    config = function()
      require('CopilotChat').setup {
        model = 'gpt-5-mini',
        language = 'Polish',
        show_help = false,
        headers = {
          user = 'User ',
          assistant = 'AI ',
          tool = 'Tool ',
        },
      }
      vim.keymap.set('n', '<leader>i', '<cmd>CopilotChatToggle<cr>')
      vim.keymap.set({ 'i', 'n' }, '<A-i>', '<cmd>CopilotChatToggle<cr>')
    end,
  },
}
