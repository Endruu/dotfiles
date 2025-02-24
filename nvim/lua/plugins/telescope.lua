return {
  'nvim-telescope/telescope.nvim',
  branch = 'master',
  event = 'VimEnter',
  dependencies = {
    { 'nvim-lua/plenary.nvim' },
    { 'nvim-telescope/telescope-ui-select.nvim' },
    { 'nvim-telescope/telescope-live-grep-args.nvim' },
    { 'nvim-telescope/telescope-fzf-native.nvim',    build = 'make' },
  },
  config = function()
    local telescope = require("telescope")
    local lga_actions = require("telescope-live-grep-args.actions")
    local layout = require("telescope.actions.layout")
    local actions = require("telescope.actions")

    telescope.setup({

      defaults = {
        file_ignore_patterns = { '.git/', '.cache/', '.vscode', '.clangd' },
        mappings = {
          i = {
            ['<C-p>'] = layout.toggle_preview,
            -- For normal keyboards
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
            -- For my split keyboard
            ["<C-Left>"] = actions.preview_scrolling_left,
            ["<C-Down>"] = actions.preview_scrolling_down,
            ["<C-Up>"] = actions.preview_scrolling_up,
            ["<C-Right>"] = actions.preview_scrolling_right,
          },
          n = {
            ['<C-p>'] = layout.toggle_preview,
            -- For normal keyboards
            ["<C-h>"] = actions.preview_scrolling_left,
            ["<C-j>"] = actions.preview_scrolling_down,
            ["<C-k>"] = actions.preview_scrolling_up,
            ["<C-l>"] = actions.preview_scrolling_right,
            -- For my split keyboard
            ["<C-Left>"] = actions.preview_scrolling_left,
            ["<C-Down>"] = actions.preview_scrolling_down,
            ["<C-Up>"] = actions.preview_scrolling_up,
            ["<C-Right>"] = actions.preview_scrolling_right,
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
          additional_args = { '--hidden' },
          mappings = {
            i = {
              ["<C-u>"] = lga_actions.quote_prompt({ postfix = " -u" }),       -- unrestricted mode
              ["<C-g>"] = lga_actions.quote_prompt({ postfix = " --iglob " }), -- case insensitive glob
              ["<C-G>"] = lga_actions.quote_prompt({ postfix = " -g " }),      -- case sensitive glob
              ["<C-t>"] = lga_actions.quote_prompt({ postfix = " -t" }),       -- file types
              ["<C-w>"] = lga_actions.quote_prompt({ postfix = " -w" }),       -- match full word
              ["<C-f>"] = lga_actions.quote_prompt({ postfix = " -F" }),       -- fixed string, no regexp
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
  end,
}

