vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })
-- Remap for dealing with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set("n", ";", ":")
vim.keymap.set("n", "<esc><esc>", ":nohlsearch<cr>")
vim.keymap.set("n", "gT", ":bprev<cr>")
vim.keymap.set("n", "gt", ":bnext<cr>")
vim.keymap.set("n", "<leader>n", ":enew<cr>", { desc = "New buffer" })
vim.keymap.set("n", "<c-q>", ":bdelete<cr>")
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { noremap = true, silent = true })
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
-- ノーマルモード
vim.keymap.set("n", "d", '"_d')
vim.keymap.set("n", "c", '"_c')
vim.keymap.set("n", "x", '"_x')
vim.keymap.set("n", "s", '"_s')
vim.keymap.set("n", "C", '"_C')
vim.keymap.set("n", "S", '"_S')

-- ビジュアルモード
vim.keymap.set("v", "d", '"_d')
vim.keymap.set("v", "c", '"_c')
vim.keymap.set("v", "x", '"_x')

vim.keymap.set({ "n", "v" }, "<leader>p", '"+p', { silent = true })
vim.keymap.set({ "n", "v" }, "<leader>P", '"+P', { silent = true })

