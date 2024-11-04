return {
  {
    "mhartington/formatter.nvim",
    event = "BufWritePost",
    enabled = true,
    config = function()
      local util = require("formatter.util")

      -- Función auxiliar para crear configuraciones de Prettier
      local function prettier_config()
        return {
          exe = "prettier",
          args = {
            "--stdin-filepath",
            util.escape_path(util.get_current_buffer_file_path()),
            "--print-width",
            "120",
          },
          stdin = true,
        }
      end

      require("formatter").setup({
        logging = true,
        filetype = {
          javascript = { prettier_config },
          typescript = { prettier_config },
          html = { prettier_config },
          css = { prettier_config },
          json = { prettier_config },
          -- Otros tipos de archivo que usan Prettier
          lua = { require("formatter.filetypes.lua").stylua },
          java = { require("formatter.filetypes.c").clangformat },
          xml = { require("formatter.filetypes.xml").xmlformat },
          php = { require("formatter.filetypes.php").php_cs_fixer },
          ["*"] = { require("formatter.filetypes.any").remove_trailing_whitespace },
        },
      })

      -- Formatear automáticamente al guardar
      vim.api.nvim_create_autocmd("BufWritePost", {
        pattern = "*",
        command = "FormatWrite",
      })
    end,
  },
  {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    enabled = false,
    config = function()
      local conform = require("conform")

      conform.setup({
        formatters_by_ft = {
          javascript = { "prettier", "prettierd" },
          typescript = { "prettier", "prettierd" },
          javascriptreact = { "prettier", "prettierd" },
          typescriptreact = { "prettier", "prettierd" },
          css = { "prettier", "prettierd" },
          html = { "prettier", "prettierd" },
          json = { "prettier", "prettierd" },
          markdown = { "prettier", "prettierd" },
          lua = { "stylua" },
          php = { "php_cs_fixer" },
        },
        format_on_save = {
          lsp_fallback = true,
          async = false,
          timeout_ms = 5000,
        },
      })

      vim.keymap.set({ "n", "v" }, "<leader>mp", function()
        conform.format({
          lsp_fallback = true,
          async = false,
          timeout_ms = 5000,
        })
      end, { desc = "Format file or range (in visual mode)" })
    end,
  },
}
