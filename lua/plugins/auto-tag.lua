---@diagnostic disable: missing-fields
return {
  "windwp/nvim-ts-autotag",
  event = { "BufNewFile", "BufReadPre" },
  config = function()
    require("nvim-ts-autotag").setup({
      opts = {
        enable_close = true,
        enable_rename = true,
        enable_close_on_slash = true,
      },
    })
  end,
}
