return {
	{
		"tpope/vim-fugitive",
		enabled = false,
		keys = {
			{ "<leader>G", "<cmd>Git<cr>", desc = "Git commit" },
		},
		cmd = { "G", "Git" },
	},
	{
		"NeogitOrg/neogit",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"sindrets/diffview.nvim",
		},
		keys = {
			{
				"<leader>G",
				function()
					return require("neogit").open({ cwd = "%:p:h" })
				end,
				desc = "Git commit",
			},
		},
		config = true,
	},
}
