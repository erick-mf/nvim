return {
    "tpope/vim-fugitive",
    keys = {
        { "<leader>G", "<cmd>Git<cr>", desc = "Git commit" },
        { "<leader>gp", "<cmd>Git pull --rebase<cr>", desc = "Git pull rebase" },
    },
    cmd = { "G", "Git" },
}
