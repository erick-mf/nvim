return {
  {
    "tpope/vim-fugitive",
    enabled = false,
    keys = {
      { "<leader>G", "<cmd>Git<cr>", desc = "Git commit" },
      { "<leader>gp", "<cmd>Git pull<cr>", desc = "Git pull rebase" },
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
      { "<leader>gp", "<cmd>Git pull<cr>", desc = "Git pull rebase" },
    },
    cmd = { "Neogit cwd=%:p:h"},
    config = true,
  }
}
