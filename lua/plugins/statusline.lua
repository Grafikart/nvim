return {
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		init = function()
			vim.g.lualine_laststatus = vim.o.laststatus
			if vim.fn.argc(-1) > 0 then
				-- set an empty statusline till lualine loads
				vim.o.statusline = " "
			else
				-- hide the statusline on the starter page
				vim.o.laststatus = 0
			end
		end,
		opts = function()
			vim.o.laststatus = vim.g.lualine_laststatus

			return {
				options = {
					theme = "auto",
					globalstatus = true,
					disabled_filetypes = { statusline = { "dashboard", "alpha", "starter" } },
				},
				sections = {
					lualine_a = {
						"mode",
					},
					lualine_b = {},
					lualine_c = {
						{ "filename", path = 1 },
					},
					lualine_x = {
						"encoding",
						"filetype",
					},
					lualine_y = { "branch" },
					lualine_z = {
						{ "location", padding = { left = 0, right = 1 } },
					},
				},
				extensions = { "neo-tree", "lazy" },
			}
		end,
	},
}
