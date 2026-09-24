return {
  'nvim-treesitter/nvim-treesitter',
  commit = 'f603a2f4da48728f80257fb5fbb90145fd1dc173',
  lazy = false,
  build = ':TSUpdate',
  dependencies = {
    -- { 'nvim-treesitter/nvim-treesitter-context', commit = 'adf4b6b0420b7be6c717ef0ac7993183d6c201b1' },
    { 'RRethy/nvim-treesitter-endwise', commit = '8fe8a95630f4f2c72a87ba1927af649e0bfaa244' },
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
