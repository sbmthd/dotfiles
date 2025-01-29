-- LSP Plugin-- LSP Plugins
return {
	{
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = {
				{ path = "luvit-meta/library", words = { "vim%.uv" } },
			},
		},
	},
	{ "Bilal2453/luvit-meta", lazy = true },
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{ "williamboman/mason.nvim", config = true },
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			{ "j-hui/fidget.nvim", opts = {} },
			-- Add blink as a dependency
			"saghen/blink.cmp",
		},
		config = function()
			-- [Your existing LSP attach autocmd code remains unchanged until the capabilities section]

			-- Update the capabilities section to use blink's get_lsp_capabilities
			local capabilities = require("blink.cmp").get_lsp_capabilities()

			-- Your servers configuration remains the same
			local servers = {
				lua_ls = {
					settings = {
						Lua = {
							completion = {
								callSnippet = "Replace",
							},
						},
					},
				},

				volar = {
					-- Your existing volar config remains unchanged
					filetypes = { "typescript", "javascript", "vue" },
					init_options = {
						typescript = {
							tsdk = vim.fn.expand("$HOME/node_modules/typescript/lib"),
						},
						vue = {
							hybridMode = false,
						},
					},
					settings = {
						-- Your existing volar settings remain unchanged
						typescript = {
							suggest = {
								enabled = true,
								paths = true,
								autoImports = true,
								completeFunctionCalls = true,
								includeCompletionsForImportStatements = true,
								includeCompletionsWithClassMemberSnippets = true,
								includeAutomaticOptionalChainCompletions = true,
								includeCompletionsForModuleExports = true,
								includeCompletionsWithSnippetText = true,
								includeCompletionsWithInsertText = true,
								includePackageJsonAutoImports = "auto",
								includeCompletionsWithObjectLiteralMethodSnippets = true,
								generateReturnInDocTemplate = true,
							},
						},
					},

					ts_ls = {
						-- Your existing ts_ls config remains unchanged
						filetypes = { "typescript", "javascript", "vue" },
						init_options = {
							preferences = {
								disableSuggestions = false,
								includeCompletionsForModuleExports = true,
							},
							plugins = {
								{
									name = "@vue/typescript-plugin",
									location = vim.fn.stdpath("data")
										.. "/mason/packages/vue-language-server/node_modules/@vue/language-server",
									languages = { "vue" },
								},
							},
						},
					},
				},
			}

			-- Mason setup remains the same
			require("mason").setup()

			local ensure_installed = vim.tbl_keys(servers or {})
			vim.list_extend(ensure_installed, {
				"stylua",
			})
			require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

			require("mason-lspconfig").setup({
				handlers = {
					function(server_name)
						local server = servers[server_name] or {}
						-- Update capabilities handling
						server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
						require("lspconfig")[server_name].setup(server)
					end,
				},
			})
		end,
	},
}
-- vim: ts=2 sts=2 sw=2 et
