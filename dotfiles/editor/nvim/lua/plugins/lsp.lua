-- lua/plugins/lsp.lua
return {
	"mason-org/mason-lspconfig.nvim",
	dependencies = { "saghen/blink.cmp" },
	config = function()
		local capabilities = require("blink.cmp").get_lsp_capabilities()

		vim.lsp.config("*", { capabilities = capabilities })

		vim.lsp.config("lua_ls", {
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

		vim.lsp.config("elmls", {
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

		vim.lsp.config("tombi", {
			filetypes = { "toml" },
			root_markers = { "tombi.toml", "pyproject.toml", ".git" },
		})

		require("mason-lspconfig").setup({})

		-- Custom lua_ls instance for teal files
		vim.lsp.config("lua_ls_teal", {
			cmd = { "lua-language-server" },
			filetypes = { "teal" },
			root_markers = { "tlconfig.lua", ".git" },
			settings = {
				Lua = {
					runtime = { version = "Lua 5.4" },
					diagnostics = { enable = false },
					semantic = { enable = false },
					workspace = { checkThirdParty = false },
				},
			},
			on_init = function(client)
				local caps = client.server_capabilities
				caps.hoverProvider = false
				caps.semanticTokensProvider = nil
				caps.definitionProvider = false
				caps.signatureHelpProvider = false
				caps.documentHighlightProvider = false
			end,
		})
		vim.lsp.enable("lua_ls_teal")

		vim.lsp.config("clangd", {
			cmd = { "clangd", "--query-driver=/run/current-system/sw/bin/*" },
		})
		vim.lsp.enable("clangd")

		-- asm_lsp: manual, Mason cargo-build fails on NixOS (OpenSSL/pkg-config), so Nix-provided instead
		vim.lsp.config("asm_lsp", {
			cmd = { "asm-lsp" },
			filetypes = { "asm", "s", "S", "vmasm" },
		})
		vim.lsp.enable("asm_lsp")

		-- bacon_ls: manual, system-flake-managed, outside Mason
		vim.lsp.config("bacon_ls", {
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

		-- nixd: manual, not in Mason's registry
		vim.lsp.config("nixd", {
			settings = {
				nixd = {
					formatting = { command = { "alejandra" } },
				},
			},
		})
		vim.lsp.enable("nixd")
		-- nil: manual, running alongside nixd
		vim.lsp.config("nil_ls", {
			settings = {
				nil_ls = {
					flake = {
						autoArchive = true,
					},
				},
			},
		})
		vim.lsp.enable("nil_ls")
	end,
}
