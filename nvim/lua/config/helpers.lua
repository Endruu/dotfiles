local M = {}

M.map = function(mode, lhs, rhs, desc, opts)
  opts = opts or {}
  opts.silent = opts.silent ~= false -- default to true unless explicitly set to false
  opts.unique = opts.unique ~= false -- default to true unless explicitly set to false
  opts.desc = desc
  vim.keymap.set(mode, lhs, rhs, opts)
end

M.map_n = function(lhs, rhs, desc, opts)
  M.map('n', lhs, rhs, desc, opts)
end

M.map_v = function(lhs, rhs, desc, opts)
  M.map('v', lhs, rhs, desc, opts)
end

M.mapl = function(mode, lhs, rhs, desc, opts)
  M.map(mode, '<leader>' .. lhs, rhs, desc, opts)
end

M.mapl_n = function(lhs, rhs, desc, opts)
  M.mapl('n', lhs, rhs, desc, opts)
end

M.mapl_v = function(lhs, rhs, desc, opts)
  M.mapl('v', lhs, rhs, desc, opts)
end

M.mapl_nv = function(lhs, rhs, desc, opts)
  M.mapl({ 'n', 'v' }, lhs, rhs, desc, opts)
end

M.with_opts = function(func, opts)
  return function()
    return func(opts)
  end
end

M.toggle_virtual_lines = function()
  local new_config = not vim.diagnostic.config().virtual_lines
  vim.diagnostic.config({ virtual_lines = new_config })
end

M.toggle_virtual_text = function()
  -- we have to use `get()` because fields of `opt` are actually proxy objects
  if vim.opt.signcolumn:get() == 'yes' then
    vim.opt.signcolumn = 'no'
  else
    vim.opt.signcolumn = 'yes'
  end
  vim.opt.list = not vim.opt.list:get()
  vim.opt.number = not vim.opt.number:get()
  vim.opt.relativenumber = not vim.opt.relativenumber:get()
  vim.diagnostic.enable(not vim.diagnostic.is_enabled())
  M.toggle_virtual_lines()
  vim.cmd('IBLToggle') -- toggle indent-blankline
end

return M
