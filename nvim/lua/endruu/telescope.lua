return {
  'nvim-telescope/telescope.nvim',
  branch = '0.1.x',
  dependencies = {
    { 'nvim-lua/plenary.nvim' },
    { 'nvim-telescope/telescope-ui-select.nvim' },
    { 'nvim-telescope/telescope-live-grep-args.nvim' },
    { 'nvim-telescope/telescope-fzf-native.nvim',    build = 'make' },
  },
  config = function()
    local telescope = require("telescope")
    local lga_actions = require("telescope-live-grep-args.actions")

    telescope.setup({

      defaults = {
        file_ignore_patterns = { '.git/' },
        mappings = {
          i = {
            ['<C-p>'] = require('telescope.actions.layout').toggle_preview,
          },
          n = {
            ['<C-p>'] = require('telescope.actions.layout').toggle_preview,
          },
        },
        layout_config = {
          horizontal = {
            width = 0.99,
            height = 0.99,
            preview_width = 0.6,
          },
        },
      },

      layout_config = {
        horizontal = {
          width = 0.8,
          preview_width = 0.7,
        },
        vertical = {
          height = 0.8,
        }
      },

      extensions = {
        ['live_grep_args'] = {
          auto_quoting = true,
          mappings = {
            i = {
              ["<C-k>"] = lga_actions.quote_prompt(),
              ["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
              ["<C-h>"] = lga_actions.quote_prompt({ postfix = " --hidden " }),
              ["<C-a>"] = lga_actions.quote_prompt({ postfix = " --no-ignore --hidden -g '!**/.git/**' " }),
            },
          },
        },
        ['ui-select'] = {
          require("telescope.themes").get_dropdown({})
        },
      },
    })

    pcall(telescope.load_extension, 'ui-select')
    pcall(telescope.load_extension, 'live_grep_args')
    pcall(telescope.load_extension, 'fzf')

    local git_status = function()
      return require('telescope.builtin').git_status({ initial_mode = 'normal' })
    end

    local diagnostics = function()
      return require('telescope.builtin').diagnostics({ initial_mode = 'normal' })
    end

    local find_in_files = function()
      require("telescope").extensions.live_grep_args.live_grep_args()
    end

    local find_selection = function()
      require("telescope-live-grep-args.shortcuts").grep_visual_selection({ initial_mode = 'normal' })
    end

    local find_last = function()
      require('telescope.builtin').resume({ initial_mode = 'normal' })
    end

    local find_references = function()
      require('telescope.builtin').lsp_references({ initial_mode = 'normal' })
    end

    local find_all_files = function()
      require('telescope.builtin').find_files({ hidden = true, no_ignore = true, follow = true })
    end

    vim.keymap.set('n', '<leader>fx', require('telescope.builtin').builtin, { desc = 'Find Builtin Pickers' })

    vim.keymap.set('n', '<leader>ff', require('telescope.builtin').find_files, { desc = 'Find Files' })
    vim.keymap.set('n', '<leader>faf', find_all_files, { desc = 'Find All Files' })
    vim.keymap.set('n', '<leader>fof', require('telescope.builtin').oldfiles, { desc = 'Find Old Files' })
    vim.keymap.set('n', '<leader>fb', require('telescope.builtin').buffers, { desc = 'Find Buffers' })
    vim.keymap.set('n', '<leader>fs', require('telescope.builtin').lsp_document_symbols, { desc = 'Find Symbols' })
    vim.keymap.set('n', '<leader>fS', require('telescope.builtin').treesitter, { desc = 'Find Symbols (treesitter)' })
    vim.keymap.set('n', '<leader>fr', find_references, { desc = 'Find References' })
    vim.keymap.set('n', '<leader>fl', find_last, { desc = 'Find Last' })
    vim.keymap.set('n', '<leader>fif', find_in_files, { desc = 'Find In Files' })
    vim.keymap.set('v', '<leader>fc', find_selection, { desc = 'Find Current Selection' })
    vim.keymap.set('n', '<leader><leader>', require('telescope.builtin').buffers, { desc = 'Find Buffers' })

    vim.keymap.set('n', '<leader>fht', require('telescope.builtin').help_tags, { desc = 'Find Help Tags' })
    vim.keymap.set('n', '<leader>fhk', require('telescope.builtin').keymaps, { desc = 'Find Help Keymaps' })
    vim.keymap.set('n', '<leader>fhc', require('telescope.builtin').commands, { desc = 'Find Help Commands' })

    vim.keymap.set('n', '<leader>gs', git_status, { desc = 'Git Status' })
    vim.keymap.set('n', '<leader>fd', diagnostics, { desc = 'Find Diagnostics' })
  end,
}

      -- -- Slightly advanced example of overriding default behavior and theme
      -- vim.keymap.set('n', '<leader>/', function()
      --   -- You can pass additional configuration to Telescope to change the theme, layout, etc.
      --   builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
      --     winblend = 10,
      --     previewer = false,
      --   })
      -- end, { desc = '[/] Fuzzily search in current buffer' })
      --
      -- -- It's also possible to pass additional configuration options.
      -- --  See `:help telescope.builtin.live_grep()` for information about particular keys
      -- vim.keymap.set('n', '<leader>s/', function()
      --   builtin.live_grep {
      --     grep_open_files = true,
      --     prompt_title = 'Live Grep in Open Files',
      --   }
      -- end, { desc = '[S]earch [/] in Open Files' })
      --
      -- -- Shortcut for searching your Neovim configuration files
      -- vim.keymap.set('n', '<leader>sn', function()
      --   builtin.find_files { cwd = vim.fn.stdpath 'config' }
      -- end, { desc = '[S]earch [N]eovim files' })
