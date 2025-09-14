local spec = {
	{
		"hrsh7th/nvim-cmp",
		config = function()
			-- [[ Configure nvim-cmp ]]
			-- See `:help cmp`
			local cmp = require("cmp")
			local luasnip = require("luasnip")

			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-n>"] = cmp.mapping.select_next_item(),
					["<C-p>"] = cmp.mapping.select_prev_item(),
					["<C-d>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete({}),
					["<CR>"] = cmp.mapping.confirm({
						behavior = cmp.ConfirmBehavior.Replace,
						select = true,
					}),
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.expand_or_locally_jumpable() then
							luasnip.expand_or_jump()
						else
							fallback()
						end
					end, { "i", "s" }),
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.locally_jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
				}),
				sources = {
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					-- { name = 'skkeleton' },
					{ name = "path" },
					{ name = "nvim_lsp_signature_help" },
					{ name = "buffer" },
				},
			})

			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = "path" },
				}, {
					{
						name = "cmdline",
						option = {
							ignore_cmds = { "Man", "!", "terminal", "read", "write" },
						},
					},
				}),
			})
		end,
	},

	-- {
	--   'rinx/cmp-skkeleton',
	--   event = 'InsertEnter',
	-- },

	{
		"saadparwaiz1/cmp_luasnip",
		config = function()
			local luasnip = require("luasnip")
			require("luasnip.loaders.from_vscode").lazy_load()
			luasnip.config.setup({})
		end,
		event = "InsertEnter",
	},

	{
		"L3MON4D3/LuaSnip",
		dependencies = "rafamadriz/friendly-snippets",
	},

	{
		"hrsh7th/cmp-nvim-lsp",
		event = "InsertEnter",
	},

	{
		"hrsh7th/cmp-nvim-lsp-signature-help",
		event = "InsertEnter",
	},

	{
		"hrsh7th/cmp-cmdline",
		event = "CmdlineEnter",
	},

	{
		"hrsh7th/cmp-buffer",
		event = "InsertEnter",
	},

	{
		"hrsh7th/cmp-path",
		event = { "InsertEnter", "CmdlineEnter" },
	},
}
return spec
