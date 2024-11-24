return {
	"smoka7/hop.nvim",
	version = "*",
	config = function()
		require("hop").setup({
			keys = "asdghklqwertyuiopzxcvbnmfj",
		})
	end,
	keys = {
		{ "ff", mode = { "n", "v" }, "<cmd>HopCamelCase<cr>", desc = "Hop" },
		{ "fl", mode = { "n", "v" }, "<cmd>HopCamelCaseCurrentLine<cr>", desc = "Hop" },
		{ "fw", mode = { "n", "v" }, "<cmd>HopWord<cr>", desc = "Hop" },
	},
}
