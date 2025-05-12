---@module "lazy"
---@module "render-markdown"

---@type LazyPluginSpec
return {
  "MeanderingProgrammer/render-markdown.nvim",
  opts = function(_, lv_opts)
    ---@cast lv_opts render.md.UserConfig

    -- I overwrite the defaults set by LazyVim for these items
    -- See: https://www.lazyvim.org/extras/lang/markdown
    lv_opts.checkbox = {}
    lv_opts.heading = {}
  end,
}
