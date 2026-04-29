local function set_workspace_shadafile()
  local workspace_path = vim.fn.getcwd()
  local cache_dir = vim.fn.stdpath 'data'
  local unique_id = vim.fn.fnamemodify(workspace_path, ':t') .. '_' .. vim.fn.sha256(workspace_path):sub(1, 8) ---@type string
  local shadafile = cache_dir .. '/myshada/' .. unique_id .. '.shada'
  vim.opt.shadafile = shadafile
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
    local cur_bufnr = vim.fn.bufnr '%'
    local cur_file = vim.fn.fnamemodify(vim.fn.expand '%:p', ':p')
    local cur_line = vim.fn.line '.'
    local deleted = {}

    for _, mark in ipairs(vim.fn.getmarklist()) do
      local name = mark.mark:sub(2, 2)
      if name:match '%u' then
        local same = (mark.pos[1] ~= 0 and mark.pos[1] == cur_bufnr) or (mark.file ~= '' and vim.fn.fnamemodify(mark.file, ':p') == cur_file)
        if same and mark.pos[2] == cur_line then
          vim.cmd('delmarks ' .. name)
          table.insert(deleted, name)
        end
      end
    end

    if #deleted > 0 then
      vim.notify('Deleted mark: ' .. table.concat(deleted, ', '), vim.log.levels.WARN)
    end
  end)

  vim.keymap.set('n', 'Dm', function()
    vim.cmd 'delmarks A-Z'
    vim.notify('All marks deleted', vim.log.levels.WARN)
  end)
end

local function next_free_mark()
  local used = {}

  for _, mark in ipairs(vim.fn.getmarklist()) do
    local name = mark.mark:sub(2, 2)
    if name:match '%u' then
      used[name] = true
    end
  end

  for byte = string.byte 'A', string.byte 'Z' do
    local name = string.char(byte)
    if not used[name] then
      return name
    end
  end
  return nil -- all A–Z occupied
end

local function is_mark_exists_on_line()
  local cur_bufnr = vim.fn.bufnr '%'
  local cur_file = vim.fn.fnamemodify(vim.fn.expand '%:p', ':p')
  local cur_line = vim.fn.line '.'

  for _, mark in ipairs(vim.fn.getmarklist()) do
    local name = mark.mark:sub(2, 2)
    if name:match '%u' then
      local same = (mark.pos[1] ~= 0 and mark.pos[1] == cur_bufnr) or (mark.file ~= '' and vim.fn.fnamemodify(mark.file, ':p') == cur_file)
      if same and mark.pos[2] == cur_line then
        return true
      end
    end
  end
  return false
end

return function()
  set_workspace_shadafile()
  setup_global_mark_navigation()

  vim.keymap.set('n', 'm', function()
    local c = vim.fn.getcharstr()
    if is_mark_exists_on_line() then
      vim.notify('Mark already added: ' .. string.upper(c), vim.log.levels.WARN)
      return
    end
    if c:match '%l' then
      local mark = next_free_mark()
      if mark then
        vim.cmd('mark ' .. mark)
        vim.notify('Mark added: ' .. mark, vim.log.levels.WARN)
      else
        vim.notify('No free mark (A–Z) or line already marked', vim.log.levels.WARN)
      end
    else
      vim.fn.feedkeys('m' .. c, 'n')
    end
  end, { desc = 'Set next free mark on current line', noremap = true })
end
