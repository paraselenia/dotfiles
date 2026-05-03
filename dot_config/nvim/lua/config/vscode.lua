if vim.g.vscode then
  vim.keymap.set("n", "<CR>", "o<ESC>", { silent = true })
  vim.keymap.set("n", "<C-h>", "^", { silent = true })
  vim.keymap.set("n", "<C-l>", "$", { silent = true })
  vim.keymap.set("n", "*", "*N", { silent = true })
  vim.keymap.set("n", "<S-Left>", "<C-w><<CR>", { silent = true })
  vim.keymap.set("n", "<S-Right>", "<C-w>><CR>", { silent = true })
  vim.keymap.set("n", "<S-Up>", "<C-w>-<CR>", { silent = true })
  vim.keymap.set("n", "<S-Down>", "<C-w>+<CR>", { silent = true })

  vim.keymap.set("n", "<leader>gd", "<Cmd>call VSCodeNotify('editor.action.goToDeclaration')<CR>")
  vim.keymap.set("n", "<leader>gy", "<Cmd>call VSCodeNotify('editor.action.goToTypeDefinition')<CR>")
  vim.keymap.set("n", "<leader>gi", "<Cmd>call VSCodeNotify('editor.action.goToImplementation')<CR>")
  vim.keymap.set("n", "<leader>gr", "<Cmd>call VSCodeNotify('editor.action.goToReferences')<CR>")

  vim.keymap.set("n", "<leader>rn", "<Cmd>call VSCodeNotify('editor.action.rename')<CR>")
  vim.keymap.set("n", "<leader>f", "<Cmd>call VSCodeNotify('editor.action.formatSelection')<CR>")
  vim.keymap.set("x", "<leader>f", "<Cmd>call VSCodeNotify('editor.action.formatSelection')<CR>")
  vim.keymap.set("i", "<C-K>", '<ESC>"*pa')
  vim.keymap.set("i", "<C-v>", '<ESC>"*pa')
end
