return {
  'Civitasv/cmake-tools.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  config = function()
    local cmt = require('cmake-tools')

    cmt.setup({
      cmake_regenerate_on_save = false,
      cmake_notifications = {
        runner = { enabled = false },
        executor = { enabled = false },
      },
    })

    local function info()
      vim.notify(string.format('Configure preset: %s\nBuild preset: %s\nBuild target: %s',
          cmt.get_configure_preset(), cmt.get_build_preset(), cmt.get_build_target()),
        vim.log.levels.INFO, { title = 'CMake Project Info' })
    end

    local h = require('config.helpers')
    h.mapl_n('mm', '<cmd>CMakeBuild<CR>', 'Build target with CMake')
    h.mapl_n('mc', '<cmd>CMakeBuild -t cppcheck<CR>', 'Run cppcheck target')
    h.mapl_n('mf', '<cmd>CMakeBuild -t clang-format<CR>', 'Run clang-format target')
    h.mapl_n('mg', '<cmd>CMakeGenerate<CR>', '(Re)Generate CMake project')
    h.mapl_n('mt', '<cmd>CMakeSelectBuildTarget<CR>', 'Select CMake build target')
    h.mapl_n('ms', '<cmd>CMakeStopExecutor<CR>', 'Stop building')
    h.mapl_n('mi', info, 'Print CMake project info')
  end,
  event = 'VimEnter',
  cond = function()
    -- only load if we are in cmake project
    return vim.fn.filereadable(vim.fn.getcwd() .. "/CMakeLists.txt") == 1
  end,
}
