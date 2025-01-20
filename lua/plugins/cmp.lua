return {
	"hrsh7th/nvim-cmp",
	dependencies = {
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-nvim-lua",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-cmdline",
		"petertriho/cmp-git",
		"saadparwaiz1/cmp_luasnip",
		"onsails/lspkind-nvim",
		{
			"L3MON4D3/LuaSnip",
			version = "v2.*",
			dependencies = {
				"rafamadriz/friendly-snippets",
			},
		},
	},
	event = { "InsertEnter", "CmdlineEnter" },
	config = function()
		require("luasnip.loaders.from_vscode").lazy_load()
		local cmp = require("cmp")
		local luasnip = require("luasnip")
		local lspkind = require("lspkind")
		local compare = require("cmp.config.compare")

		cmp.setup({
			completion = {
				completeopt = "menu, menuone, noselect",
			},
			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},
			mapping = {
				["<C-n>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
					elseif luasnip.expand_or_jumpable() then
						luasnip.expand_or_jump()
					else
						fallback()
					end
				end, { "i", "s" }),
				["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
				["<C-space>"] = cmp.mapping.complete(),
				["<C-e>"] = cmp.mapping.abort(),
				["<cr>"] = cmp.mapping.confirm({
					behavior = cmp.ConfirmBehavior.Insert,
					select = false,
				}),
				["<C-b>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
			},
			sources = cmp.config.sources({
				{
					name = "nvim_lsp",
					entry_filter = function(entry, ctx)
						local kind = require("cmp.types").lsp.CompletionItemKind[entry:get_kind()]

						-- Excluir entradas de tipo "Text"
						if kind == "Text" then
							return false
						end

						-- Obtener el texto antes del cursor
						local line = ctx.cursor.line
						local col = ctx.cursor_before_line:len()
						local current_line = vim.api.nvim_buf_get_lines(0, line, line + 1, false)[1]
						local text_before_cursor = current_line:sub(1, col)

						-- Filtrar basado en el contexto
						if text_before_cursor:match("[%.%->]%w*$") then
							-- Si estamos después de un punto o una flecha, mostrar solo métodos, propiedades y campos
							return kind == "Method" or kind == "Property" or kind == "Field"
						elseif text_before_cursor:match("new%s+%w*$") then
							-- Si estamos después de 'new', mostrar solo clases
							return kind == "Class"
						elseif text_before_cursor:match("::%w*$") then
							-- Si estamos después de '::', mostrar métodos estáticos y constantes
							return kind == "Method" or kind == "Constant"
						end

						-- Para otros casos, mostrar todas las entradas excepto "Text"
						return true
					end,
				},
				{ name = "nvim_lua" },
				{ name = "luasnip" },
				{ name = "path" },
				{ name = "lazydev", group_index = 0 },
				{ name = "buffer", group_index = 10 },
			}),
			formatting = {
				expandable_indicator = false,
				fields = { "abbr", "kind", "menu" },
				format = lspkind.cmp_format({
					show_labelDetails = true,
					mode = "symbol_text",
					menu = {
						nvim_lsp = "[LSP]",
						nvim_lua = "[API]",
						luasnip = "[SNIP]",
						path = "[PATH]",
						buffer = "[BUF]",
					},
					before = function(entry, vim_item)
						local KIND_ICONS = {
							Tailwind = "󰹞󰹞󰹞󰹞󰹞󰹞󰹞󰹞",
							Color = " Color",
						}
						if vim_item.kind == "Color" and entry.completion_item.documentation then
							local _, _, r, g, b =
								string.find(entry.completion_item.documentation, "^rgb%((%d+), (%d+), (%d+)")

							if r and g and b then
								local color = string.format("%02x", r)
									.. string.format("%02x", g)
									.. string.format("%02x", b)
								local group = "Tw_" .. color

								if vim.api.nvim_call_function("hlID", { group }) < 1 then
									vim.api.nvim_command("highlight" .. " " .. group .. " " .. "guifg=#" .. color)
								end

								vim_item.kind = KIND_ICONS.Tailwind
								vim_item.kind_hl_group = group

								return vim_item
							end
						end
						vim_item.kind = KIND_ICONS[vim_item.kind] or vim_item.kind

						return vim_item
					end,
				}),
			},
			view = {
				entries = { name = "custom" },
			},
			window = {
				completion = cmp.config.window.bordered({
					winhighlight = "cursorline:pmenusel,search:none",
				}),
				documentation = cmp.config.window.bordered({
					winhighlight = "cursorline:pmenusel,search:none",
				}),
			},
			sorting = {
				priority_weight = 2,
				comparators = {
					compare.offset,
					compare.exact,
					compare.score,
					compare.kind,
					compare.sort_text,
					compare.length,
					compare.order,
				},
			},
			experimental = {
				native_menu = false,
				ghost_text = false,
			},
		})

		-- Set configuration for specific filetype.
		cmp.setup.filetype("gitcommit", {
			sources = cmp.config.sources({
				{ name = "git" }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
			}, {
				{ name = "buffer" },
			}),
		})

		-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
		cmp.setup.cmdline({ "/", "?" }, {
			mapping = cmp.mapping.preset.cmdline(),
			sources = {
				{ name = "buffer" },
			},
		})

		-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
		cmp.setup.cmdline(":", {
			mapping = cmp.mapping.preset.cmdline(),
			sources = cmp.config.sources({
				{ name = "path" },
			}, {
				{ name = "cmdline" },
			}),
		})
	end,
}
