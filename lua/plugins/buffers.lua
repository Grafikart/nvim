return {
	-- Go next / previous buffer
	{
		"ghillb/cybu.nvim",
		branch = "v1.x", -- won't receive breaking changes
		dependencies = { "nvim-tree/nvim-web-devicons", "nvim-lua/plenary.nvim" }, -- optional for icon support
		config = function()
			cybu = require("cybu")
			cybu.setup({
				behavior = { -- set behavior for different modes
					mode = {
						last_used = {
							switch = "immediate", -- immediate, on_close
							view = "paging", -- paging, rolling
						},
					},
					show_on_autocmd = false, -- event to trigger cybu (eg. "BufEnter")
				},
				display_time = 750, -- time the cybu window is displayed
			})
			vim.keymap.set("n", "K", "<Plug>(CybuLastusedPrev)")
			vim.keymap.set("n", "J", "<Plug>(CybuLastusedNext)")
		end,
	},
}
