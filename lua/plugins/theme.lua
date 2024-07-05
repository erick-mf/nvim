return {
  {
    "sainnhe/sonokai",
    lazy = false,
    priority = 1000,
    init = function()
      -- vim.cmd.colorscheme("sonokai")
    end,
  },
  {
    "ellisonleao/gruvbox.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("gruvbox")
    end,
  },
}
