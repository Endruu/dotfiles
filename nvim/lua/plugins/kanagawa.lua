return {
  "rebelot/kanagawa.nvim",
  config = function()
    require("kanagawa").setup({
      compile = true,
      transparent = true,
      colors = {
        theme = {
          all = {
            ui = {
              bg_gutter = "none"
            }
          }
        }
      },
    });
    vim.cmd("colorscheme kanagawa");
  end,
  build = function()
    vim.cmd("KanagawaCompile");
  end
}
