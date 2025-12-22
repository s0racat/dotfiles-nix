local spec = {

	{
		"kevinhwang91/nvim-hlslens",
		event = "BufReadPost",
		config = function()
			require("hlslens").setup()

			local kopts = { noremap = true, silent = true }

			vim.api.nvim_set_keymap(
				"n",
				"n",
				[[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]],
				kopts
			)
			vim.api.nvim_set_keymap(
				"n",
				"N",
				[[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]],
				kopts
			)
			vim.api.nvim_set_keymap("n", "*", [[*<Cmd>lua require('hlslens').start()<CR>]], kopts)
			vim.api.nvim_set_keymap("n", "#", [[#<Cmd>lua require('hlslens').start()<CR>]], kopts)
			vim.api.nvim_set_keymap("n", "g*", [[g*<Cmd>lua require('hlslens').start()<CR>]], kopts)
			vim.api.nvim_set_keymap("n", "g#", [[g#<Cmd>lua require('hlslens').start()<CR>]], kopts)
		end,
	},
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
		ft = {
			"lua",
			"css",
			"html",
			"sass",
			"less",
			"typescriptreact",
			"conf",
			"vim",
			"i3config",
			"swayconfig",
			"tmux",
		},
	},

	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			spec = {
				{
					"<leader>h",
					group = "Git [H]unk",
					mode = { "n", "v" },
				},
				{
					"<leader>w",
					group = "LSP: [W]orkspace",
				},
			},
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
		"monkoose/matchparen.nvim",
		event = "VeryLazy",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		},
		opts = {},
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
