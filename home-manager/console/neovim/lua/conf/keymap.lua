vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })
-- Remap for dealing with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set("n", ";", ":")
vim.keymap.set("n", "<esc><esc>", ":nohlsearch<cr>")
vim.keymap.set("n", "<c-p>", ":bprev<cr>")
vim.keymap.set("n", "<c-n>", ":bnext<cr>")
vim.keymap.set("n", "<c-q>", ":bdelete<cr>")
vim.keymap.set("t", "<c-]>", "<c-\\><c-n>", { noremap = true, silent = true })
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

vim.keymap.set("n", "<leader>s", ":%s///g<Left><Left>", { silent = false })
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y', { silent = true }) -- 選択範囲をシステムクリップボードにコピー
vim.keymap.set("n", "<leader>Y", '"+Y', { silent = true }) -- 行全体をシステムクリップボードにコピー
vim.keymap.set("n", "<C-q>", function()
	local bufnr = vim.api.nvim_get_current_buf()
	local buffers = vim.fn.getbufinfo({ buflisted = 1 })
	local count = 0
	for _, buf in ipairs(buffers) do
		if buf.bufnr ~= bufnr then
			count = count + 1
		end
	end

	-- 開いているバッファが他にあればバッファ削除、なければウィンドウ閉じる
	if count > 0 then
		vim.cmd("bdelete")
	else
		vim.cmd("q")
	end
end, { silent = true })

vim.keymap.set("n", "<leader>w", ":w<CR>", { silent = true })
-- ウィンドウ移動は Ctrl + h/j/k/l
vim.keymap.set("n", "<C-h>", "<C-w>h", { silent = true })
vim.keymap.set("n", "<C-j>", "<C-w>j", { silent = true })
vim.keymap.set("n", "<C-k>", "<C-w>k", { silent = true })
vim.keymap.set("n", "<C-l>", "<C-w>l", { silent = true })
