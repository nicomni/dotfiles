---@module "blink.cmp"

return {
  {
    "saghen/blink.cmp",
    ---@type blink.cmp.Config
    opts = {
      completion = {
        accept = {
          auto_brackets = {
            enabled = false,
          },
        },
        menu = {
          draw = {
            -- Default value.
            -- columns = { { "kind_icon" }, { "label", "label_description", gap = 1 } },
            -- See: [Source on Github](https://github.com/saghen/blink.cmp/blob/2408f14f740f89d603cad33fe8cbd92ab068cc92/lua/blink/cmp/config/completion/menu.lua#L73-L73)
            columns = {
              { "kind_icon" },
              { "label", "label_description", gap = 1 },
              { "source_name", "lsp_client_name", gap = 1 },
            },
            components = {
              lsp_client_name = {
                text = function(ctx)
                  return ctx.item.client_name or ""
                end,
              },
            },
          },
        },
      },
    },
  },
}
