return {
	-- Fuzzy Finder (files, lsp, etc)
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			-- Fuzzy Finder Algorithm which requires local dependencies to be built.
			-- Only load if `make` is available. Make sure you have the system
			-- requirements installed.
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				-- NOTE: If you are having trouble with this installation,
				--       refer to the README for telescope-fzf-native for more instructions.
				build = "make",
				cond = function()
					return vim.fn.executable("make") == 1
				end,
			},
		},
		opts = {
			defaults = {
				sorting_strategy = "ascending", -- display results top->bottom
				layout_config = {
					prompt_position = "top",
					horizontal = {
						preview_cutoff = 100,
						preview_width = 0.5,
					},
					vertical = {
						preview_cutoff = 0.4,
					},
					flex = {
						flip_columns = 110,
					},
					height = 0.94,
					width = 0.86,
				},
			},
		},
	},
}
