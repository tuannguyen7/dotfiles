require('telescope').setup{
  defaults = {
    vimgrep_arguments = {
      'rg',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case',
      '--hidden'
    },
    file_previewer = require'telescope.previewers'.cat.new
  }
}

local telescopeBuiltin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', telescopeBuiltin.find_files, { noremap = true })
vim.keymap.set('n', '<leader>fg', telescopeBuiltin.live_grep, { noremap = true })
vim.keymap.set('n', '<leader>fb', telescopeBuiltin.buffers, { noremap = true })
vim.keymap.set('n', '<leader>fh', telescopeBuiltin.help_tags, { noremap = true })
vim.keymap.set('n', '<leader>fc', telescopeBuiltin.colorscheme, { noremap = true })