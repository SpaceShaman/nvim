return {
  'github/copilot.vim',
  config = function()
    map = vim.keymap.set
    vim.g.copilot_no_tab_map = true

    -- <Right>: if a suggestion is visible -> copilot-next, otherwise -> copilot-suggest
    _G.copilot_next_or_suggest = function()
      -- copilot.vim sets b:_copilot when an inline suggestion is active
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
    -- Smart <Right>
    map('i', '<Right>', 'v:lua.copilot_next_or_suggest()', {
      expr = true,
      replace_keycodes = false,
    })
    map('i', '<Left>', '<Plug>(copilot-previous)')
    map('i', '<C-j>', '<Plug>(copilot-dismiss)')
    map('i', '<C-Right>', '<Plug>(copilot-accept-line)')
  end,
}
