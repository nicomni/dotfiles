---@module "tokyonight"
---@module "LazyVim"

return {
  {
    "LazyVim/LazyVim",
    ---@type LazyVimConfig
    opts = {
      -- Lazyvim uses tokyonight. Uncomment the following line to use a
      -- different colorscheme.
      -- colorscheme = "",
    },
  },
  {
    "folke/tokyonight.nvim",
    optional = true,
    ---@param opts tokyonight.Config
    opts = function(_, opts)
      -- Change characters used for separators (borders) between splits.
      -- See ':help fillchars'
      vim.opt.fillchars = {
        horiz = "━",
        horizup = "┻",
        horizdown = "┳",
        vert = "┃",
        vertleft = "┫",
        vertright = "┣",
        verthoriz = "╋",
      }
      opts.on_highlights = function(hl, c)
        -- Fix: default WinSeparator color is very dark and hard to see
        hl.WinSeparator.fg = c.blue
      end

      return opts
    end,
  },
}
