return {
	{
		"catppuccin/nvim",
		lazy = false,
		name = "catppuccin",
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				flavour = "auto",
				transparent_background = true,
				dim_inactive = {
					enabled = false,
					shade = "dark",
					percentage = 0.15,
				},
				styles = {
					comments = { "italic" },
					keywords = { "italic" },
				},
				integrations = {
					harpoon = true,
					mason = true,
					noice = true,
					notify = true,
					lsp_trouble = true,
				},
			})
			-- vim.cmd.colorscheme("catppuccin")
		end,
	},
	{
		"rebelot/kanagawa.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("kanagawa").setup({
				commentStyle = { italic = true },
				keywordStyle = { italic = true },
				transparent = true,
				colors = {
					theme = {
						all = {
							ui = {
								bg_gutter = "none",
							},
						},
					},
				},
			})
			vim.cmd("colorscheme kanagawa-wave")
		end,
	},
}
