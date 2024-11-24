return {
	"stevearc/oil.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {
		default_file_explorer = false,
		preview = {
			max_width = 0.3,
		},
	},
	keys = {
		{ "<leader>o", "<cmd>Oil --float<cr>" },
	},
}
