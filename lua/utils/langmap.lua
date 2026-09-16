local M = {}

-- Translate a modified key without folding its modifiers (e.g. Shift+l to L).
-- Call after the mapping has been created, including mappings owned by plugins.
function M.translate_mapping(modes, lhs, from, to)
  local raw = vim.keycode(lhs)
  assert(raw:sub(-#from) == from, 'Expected mapping to end with ' .. from)
  local translated = raw:sub(1, #raw - #from) .. to

  for _, mode in ipairs(type(modes) == 'table' and modes or { modes }) do
    local mapping = vim.fn.maparg(lhs, mode, false, true)
    assert(not vim.tbl_isempty(mapping), 'Missing ' .. mode .. ' mapping: ' .. lhs)
    mapping.lhsraw = translated
    mapping.lhsrawalt = nil
    -- Keep lhs unchanged: mapset uses it to replace the original mapping.
    -- Using keytrans(translated) here could overwrite a different shortcut.
    vim.fn.mapset(mode, false, mapping)
  end
end

return M
