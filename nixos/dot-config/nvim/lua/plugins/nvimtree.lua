return {
  "nvim-tree/nvim-tree.lua",
  opts = {
    sort = {
      sorter = "case_sensitive",
    },
    view = {
      width = 30,
    },
    renderer = {
      group_empty = true,
    },
    filters = {
      dotfiles = false,
    },
  },
  init = function()
    -- Disable netrw at the very start
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    -- Enable 24-bit color
    vim.opt.termguicolors = true
  end,
  config = function(_, opts)
    require("nvim-tree").setup(opts)
    -- Apply your setup
    -- Custom keymap using the API
    local api = require("nvim-tree.api")
    vim.keymap.set("n", "<leader>e", function()
      api.tree.find_file({ open = false, focus = true, update_root = true })
    end, { desc = "Reveal file in NvimTree" })

    vim.keymap.set('n', '<C-n>', api.tree.toggle, { noremap = true })
  end,
}
