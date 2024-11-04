local opts = { noremap = true, silent = true }

return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      cond = function()
        return vim.fn.executable("make") == 1
      end,
    },
  },
  config = function()
    require("telescope").setup({
      defaults = {
        initial_mode = "insert",
        file_ignore_patterns = {
          "%.zip",
          "%.class",
          "lazy-lock.json",
          "node_modules/",
          "live-server/",
          "vendor/",
        },
        layout_strategy = "vertical",
        layout_config = {
          width = 0.6,
          height = 0.85,
          preview_cutoff = 1,
          mirror = true,
          prompt_position = "top",
        },
        selection_strategy = "reset",
        sorting_strategy = "ascending",
        scroll_strategy = "limit",
        color_devicons = true,
        mappings = {
          n = {
            ["<C-c>"] = "close",
            ["<C-h>"] = "which_key",
            ["<C-q>"] = "close",
          },
          i = {
            ["<C-c>"] = "close",
            ["<C-q>"] = "close",
            ["<C-h>"] = "which_key",
          },
        },
        history = {
          path = "~/.local/share/nvim/databases/telescope_history.sqlite3",
          limit = 100,
        },
      },
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = "smart_case",
        },
      },
    })
    require("telescope").load_extension("fzf")
  end,
  keys = {
    {
      "<leader>fw",
      "<cmd>Telescope grep_string<cr>",
      desc = "Grep string",
      opts,
    },
    { "<leader>fs", "<cmd>Telescope live_grep<cr>", desc = "Live grep", opts },
    {
      "<leader>gs",
      "<cmd>Telescope git_status cwd=%:p:h initial_mode=normal<cr>",
      desc = "Git Status",
      opts,
    },
    {
      "<leader>gl",
      "<cmd>Telescope git_commits cwd=%:p:h initial_mode=normal<cr>",
      desc = "Git commits",
      opts,
    },
    {
      "<leader>ff",
      function()
        local opt = { show_untracked = true }
        local ok = pcall(require("telescope.builtin").git_files, opt)
        if not ok then
          require("telescope.builtin").find_files({ opt })
        end
      end,
      desc = "Git/Find files",
      opts,
    },
    {
      "<leader>fh",
      function()
        return require("telescope.builtin").find_files({
          prompt_title = " Hidden Files",
          cwd = "%:p:h",
          hidden = true,
          file_ignore_patterns = {},
        })
      end,
      desc = "Find hidden files",
      opts,
    },
    {
      "<leader>fp",
      function()
        return require("telescope.builtin").find_files({
          cwd = vim.fn.stdpath("config"),
          prompt_title = " Neovim Config ",
        })
      end,
      desc = "Open neovim config",
      opts,
    },
    {
      "<leader>fb",
      function()
        return require("telescope.builtin").buffers({
          initial_mode = "normal",
          select_buffer = true,
        })
      end,
      desc = "File browser relative",
      opts,
    },
    {
      "<leader>fk",
      "<cmd>Telescope keymaps<cr>",
      desc = "Keymaps",
      opts,
    },
    {
      "<leader>fa",
      "<cmd>Telescope help_tags<cr>",
      desc = "Help tags",
      opts,
    },
    {
      "<leader>fn",
      "<cmd>Telescope todo-comments keywords=TODO,NOTE initial_mode=normal<cr>",
      desc = "Todos",
      opts,
    },
    {
      "<leader>fx",
      "<cmd>Telescope todo-comments keywords=FIX,BUG initial_mode=normal<cr>",
      desc = "Todo Fix",
      opts,
    },
  },
}
