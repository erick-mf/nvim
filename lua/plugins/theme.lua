return {
  {
    "catppuccin/nvim",
    lazy = false,
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "auto",
        transparent_background = true,
        dim_inactive = {
          enabled = false,
          shade = "dark",
          percentage = 0.15,
        },
        styles = {
          comments = { "italic" },
          keywords = { "italic" },
        },
        integrations = {
          harpoon = true,
          mason = true,
          noice = true,
          notify = true,
          lsp_trouble = true,
        },
      })
      vim.cmd.colorscheme("catppuccin")
    end,
  },
  {
    "rose-pine/neovim",
    name = "rose-pine",
    lazy = false,
    priority = 1000,
    config = function()
      require("rose-pine").setup({
        styles = {
          transparency = true,
        },
      })
      -- vim.cmd("colorscheme rose-pine-moon")
    end,
  },
}
