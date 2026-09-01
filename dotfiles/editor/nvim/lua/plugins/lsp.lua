-- lua/plugins/lsp.lua
return {
	"mason-org/mason-lspconfig.nvim",
	dependencies = { "saghen/blink.cmp" },
	config = function()
		local capabilities = require("blink.cmp").get_lsp_capabilities()

		require("mason-lspconfig").setup({
			handlers = {
				function(server_name)
					vim.lsp.config(server_name, { capabilities = capabilities })
					vim.lsp.enable(server_name)
				end,

				["nixd"] = function()
					vim.lsp.config("nixd", {
						capabilities = capabilities,
						settings = {
							nixd = {
								formatting = { command = { "alejandra" } },
							},
						},
					})
					vim.lsp.enable("nixd")
				end,

				["lua_ls"] = function()
					vim.lsp.config("lua_ls", {
						capabilities = capabilities,
						settings = {
							Lua = {
								runtime = { version = "Lua 5.4" },
								diagnostics = { globals = { "vim" } },
								workspace = {
									checkThirdParty = false,
									library = { vim.env.VIMRUNTIME },
								},
							},
						},
					})
					vim.lsp.enable("lua_ls")
				end,

				["kotlin_language_server"] = function()
					vim.lsp.config("kotlin_language_server", {
						capabilities = capabilities,
						init_options = {
							storagePath = vim.fn.stdpath("cache") .. "/kotlin_language_server",
						},
						root_markers = {
							"build.gradle",
							"build.gradle.kts",
							"pom.xml",
							"settings.gradle",
							"settings.gradle.kts",
							".git",
						},
						settings = {
							kotlin = { linting = { enabled = true } },
						},
					})
					vim.lsp.enable("kotlin_language_server")
				end,

				["elmls"] = function()
					vim.lsp.config("elmls", {
						capabilities = capabilities,
						settings = {
							elmLS = {
								elmPath = "elm",
								elmFormatPath = "elm-format",
								elmTestPath = "elm-test",
								elmReviewPath = "elm-review",
								disableElmLSDiagnostics = false,
								onlyUpdateDiagnosticsOnSave = false,
							},
						},
					})
					vim.lsp.enable("elmls")
				end,

				["tombi"] = function()
					vim.lsp.config("tombi", {
						capabilities = capabilities,
						filetypes = { "toml" },
						root_markers = { "tombi.toml", "pyproject.toml", ".git" },
					})
					vim.lsp.enable("tombi")
				end,
			},
		})

		-- asm_lsp: manual, Mason cargo-build fails on NixOS (OpenSSL/pkg-config), so Nix-provided instead
		vim.lsp.config("asm_lsp", {
			capabilities = capabilities,
			cmd = { "asm-lsp" },
			filetypes = { "asm", "s", "S", "vmasm" },
		})
		vim.lsp.enable("asm_lsp")

		-- bacon_ls: manual, system-flake-managed, outside Mason
		vim.lsp.config("bacon_ls", {
			capabilities = capabilities,
			cmd = { "bacon-ls" },
			filetypes = { "rust" },
			root_markers = { "Cargo.toml" },
			settings = {
				bacon_ls = {
					backend = "cargo",
					cargo = { command = "clippy", checkOnSave = true },
				},
			},
		})
		vim.lsp.enable("bacon_ls")
	end,
}
