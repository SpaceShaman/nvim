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
          location = vim.fn.exepath 'vue-language-server',
          languages = { 'vue' },
          configNamespace = 'typescript',
          enableForWorkspaceTypeScriptVersions = true,
        },
      },
    },
    filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
  },
  tailwindcss = {},
  vue_ls = {},
  -- expert = {},
  elixirls = {},
  dockerls = {},
  docker_compose_language_service = {
    filetypes = { 'yaml', 'docker-compose' },
    root_markers = { '*compose*.yaml', '*compose*.yml' },
  },
}
