return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	config = function()
		---@diagnostic disable-next-line: missing-parameter
		require("harpoon"):setup()

		require("harpoon"):extend({
			UI_CREATE = function(cx)
				vim.keymap.set("n", "<C-v>", function()
					require("harpoon").ui:select_menu_item({ vsplit = true })
				end, { buffer = cx.bufnr })

				vim.keymap.set("n", "<C-x>", function()
					require("harpoon").ui:select_menu_item({ split = true })
				end, { buffer = cx.bufnr })
			end,
		})
	end,
	keys = {
		{
			"<leader>sa",
			function()
				require("harpoon"):list():add()
			end,
		},
		{
			"<leader>ss",
			function()
				require("harpoon").ui:toggle_quick_menu(require("harpoon"):list())
			end,
		},
		{
			"<leader>1",
			function()
				require("harpoon"):list():select(1)
			end,
		},
		{
			"<leader>2",
			function()
				require("harpoon"):list():select(2)
			end,
		},
		{
			"<leader>3",
			function()
				require("harpoon"):list():select(3)
			end,
		},
		{
			"<leader>4",
			function()
				require("harpoon"):list():select(4)
			end,
		},
	},
}
