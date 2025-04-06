vim.g.have_nerd_font = true

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = 'yes'

vim.opt.cursorline = true
vim.opt.wrap = false
vim.opt.list = true -- Sets how neovim will display certain whitespace characters in the editor.
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

vim.opt.completeopt = 'menuone,noselect,preview'
vim.opt.updatetime = 100
vim.opt.undofile = true

vim.opt.scrolloff = 10
vim.opt.mouse = 'a'

vim.opt.showmode = false  -- Don't show the mode, since it's already in the status line
vim.opt.cmdheight = 0

vim.opt.ignorecase = true -- Case-insensitive searching UNLESS \C
vim.opt.smartcase = true  -- unless one or more capital letters in the search term

vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.smarttab = true

vim.opt.breakindent = true
vim.opt.autoindent = true
vim.opt.smartindent = true

vim.opt.confirm = true

-- Sync clipboard between OS and Neovim.
-- Schedule the setting after `UiEnter` because it can increase startup-time.
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)
