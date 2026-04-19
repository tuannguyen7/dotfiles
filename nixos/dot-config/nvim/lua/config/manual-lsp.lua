vim.lsp.config['go_ls'] = {
  -- Command and arguments to start the server.
  cmd = { '/Users/tunguyen/.local/share/nvim/mason/bin/gopls' },
  -- Filetypes to automatically attach to.
  filetypes = { 'go' },
  -- Sets the "workspace" to the directory where any of these files is found.
  -- Files that share a root directory will reuse the LSP server connection.
  -- Nested lists indicate equal priority, see |vim.lsp.Config|.
  -- root_markers = { { '.luarc.json', '.luarc.jsonc' }, '.git' },
  -- Specific settings to send to the server. The schema is server-defined.
  -- Example: https://raw.githubusercontent.com/LuaLS/vscode-lua/master/setting/schema.json
}

vim.lsp.enable('go_ls')
