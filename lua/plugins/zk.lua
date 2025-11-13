return {
  'zk-org/zk-nvim',
  config = function()
    require('zk').setup {
      picker = 'telescope',
    }
    local map = function(mode, lhs, rhs, desc)
      local opts = { noremap = true, silent = true }
      if desc ~= '' then
        opts.desc = desc
      end
      vim.keymap.set(mode, lhs, rhs, opts)
    end

    map('n', '<leader>zn', "<Cmd>ZkNew { title = vim.fn.input('Title: ') }<CR>", 'Create a new note')
    map('n', '<leader>zo', "<Cmd>ZkNotes { sort = { 'modified' } }<CR>", 'Open notes')
    map('n', '<leader>zt', '<Cmd>ZkTags<CR>', 'Open notes associated with the selected tags')
    map('n', '<leader>zf', "<Cmd>ZkNotes { sort = { 'modified' }, match = { vim.fn.input('Search: ') } }<CR>", 'Search for the notes matching a given query')
    map('v', '<leader>zf', ":'<,'>ZkMatch<CR>", 'Search for the notes matching the current visual selection')
    -- More keybindings for Markdown buffers only.
    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'markdown',
      callback = function()
        if require('zk.util').notebook_root(vim.fn.expand '%:p') ~= nil then
          map('n', '<CR>', '<Cmd>lua vim.lsp.buf.definition()<CR>', 'Open the link under the caret')
          map('n', '<leader>zb', '<Cmd>ZkBacklinks<CR>', 'Open notes linking to the current buffer')
          map('n', '<leader>zk', '<Cmd>ZkLinks<CR>', 'Open notes linked by the current buffer')
          map('n', '<leader>zn', "<Cmd>ZkNew { dir = vim.fn.expand('%:p:h'), title = vim.fn.input('Title: ') }<CR>", 'Create a new note')
          map('v', '<leader>zn', ":'<,'>ZkNewFromContentSelection { title = vim.fn.input('Title: ') }<CR>", 'Create a new note using the current selection')
          map('n', '<leader>zp', '<Cmd>lua vim.lsp.buf.hover()<CR>', 'Preview a linked note')
          map('v', '<leader>za', ":'<,'>lua vim.lsp.buf.range_code_action()<CR>", 'Code actions')
          map('n', '<leader>zi', '<Cmd>ZkInsertLink<CR>', 'Insert a link')
        end
      end,
    })
  end,
}
