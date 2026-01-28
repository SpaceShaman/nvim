return {
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  build = ':TSUpdate',
  dependencies = {
    'nvim-treesitter/nvim-treesitter-context',
    'RRethy/nvim-treesitter-endwise',
  },
  config = function()
    local languages = {
      'bash',
      'c',
      'diff',
      'html',
      'lua',
      'luadoc',
      'markdown',
      'markdown_inline',
      'query',
      'vim',
      'vimdoc',
      'python',
      'elixir',
      'eex',
      'heex',
      'typst',
      'yaml',
      'vue',
      'typescript',
      'javascript',
      'json',
      -- 'dockerfile',
    }
    require('nvim-treesitter').install(languages)

    -- Enable treesitter highlighting automatically
    vim.api.nvim_create_autocmd('FileType', {
      callback = function(args)
        local buf = args.buf
        local lang = vim.treesitter.language.get_lang(args.match)
        if not lang then
          return
        end

        -- Try to start treesitter if parser is available
        local ok = pcall(vim.treesitter.start, buf, lang)
        if not ok then
          -- Parser might not be installed yet, ignore silently
          return
        end
      end,
    })
  end,
}
