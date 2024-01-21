local builtin = require('telescope.builtin')
local map = vim.keymap.set

local findFile = function ()
    builtin.find_files({ find_command = {'rg', '--files', '--hidden', '-g', '!.git' }})
end

local organizeImport = function ()
    vim.lsp.buf.execute_command({command = "_typescript.organizeImports", arguments = {vim.fn.expand("%:p")}})
end

vim.keymap.set('n', '<leader>oi', organizeImport, {desc = 'Organize imports'})
vim.keymap.set('n', '<leader>ff', findFile, {desc = 'Find files'})
vim.keymap.set('n', '<leader><leader>', findFile, {desc = 'Find files'})
vim.keymap.set('n', '<leader>fs', builtin.live_grep, {desc = 'Search'})
vim.keymap.set('n', '<leader>fr', builtin.buffers, {desc = 'Find buffer'})
vim.keymap.set('n', '<leader>gg', ':LazyGit<CR>', {silent = true, desc= 'Git'})
vim.keymap.set('n', '<leader>rn', ':IncRename ')

-- Clipboard system
vim.keymap.set('v', '<leader>y',  '"+y')
vim.keymap.set('n', '<leader>Y',  '"+yg_')
vim.keymap.set('n', '<leader>y',  '"+y')
vim.keymap.set('n', '<leader>yy',  '"+yy')
vim.keymap.set('n', '<leader>p', '"+p')
vim.keymap.set('n', '<leader>P', '"+P')
vim.keymap.set('v', '<leader>p', '"+p')
vim.keymap.set('v', '<leader>P', '"+P')
