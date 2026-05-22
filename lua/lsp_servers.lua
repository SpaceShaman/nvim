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
  basedpyright = {
    on_attach = function(client)
      -- disable rename — handled by other LSPs to avoid double prompt
      client.server_capabilities.renameProvider = false
    end,
    handlers = {
      -- disable all diagnostics from basedpyright (handled by ruff + ty)
      ['textDocument/publishDiagnostics'] = function() end,
    },
    settings = {
      basedpyright = {
        analysis = {
          typeCheckingMode = 'off', -- type checking handled by ty
          autoSearchPaths = true,
          useLibraryCodeForTypes = true,
        },
      },
    },
  }, -- Python completion and import suggestions
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
  docker_compose_language_service = {
    filetypes = { 'yaml', 'docker-compose' },
    root_markers = { '*compose*.yaml', '*compose*.yml' },
  },
}
