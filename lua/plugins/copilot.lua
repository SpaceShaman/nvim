return {
  'github/copilot.vim',
  config = function()
    local map = vim.keymap.set
    vim.g.copilot_no_tab_map = true

    -- if a suggestion is visible -> copilot-next, otherwise -> copilot-suggest
    local function copilot_next_or_suggest()
      if vim.b._copilot ~= nil then
        return vim.api.nvim_replace_termcodes('<Plug>(copilot-next)', true, true, true)
      else
        return vim.api.nvim_replace_termcodes('<Plug>(copilot-suggest)', true, true, true)
      end
    end

    map('i', '<Tab>', 'copilot#Accept("\\<CR>")', {
      expr = true,
      replace_keycodes = false,
    })
    map('i', '<F13>', '<Plug>(copilot-accept-word)') -- F13 is Ctrl+;
    map('i', '<C-l>', copilot_next_or_suggest, {
      expr = true,
      replace_keycodes = false,
    })
    map('i', '<C-j>', '<Plug>(copilot-dismiss)')
    map('i', '<C-Right>', '<Plug>(copilot-accept-line)')
  end,
}
