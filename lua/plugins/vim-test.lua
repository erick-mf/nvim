return {
	"vim-test/vim-test",
	init = function()
		vim.g["test#strategy"] = "neovim"
		vim.g["test#neovim#start_normal"] = 1
		vim.g["test#neovim#term_position"] = "vert botright 75"
		vim.g["test#javascript#runner"] = "jest"
		vim.g["test#php#runner"] = "phpunit"
	end,
	keys = {
		{ "<leader>T", "<cmd>TestFile<cr>", desc = "Test Nearest" },
	},
}
