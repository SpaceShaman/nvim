return {
  'nvim-neotest/neotest',
  dependencies = {
    'nvim-neotest/nvim-nio',
    'nvim-lua/plenary.nvim',
    'antoinemadec/FixCursorHold.nvim',
    'nvim-treesitter/nvim-treesitter',
    'nvim-neotest/neotest-python',
    'folke/which-key.nvim',
  },
  config = function()
    require('neotest').setup {
      adapters = {
        require 'neotest-python' {
          runner = 'pytest',
        },
      },
    }

    local neotest = require 'neotest'
    local keymap = vim.keymap.set

    keymap('n', '<leader>tn', function()
      neotest.run.run()
    end, { desc = 'Run nearest test' })
    keymap('n', '<leader>tf', function()
      neotest.run.run(vim.fn.expand '%')
    end, { desc = 'Run tests in current file' })
    keymap('n', '<leader>ta', function()
      neotest.run.run { suite = true }
    end, { desc = 'Run all tests' })
    keymap('n', '<leader>td', function()
      neotest.run.run { strategy = 'dap' }
    end, { desc = 'Debug nearest test' })
    keymap('n', '<leader>ts', function()
      neotest.run.stop()
    end, { desc = 'Stop tests' })
    keymap('n', '<leader>to', function()
      neotest.output.open()
    end, { desc = 'Show test output' })
    keymap('n', '<leader>tp', function()
      neotest.output_panel.toggle()
    end, { desc = 'Toggle test output panel' })
    keymap('n', '<leader>tt', function()
      neotest.summary.toggle()
    end, { desc = 'Toggle test summary' })
    keymap('n', '<leader>tc', function()
      neotest.run.run { suite = true, env = { CI = true } }
    end, { desc = 'Run all tests in CI mode' })
  end,
}
