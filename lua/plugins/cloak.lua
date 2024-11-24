return {
	"laytan/cloak.nvim",
	opts = {
		cloak_character = "*",
		highlight_group = "Comment",
		cloak_telescope = true,
		patterns = {
			{
				file_pattern = { ".env" },
				cloak_pattern = { "=.+", ":.+" },
			},
		},
	},
}
