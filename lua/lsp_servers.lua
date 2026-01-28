local home_dir = vim.fn.expand '~'
return {
  lua_ls = {
    settings = {
      Lua = {
        completion = {
          callSnippet = 'Replace',
        },
      },
    },
  },
  ruff = {}, -- Python linter and formatter backed by Astral
  ty = {}, -- Python type checker and language server, backed by Astral
  ts_ls = {
    init_options = {
      plugins = {
        {
          name = '@vue/typescript-plugin',
          location = vim.fn.expand '$MASON/packages/vue-language-server/node_modules/@vue/language-server',
          languages = { 'vue' },
          configNamespace = 'typescript',
        },
      },
    },
    filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
  },
  tailwindcss = {},
  stylua = {}, -- Used to format Lua code
  prettier = {},
  vue_ls = {},
  -- expert = {},
  elixirls = {},
  tombi = {},
  dockerls = {},
}
