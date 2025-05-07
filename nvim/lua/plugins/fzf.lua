local function km(key, func_name, desc, mode)
  return {
    '<leader>' .. key,
    function()
      require('fzf-lua')[func_name]()
    end,
    mode = mode or 'n',
    desc = desc,
  }
end

return
{
  "ibhagwan/fzf-lua",
  dependencies = { "echasnovski/mini.icons" },
  opts = {
    hide = true, -- is this working?
    winopts = {
      fullscreen = true,
      preview = {
        layout = 'vertical',
      },
    },
    keymap = {
      fzf = {
        ["ctrl-q"] = "select-all+accept",
      },
    },
  },
  keys = {
    km('ff', 'files', 'Find Files'),
    km('fo', 'oldfiles', 'Find Old Files'),
    km('f<space>', 'buffers', 'Find Buffers'),
    km('fs', 'lsp_document_symbols', 'Find Symbols'),
    km('fr', 'lsp_references', 'Find References'),
    km('fl', 'resume', 'Find Last'),
    km('fI', 'grep', 'Grep'),
    km('fi', 'live_grep_glob', 'Find In Files'),
    km('fw', 'grep_cword', 'Find word under cursor'),
    km('fv', 'grep_visual', 'Find visual selection', 'v'),
    km('fg', 'git_status', 'Find changed git files'),
    km('fm', 'marks', 'Find Marks'),
    km('/', 'blines', 'Fuzzy search in current buffer'),
    km('fhs', 'search_history', 'Find in search history'),
    km('fhc', 'command_history', 'Find in command history'),
    km('Ht', 'help_tags', 'Help Tags'),
    km('Hk', 'keymaps', 'Help Keymaps'),
    km('Hc', 'commands', 'Help Commands'),
    km('Hp', 'builtin', 'Help Pickers'),
  },
}
