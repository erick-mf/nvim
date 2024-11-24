return {
  {
    "tpope/vim-fugitive",
    enabled = false,
    keys = {
      { "<leader>G", "<cmd>Git<cr>", desc = "Git commit" },
    },
    cmd = { "G", "Git" },
  },
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
    },
    keys = {
      { "<leader>G", "<cmd>Neogit cwd=%:p:h<cr>", desc = "Git commit" },
    },
    cmd = { "Neogit cwd=%:p:h" },
    config = true,
  },
}
