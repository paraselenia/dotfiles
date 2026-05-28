_G.Yazi = {}

function _G.Yazi.open(path)
  vim.cmd("tab drop " .. vim.fn.fnameescape(path))
end
