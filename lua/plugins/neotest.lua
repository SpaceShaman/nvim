return {
  'nvim-neotest/neotest',
  dependencies = {
    'nvim-neotest/nvim-nio',
    'nvim-lua/plenary.nvim',
    'antoinemadec/FixCursorHold.nvim',
    'nvim-treesitter/nvim-treesitter',
    'nvim-neotest/neotest-python',
  },
  config = function()
    require('neotest').setup {
      adapters = {
        require 'neotest-python' {
          dap = { justMyCode = false },
          runner = 'pytest',
        },
      },
    }

    local map = vim.keymap.set
    local neotest = require 'neotest'

    map('n', '<leader>tt', function()
      neotest.summary.toggle()
    end, { desc = 'Toggle test summary' })

    map('n', '<leader>tn', function()
      neotest.run.run()
    end, { desc = 'Run nearest test' })

    map('n', '<leader>tf', function()
      neotest.run.run(vim.fn.expand '%')
    end, { desc = 'Run tests in current file' })

    map('n', '<leader>td', function()
      neotest.run.run { strategy = 'dap' }
    end, { desc = 'Debug nearest test' })
  end,
}
