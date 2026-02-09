return {
  'nvim-neotest/neotest',
  dependencies = {
    'nvim-neotest/nvim-nio',
    'nvim-lua/plenary.nvim',
    'antoinemadec/FixCursorHold.nvim',
    'nvim-treesitter/nvim-treesitter',
    'nvim-neotest/neotest-python',
    'marilari88/neotest-vitest',
    -- { dir = '/home/ton618/Dev/neotest-python' },
    'folke/which-key.nvim',
  },
  config = function()
    require('neotest').setup {
      adapters = {
        require 'neotest-python' {
          runner = 'pytest',
          -- args = { '-n', 'auto' },
        },
        require 'neotest-vitest',
      },
    }

    local neotest = require 'neotest'
    local keymap = vim.keymap.set

    keymap('', '<F7>', function()
      neotest.run.run_last()
      neotest.summary.open()
    end, { desc = 'Run last tests' })
    keymap('', '<F8>', function()
      neotest.run.run()
      neotest.summary.open()
    end, { desc = 'Run nearest test' })
    keymap('n', '<F9>', function()
      neotest.run.run(vim.fn.expand '%')
      neotest.summary.open()
    end, { desc = 'Run tests in current file' })
    keymap('n', '<F10>', function()
      neotest.summary.toggle()
    end, { desc = 'Toggle test summary' })
    keymap('n', '<F11>', function()
      neotest.run.run { suite = true }
      neotest.summary.open()
    end, { desc = 'Run all tests' })
    keymap('n', '<F12>', function()
      neotest.run.run_last { strategy = 'dap' }
    end, { desc = 'Debug last test' })

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
