local opts = { noremap = true, silent = true }

return {
	"ibhagwan/fzf-lua",
	dependencies = {
		-- "nvim-tree/nvim-web-devicons",
		{ "echasnovski/mini.icons", opts = {} },
	},
	config = function()
		local fzf = require("fzf-lua")
		fzf.setup({
			winopts = {
				height = 0.8,
				width = 0.8,
				row = 0.5,
				col = 0.5,
				preview = {
					-- 	layout = "vertical",
					-- 	vertical = "down:55%",
					scrollbar = false,
					scrolloff = -2,
				},
			},
			fzf_opts = {
				["--layout"] = "reverse",
			},
			keymap = {
				builtin = {
					["<C-c>"] = "close",
					["<C-d>"] = "preview-down",
					["<C-u>"] = "preview-up",
				},
				fzf = {
					["change"] = "first",
					["alt-a"] = "toggle-all",
					["ctrl-c"] = "abort",
					["ctrl-d"] = "preview-down",
					["ctrl-u"] = "preview-up",
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
					cmd = 'git ls-files --exclude-standard --cached | grep -v -E "vendor/|node_modules/|public/bootstrap/"',
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
				local function find_git_root()
					local current_file = vim.fn.expand("%:p:h")
					local git_root = vim.fn.systemlist(
						"git -C " .. vim.fn.shellescape(current_file) .. " rev-parse --show-toplevel"
					)[1]
					return git_root
				end

				local git_root = find_git_root()
				if git_root then
					require("fzf-lua").git_status({ cwd = git_root })
				end
			end,
			desc = "Git Status",
			opts,
		},
		{
			"<leader>gl",
			function()
				require("fzf-lua").git_commits({ cwd = vim.fn.expand("%:p:h") })
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
					require("fzf-lua").git_files({ cwd = vim.fn.expand("%:p:h"), silent = true })
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
			"<cmd>TodoFzfLua<cr>",
			desc = "Todos",
			opts,
		},
		{
			"gm",
			function()
				local function has_document_symbols()
					local params = { textDocument = vim.lsp.util.make_text_document_params() }
					local result = vim.lsp.buf_request_sync(0, "textDocument/documentSymbol", params, 1000)
					for _, res in pairs(result or {}) do
						if res.result and #res.result > 0 then
							return true
						end
					end
					return false
				end

				if has_document_symbols() then
					vim.cmd("FzfLua lsp_document_symbols")
				else
					return
				end
			end,
			desc = "LSP Document Symbols",
			opts,
		},
	},
}
