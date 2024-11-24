return {
	"lewis6991/gitsigns.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local gitsigns = require("gitsigns")
		gitsigns.setup({
			signcolumn = false,
			numhl = true,
			trouble = false,
			on_attach = function(bufnr)
				vim.keymap.set("n", "<leader>hd", gitsigns.diffthis, { buffer = bufnr, desc = "Prev hunk" })
				vim.keymap.set("n", "<leader>hh", gitsigns.preview_hunk, { buffer = bufnr, desc = "Preview hunk" })
				vim.keymap.set("n", "<leader>hn", gitsigns.next_hunk, { buffer = bufnr, desc = "Next hunk" })
				vim.keymap.set("n", "<leader>hp", gitsigns.prev_hunk, { buffer = bufnr, desc = "Prev hunk" })
			end,
			max_file_length = 10000,
		})
	end,
}
