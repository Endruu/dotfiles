return {
  'rcarriga/nvim-notify',
  priority = 900,
  init = function()
    vim.notify = require('notify')
  end,
}

