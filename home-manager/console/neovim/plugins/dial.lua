local spec = {
	{
		"monaqa/dial.nvim",
		keys = {
			{ "<C-a>", mode = "n" },
			{ "<C-x>", mode = "n" },
			{ "g<C-a>", mode = "n" },
			{ "g<C-x>", mode = "n" },
			{ "<C-a>", mode = "v" },
			{ "<C-x>", mode = "v" },
			{ "g<C-a>", mode = "v" },
			{ "g<C-x>", mode = "v" },
		},
		config = function()
			local augend = require("dial.augend")
			require("dial.config").augends:register_group({
				-- default augends used when no group name is specified
				default = {
					augend.integer.alias.decimal, -- nonnegative decimal number (0, 1, 2, 3, ...)
					augend.integer.alias.hex, -- nonnegative hex number  (0x01, 0x1a1f, etc.)
					augend.date.alias["%Y/%m/%d"], -- date (2022/02/19, etc.)
					augend.constant.alias.bool,
				},
			})
			local dial = require("dial.map")
			-- Normal mode mappings
			vim.keymap.set("n", "<C-a>", function()
				dial.manipulate("increment", "normal")
			end)
			vim.keymap.set("n", "<C-x>", function()
				dial.manipulate("decrement", "normal")
			end)
			vim.keymap.set("n", "g<C-a>", function()
				dial.manipulate("increment", "gnormal")
			end)
			vim.keymap.set("n", "g<C-x>", function()
				dial.manipulate("decrement", "gnormal")
			end)

			-- Visual mode mappings
			vim.keymap.set("v", "<C-a>", function()
				dial.manipulate("increment", "visual")
			end)
			vim.keymap.set("v", "<C-x>", function()
				dial.manipulate("decrement", "visual")
			end)
			vim.keymap.set("v", "g<C-a>", function()
				dial.manipulate("increment", "gvisual")
			end)
			vim.keymap.set("v", "g<C-x>", function()
				dial.manipulate("decrement", "gvisual")
			end)
		end,
	},
}

return spec
