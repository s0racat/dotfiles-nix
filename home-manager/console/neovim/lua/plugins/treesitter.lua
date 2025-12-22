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
		"nvim-treesitter/nvim-treesitter-context",
		event = "BufReadPost",
		config = function()
			require("treesitter-context").setup({
				enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
				-- multiwindow = false, -- Enable multiwindow support.
				--   max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
				--   min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
				--   line_numbers = true,
				--   multiline_threshold = 20, -- Maximum number of lines to show for a single context
				--   trim_scope = 'outer', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
				-- mode = 'topline', -- Line used to calculate context. Choices: 'cursor', 'topline'
				--   -- Separator between context and content. Should be a single character string, like '-'.
				--   -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
				--   separator = nil,
				--   zindex = 20, -- The Z-index of the context window
				-- on_attach = function()
				-- 	vim.cmd('set ft?')
				-- end, -- (fun(buf: integer): boolean) return false to disable attaching
			})
			vim.api.nvim_set_hl(0, "TreesitterContext", {
				fg = "NONE",
				bg = "#3b4252",
				italic = true,
				sp = "NONE",
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
