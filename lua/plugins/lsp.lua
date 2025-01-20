return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		{
			"williamboman/mason.nvim",
			cmd = "Mason",
			opts = {
				ui = {
					border = "rounded",
					width = 0.7,
					height = 0.7,
				},
			},
		},
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		{
			"folke/lazydev.nvim",
			ft = "lua",
			opts = {
				library = {
					{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
				},
			},
		},
	},
	config = function()
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
			callback = function(event)
				local map = function(mode, keys, func, desc)
					mode = type(mode) == "table" and mode or { mode or "n" }
					vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
				end
				map("n", "<leader>vd", vim.diagnostic.open_float, "Diagnostic")
				map("n", "gd", vim.lsp.buf.definition, "Goto Definition")
				map("n", "gr", "<cmd>FzfLua lsp_references initial_mode=normal<cr>", "Goto References")
				map("n", "<leader>rn", vim.lsp.buf.rename, "Rename")
				map("n", "<A-f>", vim.lsp.buf.format, "Format")
				map({ "n", "v" }, "<leader>vc", vim.lsp.buf.code_action, "Code Action")
				map("n", "K", vim.lsp.buf.hover, "Hover Documentation")
				vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, { desc = "Signature help" })

				local client = vim.lsp.get_client_by_id(event.data.client_id)
				---@diagnostic disable-next-line: missing-parameter, param-type-mismatch
				if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
					map("n", "<leader>th", function()
						vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
					end, "[T]oggle Inlay [H]ints")
				end
			end,
		})

		require("lazydev").setup()

		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

		local servers = {
			html = {
				filetypes = { "html", "php", "blade" },
			},
			cssls = {},
			emmet_ls = {},
			ts_ls = {},
			lemminx = {},
			volar = {},
			angularls = {},
			astro = {},
			jdtls = {},
			phpactor = {
				root_dir = require("lspconfig").util.root_pattern("composer.json", ".git", "*.php"),
				filetypes = { "php", "blade" },
				init_options = {
					["language_server_configuration.auto_config"] = true,
					["language_server_worse_reflection.inlay_hints.enable"] = true,
					["language_server_worse_reflection.inlay_hints.types"] = false,
					["language_server_worse_reflection.inlay_hints.params"] = true,
					["code_transform.import_globals"] = false,
					["language_server_phpstan.mem_limit"] = "2048M",
					["language_server.diagnostic_ignore_codes"] = {
						"worse.docblock_missing_return_type",
						"worse.missing_return_type",
						"worse.docblock_missing_param",
						"fix_namespace_class_name",
					},
					["indexer.exclude_patterns"] = {
						"/vendor/**/Tests/**/*",
						"/vendor/**/tests/**/*",
						"/var/cache/**/*",
						"/vendor/composer/**/*",
						"/vendor/composer/**/*",
						"/vendor/laravel/fortify/workbench/**/*",
						"/vendor/filament/forms/.stubs.php",
						"/vendor/filament/notifications/.stubs.php",
						"/vendor/filament/tables/.stubs.php",
						"/vendor/filament/actions/.stubs.php",
						"/storage/framework/cache/**/*",
						"/storage/framework/views/**/*",
					},
					["indexer.stub_paths"] = { "/vendor/laravel/framework/src/Illuminate/Foundation/helpers.php" },
				},
				handlers = {
					["textDocument/publishDiagnostics"] = function(err, result, ctx, config)
						-- Filtra los diagnósticos
						result.diagnostics = vim.tbl_filter(function(diagnostic)
							-- Verifica si el archivo está en el directorio de vistas y config
							if
								string.match(result.uri, "/[vV]i[es][wt][as]?/")
								or string.match(result.uri, "/config?/")
							then
								-- Elimina los avisos de variables no definidas en vistas
								if
									string.match(diagnostic.message, "Undefined variable")
									or string.match(diagnostic.message, "Fix PSR namespace and class name")
								then
									return false
								end
							end

							return true
						end, result.diagnostics)

						-- Llama al handler estándar con los diagnósticos filtrados
						---@diagnostic disable-next-line: redundant-parameter
						vim.lsp.handlers["textDocument/publishDiagnostics"](err, result, ctx, config)
					end,
				},
			},
			lua_ls = {
				settings = {
					Lua = {
						completion = {
							callSnippet = "Replace",
						},
						diagnostics = {
							globals = { "vim" },
						},
					},
				},
			},
		}

		require("mason").setup()
		local ensure_installed = vim.tbl_keys(servers or {})
		vim.list_extend(ensure_installed, {
			"stylua",
			"prettier",
			"phpcbf",
		})
		require("mason-tool-installer").setup({
			ensure_installed = ensure_installed,
		})

		require("mason-lspconfig").setup({
			handlers = {
				function(server_name)
					if server_name ~= "jdtls" then
						local server = servers[server_name] or {}
						server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
						require("lspconfig")[server_name].setup(server)
					end
				end,
			},
		})
	end,
}
