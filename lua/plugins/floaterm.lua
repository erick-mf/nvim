return {
  "voldikss/vim-floaterm",
  keys = {
    { "<leader>tt", "<cmd>FloatermToggle<cr>", desc = "Toggle floaterm" },
    { "<leader>tn", "<cmd>FloatermNew<cr>", desc = "Toggle floaterm new" },
    { "<C-h>", mode = "t", "<cmd>FloatermHide<cr>", desc = "Toggle floaterm hide" },
    { "<C-q>", mode = "t", "<cmd>FloatermKill<cr>", desc = "Toggle floaterm kill" },
    { "<C-k>", mode = "t", "<cmd>FloatermNext<cr>", desc = "Toggle floaterm kill" },
    { "<C-j>", mode = "t", "<cmd>FloatermPrev<cr>", desc = "Toggle floaterm kill" },
  },
}
