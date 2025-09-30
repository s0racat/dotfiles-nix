local function skkeleton()
	local ok, mode = pcall(vim.fn["skkeleton#mode"])
	if not ok then
		return ""
	end

	if mode == "hira" then
		return "ひら"
	elseif mode == "kata" then
		return "カタ"
	elseif mode == "hankata" then
		return "半カナ"
	elseif mode == "zenkaku" then
		return "全英"
	elseif mode == "abbrev" then
		return "abbr"
	else
		return "英数"
	end
	return ""
end
local spec = {
	{
		"shaunsingh/nord.nvim",
		priority = 1000,
		lazy = false,
		config = function()
			vim.g.nord_italic = false
			require("nord").set()
			vim.api.nvim_set_hl(0, "MatchParen", {
				fg = "#eceff4",
				bg = "#5e81ac",
				bold = true,
			})
		end,
	},

	{
		-- Set lualine as statusline
		"nvim-lualine/lualine.nvim",
		-- See `:help lualine.txt`
		event = "VeryLazy",
		opts = {
			options = {
				icons_enabled = true,
				theme = "nord",
				-- component_separators = { left = '', right = '' },
				-- section_separators = { left = '', right = '' }
			},
			sections = {
				lualine_x = { skkeleton },
			},
		},
	},

	{ "nvim-tree/nvim-web-devicons", opt = true },

	{
		"akinsho/bufferline.nvim",
		version = "*",
		config = function()
			vim.opt.termguicolors = true
			local highlights = require("nord").bufferline.highlights({
				italic = true,
				bold = true,
			})

			require("bufferline").setup({
				options = {
					separator_style = "thin",
				},
				highlights = highlights,
			})
		end,
		event = "VeryLazy",
	},
}
return spec
