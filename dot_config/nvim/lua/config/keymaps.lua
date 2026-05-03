-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("n", "<C-h>", "^")
vim.keymap.set("n", "<C-l>", "$")
vim.keymap.set("n", "*", "*N")
vim.keymap.set("n", "<S-Left>", "<C-w><<CR>")
vim.keymap.set("n", "<S-Right>", "<C-w>><CR>")
vim.keymap.set("n", "<S-Up>", "<C-w>-<CR>")
vim.keymap.set("n", "<S-Down>", "<C-w>+<CR>")
