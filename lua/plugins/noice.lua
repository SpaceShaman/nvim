return {
  'folke/noice.nvim',
  event = 'VeryLazy',
  dependencies = {
    'MunifTanjim/nui.nvim',
    {
      'rcarriga/nvim-notify',
      opts = {
        background_colour = '#000000',
      },
    },
  },
  config = function()
    require('noice').setup {
      lsp = {
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
          ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
          ['vim.lsp.util.stylize_markdown'] = true,
          ['cmp.entry.get_documentation'] = true, -- requires hrsh7th/nvim-cmp
        },
      },
      presets = {
        long_message_to_split = true, -- long messages will be sent to a split
      },
    }
    local keymap = vim.keymap.set

    keymap('n', '<leader>ml', function()
      require('noice').cmd 'last'
    end, { desc = 'Show last message' })

    keymap('n', '<leader>mh', function()
      require('noice').cmd 'telescope'
    end, { desc = 'Show message history' })

    keymap('n', '<leader>mc', function()
      require('noice').cmd 'dismiss'
    end, { desc = 'Close messages' })
  end,
}
