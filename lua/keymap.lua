local builtin = require("telescope.builtin")
local map = vim.keymap.set

-- files to ignore with `file_ignore_patterns`
local excludedFiles = {
	"yarn%.lock",
	"package%-lock%.json",
	"pnpm%-lock%.yaml",
	"node_modules/.*",
	"deno%.lock",
	"%.git/.*",
	"%.png",
	"%.jpeg",
	"%.jpg",
	"%.ico",
}
local telescopeOpts = { hidden = true, follow = true, file_ignore_patterns = excludedFiles }

local findFile = function()
	builtin.find_files(telescopeOpts)
end
local searchFile = function()
	builtin.live_grep(telescopeOpts)
end

local organizeImport = function()
	vim.lsp.buf.execute_command({ command = "_typescript.organizeImports", arguments = { vim.fn.expand("%:p") } })
end

local insertAndIndent = function()
	return string.match(vim.api.nvim_get_current_line(), "%g") == nil and "cc" or "i"
end

--File navigation
vim.keymap.set("n", "<leader>ff", findFile, { desc = "Find files" })
vim.keymap.set("n", "<leader>fp", ":Telescope projects<CR>", { desc = "Find projects" })
vim.keymap.set("n", "<leader><leader>", findFile, { desc = "Find files" })
vim.keymap.set("n", "<leader>fs", searchFile, { desc = "Search" })
vim.keymap.set("n", "<leader>fr", builtin.buffers, { desc = "Find buffer" })
vim.keymap.set("n", "<leader>gg", ":LazyGit<CR>", { silent = true, desc = "Git" })
vim.keymap.set("n", "<leader>fe", ":Neotree toggle=true reveal<CR>", { desc = "File explorer" })

-- Editor action
vim.keymap.set("n", "<leader>rn", ":IncRename ", { desc = "Rename" })
vim.keymap.set("n", "<leader>oi", organizeImport, { desc = "Organize imports" })
vim.keymap.set("n", "<leader>ca", ":lua vim.lsp.buf.code_action()<CR>", { desc = "Code action" })
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
