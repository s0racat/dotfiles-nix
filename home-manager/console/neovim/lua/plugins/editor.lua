local spec = {

	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = function()
			require("nvim-autopairs").setup()
		end,
	},
	{
		"tversteeg/registers.nvim",
		config = function()
			require("registers").setup()
		end,
		keys = {
			{ '"', mode = { "n", "v" } },
			{ "<C-R>", mode = "i" },
		},
		cmd = "Registers",
	},

	{
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup()
		end,
		ft = { "lua", "css", "html", "sass", "less", "typescriptreact", "conf", "vim", "i3config", "swayconfig" },
	},

	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			triggers = {
				{ "<leader>", mode = { "n", "v" } },
			},
		},
	},
	{
		-- Add indentation guides even on blank lines
		"shellRaining/hlchunk.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			require("hlchunk").setup({
				chunk = {
					enable = true,
					-- ...
				},
				indent = {
					enable = true,
					-- ...
				},
			})
		end,
	},
	{
		"hiphish/rainbow-delimiters.nvim",
		event = { "BufReadPost", "BufNewFile" },
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		main = "rainbow-delimiters.setup",
		opts = {},
	},
}

return spec
