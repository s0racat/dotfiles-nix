local spec = {
	{
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			opts.ensure_installed = {}
		end,
	},

	{
		"nvim-treesitter/nvim-treesitter-textobjects",
	},
}
return spec
