vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })
-- Remap for dealing with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set("n", ";", ":")
vim.keymap.set("n", "<C-l>", ":nohlsearch<cr>")
vim.keymap.set("n", "<c-p>", ":bprev<cr>")
vim.keymap.set("n", "<c-n>", ":bnext<cr>")
vim.keymap.set("n", "<c-q>", ":bdelete<cr>")
