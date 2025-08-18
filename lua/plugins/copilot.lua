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
        window = {
          layout = 'float',
          border = 'rounded',
          width = 0.8,
          height = 0.8,
          zindex = 100,
        },
        mappings = {
          complete = nil,
        },
      }
      vim.keymap.set('n', '<leader>i', '<cmd>CopilotChatToggle<cr>')
      vim.keymap.set({ 'i', 'n' }, '<A-i>', '<cmd>CopilotChatToggle<cr>')
    end,
  },
}
