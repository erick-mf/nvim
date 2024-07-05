return {
  "folke/trouble.nvim",
  enabled = true,
  dependencies = "nvim-tree/nvim-web-devicons",
  keys = {
    {
      "<leader>xx",
      function()
        require("trouble").toggle("diagnostics")
      end,
      desc = "Trouble toggle",
    },
  },
  opts = {
    use_diagnostic_signs = true,
  },
}
