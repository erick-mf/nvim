return {
  'stevearc/dressing.nvim',
  event = 'VeryLazy',
  opts = {
    input = {
      title_pos = 'center',
      rellative = 'editor',
    },
    mappings = {
      n = {
        ['<C-c>'] = 'Close',
        ['<Esc>'] = 'Close',
        ['<CR>'] = 'Confirm',
      },
      i = {
        ['<C-c>'] = 'Close',
        ['<CR>'] = 'Confirm',
        ['<C-p>'] = 'HistoryPrev',
        ['<C-n>'] = 'HistoryNext',
      },
    },
    select = {
      mappings = {
        n = {
          ['<C-c>'] = 'Close',
          ['<Esc>'] = 'Close',
          ['<CR>'] = 'Confirm',
        },
        i = {
          ['<C-c>'] = 'Close',
          ['<CR>'] = 'Confirm',
          ['<C-p>'] = 'HistoryPrev',
          ['<C-n>'] = 'HistoryNext',
        },
      },
    },
  },
}
