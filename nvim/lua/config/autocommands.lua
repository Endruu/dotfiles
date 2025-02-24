-- Workaround for not seeing when recording
vim.api.nvim_create_autocmd('RecordingEnter', { command = 'set cmdheight=1' })
vim.api.nvim_create_autocmd('RecordingLeave', { command = 'set cmdheight=0' })

-- Check if we need to reload the file
vim.api.nvim_create_autocmd('FocusGained', { command = ':checktime' })

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})
