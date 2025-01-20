return {
	"adalessa/laravel.nvim",
	cmd = { "Laravel" },
	event = { "VeryLazy" },
	dependencies = {
		"tpope/vim-dotenv",
		"ibhagwan/fzf-lua",
		"MunifTanjim/nui.nvim",
		"kevinhwang91/promise-async",
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
	},
	keys = {
		{ "<leader>la", ":Laravel artisan<cr>" },
		{ "<leader>lr", ":Laravel routes<cr>" },
		{ "<leader>ls", ":Laravel serve<cr>" },
	},
	opts = {
		lsp_server = "phpactor",
		features = {
			pickers = {
				provider = "fzf-lua",
			},
			route_info = {
				enable = false,
				view = "top",
			},
			model_info = {
				enable = true,
			},
			override = {
				enable = true,
			},
		},
	},
}
