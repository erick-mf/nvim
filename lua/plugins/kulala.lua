return {
	"mistweaverco/kulala.nvim",
	opts = {},
	keys = {
		{
			"<leader>ht",
			function()
				require("kulala").run()
			end,
			desc = "Run Kulala",
		},
	},
}
