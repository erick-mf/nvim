local opts = { noremap = true, silent = true }

return {
	"ibhagwan/fzf-lua",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		local fzf = require("fzf-lua")
		fzf.setup({
			winopts = {
				height = 0.8,
				width = 0.6,
				row = 0.5,
				col = 0.5,
				preview = {
					layout = "vertical",
					vertical = "down:55%",
				},
				hls = {
					normal = "Normal",
					border = "Normal",
					cursor = "Cursor",
					cursorline = "CursorLine",
					search = "Search",
					scrollbar_f = "PmenuThumb",
					scrollbar_e = "PmenuSbar",
				},
			},
			fzf_opts = {
				["--layout"] = "reverse",
			},
			keymap = {
				builtin = {
					["ctrl-c"] = "close",
					["ctrl-q"] = "close",
					["ctrl-d"] = "preview-down",
					["ctrl-u"] = "preview-up",
				},
				fzf = {
					["ctrl-c"] = "abort",
					["ctrl-q"] = "abort",
					["ctrl-d"] = "preview-down",
					["ctrl-u"] = "preview-up",
					["change"] = "first",
				},
			},
			previewers = {
				git_diff = {
					pager = "delta --color-only --width=$FZF_PREVIEW_COLUMNS",
				},
			},
			files = {
				prompt = "Files> ",
				cwd_prompt = false,
				fd_opts = [[--color=never --type f --hidden --follow --exclude .git --exclude node_modules --exclude vendor]],
				rg_opts = [[--color=never --files --hidden --follow -g "!.git" -g "!node_modules" -g "!vendor"]],
				find_opts = [[-type f -not -path '*/\.git/*' -not -path '*/node_modules/*' -not -path '*/vendor/*' -printf '%P\n']],
			},
			git = {
				files = {
					cmd = 'git ls-files --exclude-standard --cached --others | grep -v -E "vendor/|node_modules/|public/bootstrap/"',
				},
			},
			grep = {
				rg_opts = "--column --line-number --no-heading --color=always --smart-case --hidden -g '!.git' -g '!node_modules' -g '!vendor' -g '!public/bootstrap'",
			},
			lsp = {
				code_actions = {
					previewer = false, -- Desactiva el previsualizador
					winopts = {
						height = 0.3,
						width = 0.5,
						row = 0.5, -- Centra verticalmente
						col = 0.5, -- Centra horizontalmente
					},
				},
			},
		}, "fzf-native")
	end,
	keys = {
		{
			"<leader>fw",
			function()
				require("fzf-lua").grep_cword()
			end,
			desc = "Grep string",
			opts,
		},
		{
			"<leader>fs",
			function()
				require("fzf-lua").live_grep()
			end,
			desc = "Live grep",
			opts,
		},
		{
			"<leader>gs",
			function()
				require("fzf-lua").git_status({ cwd = vim.fn.getcwd() })
			end,
			desc = "Git Status",
			opts,
		},
		{
			"<leader>gl",
			function()
				require("fzf-lua").git_commits({ cwd = vim.fn.getcwd() })
			end,
			desc = "Git commits",
			opts,
		},
		-- {
		-- 	"<leader>ff",
		-- 	function()
		-- 		-- Comprueba si estamos en un repositorio Git
		-- 		local is_git_repo = vim.fn.system("git rev-parse --is-inside-work-tree 2>/dev/null") == "true\n"
		--
		-- 		if is_git_repo then
		-- 			require("fzf-lua").git_files({ silent = true })
		-- 		else
		-- 			require("fzf-lua").files({ silent = true })
		-- 		end
		-- 	end,
		-- 	desc = "Git/Find files",
		-- 	opts,
		-- },
		{
			"<leader>ff",
			function()
				require("fzf-lua").files({ silent = true })
			end,
			desc = "Find files",
			opts,
		},
		{
			"<leader>gf",
			function()
				local is_git_repo = vim.fn.system("git rev-parse --is-inside-work-tree 2>/dev/null") == "true\n"

				if is_git_repo then
					require("fzf-lua").git_files({ silent = true })
				end
			end,
			desc = "Git files",
			opts,
		},
		{
			"<leader>fh",
			function()
				require("fzf-lua").files({
					prompt = "Hiiden Files> ",
					hidden = true,
					no_ignore = true,
					silent = true,
				})
			end,
			desc = "Find hidden files",
			opts,
		},
		{
			"<leader>fp",
			function()
				require("fzf-lua").files({
					cwd = vim.fn.stdpath("config"),
					prompt = "Plugins> ",
					silent = true,
				})
			end,
			desc = "Open neovim config",
			opts,
		},
		{
			"<leader>fb",
			function()
				require("fzf-lua").buffers({
					initial_mode = "normal",
				})
			end,
			desc = "Buffers",
			opts,
		},
		{
			"<leader>fk",
			function()
				require("fzf-lua").keymaps()
			end,
			desc = "Keymaps",
			opts,
		},
		{
			"<leader>fa",
			function()
				require("fzf-lua").help_tags()
			end,
			desc = "Help tags",
			opts,
		},
		{
			"<leader>fn",
			function()
				require("fzf-lua").grep({ search = "TODO|NOTE", no_esc = true })
			end,
			desc = "Todos",
			opts,
		},
		{
			"<leader>fx",
			function()
				require("fzf-lua").grep({ search = "FIX|BUG", no_esc = true })
			end,
			desc = "Todo Fix",
			opts,
		},
	},
}
