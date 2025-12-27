local spec = {
	{
		-- LSP Configuration & Plugins
		"neovim/nvim-lspconfig",
		event = { "BufNewFile", "BufReadPre" },
		config = function()
			local on_attach = function(_, bufnr)
				local nmap = function(keys, func, desc)
					if desc then
						desc = "LSP: " .. desc
					end
					vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
				end
				vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
				vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
				vim.keymap.set(
					"n",
					"<leader>de",
					vim.diagnostic.open_float,
					{ desc = "Open floating diagnostic message" }
				)
				-- vim.keymap.set("n", "<leader>dq", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })
				nmap("<leader>ln", vim.lsp.buf.rename, "[R]e[n]ame")
				nmap("<leader>la", vim.lsp.buf.code_action, "[C]ode [A]ction")
				nmap("<leader>lf", vim.lsp.buf.format, "Format")

				nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
				nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
				nmap("gI", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
				nmap("<leader>lt", vim.lsp.buf.type_definition, "Type [D]efinition")
				nmap("<leader>ls", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
				nmap("<leader>lS", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

				-- See `:help K` for why this keymap
				nmap("K", vim.lsp.buf.hover, "Hover Documentation")
				nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")

				-- Lesser used LSP functionality
				nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
				nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
				nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
				nmap("<leader>wl", function()
					print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
				end, "[W]orkspace [L]ist Folders")

				-- Create a command `:Format` local to the LSP buffer
				vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
					vim.lsp.buf.format()
				end, { desc = "Format current buffer with LSP" })
			end

			-- Enable the following language servers
			--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
			--
			--  Add any additional override configuration in the following tables. They will be passed to
			--  the `settings` field of the server config. You must look up that documentation yourself.
			--
			--  If you want to override the default filetypes that your language server will attach to you can
			--  define the property 'filetypes' to the map in question.

			-- Add additional capabilities supported by nvim-cmp
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
			local servers =
				{ "lua_ls", "ts_ls", "bashls", "vimls", "emmet_language_server", "gopls", "nixd", "pyright" }
			vim.lsp.config["lua_ls"] = {
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" },
						},
					},
				},
			}
			--  https://github.com/PriceHiller/dots/blob/5a836299a74205c8babb46f443eb0679c58bdb43/users/price/dots/.config/nvim/lsp/nixd.lua
			vim.lsp.config["nixd"] = {

				cmd = { "nixd" },
				settings = {
					nixd = {
						nixpkgs = {
							expr = "import <nixpkgs> {}",
						},
						formatting = {
							command = { "nixfmt" },
						},
						options = {
							home_manager = {
								expr = "(let pkgs = import <nixpkgs> { }; lib = import ~/.local/share/nix/inputs/home-manager/modules/lib/stdlib-extended.nix pkgs.lib; in (lib.evalModules { modules = (import ~/.local/share/nix/inputs/home-manager/modules/modules.nix) { inherit lib pkgs; check = false; }; })).options",
							},
							nixos = {
								expr = "(let pkgs = import <nixpkgs> { }; in (pkgs.lib.evalModules { modules = (import <nixpkgs/nixos/modules/module-list.nix>) ++ [ ({...}: { nixpkgs.hostPlatform = builtins.currentSystem;} ) ] ; })).options",
							},
						},
					},
				},
			}
			vim.lsp.config["*"] = {
				capabilities = capabilities,
				on_attach = on_attach,
			}

			for _, lsp in ipairs(servers) do
				vim.lsp.enable(lsp)
			end

			--
		end,
	},
	-- Automatically install LSPs to stdpath for neovim

	{
		"j-hui/fidget.nvim",
		event = { "BufReadPre", "BufNewFile" },
		opts = {},
	},
}
return spec
