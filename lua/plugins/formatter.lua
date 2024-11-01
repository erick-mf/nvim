return {
  "mhartington/formatter.nvim",
  event = "BufWritePost",
  config = function()
    require("formatter").setup({
      logging = true,
      filetype = {
        html = { require("formatter.filetypes.html").prettier },
        css = { require("formatter.filetypes.css").prettier },
        javascript = { require("formatter.filetypes.javascript").prettier },
        typescript = { require("formatter.filetypes.javascript").prettier },
        lua = { require("formatter.filetypes.lua").stylua },
        java = { require("formatter.filetypes.c").clangformat },
        xml = { require("formatter.filetypes.xml").xmlformat },
        json = { require("formatter.filetypes.json").prettier },
        php = { require("formatter.filetypes.php").phpcbf },
        ["*"] = { require("formatter.filetypes.any").remove_trailing_whitespace },
      },
    })

    -- Format on save automatically
    vim.api.nvim_create_autocmd("BufWritePost", {
      pattern = "*",
      command = "FormatWrite",
    })
  end,
}
