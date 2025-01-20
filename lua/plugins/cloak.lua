return {
	"laytan/cloak.nvim",
	cmd = "CloakEnable",
	init = function()
		vim.api.nvim_create_autocmd("BufEnter", {
			pattern = { ".env" },
			callback = function()
				vim.cmd([[CloakEnable]])
			end,
		})
	end,
	opts = {
		cloak_character = "*",
		highlight_group = "Comment",
		patterns = {
			{
				file_pattern = ".env*",
				cloak_pattern = { "=.+", ":.+" },
			},
		},
	},
	keys = {
		{ "<leader>cd", "<cmd>CloakPreviewLine<cr>", desc = "CloakDisable" },
	},
}
