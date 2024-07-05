return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    options = {
      globalstatus = true,
      section_separators = "",
      component_separators = "",
    },
    extensions = { "fugitive" },
    sections = {
      lualine_a = { { "mode", upper = true } },
      lualine_b = { { "branch", icon = "" }, "db_ui#statusline" },
      lualine_c = { { "filename", file_status = false, path = 0 } },
      lualine_x = {
        "diagnostics",
        {
          "diff",
          symbols = {
            added = " ",
            modified = " ",
            removed = " ",
          },
        },
      },
      lualine_y = { "filetype", "progress" },
      lualine_z = { "location" },
    },
  },
}
