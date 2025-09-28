local spec = {
	{
		"nvim-treesitter/nvim-treesitter",
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = {}, -- 必要な言語を指定
				highlight = {
					enable = true,
				},
				indent = {
					enable = true,
				},
			})
		end,
	},

	{
		"nvim-treesitter/nvim-treesitter-textobjects",
	},
}
return spec
