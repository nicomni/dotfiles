local treesitter_config = require('nvim-treesitter.configs')

treesitter_config.setup {
  ensure_installed = {
    "javascript",
    "jsdoc",
    "json",
    "jsonc",
    "lua",
    "typescript",
    "tsx",
  },

  sync_install = false,

  auto_install = true,

  highlight = { enable = true, additional_vim_regex_highlighting = false },
}
