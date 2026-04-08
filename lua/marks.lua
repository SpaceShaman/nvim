local function set_workspace_shadafile()
  local workspace_path = vim.fn.getcwd()
  local cache_dir = vim.fn.stdpath 'data'
  local unique_id = vim.fn.fnamemodify(workspace_path, ':t') .. '_' .. vim.fn.sha256(workspace_path):sub(1, 8) ---@type string
  local shadafile = cache_dir .. '/myshada/' .. unique_id .. '.shada'
  vim.opt.shadafile = shadafile
end

local function remap_lowercase_marks_to_global()
  -- Remaps Vim mark commands so that lowercase marks behave as global.
  -- Normally, 'a–z' marks are buffer-local and 'A–Z' marks are global.
  -- With this mapping:
  --   - typing `ma` will actually set the global mark `A`
  --   - jumping with `'a` or `` `a `` will go to the global `A` mark
  -- Non-letter marks (like `m1`, `m/`) remain unchanged.
  -- This ensures all user-defined marks act globally across buffers.
  local function upper_if_lower(c)
    return (c:match '%l' and c:upper()) or c
  end

  local function map_mark_prefix(prefix)
    vim.keymap.set('n', prefix, function()
      local c = vim.fn.getcharstr()
      return prefix .. upper_if_lower(c)
    end, { expr = true, noremap = true })
  end

  map_mark_prefix 'm'
  map_mark_prefix "'"
  map_mark_prefix '`'
end

local function setup_global_mark_navigation()
  local marks = {}
  local idx = 0

  local function refresh_marks()
    marks = {}
    for _, mark in ipairs(vim.fn.getmarklist()) do
      local name = mark.mark:sub(2, 2)
      if name:match '%u' then
        table.insert(marks, name)
      end
    end
    table.sort(marks)
  end

  vim.keymap.set('n', '<Left>', function()
    refresh_marks()
    if #marks == 0 then
      return
    end
    idx = (idx % #marks) + 1
    vim.cmd("normal! '" .. marks[idx])
  end)

  vim.keymap.set('n', '<Right>', function()
    refresh_marks()
    if #marks == 0 then
      return
    end
    idx = ((idx - 2) % #marks) + 1
    vim.cmd("normal! '" .. marks[idx])
  end)

  vim.keymap.set('n', 'dm', function()
    local c = vim.fn.getcharstr()

    if c == 'A' then
      vim.cmd 'delmarks A-Z'
      vim.notify('All global marks deleted', vim.log.levels.WARN)
    elseif c:match '%a' then
      vim.cmd('delmarks ' .. c:upper())
      vim.notify('Global mark ' .. c:upper() .. ' deleted', vim.log.levels.WARN)
    end
  end)
end

return function()
  remap_lowercase_marks_to_global()
  set_workspace_shadafile()
  setup_global_mark_navigation()
end
