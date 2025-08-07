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
      output = { open_on_run = true },
    }

    local neotest = require 'neotest'
    require('which-key').add {
      { '<leader>t', group = '[T]ests' },
      {
        '<leader>tn',
        function()
          neotest.run.run()
        end,
        desc = 'Run nearest test',
      },
      {
        '<leader>tf',
        function()
          neotest.run.run(vim.fn.expand '%')
        end,
        desc = 'Run tests in current file',
      },
      {
        '<leader>ta',
        function()
          neotest.run.run { suite = true }
        end,
        desc = 'Run all tests',
      },
      {
        '<leader>td',
        function()
          neotest.run.run { strategy = 'dap' }
        end,
        desc = 'Debug nearest test',
      },
      {
        '<leader>ts',
        function()
          neotest.run.stop()
        end,
        desc = 'Stop tests',
      },
      {
        '<leader>to',
        function()
          neotest.output.open()
        end,
        desc = 'Show test output',
      },
      {
        '<leader>tp',
        function()
          neotest.output_panel.toggle()
        end,
        desc = 'Toggle test output panel',
      },
      {
        '<leader>tt',
        function()
          neotest.summary.toggle()
        end,
        desc = 'Toggle test summary',
      },
      {
        '<leader>tc',
        function()
          neotest.run.run { suite = true, env = { CI = true } }
        end,
        desc = 'Run all tests in CI mode',
      },
    }
  end,
}
