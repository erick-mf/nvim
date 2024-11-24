return {
	"mfussenegger/nvim-lint",
	config = function()
		local linters = require("lint").linters

		linters.sqlfluff.args = { "lint", "--format=json", "--dialect=mysql", "-" }
		linters.sqlfluff.stdin = true

		require("lint").linters_by_ft = {
			sql = { "sqlfluff" },
		}
		vim.api.nvim_create_autocmd({ "BufWinEnter", "TextChanged", "TextChangedI" }, {
			callback = function()
				require("lint").try_lint()
			end,
		})
	end,
}
