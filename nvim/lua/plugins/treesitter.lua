return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  event = 'VimEnter',
  main = 'nvim-treesitter.configs',   -- Sets main module to use for opts
  opts = {
    ensure_installed = { 'bash', 'c', 'cpp', 'rust', 'go', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc' },
    auto_install = true,
    sync_install = false,
    highlight = {
      enable = true,
    },
    indent = { enable = true, disable = { 'ruby' } },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = '<Enter>',
        node_incremental = '<Enter>',
        node_decremental = '<Backspace>',
        scope_incremental = false,
      },
    },
  },
}
