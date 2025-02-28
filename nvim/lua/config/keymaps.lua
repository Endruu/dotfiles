local h = require('config.helpers')

-- Some simple key mappings - because typing too fast
vim.cmd.cabbrev('W w')
vim.cmd.cabbrev('Q q')
vim.cmd.cabbrev('WQ wq')

-- Making life easier
h.map('n', '<Esc>', '<cmd>nohlsearch<CR>', 'Clear highlights on search')
h.map('t', '<Esc><Esc>', '<C-\\><C-n>', 'Exit terminal mode')
h.map('v', 'y', 'ygv<Esc>', 'Yank, but keep the cursor at its current position')

-- Diagnostic keymaps
h.mapl_n('q', vim.diagnostic.setloclist, 'Open diagnostic Quickfix list')
h.mapl_n('e', vim.diagnostic.open_float, 'Show diagnostic Error messages')

-- Indenting
h.map_v('<', '<gv', 'Decrease indent and keep selection')
h.map_v('>', '>gv', 'Increase indent and keep selection')

-- Delete/Paste without saving to registers
h.mapl("x", "p", [["_dP]], "Paste without copy")
h.mapl_nv("d", [["_d]], "Delete without copy")
h.mapl_nv("c", [["_c]], "Change without copy")
h.mapl_nv("x", [["_x]], "Delete without copy")

-- Misc
h.mapl_n('lg', ':LazyGit<CR>', 'Open LazyGit')
h.mapl_n('tvt', h.toggle_virtual_text, 'Toggle Virtual Text and other fancy stuff')

-- Navigation
h.map_n('<leader><leader>', '<cmd>b#<CR>', 'Go to previous buffer')
h.map_n('-', '<cmd>Oil<CR>', 'Open Oil file explorer')

-- Search and Replace
h.mapl_v('sr', 'y:%s/<C-r>0//g<Left><Left>', 'Search and replace', { silent = false })
h.mapl_v('sm', 'y:%s/<C-r>0/<C-r>0/g<Left><Left>', 'Search and modify', { silent = false })

-- Telescope
vim.schedule(function()
  local tb = require('telescope.builtin')
  local t = require('telescope')
  local tlg = require("telescope-live-grep-args.shortcuts")

  h.mapl_n('ff', h.with_opts(tb.find_files, { hidden = true, follow = true }), 'Find Files')
  h.mapl_n('fF', h.with_opts(tb.find_files, { hidden = true, no_ignore = true, follow = true }), 'Find All Files')
  h.mapl_n('fo', tb.oldfiles, 'Find Old Files')
  h.mapl_n('fb', tb.buffers, 'Find Buffers')
  h.mapl_n('fs', tb.lsp_document_symbols, 'Find Symbols')
  h.mapl_n('fS', tb.treesitter, 'Find Symbols (treesitter)')
  h.mapl_n('fr', tb.lsp_references, 'Find References')
  h.mapl_n('fl', tb.resume, 'Find Last')
  h.mapl_n('fi', t.extensions.live_grep_args.live_grep_args, 'Find In Files')
  h.mapl_v('fc', h.with_opts(tlg.grep_visual_selection, { initial_mode = 'normal' }), 'Find Current Selection')
  h.mapl_n('fw', tb.grep_string, 'Find Changed git files')
  h.mapl_n('fg', tb.git_status, 'Find Changed git files')
  h.mapl_n('fd', tb.diagnostics, 'Find Diagnostics')
  h.mapl_n('/', tb.current_buffer_fuzzy_find, 'Find Diagnostics')

  h.mapl_n('ht', tb.help_tags, 'Help Tags')
  h.mapl_n('hk', tb.keymaps, 'Help Keymaps')
  h.mapl_n('hc', tb.commands, 'Help Commands')
  h.mapl_n('hp', tb.builtin, 'Help Pickers')
end)
