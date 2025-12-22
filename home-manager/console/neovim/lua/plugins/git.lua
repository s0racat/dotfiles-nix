local spec = {
	{
		-- Adds git related signs to the gutter, as well as utilities for managing changes
		"lewis6991/gitsigns.nvim",
		event = "VeryLazy",
		opts = {
			-- See `:help gitsigns.txt`
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
			},

			on_attach = function(bufnr)
				local gitsigns = require("gitsigns")

				local function map(mode, l, r, opts)
					opts = opts or {}
					opts.buffer = bufnr
					vim.keymap.set(mode, l, r, opts)
				end

				-- Navigation
				map("n", "]c", function()
					if vim.wo.diff then
						vim.cmd.normal({ "]c", bang = true })
					else
						gitsigns.nav_hunk("next")
					end
				end, { desc = "Git: Next Hunk" })

				map("n", "[c", function()
					if vim.wo.diff then
						vim.cmd.normal({ "[c", bang = true })
					else
						gitsigns.nav_hunk("prev")
					end
				end)

				-- Actions
				map("n", "<leader>hs", gitsigns.stage_hunk, { desc = "Git: Stage Hunk" })
				map("n", "<leader>hr", gitsigns.reset_hunk, { desc = "Git: Reset Hunk" })

				map("v", "<leader>hs", function()
					gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end, { desc = "Git: Stage Hunk" })

				map("v", "<leader>hr", function()
					gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end, { desc = "Git: Reset Hunk" })

				map("n", "<leader>hS", gitsigns.stage_buffer, { desc = "Git: Stage Buffer" })
				map("n", "<leader>hR", gitsigns.reset_buffer, { desc = "Git: Reset Buffer" })
				map("n", "<leader>hp", gitsigns.preview_hunk, { desc = "Git: Preview Hunk" })
				map("n", "<leader>hi", gitsigns.preview_hunk_inline, { desc = "Git: Preview Hunk Inline" })

				map("n", "<leader>hb", function()
					gitsigns.blame_line({ full = true })
				end, { desc = "Git: Blame Line" })

				map("n", "<leader>hd", gitsigns.diffthis, { desc = "Git: Diff This" })

				map("n", "<leader>hD", function()
					gitsigns.diffthis("~")
				end, { desc = "Git: Diff This ~" })

				map("n", "<leader>hQ", function()
					gitsigns.setqflist("all")
				end, { desc = "Git: Set QF List" })
				map("n", "<leader>hq", gitsigns.setqflist, { desc = "Git: Set QF List (Hunks)" })

				-- Toggles
				map("n", "<leader>tb", gitsigns.toggle_current_line_blame, { desc = "Git: Toggle Current Line Blame" })
				map("n", "<leader>tw", gitsigns.toggle_word_diff, { desc = "Git: Toggle Word Diff" })

				-- Text object
				map({ "o", "x" }, "ih", gitsigns.select_hunk, { desc = "Git: Inner Hunk" })
			end,
		},
	},
}
return spec
