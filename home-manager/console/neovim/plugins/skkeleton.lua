local spec = {
	{
		"vim-skk/skkeleton",
		config = function()
			local skk_dicts = {}
			table.insert(skk_dicts, "~/.local/share/skk/SKK-JISYO.L")
			vim.fn["skkeleton#config"]({
				eggLikeNewline = true,
				globalDictionaries = skk_dicts,
			})
		end,
		cond = function()
            return vim.fn.has('wsl') ~= 1
		end,
		dependencies = {
			"vim-denops/denops.vim",
			{ "delphinus/skkeleton_indicator.nvim", opts = {} },
		},
		keys = {
			{ id = "skkeleton-enable", "<C-j>", "<Plug>(skkeleton-enable)", mode = { "i", "c", "t" }, noremap = false },
		},
	},
}
return spec
