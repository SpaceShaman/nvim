return {
  'nvim-neotest/neotest',
  dependencies = {
    'nvim-neotest/nvim-nio',
    'nvim-lua/plenary.nvim',
    'antoinemadec/FixCursorHold.nvim',
    'nvim-treesitter/nvim-treesitter',
    'nvim-neotest/neotest-python',
    'marilari88/neotest-vitest',
    'folke/which-key.nvim',
  },
  config = function()
    require('neotest').setup {
      adapters = {
        require 'neotest-python' {
          runner = 'pytest',
        },
        require 'neotest-vitest',
      },
    }

    local neotest = require 'neotest'
    local keymap = vim.keymap.set

    keymap('n', 'gtn', function()
      neotest.run.run()
    end, { desc = 'Run nearest test' })
    keymap('n', 'gtf', function()
      neotest.run.run(vim.fn.expand '%')
    end, { desc = 'Run tests in current file' })
    keymap('n', 'gta', function()
      neotest.run.run { suite = true }
    end, { desc = 'Run all tests' })
    keymap('n', 'gtd', function()
      neotest.run.run { strategy = 'dap' }
    end, { desc = 'Debug nearest test' })
    keymap('n', 'gts', function()
      neotest.run.stop()
    end, { desc = 'Stop tests' })
    keymap('n', 'gto', function()
      neotest.output.open()
    end, { desc = 'Show test output' })
    keymap('n', 'gtp', function()
      neotest.output_panel.toggle()
    end, { desc = 'Toggle test output panel' })
    keymap('n', 'gtt', function()
      neotest.summary.toggle()
    end, { desc = 'Toggle test summary' })
    keymap('n', 'gtc', function()
      neotest.run.run { suite = true, env = { CI = true } }
    end, { desc = 'Run all tests in CI mode' })
    keymap('n', ']t', function()
      neotest.jump.next { status = 'failed' }
    end, { desc = 'Next failed test' })
    keymap('n', '[t', function()
      neotest.jump.prev { status = 'failed' }
    end, { desc = 'Prev failed test' })
  end,
}
