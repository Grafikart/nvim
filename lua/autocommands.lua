local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

local general = augroup("General Settings", { clear = true })

autocmd({ "FocusLost", "BufLeave", "BufWinLeave", "InsertLeave" }, {
	callback = function()
		if vim.bo.filetype ~= "" and vim.bo.buftype == "" then
			vim.cmd("silent! w")
		end
	end,
	group = general,
	desc = "Auto Save",
})

autocmd("FocusGained", {
	callback = function()
		vim.cmd("checktime")
	end,
	group = general,
	desc = "Update file when there are changes",
})
