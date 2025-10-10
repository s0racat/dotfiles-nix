local spec = {
	{
		"vim-jp/vimdoc-ja",
		event = "CmdlineEnter",
		config = function()
			vim.o.helplang = "ja,en"
		end,
	},

	{
		"simeji/winresizer",
		keys = {
			"<C-e>",
		},
	},
}
return spec
