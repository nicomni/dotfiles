return {
	{
		"linux-cultist/venv-selector.nvim",
		version = false,
		opts = {
			anaconda_base_path = "~/miniforge",
			anaconda_envs_path = "~/miniforge/envs",
		},
	},
	{
		"tmhedberg/SimpylFold",
		ft = "python",
	},
	{
		"neovim/nvim-lspconfig",
		-- opts = {
		--   servers = {
		--     pyright = {
		--       settings = {
		--         python = {
		--           analysis = {
		--             diagnosticMode = "workspace",
		--           },
		--         },
		--       },
		--     },
		--   },
		-- },
	},
}
