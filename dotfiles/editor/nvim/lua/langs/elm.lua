return {
	"neovim/nvim-lspconfig",
	opts = {
		servers = {
			elmls = {
				cmd = { "elm-language-server" },
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
			},
		},
	},
}
