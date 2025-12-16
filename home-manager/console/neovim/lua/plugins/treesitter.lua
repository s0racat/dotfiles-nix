local spec = {
	{
		"nvim-treesitter/nvim-treesitter",
		-- TODO: update to main branch
		branch = "master",
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = {}, -- 必要な言語を指定
				highlight = {
					enable = true,
					additional_vim_regex_highlighting = false,
					disable = { "tmux" },
				},
				indent = {
					enable = true,
				},
			})
		end,
	},

	{
		"windwp/nvim-ts-autotag",
		ft = { "html" },
		config = function()
			require("nvim-ts-autotag").setup({
				opts = {
					-- Defaults
					enable_close = true, -- Auto close tags
					enable_rename = true, -- Auto rename pairs of tags
					enable_close_on_slash = false, -- Auto close on trailing </
				},
				-- Also override individual filetype configs, these take priority.
				-- Empty by default, useful if one of the "opts" global settings
				-- doesn't work well in a specific filetype
				-- per_filetype = {
				-- 	["html"] = {
				-- 		enable_close = false,
				-- 	},
				-- },
			})
		end,
	},

	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		-- TODO: update to main branch
		branch = "master",
		event = "CursorMoved",
		-- TODO: config
	},
}
return spec
