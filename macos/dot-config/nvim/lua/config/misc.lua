-- Copy relative path
vim.keymap.set("n", "<leader>cf", '<cmd>let @+ = expand("%")<CR>', { desc = "Copy relative path" })

-- Copy absolute path
vim.keymap.set("n", "<leader>cF", '<cmd>let @+ = expand("%:p")<CR>', { desc = "Copy absolute path" })
