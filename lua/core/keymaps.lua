vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("v", "<", "<gv", { noremap = true, silent = true })
vim.keymap.set("v", ">", ">gv", { noremap = true, silent = true })

vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- This is going to get me cancelled
vim.keymap.set("n", "<Esc>", "<cmd>noh<return><Esc>", { noremap = true, silent = true })
vim.keymap.set({ "i", "n" }, "<C-c>", "<Esc>", { noremap = true, silent = true })
vim.keymap.set("n", "space", "<nop>")
vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "q", "<nop>")
vim.keymap.set("n", "J", "<nop>")
vim.keymap.set({ "n", "v" }, "L", "$")
vim.keymap.set({ "n", "v" }, "H", "^")

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- salir del modo terminal
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { noremap = true, silent = true })
-- Splits
vim.keymap.set("n", "<leader>qq", ":bd!<CR>", { noremap = true, silent = true, desc = "Splits quit" })
vim.keymap.set("n", "<C-q>", ":bd<CR>", { noremap = true, silent = true, desc = "Splits quit" })
vim.keymap.set(
  "n",
  "<A-v>",
  ":vnew +set\\ buftype=nofile<CR>",
  { noremap = true, silent = true, desc = "Splits vertical" }
)
vim.keymap.set(
  "n",
  "<A-s>",
  ":new +set\\ buftype=nofile<CR>",
  { noremap = true, silent = true, desc = "Splits horizontal" }
)

-- windows
vim.keymap.set("n", "<C-t>", ":tabnew<CR>", { noremap = true, silent = true, desc = "tabnew" })
vim.keymap.set("n", "<C-h>", "<C-w>h", { noremap = true, silent = true, desc = "Change window left" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { noremap = true, silent = true, desc = "Change window down" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { noremap = true, silent = true, desc = "Change window up" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { noremap = true, silent = true, desc = "Change window right" })
vim.keymap.set("n", "<C-w>h", "<C-w>H", { noremap = true, silent = true, desc = "split move left" })
vim.keymap.set("n", "<C-w>j", "<C-w>J", { noremap = true, silent = true, desc = "split move down" })
vim.keymap.set("n", "<C-w>k", "<C-w>K", { noremap = true, silent = true, desc = "split move up" })
vim.keymap.set("n", "<C-w>l", "<C-w>L", { noremap = true, silent = true, desc = "split move right" })
vim.keymap.set("n", "<C-n>", "<cmd>bnext<cr>", { noremap = true, silent = true, desc = "split move right" })
vim.keymap.set("n", "<C-p>", "<cmd>bprev<cr>", { noremap = true, silent = true, desc = "split move right" })

-- indentar codigo
vim.keymap.set(
  { "n", "v" },
  "<leader>F",
  "mm=G`m",
  { noremap = true, silent = true, desc = "Indent code without plugin" }
)

vim.keymap.set("n", "<c-u>", "6k", { noremap = true, silent = true })
vim.keymap.set("n", "<c-d>", "6j", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>e", vim.cmd.ex, { noremap = true, silent = true })

vim.keymap.set({ "n", "v" }, "<leader>y", '"zy', { noremap = true, silent = true, desc = "copiar al registro z" })
vim.keymap.set(
  { "n", "v" },
  "<leader>p",
  '"zp',
  { noremap = true, silent = true, desc = "pegar del registro z después" }
)
