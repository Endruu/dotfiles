return {
  'lewis6991/gitsigns.nvim',
  event = 'BufEnter',
  opts = {
    on_attach = function(bufnr)
      local gitsigns = require('gitsigns')

      local map_n = function(keys, func, desc)
        require("config.helpers").map_n(keys, func, desc, { buffer = bufnr })
      end

      map_n(']h', function() gitsigns.nav_hunk('next') end, "Go to next hunk")
      map_n('[h', function() gitsigns.nav_hunk('prev') end, "Go to prev hunk")
    end,
  },
}
