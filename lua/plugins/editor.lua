return {
	-- "gc" to comment visual regions/lines
	{ "numToStr/Comment.nvim", opts = {} },
	-- Detect tabstop and shiftwidth automatically
	"tpope/vim-sleuth",
	-- Automatically add closing tags for HTML and JSX
	{
		"windwp/nvim-ts-autotag",
		event = { "BufReadPost", "BufNewFile", "BufWritePre" },
		opts = {},
	},
	-- Rename a variable (using ":IncRename" in keymap)
	{
		"smjonas/inc-rename.nvim",
		dependencies = { "stevearc/dressing.nvim" },
		config = function()
			require("inc_rename").setup({
				input_buffer_type = "dressing",
			})
		end,
	},
	-- Auto close brackets
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {}, -- this is equalent to setup({}) function
	},
	-- Surround
	{
		"tpope/vim-surround",
	},
}
