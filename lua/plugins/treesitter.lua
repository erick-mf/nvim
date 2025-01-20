return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"nvim-treesitter/nvim-treesitter-textobjects",
	},
	config = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = {
				"angular",
				"astro",
				"bash",
				"css",
				"go",
				"html",
				"http",
				"javascript",
				"json",
				"lua",
				"luadoc",
				"markdown",
				"markdown_inline",
				"php",
				"php_only",
				"blade",
				"toml",
				"typescript",
				"vim",
				"vimdoc",
				"vue",
				"xml",
			},
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = { "markdown" },
				disable = function(_, buf)
					local max_filesize = 100 * 1024 -- 100 KB
					local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
					if ok and stats and stats.size > max_filesize then
						vim.notify(
							"File larger than 100KB treesitter disabled for performance",
							vim.log.levels.WARN,
							{ title = "Treesitter" }
						)
						return true
					end
				end,
			},
			indent = {
				enable = true,
			},
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<C-space>",
					node_incremental = "<C-space>",
					node_decremental = "<C-space>-",
					scope_incremental = nil,
				},
			},
			textobjects = {
				select = {
					enable = true,
					keymaps = {
						["af"] = "@function.outer",
						["if"] = "@function.inner",
						["aC"] = "@class.outer",
						["iC"] = "@class.inner",
						["ac"] = "@conditional.outer",
						["ic"] = "@conditional.inner",
						["al"] = "@loop.outer",
						["il"] = "@loop.inner",
					},
				},
			},
		})

		---@diagnostic disable-next-line: inject-field
		require("nvim-treesitter.parsers").get_parser_configs().blade = {
			install_info = {
				url = "/mnt/d/Documentos/tree-sitter-blade-0.11.0",
				files = { "src/parser.c" },
			},
			filetype = "blade",
		}

		vim.filetype.add({ pattern = { [".*%.blade%.php"] = "blade" } })
	end,
}
