vim.scriptencoding = 'utf-8'
vim.opt.encoding = 'utf-8'
vim.opt.fileencodings = {'utf-8', 'iso-2022-jp', 'cp932', 'euc-jp', 'sjis'}

vim.opt.belloff = 'all'
vim.opt.visualbell = true

vim.opt.showmatch = true
vim.opt.matchtime = 1

vim.opt.autoindent = true
vim.opt.number = true
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.title = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
--vim.opt.nobackup = true
--vim.opt.noswapfile = true
--vim.opt.nowritebackup = true
--vim.opt.noundofile = true
vim.opt.list = true
vim.opt.listchars={tab='>.', trail='_', extends='>', precedes='<'}
vim.opt.display = 'uhex'
vim.opt.autoread = true
vim.opt.formatoptions = 'lmoq'
vim.opt.laststatus = 2

vim.opt.backspace = {'indent', 'eol' , 'start'}

vim.opt.foldmethod = 'marker'

vim.opt.clipboard= {'unnamed', 'unnamedplus'}

vim.opt.wildmode = {'longest:full', 'full'}

vim.opt.hlsearch = true

vim.wo.number = true
vim.wo.relativenumber = false
vim.wo.wrap = false
vim.cmd("set nostartofline")

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
