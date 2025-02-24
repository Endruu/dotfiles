return {
  'mrcjkb/rustaceanvim',
  version = '^5', -- Recommended
  lazy = false, -- This plugin is already lazy
  event = 'VimEnter',
  cond = function()
    -- only load if we are in rust project
    return vim.fn.filereadable(vim.fn.getcwd() .. "/Cargo.toml") == 1
  end,
}
