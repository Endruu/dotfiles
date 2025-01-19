vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.g.have_nerd_font = true

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = 'yes'
vim.opt.cursorline = true
vim.opt.scrolloff = 10
vim.opt.mouse = 'a'
vim.opt.showmode = false  -- Don't show the mode, since it's already in the status line
vim.opt.cmdheight = 0
vim.opt.ignorecase = true -- Case-insensitive searching UNLESS \C
vim.opt.smartcase = true  -- unless one or more capital letters in the search term
vim.opt.wrap = false
vim.opt.completeopt = 'menuone,noselect,preview'
vim.opt.updatetime = 100

vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2

vim.opt.breakindent = true
vim.opt.undofile = true

vim.opt.list = true -- Sets how neovim will display certain whitespace characters in the editor.
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

---@diagnostic disable: undefined-field
local function toggle_virtual_text()
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
  vim.cmd('IBLToggle') -- toggle indent-blankline
end

-- Sync clipboard between OS and Neovim.
-- Schedule the setting after `UiEnter` because it can increase startup-time.
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

-- [[ Basic Keymaps ]]

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>', { desc = 'Clear highlights on search' })
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
vim.keymap.set('n', '<leader>ll', '<cmd>Ex<CR>', { desc = 'Explore' })

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })

-- Indenting
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')

-- Delete/Paste without saving to registers
vim.keymap.set("x", "<leader>p", [["_dP]])
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])
vim.keymap.set({ "n", "v" }, "<leader>c", [["_c]])
vim.keymap.set({ "n", "v" }, "<leader>x", [["_x]])

-- Some simple key mappings - because typing too fast
vim.cmd.cabbrev('W w')
vim.cmd.cabbrev('Q q')
vim.cmd.cabbrev('WQ wq')
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Misc
vim.keymap.set('n', '<leader>lg', ':LazyGit<CR>', { desc = 'Open LazyGit' })
vim.keymap.set('n', '<leader>rsc', require('endruu/custom').load_custom, { desc = 'Re-source custom init' })
vim.keymap.set('n', '<leader>tt', ':TransparentToggle<CR>', { desc = 'Toggle background transparency' })
vim.keymap.set('n', '<leader>tvt', toggle_virtual_text,
  { desc = 'Toggle Virtual Text and other fancy stuff and other fancy stuff' })

-- [[ Basic Autocommands ]]

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Workaround for not seeing when recording
vim.api.nvim_create_autocmd('RecordingEnter', { command = 'set cmdheight=1' })
vim.api.nvim_create_autocmd('RecordingLeave', { command = 'set cmdheight=0' })

-- Check if we need to reload the file
vim.api.nvim_create_autocmd('FocusGained', { command = ':checktime' })


-- [[ Install `lazy.nvim` plugin manager ]]

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)


-- [[ Install plugins ]]

require('lazy').setup({
  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically
  'tribela/vim-transparent',

  { 'lewis6991/gitsigns.nvim', opts = {} },
  { 'lukas-reineke/indent-blankline.nvim', main = 'ibl', opts = { indent = { char = '┊' } } },
  { 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },
  { 'kdheepak/lazygit.nvim', event = 'VimEnter' },

  {
    'folke/tokyonight.nvim',
    priority = 1000, -- Make sure to load this before all the other start plugins.
    init = function()
      -- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
      vim.cmd.colorscheme 'tokyonight-night'
    end,
  },

  {
    'rcarriga/nvim-notify',
    priority = 900,
    init = function()
      vim.notify = require('notify')
    end,
  },

  require('endruu/telescope'),
  require('endruu/autocomplete'),
  require('endruu/lsp'),

  {
    'mrcjkb/rustaceanvim',
    version = '^5', -- Recommended
    lazy = false,   -- This plugin is already lazy
    init = function()
      vim.g.rustaceanvim = {
        -- tools = { test_executor = 'background' },
      }
    end
  },

  {
    -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
    -- used for completion, annotations and signatures of Neovim apis
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = 'luvit-meta/library', words = { 'vim%.uv' } },
      },
    },
  },
  { 'Bilal2453/luvit-meta', lazy = true },

  { -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
    config = function()
      -- Better Around/Inside textobjects
      require('mini.ai').setup { n_lines = 500 }

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      require('mini.surround').setup()

      local statusline = require 'mini.statusline'
      statusline.setup { use_icons = vim.g.have_nerd_font }

      -- cursor location to LINE:COLUMN
      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function()
        return '%2l:%-2v'
      end
    end,
  },

  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    main = 'nvim-treesitter.configs', -- Sets main module to use for opts
    opts = {
      ensure_installed = { 'bash', 'c', 'cpp', 'rust', 'go', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc' },
      -- Autoinstall languages that are not installed
      auto_install = true,
      highlight = {
        enable = true,
        -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
        --  If you are experiencing weird indenting issues, add the language to
        --  the list of additional_vim_regex_highlighting and disabled languages for indent.
        additional_vim_regex_highlighting = { 'ruby' },
      },
      indent = { enable = true, disable = { 'ruby' } },
    },
    -- There are additional nvim-treesitter modules that you can use to interact
    -- with nvim-treesitter. You should go explore a few and see what interests you:
    --
    --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
    --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
    --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
  },

}, {})

require('endruu/custom').load_custom_if_exists()

-- vim: ts=2 sts=2 sw=2 et
