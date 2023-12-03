return {
  {
    "fatih/vim-go",
    ft = "go",
    build = ":GoUpdateBinaries",
    tag = "v1.28",
    config = function()
      vim.g.go_code_completion_enabled = 0
    end,
  },
}
