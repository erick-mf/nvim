return {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
        preview = {
            max_width = 0.3,
        },
    },
    keys = {
        { "<leader>o", "<cmd>Oil --float<cr>" },
    },
}
