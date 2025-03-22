return {
  "lukas-reineke/indent-blankline.nvim",
  event = 'BufEnter',
  main = "ibl",
  ---@module "ibl"
  ---@type ibl.config
  opts = { indent = { char = '┊' } },
}
