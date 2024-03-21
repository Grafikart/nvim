local map = vim.keymap.set

local organizeImport = function()
	vim.lsp.buf.execute_command({ command = "_typescript.organizeImports", arguments = { vim.fn.expand("%:p") } })
end

local insertAndIndent = function()
	return string.match(vim.api.nvim_get_current_line(), "%g") == nil and "cc" or "i"
end

-- Editor action
vim.keymap.set("n", "<leader>oi", organizeImport, { desc = "Organize imports" })
vim.keymap.set("n", "<leader>ca", ":lua vim.lsp.buf.code_action()<CR>", { desc = "Code action" })
vim.keymap.set("n", "<leader>s", ":w<CR>", { desc = "Save" })
---- Auto indent on empty line.
vim.keymap.set("n", "i", insertAndIndent, { expr = true, noremap = true })

-- Clipboard system
vim.keymap.set("v", "<leader>y", '"+y')
vim.keymap.set("n", "<leader>Y", '"+yg_')
vim.keymap.set("n", "<leader>y", '"+y')
vim.keymap.set("n", "<leader>yy", '"+yy')
vim.keymap.set("n", "<leader>p", '"+p')
vim.keymap.set("n", "<leader>P", '"+P')
vim.keymap.set("v", "<leader>p", '"+p')
vim.keymap.set("v", "<leader>P", '"+P')
