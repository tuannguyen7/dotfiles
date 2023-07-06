vim.opt.timeout = false
vim.opt.encoding = "utf-8"
vim.opt.number = true
vim.opt.linebreak = true
vim.opt.showbreak = "+++"
vim.opt.visualbell = true
vim.opt.autoindent = true
vim.opt.swapfile = false
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.api.nvim_set_keymap("i","jj","<ESC>", { noremap = true })

local nvimTreeApi = require 'nvim-tree.api'
vim.keymap.set('n', '<C-n>', nvimTreeApi.tree.toggle, { noremap = true })

--vim.cmd("colorscheme tokyonight")
vim.cmd("colorscheme catppuccin")

