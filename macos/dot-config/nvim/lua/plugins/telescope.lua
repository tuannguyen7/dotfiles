return {
    'nvim-telescope/telescope.nvim', tag = '0.1.8',
   opts = {
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
  },
  keys = {
    { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
    { "<leader>fg", "<cmd>Telescope live_grep<cr>" },
    { "<leader>fb", "<cmd>Telescope buffers<cr>" },
    { "<leader>fh", "<cmd>Telescope help_tags<cr>" },
    { "<leader>fh", "<cmd>Telescope colorscheme<cr>" },
  }
}

