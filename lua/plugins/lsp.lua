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
    { "j-hui/fidget.nvim", opts = {} },
    { "folke/neodev.nvim", opts = {} },
  },
  config = function()
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
      callback = function(event)
        local map = function(keys, func, desc)
          vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
        end
        map("<leader>vd", vim.diagnostic.open_float, "Diagnostic")
        map("gd", vim.lsp.buf.definition, "Goto Definition")
        map("gr", "<cmd>Telescope lsp_references initial_mode=normal<cr>", "Goto References")
        map("<leader>rn", vim.lsp.buf.rename, "Rename")
        map("<A-f>", vim.lsp.buf.format, "Format")
        map("<leader>vc", vim.lsp.buf.code_action, "Code Action")
        map("K", vim.lsp.buf.hover, "Hover Documentation")
        vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, { desc = "Signature help" })
      end,
    })

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

    local servers = {
      html = {},
      cssls = {},
      emmet_ls = {
        filetypes = {
          "php",
          "html",
          "javascript",
        },
      },
      ts_ls = {},
      lemminx = {},
      volar = {},
      angularls = {},
      astro = {},
      jdtls = {},
      phpactor = {
        root_dir = require("lspconfig").util.root_pattern("*.php", ".git", "composer.*"),
      },
      lua_ls = {
        settings = {
          Lua = {
            completion = {
              callSnippet = "Replace",
            },
            diagnostic = {
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
