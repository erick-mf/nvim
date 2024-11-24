return {
	"mrjones2014/smart-splits.nvim",
	config = true,
	keys = {
		{
			"<C-left>",
			function()
				require("smart-splits").resize_left()
			end,
			desc = "Resize window left +10",
		},
		{
			"<C-down>",
			function()
				require("smart-splits").resize_down()
			end,
			desc = "Resize window down +10",
		},
		{
			"<C-up>",
			function()
				require("smart-splits").resize_up()
			end,
			desc = "Resize window up +10",
		},
		{
			"<C-right>",
			function()
				require("smart-splits").resize_right()
			end,
			desc = "Resize window right +10",
		},
	},
}
