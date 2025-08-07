return {
  'nvim-telescope/telescope.nvim',
  event = 'VimEnter',
  dependencies = {
    'nvim-lua/plenary.nvim',
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
    { 'nvim-telescope/telescope-ui-select.nvim' },
    { 'nvim-tree/nvim-web-devicons' },
  },
  config = function()
    -- Two important keymaps to use while in Telescope are:
    --  - Insert mode: <c-/>
    --  - Normal mode: ?
    -- [[ Configure Telescope ]]
    -- See `:help telescope` and `:help telescope.setup()`
    require('telescope').setup {
      defaults = {
        mappings = {
          i = {
            ['<ESC>'] = 'close',
            ['<M-BS>'] = { '<C-o>db<C-o>x', type = 'command', opts = { desc = 'Delete previous word' } },
            ['<C-s>'] = require('telescope.actions').select_vertical,
            ['<C-h>'] = require('telescope.actions').select_horizontal,
          },
        },
      },
      -- pickers = {}
      extensions = {
        ['ui-select'] = {
          require('telescope.themes').get_dropdown(),
        },
      },
    }

    -- Enable Telescope extensions if they are installed
    pcall(require('telescope').load_extension, 'fzf')
    pcall(require('telescope').load_extension, 'ui-select')

    -- See `:help telescope.builtin`
    local telescope = require 'telescope.builtin'
    local keymap = vim.keymap.set

    keymap('n', '<leader>sh', telescope.help_tags, { desc = '[S]earch [H]elp' })
    keymap('n', '<leader>sk', telescope.keymaps, { desc = '[S]earch [K]eymaps' })
    keymap('n', '<leader>sf', telescope.find_files, { desc = '[S]earch [F]iles' })
    keymap('n', '<leader>f', telescope.find_files, { desc = '[S]earch [F]iles' })
    keymap('n', '<leader>ss', telescope.builtin, { desc = '[S]earch [S]elect Telescope' })
    keymap('n', '<leader>sw', telescope.grep_string, { desc = '[S]earch current [W]ord' })
    keymap('n', '<leader>sg', telescope.live_grep, { desc = '[S]earch by [G]rep' })
    keymap('n', '<leader>sd', telescope.diagnostics, { desc = '[S]earch [D]iagnostics' })
    keymap('n', '<leader>sr', telescope.resume, { desc = '[S]earch [R]esume' })
    keymap('n', '<leader>s.', telescope.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
    keymap('n', '<leader>.', telescope.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
    keymap('n', '<leader><leader>', telescope.buffers, { desc = '[ ] Find existing buffers' })

    keymap('n', '<leader>/', function()
      -- You can pass additional configuration to Telescope to change the theme, layout, etc.
      telescope.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown())
    end, { desc = '[/] Fuzzily search in current buffer' })

    keymap('n', '<leader>s/', function()
      telescope.live_grep {
        grep_open_files = true,
        prompt_title = 'Live Grep in Open Files',
      }
    end, { desc = '[S]earch [/] in Open Files' })

    keymap('n', '<leader>sn', function()
      telescope.find_files { cwd = vim.fn.stdpath 'config' }
    end, { desc = '[S]earch [N]eovim files' })
  end,
}
