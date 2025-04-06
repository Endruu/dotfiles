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

-- Indenting
h.map_v('<', '<gv', 'Decrease indent and keep selection')
h.map_v('>', '>gv', 'Increase indent and keep selection')

-- Delete/Paste without saving to registers
h.mapl("x", "p", [["_dP]], "Paste without copy")
h.mapl_nv("d", [["_d]], "Delete without copy")
h.mapl_nv("c", [["_c]], "Change without copy")
h.mapl_nv("x", [["_x]], "Delete without copy")

-- Misc
h.mapl_n('tvt', h.toggle_virtual_text, 'Toggle Virtual Text and other fancy stuff')
h.map_n('gK', h.toggle_virtual_lines, 'Toggle Virtual Lines')

-- Navigation
h.map_n('<leader><leader>', '<cmd>b#<CR>', 'Go to previous buffer')
h.map_n('-', '<cmd>Oil<CR>', 'Open Oil file explorer')

-- Search and Replace
h.mapl_v('sr', 'y:%s/<C-r>0//g<Left><Left>', 'Search and replace', { silent = false })
h.mapl_v('sm', 'y:%s/<C-r>0/<C-r>0/g<Left><Left>', 'Search and modify', { silent = false })

