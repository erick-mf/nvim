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
    { "L3MON4D3/LuaSnip", version = "v2.*" },
  },
  event = { "InsertEnter", "CmdlineEnter" },
  config = function()
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
        ["<CR>"] = cmp.mapping.confirm({
          behavior = cmp.ConfirmBehavior.Insert,
          select = false,
        }),
      },
      sources = cmp.config.sources({
        { name = "path" },
        { name = "nvim_lsp" },
        { name = "nvim_lua" },
        { name = "luasnip" },
        { name = "buffer", keyword_length = 4 },
      }),
      formatting = {
        expandable_indicator = false,
        fields = { "abbr", "kind", "menu" },
        format = lspkind.cmp_format({
          show_labelDetails = true,
          mode = "symbol_text",
          menu = {
            path = "[PATH]",
            nvim_lsp = "[LSP]",
            nvim_lua = "[API]",
            buffer = "[BUF]",
            luasnip = "[SNIP]",
          },
          before = function(entry, vim_item)
            local KIND_ICONS = {
              Tailwind = "󰹞󰹞󰹞󰹞󰹞󰹞󰹞󰹞",
              Color = " Color",
            }
            if vim_item.kind == "Color" and entry.completion_item.documentation then
              local _, _, r, g, b = string.find(entry.completion_item.documentation, "^rgb%((%d+), (%d+), (%d+)")

              if r and g and b then
                local color = string.format("%02x", r) .. string.format("%02x", g) .. string.format("%02x", b)
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
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
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
