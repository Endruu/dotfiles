local M = {}

function M.load_custom_if_exists()
  if vim.fn.filereadable('./.endruu/init.lua') == 1 then
    vim.cmd.source('.endruu/init.lua')
    vim.notify('Loaded custom init.lua', vim.log.levels.INFO)
  end
end

function M.load_custom()
  if vim.fn.filereadable('.endruu/init.lua') == 1 then
    vim.cmd.source('.endruu/init.lua')
    vim.notify('Loaded custom init.lua', vim.log.levels.INFO)
  else
    vim.notify('No custom init.lua', vim.log.levels.ERROR)
  end
end

return M
