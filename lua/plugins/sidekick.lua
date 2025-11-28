return {
  'folke/sidekick.nvim',
  config = function()
    local map = vim.keymap.set
    local sidekick = require 'sidekick'
    local sidekick_cli = require 'sidekick.cli'
    sidekick.setup {
      cli = {
        mux = {
          enabled = true,
          backend = 'tmux',
        },
      },
    }
    map('n', '<Tab>', function()
      -- if there is a next edit, jump to it, otherwise apply it if any
      if not sidekick.nes_jump_or_apply() then
        return '<Tab>' -- fallback to normal tab
      end
    end, { expr = true })

    local toggle_cli = function()
      sidekick_cli.toggle { name = 'copilot', focus = true }
    end

    map('n', '<leader>i', toggle_cli, { desc = 'AI Toggle', silent = true })
    map({ 'i', 'n', 't' }, '<A-i>', toggle_cli, { desc = 'AI Toggle', silent = true })

    local send_selection = function()
      sidekick_cli.send { msg = '{selection}' }
    end

    map('x', '<leader>i', send_selection, { desc = 'Send Selection to AI', silent = true })
    map('x', '<A-i>', send_selection, { desc = 'Send Selection to AI', silent = true })
  end,
}
