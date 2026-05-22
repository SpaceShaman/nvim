return {
  'nvim-neotest/neotest',
  commit = '72bc8f1ec62a590fb47368c81f89610e0f353e28',
  dependencies = {
    { 'nvim-neotest/nvim-nio', commit = '21f5324bfac14e22ba26553caf69ec76ae8a7662' },
    { 'nvim-lua/plenary.nvim', commit = 'b9fd5226c2f76c951fc8ed5923d85e4de065e509' },
    { 'antoinemadec/FixCursorHold.nvim', commit = '1900f89dc17c603eec29960f57c00bd9ae696495' },
    { 'nvim-treesitter/nvim-treesitter', commit = '6620ae1c44dfa8623b22d0cbf873a9e8d073b849' },
    { 'nvim-neotest/neotest-python', commit = 'b0d3a861bd85689d8ed73f0590c47963a7eb1bf9' },
    { 'marilari88/neotest-vitest', commit = 'f01addc6f07b79ef1be5f4297eafbee9e0959018' },
    -- { dir = '/home/ton618/Dev/neotest-python' },
    { 'folke/which-key.nvim', commit = '3aab2147e74890957785941f0c1ad87d0a44c15a' },
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
