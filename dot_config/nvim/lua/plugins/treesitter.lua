return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, _)
      vim.opt.foldmethod = 'expr'
      vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
    end
  }
}
