return {
	"NvChad/nvim-colorizer.lua",
	event = "BufReadPre",
	enabled = false,
	config = function()
		require("colorizer").setup({
			buftypes = { "*" },
			filetypes = { "*" },
			user_default_options = {
				RGB = true,
				RRGGBB = true,
				names = true,
				RRGGBBAA = true,
				AARRGGBB = true,
				rgb_fn = true,
				hsl_fn = true,
				css = true,
				css_fn = true,
				mode = "background",
				tailwind = "both",
				sass = { enable = true, parsers = { "css" } },
				virtualtext = "■",
			},
		})
	end,
}
