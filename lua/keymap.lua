local builtin = require('telescope.builtin')
local map = vim.keymap.set

local findFile = function ()
    builtin.find_files({ find_command = {'rg', '--files', '--hidden', '-g', '!.git' }})
end

vim.keymap.set('n', '<leader>ff', findFile, {desc = "Find files"})
vim.keymap.set('n', '<leader><leader>', findFile, {desc = "Find files"})
vim.keymap.set('n', '<leader>fs', builtin.live_grep, {desc = "Search"})
vim.keymap.set('n', '<leader>fr', builtin.buffers, {desc = "Find buffer"})
vim.keymap.set('n', '<leader>gg', ':LazyGit<CR>', {silent = true, desc= "Git"})
